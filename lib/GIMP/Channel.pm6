use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Channel;

use GIMP::Drawable;

use GLib::Roles::Implementor;

our subset GimpChannelAncestry is export of Mu
  where GimpChannel | GimpDrawableAncestry;

class GIMP::Channel is GIMP::Drawable {
  has GimpChannel $!g-c is implementor;

  submethod BUILD ( :$gimp-channel ) {
    self.setGimpChannel($gimp-channel) if $gimp-channel
  }

  method setGimpChannel (GimpChannelAncestry $_) {
    my $to-parent;

    $!g-c = do {
      when GimpChannel {
        $to-parent = cast(GimpDrawable, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpChannel, $_);
      }
    }
    self.setGimpDrawable($to-parent);
  }

  method GIMP::Raw::Definitions::GimpChannel
    is also<GimpChannel>
  { $!g-c }

  multi method new (
     $gimp-channel where * ~~ GimpChannelAncestry,

    :$ref = True
  ) {
    return unless $gimp-channel;

    my $o = self.bless( :$gimp-channel );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    GimpImage() $image,
    Str()       $name,
    Int()       $width,
    Int()       $height,
    Num()       $opacity,
    GimpRGB()   $color
  ) {
    my guint   ($w, $h) = ($width, $height);
    my gdouble  $o      =  $opacity;

    my $gimp-channel = gimp_channel_new($image, $name, $w, $h, $o, $color);

    $gimp-channel ?? self.bless( :$gimp-channel ) !! Nil;
  }
  multi method new (Int() $id) {
    self.get_by_id($id);
  }
  multi method new (
    GimpImage() $image,
    Int()       $component,
    Str()       $name
  ) {
    self.new_from_component($image, $component, $name);
  }

  method new_from_component (
    GimpImage() $image,
    Int()       $component,
    Str()       $name
  )
    is also<new-from-component>
  {
    my GimpChannelType $c = $component;

    my $gimp-channel = gimp_channel_new_from_component($image, $c, $name);

    $gimp-channel ?? self.bless( :$gimp-channel ) !! Nil;
  }

  method get_by_id (Int() $id) is static is also<get-by-id> {
    my gint $i = $id;

    my $gimp-channel = gimp_channel_get_by_id($id);

    $gimp-channel ?? self.bless( :$gimp-channel ) !! Nil;
  }

  method combine_masks (
    GimpChannel() $channel2,
    Int()         $operation,
    Int()         $offx,
    Int()         $offy
  )
    is also<combine-masks>
  {
    my GimpChannelOps  $o      =  $operation;
    my gint           ($x, $y) = ($offx, $offy);

    so gimp_channel_combine_masks($!g-c, $channel2, $o, $x, $y);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gimp_channel_copy($!g-c),
      $raw,
      |self.getTypePair
    );
  }

  method get_color (GimpRGB() $color) is also<get-color> {
    gimp_channel_get_color($!g-c, $color);
  }

  method get_opacity is also<get-opacity> {
    gimp_channel_get_opacity($!g-c);
  }

  method get_show_masked is also<get-show-masked> {
    so gimp_channel_get_show_masked($!g-c);
  }

  method set_color (GimpRGB() $color) is also<set-color> {
    gimp_channel_set_color($!g-c, $color);
  }

  method set_opacity (Num() $opacity) is also<set-opacity> {
    my gdouble $o = $opacity;

    gimp_channel_set_opacity($!g-c, $o);
  }

  method set_show_masked (Int() $show_masked) is also<set-show-masked> {
    my gboolean $s = $show_masked.so.Int;

    gimp_channel_set_show_masked($!g-c, $s);
  }

}
