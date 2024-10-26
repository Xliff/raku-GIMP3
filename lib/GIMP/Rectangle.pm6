use v6;

use NativeCall;

use GIMP::Raw::Types;

use GLib::Roles::StaticClass;

class GIMP::Rectangle {
  also does GLib::Roles::StaticClass;

  multi method intersect (
    Int() $x1,
    Int() $y1,
    Int() $width1,
    Int() $height1,
    Int() $x2,
    Int() $y2,
    Int() $width2,
    Int() $height2
  ) {
    samewith(
       $x1, $y1, $width1, $height1,
       $x2, $y2, $width2, $height2,
         $,   $,       $,        $,
      :all
    );
  }
  multi method intersect (
    Int()  $x1,
    Int()  $y1,
    Int()  $width1,
    Int()  $height1,
    Int()  $x2,
    Int()  $y2,
    Int()  $width2,
    Int()  $height2,
           $dest_x      is rw,
           $dest_y      is rw,
           $dest_width  is rw,
           $dest_height is rw,
          :$all                = False
  ) {
    my gint ($xx1, $yy1, $w1, $h1, $xx2, $yy2, $w2, $h2, $dx, $dy, $dw, $dh)
      = (
        $x1, $y1, $w1, $h1,
        $x2, $y2, $w2, $h2,
          0,   0,   0,   0
      );

    my $rv = so gimp_rectangle_intersect(
      $xx1, $yy1, $w1, $h1,
      $xx2, $yy2, $w2, $h2,
       $dx,  $dy, $dw, $dh
    );
    ($dest_x, $dest_y, $dest_width, $dest_height) = ($dx, $dy, $dw, $dh);
    $all.not ?? $rv !! ($rv, $dest_x, $dest_y, $dest_width, $dest_height);
  }

  multi method union (
    Int() $x1,
    Int() $y1,
    Int() $width1,
    Int() $height1,
    Int() $x2,
    Int() $y2,
    Int() $width2,
    Int() $height2
  ) {
    samewith(
       $x1, $y1, $width1, $height1,
       $x2, $y2, $width2, $height2,
         $,   $,       $,        $
    );
  }
  multi method union (
    Int() $x1,
    Int() $y1,
    Int() $width1,
    Int() $height1,
    Int() $x2,
    Int() $y2,
    Int() $width2,
    Int() $height2,
    $dest_x      is rw,
    $dest_y      is rw,
    $dest_width  is rw,
    $dest_height is rw,
  ) {
    my gint ($xx1, $yy1, $w1, $h1, $xx2, $yy2, $w2, $h2, $dx, $dy, $dw, $dh)
      = (
      $x1, $y1, $w1, $h1,
      $x2, $y2, $w2, $h2,
        0,   0,   0,   0
    );

    gimp_rectangle_union(
      $xx1, $yy1, $w1, $h1,
      $xx2, $yy2, $w2, $h2,
       $dx,  $dy, $dw, $dh
    );
    ($dest_x, $dest_y, $dest_width, $dest_height) = ($dx, $dy, $dw, $dh);
  }

}

### /usr/src/gimp/libgimpbase/gimprectangle.h

sub gimp_rectangle_intersect (
  gint $x1,
  gint $y1,
  gint $width1,
  gint $height1,
  gint $x2,
  gint $y2,
  gint $width2,
  gint $height2,
  gint $dest_x      is rw,
  gint $dest_y      is rw,
  gint $dest_width  is rw,
  gint $dest_height is rw
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_rectangle_union (
  gint $x1,
  gint $y1,
  gint $width1,
  gint $height1,
  gint $x2,
  gint $y2,
  gint $width2,
  gint $height2,
  gint $dest_x      is rw,
  gint $dest_y      is rw,
  gint $dest_width  is rw,
  gint $dest_height is rw
)
  is      native(gimpbase)
  is      export
{ * }
