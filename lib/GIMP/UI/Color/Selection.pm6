use v6.c;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Color::Selection;

use GTK::Box;
use GTK::Widget;

use GLib::Roles::Implementor;

class GIMP::UI::Color::Selection is GTK::Box {
  has GimpColorSelection $!g-cs is implementor;

  method new {
    my $gimp-color-selection = gimp_color_selection_new();

    $gimp-color-selection ?? self.bless( :$gimp-color-selection ) !! Nil;
  }

  # Type: GimpColorConfig
  method config is rw  is g-property {
    my $gv = GLib::Value.new( GIMP::Color::Config.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'config does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GimpColorConfig() $val is copy {
        $gv.object = $val;
        self.prop_set('config', $gv);
      }
    );
  }

  method Color-Changed {
    self.connect($!g-cs, 'color-changed');
  }

  method color_changed {
    gimp_color_selection_color_changed($!g-cs);
  }

  proto method get_color (|)
  { * }

  multi method get_color ( :$raw = False ) {
    samewith(GimpRGB.new, :$raw)
  }
  multi method get_color (GimpRGB() $color, :$raw = False) {
    gimp_color_selection_get_color($!g-cs, $color);
    propReturnObject($color, $raw |GIMP::RGB.getTypePair);
  }

  method get_notebook ( :$raw = False ) {
    propReturnObject(
      gimp_color_selection_get_notebook($!g-cs),
      $raw,
      |GIMP::UI::Color::Notebook.getTypePair
    );
  }

  proto method get_old_color (|)
  { * }
  multi method get_old_color ( :$raw = False ) {
    samewith(GimpRGB.new, :$raw)
  }
  multi method get_old_color (GimpRGB() $color, :$raw = False) {
    gimp_color_selection_get_old_color($!g-cs, $color);
    propReturnObject($color, $raw |GIMP::RGB.getTypePair);
  }

  method get_right_vbox ( :$raw = False ) {
    ReturnWidget(
      gimp_color_selection_get_right_vbox($!g-cs),
      $raw,
    );
  }

  method get_show_alpha {
    so gimp_color_selection_get_show_alpha($!g-cs);
  }

  method get_type {
    gimp_color_selection_get_type();
  }

  method reset {
    gimp_color_selection_reset($!g-cs);
  }

  method set_color (GimpRGB() $color) {
    gimp_color_selection_set_color($!g-cs, $color);
  }

  method set_config (GimpColorConfig() $config) {
    gimp_color_selection_set_config($!g-cs, $config);
  }

  method set_old_color (GimpRGB() $color) {
    gimp_color_selection_set_old_color($!g-cs, $color);
  }

  method set_show_alpha (Int() $show_alpha) {
    my gboolean $s = $show_alpha.so.Int;
    gimp_color_selection_set_show_alpha($!g-cs, $s);
  }

  method set_simulation (
    GimpColorProfile() $profile,
    Int()              $intent,
    Int()              $bpc
  ) {
    my GimpColorRenderingIntent $i = $intent;
    my gboolean                 $b = $bpc;

    gimp_color_selection_set_simulation($!g-cs, $profile, $i, $b);
  }

}
