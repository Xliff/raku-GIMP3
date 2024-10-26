use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::Colorspace;

use GLib::Roles::Implementor;

# BOXED

class GIMP::HSV {
  also does GLib::Roles::Implementor;
  
  has GimpHSV $!g-hsv is implementor handles<
    hue        h
    saturation s
    value      v
    alpha      a
  >;

  submethod BUILD ( :$gimp-hsv ) {
    self.setGimpHSV($gimp-hsv) if $gimp-hsv;
  }

  method setGimpHSV (GimpHSV $_) {
    $!g-hsv = $_;
  }

  method GIMP::Raw::Structs::GimpHSV
  { $!g-hsv }
  method GIMP::Raw::Structs::GimpRGB
  { self.to_rgba( :raw ) }
  method GIMP::Raw::Structs::GimpHSL
  { self.to_rgba.to_hsv( :raw ) }

  proto method new (|)
  { * }

  multi method new (GimpHSV $gimp-hsv) {
    $gimp-hsv ?? self.bless( :$gimp-hsv ) !! Nil;
  }
  multi method new (
    :h(:$hue),
    :s(:$saturation),
    :v(:$value),
    :a(:$alpha)
  ) {
    samewith($hue, $saturation, $value, $alpha);
  }
  multi method new (Num() $h, Num() $s, Num() $v, Num() $a = 1e0) {
    my $gimp-hsv = GimpHSV.new;

    my $o = $gimp-hsv ?? self.bless( :$gimp-hsv ) !! Nil;
    return unless $o;

    ( .h, .s, .v, .a ) = ($h, $s, $v, $a) given $o;
    $o;
  }

  method clamp {
    gimp_hsv_clamp($!g-hsv);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_hsv_get_type, $n, $t );
  }

  multi method hsva_set (
    :h(:$hue)        = self.hue,
    :s(:$saturation) = self.saturation,
    :v(:$value)      = self.value,
    :a(:$alpha)      = self.alpha
  ) {
    self.hsva_set($hue, $saturation, $value);
  }
  multi method hsva_set (
    Num() $h,
    Num() $s,
    Num() $v,
    Num() $a
  ) {
    my gdouble ($hh, $ss, $vv, $aa) = ($h, $s, $v, $a);

    gimp_hsva_set($!g-hsv, $hh, $ss, $vv, $aa);
  }

  multi method set (
    :h(:$hue)        = self.hue,
    :s(:$saturation) = self.saturation,
    :v(:$value)      = self.value
  ) {
    self.set($hue, $saturation, $value);
  }
  multi method set (
    Num() $h,
    Num() $s,
    Num() $v
  ) {
    my gdouble ($hh, $ss, $vv) = ($h, $s, $v);

    gimp_hsv_set($!g-hsv, $hh, $ss, $vv);
  }

  proto method to_rgb (|)
  { * }

  multi method to_rgb ( :$raw = False ) {
    samewith( GimpRGB.new, :$raw );
  }
  multi method to_rgb (GimpRGB() $rgb, :$raw = False) {
    return Nil unless $rgb;

    gimp_hsv_to_rgb($!g-hsv, $rgb);
    propReturnObject($rgb, $raw, ::('Gimp::RGB').getTypePair)
  }

}

### /usr/src/gimp/libgimpcolor/gimphsv.h

sub gimp_hsv_clamp (GimpHSV $hsv)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_hsv_get_type
  returns GType
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_hsva_set (
  GimpHSV $hsva,
  gdouble $hue,
  gdouble $saturation,
  gdouble $value,
  gdouble $alpha
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_hsv_set (
  GimpHSV $hsv,
  gdouble $hue,
  gdouble $saturation,
  gdouble $value
)
  is      native(gimpcolor)
  is      export
{ * }
