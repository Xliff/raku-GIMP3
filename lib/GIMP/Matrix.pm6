use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::Matrix;

use GLib::Roles::Implementor;

class GIMP::Matrix2 {
  has GimpMatrix2 $!g-m is implementor handles<Array>;

  submethod BUILD ( :$gimp-matrix2 ) {
    $!g-m = $gimp-matrix2;
  }

  method GIMP::Raw::Structs::GimpMatrix2
    #is also<GimpMatrix2>
  { $!g-m }

  multi method new (GimpMatrix2 $gimp-matrix2) {
    $gimp-matrix2 ?? self.bless( :$gimp-matrix2 ) !! Nil;
  }
  multi method new (@a) {
    my $gimp-matrix2 = GimpMatrix2.new(@a);

    $gimp-matrix2 ?? self.bless( :$gimp-matrix2 ) !! Nil;
  }
  multi method new {
    samewith(GimpMatrix2.new);
  }
  multi method new ( :i(:$identity) is required ) {
    ::?CLASS.new.identity;
  }

  method determinant {
    gimp_matrix2_determinant($!g-m);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_matrix2_get_type, $n, $t );
  }

  method identity {
    gimp_matrix2_identity($!g-m);
    self;
  }

  method invert {
    gimp_matrix2_invert($!g-m);
    self;
  }

  method mult (GimpMatrix2() $left) {
    # cw: Invocant moved to RHS to allow for chaining.
    gimp_matrix2_mult($left, $!g-m);
    self;
  }

  proto method transform_point (|)
    is also<transform-point>
  { * }

  multi method transform_point (Num() $x, Num() $y) {
    samewith($x, $y, $, $);
  }
  multi method transform_point (
    Num() $x,
    Num() $y,
          $newx is rw,
          $newy is rw
  ) {
    my gdouble ($nx, $ny) = 0e0 xx 2;

    gimp_matrix2_transform_point($!g-m, $x, $y, $nx, $ny);
    ($newx, $newy) = ($nx, $ny);
  }

  method gist {
    "GIMP::Vector2.new( { $!g-m.Array.gist } )";
  }

}

class GIMP::Matrix3 {
  has GimpMatrix3 $!g-m is implementor;

  method affine (Num() $a, Num() $b, Num() $c, Num() $d, Num() $e, Num() $f) {
    my gdouble ($aa, $bb, $cc, $dd, $ee, $ff) = ($a, $b, $c, $d, $e, $f);

    gimp_matrix3_affine($!g-m, $aa, $bb, $cc, $dd, $ee, $ff);
  }

  method determinant {
    gimp_matrix3_determinant($!g-m);
  }

  method equal (GimpMatrix3() $matrix2) {
    so gimp_matrix3_equal($!g-m, $matrix2);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_matrix3_get_type, $n, $t );
  }

  method identity {
    gimp_matrix3_identity($!g-m);
  }

  method invert {
    gimp_matrix3_invert($!g-m);
  }

  method is_affine is also<is-affine> {
    so gimp_matrix3_is_affine($!g-m);
  }

  method is_diagonal is also<is-diagonal> {
    so gimp_matrix3_is_diagonal($!g-m);
  }

  method is_identity is also<is-identity> {
    so gimp_matrix3_is_identity($!g-m);
  }

  method is_simple is also<is-simple> {
    so gimp_matrix3_is_simple($!g-m);
  }

  method mult (GimpMatrix3() $left) {
    # cw: Invocant moved to RHS to allow for chaining.
    gimp_matrix3_mult($left, $!g-m);
    self;
  }

  method rotate (Num() $theta) {
    my gdouble $t = $theta;

    gimp_matrix3_rotate($!g-m, $t);
  }

  method scale (Num() $x, Num() $y) {
    my gdouble ($xx, $yy);

    gimp_matrix3_scale($!g-m, $xx, $yy);
  }

  proto method transform_point (|)
    is also<transform-point>
  { * }

  multi method transform_point (Num() $x, Num() $y) {
    samewith($x, $y, $, $);
  }
  multi method transform_point (
    Num() $x,
    Num() $y,
          $newx is rw,
          $newy is rw
  ) {
    my gdouble ($nx, $ny) = 0e0 xx 2;

    gimp_matrix3_transform_point($!g-m, $x, $y, $newx, $newy);
    ($newx, $newy) = ($nx, $ny)
  }

  method translate (Num() $x, Num() $y) {
    my gdouble ($xx, $yy) = ($x, $y);

    gimp_matrix3_translate($!g-m, $xx, $yy);
    self
  }

  method xshear (Num() $amount) {
    my gdouble $a = $amount;

    gimp_matrix3_xshear($!g-m, $a);
    self;
  }

  method yshear (Num() $amount) {
    my gdouble $a = $amount;

    gimp_matrix3_yshear($!g-m, $a);
    self;
  }

  method gist {
    "GIMP::Vector3.new( { $!g-m.Array.gist } )";
  }
}

class GIMP::Matrix4 {
  has GimpMatrix4 $!g-m is implementor;

  method identity {
    gimp_matrix4_identity($!g-m);
    self;
  }

  method mult (GimpMatrix4() $right) {
    gimp_matrix4_mult($!g-m, $right);
    self;
  }

  proto method to_deg (|)
    is also<to-deg>
  { * }

  multi method to_deg {
    samewith($, $, $);
  }
  multi method to_deg ($a is rw, $b is rw, $c is rw) {
    my gdouble ($aa, $bb, $cc) = 0e0 xx 3;

    gimp_matrix4_to_deg($!g-m, $aa, $bb, $cc);
    ($a, $b, $c) = ($aa, $bb, $cc);
  }

  proto method transform_point (|)
    is also<transform-point>
  { * }

  multi method transform_point (Num() $x, Num() $y, Num() $z) {
    samewith($x, $y, $z, $, $, $);
  }
  multi method transform_point (
    Num() $x,
    Num() $y,
    Num() $z,
          $newx is rw,
          $newy is rw,
          $newz is rw
  ) {
    my gdouble ($xx, $yy, $zz) = ($x, $y, $z);
    my gdouble ($nx, $ny, $nz) =  3e0 xx 3;

    gimp_matrix4_transform_point($!g-m, $xx, $yy, $zz, $nx, $ny, $nz);
    ($newx, $newy, $newz) = ($nx, $ny, $nz);
  }

  method gist {
    "GIMP::Vector4.new( { $!g-m.Array.gist } )";
  }
}

class GIMP::Matrix::ParamSpec {

  method matrix2_get_type is also<matrix2-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_param_matrix2_get_type, $n, $t );
  }

  method matrix3_get_type is also<matrix3-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_param_matrix3_get_type, $n, $t );
  }

  method matrix2 (
    Str()         $name,
    Str()         $nick,
    Str()         $blurb,
    GimpMatrix2() $default_value,
    Int()         $flags
  ) {
    my GParamFlags $f = $flags;

    gimp_param_spec_matrix2($name, $nick, $blurb, $default_value, $f);
  }

  method matrix3 (
    Str()         $name,
    Str()         $nick,
    Str()         $blurb,
    GimpMatrix3() $default_value,
    Int()         $flags
  ) {
    my GParamFlags $f = $flags;

    gimp_param_spec_matrix3($name, $nick, $blurb, $default_value, $f);
  }

}
