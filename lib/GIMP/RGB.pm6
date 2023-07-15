use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::RGB;

# BOXED

class GIMP::RGB {
  has GimpRGB $!g-rgb handles<
    red   r
    green g
    blue  b
    alpha a
  >;

  has $!this;

  class RGBA {

    method add (GimpRGB() $rgba2) {
      gimp_rgba_add($!g-rgb, $rgba2);
      $!this;
    }

    method distance (GimpRGB() $rgba2) {
      gimp_rgba_distance($!g-rgb, $rgba2);
    }

    proto method get_pixel (|)
    { * }

    method get_pixel (Babl() $format) {
      my $b = CArray[uint8].allocate($format.bpp);

      samewith( $format, cast(gpointer, $b) )
      $b;
    }
    method get_pixel (Babl() $format, gpointer $pixel) {
      gimp_rgba_get_pixel($!g-rgb, $format, $pixel);
    }

    proto method get_uchar (|)
    { * }

    multi method get_uchar {
      samewit($, $, $, $);
    }
    multi method get_uchar (
      $red   is rw,
      $green is rw,
      $blue  is rw,
      $alpha is rw
    ) {
      my uint8 ($r, $g, $b, $a) = 0 xx 4;

      gimp_rgba_get_uchar($!g-rgb, $r, $g, $b, $a);
      ($red, $green, $blue, $alpha) = ($r, $g, $b, $a)
    }

    method multiply (Num() $f) {
      my gdouble $f = $factor;

      gimp_rgba_multiply($!g-rgb, $f);
      $!this;
    }

    method parse_css (
      Str     $css,
      gint    $len
    ) {
      gimp_rgba_parse_css($!g-rgb, $css, $len);
    }

    method set (Num() $red, Num() $green, Num() $blue, Num() $alpha) {
      my gdouble ($r, $g, $b, $a) = 0e0;

      gimp_rgba_set($!g-rgb, $r, $g, $b, $a);
      ($red, $green, $blue, $alpha) = ($r, $g, $b, $a);
    }


    proto method set_pixel (|)
    { * }

    method set_pixel (Babl() $format, $a) {
      samewith(
        $format,
        do given $a {
          when Array         { $_ = ArrayToCArray(uint8, $a); proceed }
          when CArray[uint8] { $_ = nativecast(gpointer, $_);         }
          when gpointer      { $_                                     }

          default {
            X::GLib::InvalidType.new(
              message => "Unknown type of { .^name } used when attempting to {
                          '' } .set_pixel"
            ).throw
          }
        }
      );
    }
    method set_pixel (Babl() $format, gpointer $pixel) {
      gimp_rgba_set_pixel($!g-rgb, $format, $pixel);
    }

    proto method set_uchar (|)
    { * }

    method set_uchar (
      Int() :r(:$red)   = self.red,
      Int() :g(:$green) = self.green,
      Int() :b(:$blue)  = self.blue,
      Int() :a(:$alpha) = self.alpha
    ) {
      samewith($red, $green, $blue, $alpha);
    }
    method set_uchar (
      Int() $red,
      Int() $green,
      Int() $blue,
      Int() $alpha
    ) {
      gimp_rgba_set_uchar($!g-rgb, $red, $green, $blue, $alpha);
    }

    method subtract (GimpRGB() $rgba) {
      gimp_rgba_subtract($!g-rgb, $rgba2);
    }
  }

  has RGBA $!rgba .= new;

  submethod BUILD ( :$gimp-rgb ) {
    self.setGimpRGB($gimp-rgb) if $gimp-rgb;
  }

  method setGimpRGB (GimpRGB $_) {
    return unless $_;

    $!g-rgb = $_;
    $!this  = self;
  }

  method add (GimpRGB() $rgb2) {
    gimp_rgb_add($!g-rgb, $rgb2);
  }

  method clamp {
    gimp_rgb_clamp($!g-rgb);
  }

  method composite (GimpRGB() $color2, Int() $mode) {
    my GimpRGBCompositeMode $m = $mode;

    gimp_rgb_composite($!g-rgb, $color2, $mode);
    self;
  }

  method distance (GimpRGB() $rgb2) {
    gimp_rgb_distance($!g-rgb, $rgb2);
  }

  method gamma (Num() $gamma) {
    my gdouble $g = $gamma;

    gimp_rgb_gamma($!g-rgb, $gamma);
    self;
  }

  proto method get_pixel (|)
  { * }

  method get_pixel (Babl() $format) {
    my $a = CArray[uint8].allocate( $format.bpp );
    samewith( $format, cast(gpointer, $a) );
    $a;
  }
  method get_pixel (Babl() $format, gpointer $pixel) {
    gimp_rgb_get_pixel($!g-rgb, $format, $pixel);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_rgb_get_type, $n, $t );
  }

  proto method get_uchar (|)
  { * }

  multi method get_uchar {
    samewith($, $, $);
  }
  multi method get_uchar ($red is rw, $green is rw, $blue is rw) {
    my uint8 ($r, $g, $b) = 0 xx 3;

    gimp_rgb_get_uchar($!g-rgb, $r, $g, $b);
    ($red, $green, $blue) = ($r, $g, $b);
  }

  proto method list_names (|)
  { * }

  multi method list_names ( :$raw = False ) {
    my $ccs = CArray[Pointer[Str]].new;
    $ccs[0] = Pointer[Str];

    samewith(
       $ccs,
       newCArray( GimpRGB ),
       $,
      :$raw
    );
  }
  multi method list_names (
    CArray[Pointer[Str]]      $names,
    CArray[Pointer[GimpRGB]]  $colors,
                              $n_colors is rw,
                             :$raw            = False,
                             :$hash           = True
  ) {
    my gint $n = 0;

    gimp_rgb_list_names($names, $colors, $n);

    my $na = cast( CArray[Str], $names[0] );
    my $cb = GLib::Roles::TypedBuffer[GimpRGB].new( $colors[0], size => $n );

    my %h;
    my @a = ( $na[^$n], $cb.Array );
    return @a unless $hash;
    %h{ @a.head[$_] } = @a.tail[$_] for ^$n;
    %h;
  }

  method luminance {
    gimp_rgb_luminance($!g-rgb);
  }

  method luminance_uchar {
    gimp_rgb_luminance_uchar($!g-rgb);
  }

  method max {
    gimp_rgb_max($!g-rgb);
  }

  method min {
    gimp_rgb_min($!g-rgb);
  }

  method multiply (Num() $factor_
  ) {
    gimp_rgb_multiply($!g-rgb, $factor);
    self;
  }

  method parse_css (Str() $css, Int() $len = -1) {
    my gint $l = $len;

    my $rv = so gimp_rgb_parse_css($!g-rgb, $css, $l);
    $rv ?? self !! Nil
  }

  method parse_hex (Str() $hex, Int() $len = -1) {
    my gint $l = $len;

    my $rv = so gimp_rgb_parse_hex($!g-rgb, $hex, $len);
    $rv ?? self !! Nil;
  }

  method parse_name (Str() $name, Int() $len = -1) {
    my $rv = so gimp_rgb_parse_name($!g-rgb, $name, $len);
    $rv ?? self !! Nil;
  }

  method set (
    Num() $red,
    Num() $green,
    Num() $blue
  ) {
    my gdouble ($r, $g, $b) = ($red, $green, $blue);;

    gimp_rgb_set($!g-rgb, $r, $g, $b);
  }

  method set_alpha (Num() $alpha) {
    my gdouble $a = $alpha;

    gimp_rgb_set_alpha($!g-rgb, $a);
  }

  proto method set_pixel (|)
  { * }

  multi method set_pixel (Babl() $format, $a) {
    X::GLib::InvalidValue.new(
      message => "Pixel value is of invalid size ({ $a.elems }) for the {
                  '' }given format requirement ({ $format.bpp })"
    ).throw unless $a.elems == $format.bpp;

    samewith(
      $fomat,
      do given $a {
        when Array         { ArrayToCArray(uint8, $_); proceed }
        when CArray[uint8] { cast(gpointer, $_)                }
        when gpointer      { $_                                }

        default {
          X::GLib::InvalidType.new(
            message => "Unknown type { .^name } encountered when attempting {
                        '' }to .set_pixel"
          ).throw;
        }
      }
    );
  }
  multi method set_pixel (Babl() $format, gpointer $pixel) {
    gimp_rgb_set_pixel($!g-rgb, $format, $pixel);
  }

  proto method set_uchar (|)
  { * }

  method set_uchar (
    Int() :r(:$red)   = self.red,
    Int() :g(:$green) = self.green,
    Int() :b(:$blue)  = self.blue
  ) {
    samewith($red, $green, $blue);
  }
  method set_uchar (Int() $red, Int() $green, Int() $blue) {
    my uint8 ($r, $g, $b) = ($red, $green, $blue);

    gimp_rgb_set_uchar($!g-rgb, $r, $g, $b);
  }

  method subtract (GimpRGB() $rgb2) {
    gimp_rgb_subtract($!g-rgb, $rgb2);
    self;
  }

}

role GIMP::Roles::ParamSpec::RGB {

  method GParamSpec { ... }

  method rgb_get_type {
    state ($n, $t);

    unstable_get_type( ::?ROLE.^name, &gimp_param_rgb_get_type, $n, $t );
  }

  method rgb (
    Str()     $nick,
    Str()     $blurb,
    Int()     $has_alpha,
    GimpRGB() $default_value,
    Int()     $flags
  ) {
    my gboolean    $h = $has_alpha.so.Int;
    my GParamFlags $f = $flags;

    gimp_param_spec_rgb(self.GParamSpec, $nick, $blurb, $has_alpha, $default_value, $flags);
  }

  method rgb_get_default (GimpRGB() $default_value, :$raw = False) {
    propReturnObject(
      gimp_param_spec_rgb_get_default(self.GParamSpec, $default_value),
      $raw,
      |GIMP::RGB.getTypePair
    );
  }

  method rgb_has_alpha {
    so gimp_param_spec_rgb_has_alpha(self.GParamSpec);
  }

}

role GIMP::Roles::Value {

  method GValue { ... }

  proto method get_gimp_rgb (|)
  { * }

  multi method get_gimp_rgb ( :$raw = False ) {
    samewith(GimpRGB.new, :$raw);  }
  multi method get_gimp_rgb (GimpRGB() $rgb, :$raw = False) {
    gimp_value_get_rgb($!g-rgb, $rgb);
  }

  method set_gimp_rgb (GimpRGB() $rgb) {
    gimp_value_set_rgb($!g-rgb, $rgb);
  }

}

multi sub infix:<🌈+> (GIMP::RGB $a, GIMP::RGB $b) is export
  { $a.rgba.add($b)            }

multi sub infix:<🌈*> (GIMP::RGB $a, Num       $b) is export
  { $a.rgba.multiply($b)       }
multi sub infix:<🌈*> (Num       $a, GIMP::RGB $b) is export
  { $b.rgba.multiply($a)       }

multi sub infix:<🌈-> (GIMP::RGB $a, GIMP::RGB $b) is export
  { $a.rgba.substract($b)      }

multi sub infix:<🌈/> (GIMP::RGB $a, Num       $b) is export
  { $a.rgba.multiply($b ** -1) }
multi sub infix:<🌈/> (Num       $a, GIMP::RGB $b) is export
  { $b.rgba.multiply($a ** -1) }

multi sub infix:<A+> (GIMP::RGB $a, GIMP::RGB $b) is export
  { $a.rgba.add($b)            }

multi sub infix:<A*> (GIMP::RGB $a, Num       $b) is export
  { $a.rgba.multiply($b)     }
multi sub infix:<A*> (Num       $a, GIMP::RGB $b) is export
  { $b.rgba.multiply($a)     }

multi sub infix:<A-> (GIMP::RGB $a, GIMP::RGB $b) is export
  { $a.rgba.substract($b)      }

multi sub infix:<A/> (GIMP::RGB $a, Num       $b) is export
  { $a.rgba.multiply($b ** -1) }
multi sub infix:<A/> (Num       $a, GIMP::RGB $b) is export
  { $b.rgba.multiply($a ** -1) }

multi sub infix:<+>   (GIMP::RGB $a, GIMP::RGB $b) is export
  { $a.add($b)            }

multi sub infix:<*>   (GIMP::RGB $a, Num       $b) is export
  { $a.multiply($b)       }

multi sub infix:<->   (GIMP::RGB $a, GIMP::RGB $b) is export
  { $a.substract($b)      }

multi sub infix:</>   (GIMP::RGB $a, Num       $b) is export
  { $a.multiply($b ** -1) }
