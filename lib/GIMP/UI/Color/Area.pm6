use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Color::Area;

use GTK::DrawingArea;

use GLib::Roles::Implementor;

our subset GimpColorAreaAncestry is export of Mu
  where GimpColorArea | GtkDrawingAreaAncestry;

class GIMP::UI::Color::Area is GTK::DrawingArea {
  has GimpColorArea $!g-ca is implementor;

  submethod BUILD ( :$gimp-color-area ) {
    self.setGimpColorArea($gimp-color-area) if $gimp-color-area
  }

  method setGimpColorArea (GimpColorAreaAncestry $_) {
    my $to-parent;

    $!g-ca = do {
      when GimpColorArea {
        $to-parent = cast(GtkDrawingArea, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorArea, $_);
      }
    }
    self.setGtkDrawingArea($to-parent);
  }

  method GIMP::Raw::Structs::GimpColorArea
    is also<GimpColorArea>
  { $!g-ca }

  multi method new (
     $gimp-color-area where * ~~ GimpColorAreaAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-area;

    my $o = self.bless( :$gimp-color-area );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    GimpRGB() :$color     = GimpRGB.new(0, 0, 0),
    Int()     :$type      = GIMP_COLOR_AREA_FLAT,
    Int()     :$drag_mask = 0
  ) {
    samewith($color, $type, $drag_mask);
  }
  multi method new (
    GimpRGB() $color,
    Int()     $type,
    Int()     $drag_mask
  ) {
    my GimpColorAreaType $t = $type;
    my GdkModifierType   $d = $drag_mask;

    my $gimp-color-area = gimp_color_area_new($color, $t, $d);

    $gimp-color-area ?? self.bless( :$gimp-color-area ) !! Nil;
  }

  # Type: GdkModifierType
  method drag-mask is rw  is g-property is also<drag_mask> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkModifierType) );
    Proxy.new(
      FETCH => sub ($) {
        warn 'drag-mask does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int()  $val is copy {
        $gv.valueFromEnum(GdkModifierType) = $val;
        self.prop_set('drag-mask', $gv);
      }
    );
  }

  # Type: boolean
  method draw-border is rw  is g-property is also<draw_border> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('draw-border', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('draw-border', $gv);
      }
    );
  }

  # Type: GimpColorAreaType
  method type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GimpColorAreaType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GimpColorAreaTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpColorAreaType) = $val;
        self.prop_set('type', $gv);
      }
    );
  }

  method color-changed is also<color_changed> {
    self.connect($!g-ca, 'color-changed');
  }

  method enable_drag (Int() $drag_mask) is also<enable-drag> {
    my GdkModifierType $d = $drag_mask;

    gimp_color_area_enable_drag($!g-ca, $d);
  }

  proto method get_color (|)
    is also<get-color>
  { * }

  multi method get_color ( :$raw = False ) {
    samewith(GimpRGB.new, :$raw);
  }
  multi method get_color (GimpRGB() $color, :$raw = False) {
    gimp_color_area_get_color($!g-ca, $color);
    propReturnObject($color, $raw, |GIMP::RGB.getTypePair)
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_area_get_type, $n, $t );
  }

  method has_alpha is also<has-alpha> {
    so gimp_color_area_has_alpha($!g-ca);
  }

  method set_color (GimpRGB() $color) is also<set-color> {
    gimp_color_area_set_color($!g-ca, $color);
  }

  method set_color_config (GimpColorConfig() $config)
    is also<set-color-config>
  {
    gimp_color_area_set_color_config($!g-ca, $config);
  }

  method set_draw_border (Int() $draw_border) is also<set-draw-border> {
    my gboolean $d = $draw_border.so.Int;

    gimp_color_area_set_draw_border($!g-ca, $d);
  }

  method set_out_of_gamut (Int() $out_of_gamut) is also<set-out-of-gamut> {
    my gboolean $o = $out_of_gamut.so.Int;

    gimp_color_area_set_out_of_gamut($!g-ca, $o);
  }

  method set_type (Int() $type) is also<set-type> {
    my GimpColorAreaType $t = $type;

    gimp_color_area_set_type($!g-ca, $t);
  }

}
