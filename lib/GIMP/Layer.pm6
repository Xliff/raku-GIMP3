use v6.c;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Layer;

use GIMP::Drawable;

use GLib::Roles::Implementor;

class GIMP::Layer is GIMP::Drawable {
  has GimpLayer $!g-l is implementor;

  method new (
    GimpImage() $image,
    Str()       $name,
    Int()       $width,
    Int()       $height,
    Int()       $type,
    Num()       $opacity,
    Int()       $mode
  ) {
    my gint    ($w, $h, $t, $m) = ($width, $height, $type, $mode);
    my gdouble  $o              =  $opacity;

    my $gimp-layer = gimp_layer_new($image, $name, $w, $h, $t, $o, $m);

    $gimp-layer ?? self.bless( :$gimp-layer ) !! Nil
  }

  proto method new_from_pixbuf (|)
  { * }

  multi method new_from_pixbuf (
    GdkPixbuf()  $pixbuf,
    Str()       :$name           = 'BASE',
    GimpImage() :$image          = ::('GIMP::Image').new( |$pixbuf.size ),
    Int()       :$mode           = GIMP_LAYER_MODE_NORMAL,
    Num()       :$opacity        = 1e0,
    Num()       :$progress_start = 0e0,
    Num()       :$progress_end   = 0e0
  ) {
    samewith(
      $image,
      $name,
      $pixbuf,
      $opacity,
      $mode,
      $progress_start,
      $progress_end
    );
  }
  multi method new_from_pixbuf (
    GimpImage() $image,
    Str()       $name,
    GdkPixbuf() $pixbuf,
    Num()       $opacity,
    Int()       $mode,
    Num()       $progress_start = 0e0,
    Num()       $progress_end   = 0e0
  ) {
    my gint     $m      =  $mode;
    my gdouble  $o      =  $opacity;
    my gdouble ($s, $e) = ($progress_start, $progress_end);

    my $gimp-layer = gimp_layer_new_from_pixbuf(
      $image,
      $name,
      $pixbuf,
      $o,
      $m,
      $s,
      $e
    );

    $gimp-layer ?? self.bless( :$gimp-layer ) !! Nil
  }

  method new_from_surface (
    GimpImage()       $image,
    Str()             $name,
    cairo_surface_t() $surface,
    Num()             $progress_start = 0e0,
    Num()             $progress_end   = 0e0
  ) {
    my gdouble ($s, $e) = ($progress_start, $progress_end);

    my $gimp-layer = gimp_layer_new_from_surface(
      $image,
      $name,
      $surface,
      $s,
      $e
    );

    $gimp-layer ?? self.bless( :$gimp-layer ) !! Nil
  }

  method get_by_id (Int() $id)  is static {
    my gint $i = $id;

    my $gimp-layer = gimp_layer_get_by_id($i);

    $gimp-layer ?? self.bless( :$gimp-layer ) !! Nil
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gimp_layer_copy($!g-l),
      $raw,
      |self.getTypePair
    );
  }

}
