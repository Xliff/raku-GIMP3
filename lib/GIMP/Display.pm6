use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Display;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GimpDisplayAncestry is export of Mu
  where GimpDisplay | GObject;

class GIMP::Display {
  also does GLib::Roles::Object;

  has GimpDisplay $!g-d is implementor;

  submethod BUILD ( :$gimp-display ) {
    self.setGimpDisplay($gimp-display) if $gimp-display
  }

  method setGimpDisplay (GimpDisplayAncestry $_) {
    my $to-parent;

    $!g-d = do {
      when GimpDisplay {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpDisplay, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Structs::GimpDisplay
    is also<GimpDisplay>
  { $!g-d }

  multi method new (
     $gimp-display where * ~~ GimpDisplayAncestry,

    :$ref = True
  ) {
    return unless $gimp-display;

    my $o = self.bless( :$gimp-display );
    $o.ref if $ref;
    $o;
  }
  multi method new (GimpImage() $image) {
    my $gimp-display = gimp_display_new($image);

    $gimp-display ?? self.bless( :$gimp-display ) !! Nil;
  }
  multi method new (Int() $i, :by_id(:by-id(:$id)) is required) {
    self.get_by_id($i);
  }

  # Type: int
  method id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('id', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  method get_by_id (Int() $id) is static is also<get-by-id> {
    my $gimp-display = gimp_display_get_by_id($id);

    $gimp-display ?? self.bless( :$gimp-display ) !! Nil;
  }

  method delete {
    gimp_display_delete($!g-d);
  }

  method flush is static {
    gimp_displays_flush();
  }

  method get_id is also<get-id> {
    gimp_display_get_id($!g-d);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_display_get_type, $n, $t );
  }

  method get_window_handle is also<get-window-handle> {
    gimp_display_get_window_handle($!g-d);
  }

  method id_is_valid is also<id-is-valid> {
    so gimp_display_id_is_valid($!g-d);
  }

  method is_valid is also<is-valid> {
    so gimp_display_is_valid($!g-d);
  }

  method present {
    so gimp_display_present($!g-d);
  }

  method reconnect (GimpImage() $old_image, GimpImage() $new_image)
    is static
  {
    gimp_displays_reconnect($old_image, $new_image);
  }

}
