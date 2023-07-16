use v6.c;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;

unit package GIMP::Raw::Color::Misc;

### /usr/src/gimp/libgimpcolor/gimpbilinear.h

sub gimp_bilinear_16 (
  gdouble $x,
  gdouble $y,
  guint16 $values is rw
)
  returns guint16
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_bilinear_32 (
  gdouble $x,
  gdouble $y,
  guint32 $values is rw
)
  returns guint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_bilinear_8 (
  gdouble $x,
  gdouble $y,
  Str     $values
)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_bilinear (
  gdouble $x,
  gdouble $y,
  gdouble $values is rw
)
  returns gdouble
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_bilinear_rgb (
  gdouble $x,
  gdouble $y,
  GimpRGB $values
)
  returns GimpRGB
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_bilinear_rgba (
  gdouble $x,
  gdouble $y,
  GimpRGB $values
)
  returns GimpRGB
  is      native(gimpcolor)
  is      export
{ * }

### /usr/src/gimp/libgimpcolor/gimpadaptivesupersample.h

sub gimp_adaptive_supersample_area (
  gint             $x1,
  gint             $y1,
  gint             $x2,
  gint             $y2,
  gint             $max_depth,
  gdouble          $threshold,
  GimpRenderFunc   $render_func,
  gpointer         $render_data,
  GimpPutPixelFunc $put_pixel_func,
  gpointer         $put_pixel_data,
  GimpProgressFunc $progress_func,
  gpointer         $progress_data
)
  returns gulong
  is      native(gimpcolor)
  is      export
{ * }
