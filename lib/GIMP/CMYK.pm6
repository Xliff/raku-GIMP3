use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::CMYK;

use GLib::Roles::Implementor;

# BOXED

class GIMP::CMYK {
  has GimpCMYK $!g-cmyk is implementor handles<
    cyan    c
    magenta m
    yellow  y
    black   k
    alpha   a
  >;

  submethod BUILD ( :$gimp-cmyk ) {
    $!g-cmyk = $gimp-cmyk if $gimp-cmyk;
  }

  method setGimpCMYK (GimpCMYK $_) {
    $!g-cmyk = $_;
  }

  method GIMP::Raw::Structs::GimpCMYK
  { $!g-cmyk }

  multi method new (GimpCMYK $gimp-cmyk) {
    $gimp-cmyk ?? self.bless( :$gimp-cmyk ) !! Nil;
  }
  multi method new (
    :c(:$cyan    ) = 0e0,
    :m(:$magenta ) = 0e0,
    :y(:$yellow  ) = 0e0,
    :k(:$black   ) = 0e0,
    :a(:$alpha   ) = 1e0
  ) {
    my $gimp-cmyk = GimpCMYK.new(
      :$cyan
      :$magenta
      :$yellow
      :$black
      :$alpha
    );

    $gimp-cmyk ?? self.bless( :$gimp-cmyk ) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_cmyk_get_type, $n, $t );
  }

  proto method get_uchar (|)
  { * }

  multi method get_uchar {
    samewith($, $, $, $);
  }
  multi method get_uchar (
    $cyan    is rw,
    $magenta is rw,
    $yellow  is rw,
    $black   is rw
  ) {
    my uint8 ($c, $m, $y, $k) = 0 xx 4;

    gimp_cmyk_get_uchar($!g-cmyk, $c, $m, $y, $k);

    ($cyan, $magenta, $yellow, $black) = ($c, $m, $y, $k)
  }

  proto method gimp_cmyka_get_uchar (|)
  { * }

  multi method gimp_cmyka_get_uchar {
    samewith($, $, $, $, $);
  }
  multi method gimp_cmyka_get_uchar (
    $cyan    is rw,
    $magenta is rw,
    $yellow  is rw,
    $black   is rw,
    $alpha   is rw
  ) {
    my uint8 ($c, $m, $y, $k, $a) = 0 xx 5;

    gimp_cmyka_get_uchar($!g-cmyk, $c, $m, $y, $k, $a);

    ($cyan, $magenta, $yellow, $black, $alpha) = ($c, $m, $y, $k, $a)
  }

  proto method gimp_cmyka_set (|)
  { * }

  method gimp_cmyka_set (
    :$cyan    = self.cyan,
    :$magenta = self.magenta,
    :$yellow  = self.yellow,
    :$black   = self.black,
    :$alpha   = self.alpha
  ) {
    samewith($cyan, $magenta, $yellow, $black, $alpha);
  }
  method gimp_cmyka_set (
    Num() $cyan,
    Num() $magenta,
    Num() $yellow,
    Num() $black,
    Num() $alpha
  ) {
    my gdouble ($c, $m, $y, $k, $a) =
      ($cyan, $magenta, $yellow, $black, $alpha);

    gimp_cmyka_set($!g-cmyk, $c, $m, $y, $k, $a);
  }

  method gimp_cmyka_set_uchar (
    Int() $cyan,
    Int() $magenta,
    Int() $yellow,
    Int() $black,
    Int() $alpha
  ) {
    my uint8 ($c, $m, $y, $k, $a) =
      ($cyan, $magenta, $yellow, $black, $alpha);

    gimp_cmyka_set_uchar($!g-cmyk, $c, $m, $y, $k, $a);
  }

  method set (
    Num() $cyan,
    Num() $magenta,
    Num() $yellow,
    Num() $black
  ) {
    my gdouble ($c, $m, $y, $k) = ($cyan, $magenta, $yellow, $black);

    gimp_cmyk_set($!g-cmyk, $c, $m, $y, $k);
  }

  method set_uchar (
    Int() $cyan,
    Int() $magenta,
    Int() $yellow,
    Int() $black
  ) {
    my uint8 ($c, $m, $y, $k) = ($cyan, $magenta, $yellow, $black);

    gimp_cmyk_set_uchar($!g-cmyk, $c, $m, $y, $k);
  }

}
