use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::Colorspace;
use GIMP::Raw::UI::Color::Selector;

use GTK::Box;

use GLib::Roles::Implementor;

our subset GimpColorSelectorAncestry is export of Mu
  where GimpColorSelector | GtkBoxAncestry;

class GIMP::UI::Color::Selector {
  has GimpColorSelector $!g-cs is implementor;

  submethod BUILD ( :$gimp-color-selector ) {
    self.setGimpColorSelector($gimp-color-selector)
      if $gimp-color-selector
  }

  method setGimpColorSelector (GimpColorSelectorAncestry $_) {
    my $to-parent;

    $!g-cs = do {
      when GimpColorSelector {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorSelector, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GIMP::Raw::Structs::GimpColorSelector
    is also<GimpColorSelector>
  { $!g-cs }

  multi method new (
     $gimp-color-selector where * ~~ GimpColorSelectorAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-selector;

    my $o = self.bless( :$gimp-color-selector );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    $c is copy where * !~~ (GimpRGB, GimpHSV).any,

    Int() $channel
  ) {
    $c .= GimpHSV if $c.^can('GimpHSV');
    $c .= GimpRGB if $c.^can('GimpRGB');

    samewith($c, $channel);
  }

  multi method new (GimpRGB $rgb, Int() $channel) {
    my $hsv = GimpHSV.new;
    gimp_rgb_to_hsv($rgb, $hsv);
    samewith($rgb, $hsv, $channel);
  }
  multi method new (GimpHSV $hsv, Int() $channel) {
    my $rgb = GimpRGB.new;
    gimp_hsv_to_rgb($hsv, $rgb);
    samewith($rgb, $hsv, $channel);
  }
  multi method new (GimpRGB() $rgb, GimpHSV() $hsv, Int() $channel) {
    my GimpColorSelectorChannel $c = $channel;

    my $gimp-color-selector = gimp_color_selector_new($!g-cs, $rgb, $hsv, $c);

    $gimp-color-selector ?? self.bless( :$gimp-color-selector ) !! Nil;
  }

  # Is originally:
  # GimpColorSelector *selector,  GimpRGB *rgb,  GimpHSV *hsv --> void
  method color-changed is also<color_changed> {
    self.connect-color-changed($!g-cs);
  }

  # Is originally:
  # GimpColorSelector *selector,  GimpColorSelectorChannel channel --> void
  method channel-changed is also<channel_changed> {
    self.connect-uint($!g-cs, 'channel-changed');
  }

  # Is originally:
  # GimpColorSelector *selector,  GimpColorSelectorModel model,  gboolean visible --> void
  method model-visible-changed is also<model_visible_changed> {
    self.connect-uint2($!g-cs, 'model-visible-changed');
  }

  method emit_channel_changed is also<emit-channel-changed> {
    gimp_color_selector_emit_channel_changed($!g-cs);
  }

  method emit_color_changed is also<emit-color-changed> {
    gimp_color_selector_emit_color_changed($!g-cs);
  }

  method emit_model_visible_changed (Int() $model) is also<emit-model-visible-changed> {
    my GimpColorSelectorModel $m = $model;

    gimp_color_selector_emit_model_visible_changed($!g-cs, $m);
  }

  method get_channel ( :$enum = True ) is also<get-channel> {
    my $c = gimp_color_selector_get_channel($!g-cs);
    return $c unless $enum;
    GimpColorSelectorChannelEnum($c);
  }

  proto method get_color (|)
    is also<get-color>
  { * }

  multi method get_color ( :$hash = True, :$array = $hash.not ) {
    my $r = samewith(GimpRGB.new, GimpHSV.new);
    return $r if $array;
    # cw: Idomatic hash creation via inline zip operator.
    ( <rgb hsv> [Z] $r[] ).flat.Hash
  }
  multi method get_color (GimpRGB() $rgb, GimpHSV() $hsv, :$raw = False) {
    gimp_color_selector_get_color($!g-cs, $rgb, $hsv);

    my $c1 = propReturnObject($rgb, $raw, |GIMP::RGB.getTypePair);
    my $c2 = propReturnObject($hsv, $raw, |GIMP::HSV.getTypePair);

    ($c1, $c2);
  }

  method get_model_visible (Int() $model) is also<get-model-visible> {
    my GimpColorSelectorModel $m = $model;

    gimp_color_selector_get_model_visible($!g-cs, $m);
  }

  method get_show_alpha is also<get-show-alpha> {
    so gimp_color_selector_get_show_alpha($!g-cs);
  }

  method get_toggles_sensitive is also<get-toggles-sensitive> {
    so gimp_color_selector_get_toggles_sensitive($!g-cs);
  }

  method get_toggles_visible is also<get-toggles-visible> {
    so gimp_color_selector_get_toggles_visible($!g-cs);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_selector_get_type, $n, $t );
  }

  method set_channel (Int() $channel) is also<set-channel> {
    my GimpColorSelectorChannel $c = $channel;

    gimp_color_selector_set_channel($!g-cs, $channel);
  }

  method set_color (GimpRGB() $rgb, GimpHSV() $hsv) is also<set-color> {
    gimp_color_selector_set_color($!g-cs, $rgb, $hsv);
  }

  method set_config (GimpColorConfig() $config) is also<set-config> {
    gimp_color_selector_set_config($!g-cs, $config);
  }

  method set_model_visible (Int() $model, Int() $visible)
    is also<set-model-visible>
  {
    my GimpColorSelectorModel $m = $model;
    my gboolean               $v = $visible.so.Int;

    gimp_color_selector_set_model_visible($!g-cs, $m, $v);
  }

  method set_show_alpha (Int() $show_alpha) is also<set-show-alpha> {
    my gboolean $s = $show_alpha.so.Int;

    gimp_color_selector_set_show_alpha($!g-cs, $s);
  }

  method set_simulation (
    GimpColorProfile() $profile,
    Int()              $intent,
    Int()              $bpc
  )
    is also<set-simulation>
  {
    my GimpColorRenderingIntent $i = $intent;
    my gboolean                 $b = $bpc;

    gimp_color_selector_set_simulation($!g-cs, $profile, $i, $b);
  }

  method set_toggles_sensitive (Int() $sensitive)
    is also<set-toggles-sensitive>
  {
    my gboolean $s = $sensitive.so.Int;

    gimp_color_selector_set_toggles_sensitive($!g-cs, $s);
  }

  method set_toggles_visible (Int() $visible) is also<set-toggles-visible> {
    my gboolean $v = $visible.so.Int;

    gimp_color_selector_set_toggles_visible($!g-cs, $v);
  }

}
