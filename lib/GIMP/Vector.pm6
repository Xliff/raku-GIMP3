use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Vector;

# BOXED

class GIMP::Vector2 {
  has GimpVector2 $!v2 is implementor handles<x y>;

  submethod BUILD ( :$gimp-vector2 ) {
    $!v2 = $gimp-vector2 if $gimp-vector2;
  }

  method GIMP::Raw::Structs::GimpVector2
    is also<GimpVector2>
  { $!v2 }

  multi method new (GimpVector2 $gimp-vector2) {
    $gimp-vector2 ?? self.bless( :$gimp-vector2 ) !! Nil
  }
  multi method new (Num() :$x, Num() :$y) {
    samewith($x, $y);
  }
  multi method new (Num() $x, Num() $y) {
    # my gdouble ($xx, $yy) = ($x, $y);
    #
    # my $gimp-vector2 = gimp_vector2_new($xx, $yy);
    #
    # $gimp-vector2 ?? self.bless( :$gimp-vector2 ) !! Nil
    my $gimp-vector2 = GimpVector2.new( x => $x, y => $y );

    $gimp-vector2 ?? self.bless( :$gimp-vector2 ) !! Nil
  }

  multi method add (GimpVector2() $vector2) {
    my $r = GimpVector2.new;
    samewith($vector2, $r);
    ::?CLASS.new($r);
  }
  multi method add (GimpVector2() $vector2, GimpVector2() $result) {
    gimp_vector2_add($result, $!v2, $vector2);
  }

  method cross_product (GimpVector2() $vector2) is also<cross-product> {
    my $new-x = $!v2.x * $vector2.y - $!v2.y * $vector2.x;
    my $new-y = $!v2.y * $vector2.x - $!v2.x * $vector2.y;
    ($!v2.x, $!v2.y) = ($new-x, $new-y);
    self;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(self.^name, &gimp_vector2_get_type, $n, $t );
  }

  method inner_product (GimpVector2() $vector2) is also<inner-product> {
    gimp_vector2_inner_product($!v2, $vector2);
  }

  method length {
    gimp_vector2_length($!v2);
  }

  method mul (Num() $factor) {
    my gdouble $f = $factor;

    gimp_vector2_mul($!v2, $f);
    self
  }

  method neg {
    gimp_vector2_neg($!v2);
    self
  }

  method normal {
    my $r = GimpVector2.new;
    $r.x = -$!v2.y;
    $r.y = $!v2.x;

    gimp_vector2_normalize($r);
    ::?CLASS.new($r);
  }

  method normalize {
    gimp_vector2_normalize($!v2);
    self;
  }

  method rotate (Num() $alpha) {
    my gdouble $a = $alpha;

    gimp_vector2_rotate($!v2, $alpha);
    self;
  }

  method set (Num() $x, Num() $y) {
    my gdouble ($xx, $yy) = ($x, $y);

    gimp_vector2_set($!v2, $xx, $yy);
  }

  multi method sub (GimpVector2() $vector2) {
    my $r = GimpVector2.new;
    samewith($vector2, $r);
    ::?CLASS.new($r);
  }
  multi method sub (GimpVector2() $vector2, GimpVector2() $result) {
    gimp_vector2_sub($result, $!v2, $vector2);
  }

  method raku {
    "GIMP::Vector2.new( x => { self.x }, y => { self.y } );";
  }

}

class GIMP::Vector3 {
  has GimpVector3 $!v3 is implementor handles<x y z>;

  submethod BUILD ( :$gimp-vector3 ) {
    $!v3 = $gimp-vector3 if $gimp-vector3;
  }

  method GIMP::Raw::Structs::GimpVector3
    is also<GimpVector3>
  { $!v3 }

  multi method new (GimpVector3 $gimp-vector3) {
    $gimp-vector3 ?? self.bless( :$gimp-vector3 ) !! Nil;
  }
  multi method new (Num() :$x, Num() :$y, Num() :$z) {
    samewith($x, $y, $z);
  }
  multi method new (Num() $x, Num() $y, Num() $z) {
    # gimp_vector3_new($x, $y, $z);
    my $gimp-vector3 = GimpVector3.new( :$x, :$y, :$z );

    $gimp-vector3 ?? self.bless( :$gimp-vector3 ) !! Nil;
  }

  multi method add (GimpVector3() $vector2) {
    my $r = GimpVector3.new;
    samewith($vector2, $r);
    ::?CLASS.new($r);
  }
  multi method add (GimpVector3() $vector2, GimpVector3() $result) {
    gimp_vector3_add($result, $!v3, $vector2);
  }

  method cross_product (GimpVector3() $vector2) is also<cross-product> {
    gimp_vector3_cross_product($!v3, $vector2);
    self;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(self.^name, &gimp_vector2_get_type, $n, $t );
  }

  method inner_product (GimpVector3() $vector2) is also<inner-product> {
    gimp_vector3_inner_product($!v3, $vector2);
    self;
  }

  method length {
    gimp_vector3_length($!v3);
  }

  method mul (Num() $factor) {
    my gdouble $f = $factor;

    gimp_vector3_mul($!v3, $f);
    self;
  }

  method neg {
    gimp_vector3_neg($!v3);
    self;
  }

  method normalize {
    gimp_vector3_normalize($!v3);
  }

  method rotate (Num() $alpha, Num() $beta, Num() $gamma) {
    my gdouble (\α, \β, \ξ) = ($alpha, $beta, $gamma);

    gimp_vector3_rotate($!v3, α, β, ξ);
    self;
  }

  method set (Num() $x, Num() $y, Num() $z) {
    my gdouble ($xx, $yy, $zz) = ($x, $y, $z);

    gimp_vector3_set($!v3, $xx, $yy, $zz);
    self;
  }

  multi method sub (GimpVector3() $vector2) {
    my $r = GimpVector3.new;
    samewith($vector2, $r);
    ::?CLASS.new($r);
  }
  multi method sub (GimpVector3() $vector2, GimpVector3() $result) {
    gimp_vector3_sub($result, $!v3, $vector2);
  }

  proto method v2d_to_3d (|)
    is also<2d-to-3d>
  { * }

  multi method v2d_to_3d (
    Int()          $sx,
    Int()          $sy,
    Int()          $w,
    Int()          $h,
    Int()          $x,
    Int()          $y,
    Num()         :$z = 0
  ) {
    my $p = GimpVector3.new( :$z );
    gimp_vector_2d_to_3d($sx, $sy, $w, $h, $x, $y, $!v3, $p);
    ::?CLASS.new($p);
  }
  multi method v2d_to_3d (
    Int()         $sx,
    Int()         $sy,
    Int()         $w,
    Int()         $h,
    Int()         $x,
    Int()         $y,
    GimpVector3() $p
  ) {
    my gint ($ssx, $ssy, $ww, $hh, $xx, $yy) = ($sx, $sy, $w, $h, $x, $y);

    gimp_vector_2d_to_3d($ssx, $ssy, $ww, $hh, $xx, $yy, $!v3, $p);
  }

  # method gimp_vector_3d_to_2d (
  #   gint        $sx,
  #   gint        $sy,
  #   gint        $w,
  #   gint        $h,
  #   gdouble     $x is rw,
  #   gdouble     $y is rw,
  #   GimpVector3 $vp,
  #   GimpVector3 $p
  # ) {
  #   gimp_vector_3d_to_2d($sx, $sy, $w, $h, $x, $y, $vp, $p);
  # }

  method raku {
    "GIMP::Vector3.new( x => { self.x }, y => { self.y }, z => { self.z } );";
  }
}
