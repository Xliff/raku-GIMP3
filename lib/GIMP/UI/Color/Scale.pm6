use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Colorspace;
use GIMP::Raw::UI::Color::Scale;

use GTK::Scale;

use GLib::Roles::Implementor;

our subset GimpColorScaleAncestry is export of Mu
  where GimpColorScale | GtkScaleAncestry;

class GIMP::UI::Color::Scale is GTK::Scale {
  has GimpColorScale $!g-cs is implementor;

  submethod BUILD ( :$gimp-color-scale ) {
    self.setGimpColorScale($gimp-color-scale) if $gimp-color-scale
  }

  method setGimpColorScale (GimpColorScaleAncestry $_) {
    my $to-parent;

    $!g-cs = do {
      when GimpColorScale {
        $to-parent = cast(GtkScale, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorScale, $_);
      }
    }
    self.setGtkScale($to-parent);
  }

  method GIMP::Raw::Structs::GimpColorScale
    is also<GimpColorScale>
  { $!g-cs }

  multi method new (
     $gimp-color-scale where * ~~ GimpColorScaleAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-scale;

    my $o = self.bless( :$gimp-color-scale );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $orientation, Int() $channel) {
    my GtkOrientation           $o = $orientation;
    my GimpColorSelectorChannel $c = $channel;

    my $gimp-color-scale = gimp_color_scale_new($!g-cs, $channel);

    $gimp-color-scale ?? self.bless( :$gimp-color-scale ) !! Nil;
  }

  proto method new-hscale (|)
    is also<new_hscale>
  { * }

  proto method new-vscale (|)
    is also<new_vscale>
  { * }

  multi method new-hscale (:h(:$hue) is required) {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, GIMP_COLOR_SELECTOR_HUE);
  }
  multi method new-vscale (:h(:$hue) is required) {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, GIMP_COLOR_SELECTOR_HUE);
  }

  multi method new-hscale (:s(:$saturation) is required) {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, GIMP_COLOR_SELECTOR_SATURATION);
  }
  multi method new-vscale (:s(:$saturation) is required) {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, GIMP_COLOR_SELECTOR_SATURATION);
  }

  multi method new-hscale (:v(:$value) is required) {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, GIMP_COLOR_SELECTOR_VALUE);
  }
  multi method new-vscale (:v(:$value) is required) {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, GIMP_COLOR_SELECTOR_VALUE);
  }

  multi method new-hscale (:r(:$red) is required) {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, GIMP_COLOR_SELECTOR_RED);
  }
  multi method new-vscale (:r(:$red) is required) {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, GIMP_COLOR_SELECTOR_RED);
  }

  multi method new-hscale (:g(:$green) is required) {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, GIMP_COLOR_SELECTOR_GREEN);
  }
  multi method new-vscale (:g(:$green) is required) {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, GIMP_COLOR_SELECTOR_GREEN);
  }

  multi method new-hscale (:b(:$blue) is required) {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, GIMP_COLOR_SELECTOR_BLUE);
  }
  multi method new-vscale (:b(:$blue) is required) {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, GIMP_COLOR_SELECTOR_BLUE);
  }

  multi method new-hscale (:a(:$alpha) is required) {
    ::?CLASS.new(GTK_ORIENTATION_HORIZONTAL, GIMP_COLOR_SELECTOR_ALPHA);
  }
  multi method new-Vscale (:a(:$alpha) is required) {
    ::?CLASS.new(GTK_ORIENTATION_VERTICAL, GIMP_COLOR_SELECTOR_ALPHA);
  }

  multi method new-hscale (:ll(:$lightness) is required) {
    ::?CLASS.new(
      GTK_ORIENTATION_HORIZONTAL,
      GIMP_COLOR_SELECTOR_LCH_LIGHTNESS
    );
  }
  multi method new-vscale (:ll(:$lightness) is required) {
    ::?CLASS.new(
      GTK_ORIENTATION_VERTICAL,
      GIMP_COLOR_SELECTOR_LCH_LIGHTNESS
    );
  }

  multi method new-hscale (:lc(:$chroma) is required) {
    ::?CLASS.new(
      GTK_ORIENTATION_HORIZONTAL,
      GIMP_COLOR_SELECTOR_LCH_CHROMA
    );
  }
  multi method new-vscale (:lc(:$chroma) is required) {
    ::?CLASS.new(
      GTK_ORIENTATION_VERTICAL,
      GIMP_COLOR_SELECTOR_LCH_CHROMA
    );
  }

  multi method new-hscale (:lh(:lch_hue(:$lch-hue)) is required) {
    ::?CLASS.new(
      GTK_ORIENTATION_HORIZONTAL,
      GIMP_COLOR_SELECTOR_LCH_HUE
    );
  }
  multi method new-vscale (:lh(:lch_hue(:$lch-hue)) is required) {
    ::?CLASS.new(
      GTK_ORIENTATION_VERTICAL,
      GIMP_COLOR_SELECTOR_LCH_HUE
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_scale_get_type, $n, $t );
  }

  method set_channel (Int() $channel) is also<set-channel> {
    my GimpColorSelectorChannel $c = $channel;

    gimp_color_scale_set_channel($!g-cs, $c);
  }

  my subset GimpRGBCompat of Mu
    where { $_ ~~ GimpRGB || .^can('GimpRGB') }
  my subset GimpHSVCompat of Mu
    where { $_ ~~ GimpHSV || .^can('GimpHSV') }

  proto method set_color (|)
    is also<set-color>
  { * }

  multi method set_color (GimpRGBCompat $rgb is copy) {
    $rgb .= GimpRGB unless $rgb ~~ GimpRGB;

    samewith( $rgb, gimp_rgb_to_hsv($rgb) );
  }
  multi method set_color (GimpHSVCompat $hsv is copy) {
    $hsv .= GimpHSV unless $hsv ~~ GimpHSV;

    samewith( gimp_hsv_to_rgb($hsv), $hsv );
  }
  multi method set_color (GimpRGB() $rgb, GimpHSV() $hsv) {
    gimp_color_scale_set_color($!g-cs, $rgb, $hsv);
  }

  method set_color_config (GimpColorConfig() $config)
    is also<set-color-config>
  {
    gimp_color_scale_set_color_config($!g-cs, $config);
  }

}
