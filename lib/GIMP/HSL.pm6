use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::Colorspace;

use GIMP::Roles::Implementor;

# BOXED

class GIMP::HSL {
  has GimpHSL $!g-hsl is implementor handles<
    hue        h
    saturation s
    lightness  l
    alpha      a
  >;

  submethod BUILD ( :$gimp-hsl ) {
    self.setGimpHSL($gimp-hsl) if $gimp-hsl;
  }

  method setGimpHSL (GimpHSL $_) {
    $!g-hsl = $_;
  }

  method GIMP::Raw::Structs::GimpHSL
  { $!g-hsl }
  method GIMP::Raw::Structs::GimpRGB
  { self.to_rgb( :raw ) }
  method GIMP::Raw::Structs::GimpHSV
  { self.to_rgb.to_hsv( :raw ) }

  proto method new (|)
  { * }

  multi method new (GimpHSL $gimp-hsl) {
    $gimp-hsl ?? self.bless( :$gimp-hsl ) !! Nil;
  }
  multi method new (
    :h(:$hue)
    :s(:$saturation)
    :l(:$lightness)
    :a(:$alpha)
  ) {
    samewith($hue, $saturation, $lightness);
  }
  method new (Num() $h, Num() $s, Num() $l, Num() $a = 1e0) {
    my $gimp-hsl = GimpHSL.new;

    my $o = $gimp-hsl ?? self.bless( :$gimp-hsl ) !! Nil;
    return unless $o;

    ( .h, .s, .l, .a ) = ($h, $s, $l, $a) given $o;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_hsl_get_type, $n, $t );
  }

  multi method set (
    :h(:$hue)        = self.hue
    :s(:$saturation) = self.saturation
    :l(:$lightness)  = self.lightness
    :a(:$alpha)
  ) {
    self.set($hue, $saturation, $lightness);

    self.set_alpha($alpha) if $alpha;
  }
  multi method set (
    Num() $h,
    Num() $s,
    Num() $l
  ) {
    my gdouble ($hh, $ss, $ll) = ($h, $s, $l);

    gimp_hsl_set($!g-hsl, $hh, $ss, $ll);
  }

  method set_alpha (Num() $a) is also<set-alpha> {
    my gdouble $aa = $a;

    gimp_hsl_set_alpha($!g-hsl, $aa);
  }

  proto method to_rgb (|)
    is also<
      to-rgb
      rgb
      to-rgba
      rgba
    >
  { * }

  method to_rgb ( :$raw = False ) {
    samewith(Gimp::RGB.new);
  }
  method to_rgb (GimpRGB() $rgb, :$raw = False) {
    gimp_hsl_to_rgb($hsl, $rgb);

    propReturnObject($rgb, $raw, ::('Gimp::RGB').getTypePair
  }
}

### /usr/src/gimp/libgimpcolor/gimphsl.h

sub gimp_hsl_get_type
  returns GType
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_hsl_set (
  GimpHSL $hsl,
  gdouble $h,
  gdouble $s,
  gdouble $l
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_hsl_set_alpha (
  GimpHSL $hsl,
  gdouble $a
)
  is      native(gimpcolor)
  is      export
{ * }
