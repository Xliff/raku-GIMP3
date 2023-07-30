use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Color::Display;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

#use GIMP::Roles::ConfigInterface;

our subset GimpColorDisplayAncestry is export of Mu
  where GimpColorDisplay | GObject;

class GIMP::UI::Color::Display {
  also does GLib::Roles::Object;
  #also does GIMP::Roles::ConfigInterface;

  has GimpColorDisplay $!g-cd is implementor;

  submethod BUILD ( :$gimp-color-display ) {
    self.setGimpColorDisplay($gimp-color-display) if $gimp-color-display;
  }

  method setGimpColorDisplay (GimpColorDisplayAncestry $_) {
    my $to-parent;

    $!g-cd = do {
      when GimpColorDisplay {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorDisplay, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorDisplay
  { $!g-cd }

  multi method new (
     $gimp-color-display where * ~~ GimpColorDisplayAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-display;

    my $o = self.bless( :$gimp-color-display );
    $o.ref if $ref;
    $o;
  }

  # Type: GimpColorConfig
  method color-config ( :$raw = False )
    is rw
    is g-property
    is also<color_config>
  {
    my $gv = GLib::Value.new( GIMP::Color::Config.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('color-config', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIMP::Color::Config.getTypePair
        );
      },
      STORE => -> $, GimpColorConfig() $val is copy {
        $gv.object = $val;
        self.prop_set('color-config', $gv);
      }
    );
  }

  # Type: GimpColorManaged
  method color-managed ( :$raw = False )
    is rw
    is g-property
    is also<color_managed>
  {
    my $gv = GLib::Value.new( GIMP::Color::Managed.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('color-managed', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIMP::Color::Managed.getTypePair
        );
      },
      STORE => -> $, GimpColorManaged() $val is copy {
        $gv.object = $val;
        self.prop_set('color-managed', $gv);
      }
    );
  }

  # Type: boolean
  method enabled is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('enabled', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('enabled', $gv);
      }
    );
  }

  method Changed {
    self.connect($!g-cd, 'changed');
  }

  method changed {
    gimp_color_display_changed($!g-cd);
  }

  method clone ( :$raw = False ) {
    returnProperObject(
      gimp_color_display_clone($!g-cd),
      $raw,
      |self.getTypePair
    );
  }

  method configure ( :$raw = False ) {
    returnProperObject(
      gimp_color_display_configure($!g-cd),
      $raw,
      |GTK::Widget.getTypePair
    );
  }

  method configure_reset is also<configure-reset> {
    gimp_color_display_configure_reset($!g-cd);
  }

  method convert_buffer (
    GeglBuffer()    $buffer,
    GeglRectangle() $area
  )
    is also<convert-buffer>
  {
    gimp_color_display_convert_buffer($!g-cd, $buffer, $area);
  }

  method get_config ( :$raw = False ) is also<get-config> {
    propReturnObject(
      gimp_color_display_get_config($!g-cd),
      $raw,
      |GIMP::Color::Config.getTypePair
    );
  }

  method get_enabled is also<get-enabled> {
    so gimp_color_display_get_enabled($!g-cd);
  }

  method get_managed ( :$raw = False ) is also<get-managed> {
    propReturnObject(
      gimp_color_display_get_managed($!g-cd),
      $raw,
      |GIMP::Color::Managed.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_display_get_type, $n, $t );
  }

  method load_state (GimpParasite() $state) is also<load-state> {
    gimp_color_display_load_state($!g-cd, $state);
  }

  method save_state is also<save-state> {
    gimp_color_display_save_state($!g-cd);
  }

  method set_enabled (Int() $enabled) is also<set-enabled> {
    my gboolean $e = $enabled.so.Int;

    gimp_color_display_set_enabled($!g-cd, $enabled);
  }

}
