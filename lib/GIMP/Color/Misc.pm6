use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::Color::Misc;

use GLib::Roles::StaticClass;
use GLib::Roles::TypedBuffer;

class GIMP::Color::Misc {
  also does GLib::Roles::StaticClass;

  multi method area (
    Int()          $max_depth,
    Num()          $threshold,
                   &render_func,
                   &put_pixel_func,
                   &progress_func,
   GdkRectangle() :rect(:$rectangle) is copy        = GdkRectangle.new,
   Int()          :$x1                              = $rect.x1,
   Int()          :$y1                              = $rect.y1,
   Int()          :$x2                              = $rect.x2,
   Int()          :$y2                              = $rect.y2,
   gpointer       :render-data(:$render_data)       = gpointer,
   gpointer       :put-pixel-data(:$put_pixel_data) = gpointer,
   gpointer       :progress-data(:$progress_data)   = gpointer
  ) {
    if $rectangle && ($x1, $y1, $x2, $y2).any.so {
      X::GLib::InvalidArguments.new(
        message => "Cannot use <rectangle> and coordinate values of {
                    '' }<x1>, <y1>, <x2>, <y2> in the same call!"
      ).throw
    }

    unless $rectanle {
      unless ($x1, $y1, $x2, $y2).all.so {
        X::GLib::InvalidArguments.new(
          message => "<x1>, <y1>, <x2>, and <y2> must be given!"
        ).throw
      }

      (.x, .y, .height, .width) =  ($x1, $y1, $y2 - $y1, $x2 - $x1)
        given $rectangle;
    }

    X::GLib::InvalidValue.new(
      message => "Subsampling rectangle must have a with and a height!"
    ) unless $rectangle;

    samewith(
      $x1,
      $y1,
      $x2,
      $y2,
      $max_depth,
      $threshold,
      &render_func,
      $render_data,
      &put_pixel_func,
      $put_pixel_data,
      &progress_func,
      $progress_data
    );
  }
  multi method area (
    Int()    $x1,
    Int()    $y1,
    Int()    $x2,
    Int()    $y2,
    Int()    $max_depth,
    Num()    $threshold,
             &render_func,
    gpointer $render_data,
             &put_pixel_func,
    gpointer $put_pixel_data,
             &progress_func,
    gpointer $progress_data
  ) {
    my gint    ($X1, $Y1, $X2, $Y2) = ($x1, $y1, $x2, $y2);
    my gdouble  $t                  =  $threshold;

    gimp_adaptive_supersample_area(
      $X1,
      $Y1,
      $X2,
      $Y2,
      $max_depth,
      $threshold,
      &render_func,
      $render_data,
      &put_pixel_func,
      $put_pixel_data,
      &progress_func,
      $progress_data
    );
  }

  proto multi method bilinear_16 (|)
  { * }

  method bilinear_16 (Num() $x, Num() $y, @values) {
    X::GLib::InvalidSize.new(
      message => '@values must have exactly 4 elements!'
    ).throw unless @values.elems == 4;

    samewith(
      $x,
      $y,
      newCArray(uint16, @values)
    );
  }
  method bilinear_16 (
    Num()           $x,
    Num()           $y,
    CArray[guint16] $values
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gimp_bilinear_16($x, $y, $values);
  }

  proto multi method bilinear_32 (|)
  { * }

  multi method bilinear_32 (Num() $x, Num() $y, @values) {
    X::GLib::InvalidSize.new(
      message => '@values must have exactly 4 elements!'
    ).throw unless @values.elems == 4;

    samewith(
      $x,
      $y,
      newCArray(uint32, @values)
    );
  }
  multi method bilinear_32 (
    Num()           $x,
    Num()           $y,
    CArray[guint32] $values
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gimp_bilinear_32($x, $y, $values);
  }

  proto multi method bilinear_8 (|)
  { * }

  multi method bilinear_8 (Num() $x, Num() $y, @values) {
    X::GLib::InvalidSize.new(
      message => '@values must have exactly 4 elements!'
    ).throw unless @values.elems == 4;

    samewith(
      $x,
      $y,
      newCArray(uint8, @values)
    );
  }
  method bilinear_8 (
    Num()         $x,
    Num()         $y,
    CArray[uint8] $values
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gimp_bilinear_8($x, $y, $values);
  }

  multi method bilinear (Num() $x, Num() $y, @values) {
    X::GLib::InvalidSize.new(
      message => '@values must have exactly 4 elements!'
    ).throw unless @values.elems == 4;

    samewith(
      $x,
      $y,
      newCArray(gdouble, @values)
    );
  }
  method bilinear (
    Num()           $x,
    Num()           $y,
    CArray[gdouble] $values
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gimp_bilinear($x, $y, $values);
  }

  proto method bilinear_rgb (|)
  { * }

  multi method bilinear_rgb (Num() $x, Num() $y, @values) {
    X::GLib::InvalidSize.new(
      message => '@values must have exactly 4 elements!'
    ).throw unless @values.elems == 4;

    samewith(
      $x,
      $y,
      GLib::Roles::TypedBuffer[GimpRGB].new(@values).p
    );
  }
  multi method bilinear_rgb (Num() $x, Num() $y, gpointer $values) {
    gimp_bilinear_rgb($x, $y, $values);
  }

  proto method bilinear_rgba (|)
  { * }

  multi method bilinear_rgba (Num() $x, Num() $y, @values) {
    X::GLib::InvalidSize.new(
      message => '@values must have exactly 4 elements!'
    ).throw unless @values.elems == 4;

    samewith(
      $x,
      $y,
      GLib::Roles::TypedBuffer[GimpRGB].new(@values).p
    );
  }
  multi method bilinear_rgba (Num() $x, Num() $y, gpointer $values) {
    gimp_bilinear_rgba($x, $y, $values);
  }

}

constant GimpCM is export = Gimp::Color::Misc;
