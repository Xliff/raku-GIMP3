use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;

use GIMP::UI::Color::Selector;

our subset GimpColorScalesAncestry is export of Mu
  where GimpColorScales | GimpColorSelectorAncestry;

class GIMP::UI::Color::Scales is GIMP::UI::Color::Selector {
  has GimpColorScales $!g-cscales is implementor;

  submethod BUILD ( :$gimp-color-scales ) {
    self.setGimpColorScales($gimp-color-scades) if $gimp-color-scaldes
  }

  method setGimpColorScales (GimpColorScalesAncestry $_) {
    my $to-parent;

    $!g-cscales = do {
      when GimpColorScales {
        $to-parent = cast(GimpColorSelector, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorScales, $_);
      }
    }
    self.setGimpColorSelector($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorScales
    is also<GimpColorScales>
  { $!g-cscales }

  multi method new (
     $gimp-color-scales where * ~~ GimpColorScalesAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-scales;

    my $o = self.bless( :$gimp-color-scaldes );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    :$color   = GimpRGB.new(0, 0, 0),
    :$channel = GIMP_COLOR_SELECTOR_HUE
  ) {
    my $gimp-color-scales = samewith( self.get_type, $color, $channel, :raw );

    $gimp-color-scales ?? self.bless( :$gimp-color-scales ) !! Nil;
  }

  # Type: boolean
  method show-hsv is rw  is g-property is also<show_hsv> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-hsv', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-hsv', $gv);
      }
    );
  }

  # Type: boolean
  method show-rgb-u8 is rw  is g-property is also<show_rgb_u8> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-rgb-u8', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-rgb-u8', $gv);
      }
    );
  }

  method get_show_rgb_u8 is also<get-show-rgb-u8> {
    so gimp_color_scales_get_show_rgb_u8($!g-cscales);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_scales_get_type, $n, $t );
  }

  method set_show_rgb_u8 (Int() $show_rgb_u8) is also<set-show-rgb-u8> {
    my gboolean $s = $show_rgb_u8.so.Int;

    gimp_color_scales_set_show_rgb_u8($!g-cscales, $s);
  }

}

### /usr/src/gimp/libgimpwidgets/gimpcolorscales.h

sub gimp_color_scales_get_show_rgb_u8 (GimpColorScales $scales)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_scales_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_scales_set_show_rgb_u8 (
  GimpColorScales $scales,
  gboolean        $show_rgb_u8
)
  is      native(gimpwidgets)
  is      export
{ * }
