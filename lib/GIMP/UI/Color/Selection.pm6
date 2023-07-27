use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Color::Selection;

use GTK::Box;
use GTK::Widget;

use GLib::Roles::Implementor;

our subset GimpColorSelectionAncestry is export of Mu
  where GimpColorSelection | GtkBoxAncestry;

class GIMP::UI::Color::Selection is GTK::Box {
  has GimpColorSelection $!g-cs is implementor;

  submethod BUILD ( :$gimp-color-selection ) {
    self.setGimpColorSelection($gimp-color-selection)
      if $gimp-color-selection
  }

  method setGimpColorSelection (GimpColorSelectionAncestry $_) {
    my $to-parent;

    $!g-cs = do {
      when GimpColorSelection {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorSelection, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorSelection
    is also<GimpColorSelection>
  { $!g-cs }

  multi method new (
     $gimp-color-selection where * ~~ GimpColorSelectionAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-selection;

    my $o = self.bless( :$gimp-color-selection );
    $o.ref if $ref;
    $o;
  }
  multi method new {
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

  method Color-Changed is also<Color_Changed> {
    self.connect($!g-cs, 'color-changed');
  }

  method color_changed is also<color-changed> {
    gimp_color_selection_color_changed($!g-cs);
  }

  proto method get_color (|)
    is also<get-color>
  { * }

  multi method get_color ( :$raw = False ) {
    samewith(GimpRGB.new, :$raw)
  }
  multi method get_color (GimpRGB() $color, :$raw = False) {
    gimp_color_selection_get_color($!g-cs, $color);
    propReturnObject($color, $raw |GIMP::RGB.getTypePair);
  }

  method get_notebook ( :$raw = False ) is also<get-notebook> {
    propReturnObject(
      gimp_color_selection_get_notebook($!g-cs),
      $raw,
      |GIMP::UI::Color::Notebook.getTypePair
    );
  }

  proto method get_old_color (|)
    is also<get-old-color>
  { * }
  multi method get_old_color ( :$raw = False ) {
    samewith(GimpRGB.new, :$raw)
  }
  multi method get_old_color (GimpRGB() $color, :$raw = False) {
    gimp_color_selection_get_old_color($!g-cs, $color);
    propReturnObject($color, $raw |GIMP::RGB.getTypePair);
  }

  method get_right_vbox ( :$raw = False ) is also<get-right-vbox> {
    ReturnWidget(
      gimp_color_selection_get_right_vbox($!g-cs),
      $raw,
    );
  }

  method get_show_alpha is also<get-show-alpha> {
    so gimp_color_selection_get_show_alpha($!g-cs);
  }

  method get_type is also<get-type> {
    gimp_color_selection_get_type();
  }

  method reset {
    gimp_color_selection_reset($!g-cs);
  }

  method set_color (GimpRGB() $color) is also<set-color> {
    gimp_color_selection_set_color($!g-cs, $color);
  }

  method set_config (GimpColorConfig() $config) is also<set-config> {
    gimp_color_selection_set_config($!g-cs, $config);
  }

  method set_old_color (GimpRGB() $color) is also<set-old-color> {
    gimp_color_selection_set_old_color($!g-cs, $color);
  }

  method set_show_alpha (Int() $show_alpha) is also<set-show-alpha> {
    my gboolean $s = $show_alpha.so.Int;
    gimp_color_selection_set_show_alpha($!g-cs, $s);
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

    gimp_color_selection_set_simulation($!g-cs, $profile, $i, $b);
  }

}
