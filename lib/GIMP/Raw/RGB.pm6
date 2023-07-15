use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use BABL;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::RGB;

### /usr/src/gimp/libgimpcolor/gimprgb.h

sub gimp_rgb_add (
  GimpRGB $rgb1,
  GimpRGB $rgb2
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_clamp (GimpRGB $rgb)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_composite (
  GimpRGB              $color1,
  GimpRGB              $color2,
  GimpRGBCompositeMode $mode
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_distance (
  GimpRGB $rgb1,
  GimpRGB $rgb2
)
  returns gdouble
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_gamma (
  GimpRGB $rgb,
  gdouble $gamma
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_get_pixel (
  GimpRGB  $rgb,
  Babl     $format,
  gpointer $pixel
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_get_type
  returns GType
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_get_uchar (
  GimpRGB $rgb,
  uint8    $red   is rw,
  uint8    $green is rw,
  uint8    $blue  is rw
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_param_rgb_get_type
  returns GType
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_param_spec_rgb (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  gboolean    $has_alpha,
  GimpRGB     $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_param_spec_rgb_get_default (
  GParamSpec $pspec,
  GimpRGB    $default_value
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_param_spec_rgb_has_alpha (GParamSpec $pspec)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_add (
  GimpRGB $rgba1,
  GimpRGB $rgba2
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_distance (
  GimpRGB $rgba1,
  GimpRGB $rgba2
)
  returns gdouble
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_get_pixel (
  GimpRGB  $rgba,
  Babl     $format,
  gpointer $pixel
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_get_uchar (
  GimpRGB $rgba,
  uint8   $red   is rw,
  uint8   $green is rw,
  uint8   $blue  is rw,
  uint8   $alpha is rw
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_multiply (
  GimpRGB $rgba,
  gdouble $factor
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_parse_css (
  GimpRGB $rgba,
  Str     $css,
  gint    $len
)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_set (
  GimpRGB $rgba,
  gdouble $red,
  gdouble $green,
  gdouble $blue,
  gdouble $alpha
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_set_pixel (
  GimpRGB  $rgba,
  Babl     $format,
  gpointer $pixel
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_set_uchar (
  GimpRGB $rgba,
  uint8   $red,
  uint8   $green,
  uint8   $blue,
  uint8   $alpha
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgba_subtract (
  GimpRGB $rgba1,
  GimpRGB $rgba2
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_value_get_rgb (
  GValue  $value,
  GimpRGB $rgb
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_value_set_rgb (
  GValue  $value,
  GimpRGB $rgb
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_list_names (
  CArray[Pointer[Str]]     $names,
  CArray[Pointer[GimpRGB]] $colors,
  gint                     $n_colors is rw
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_luminance (GimpRGB $rgb)
  returns gdouble
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_luminance_uchar (GimpRGB $rgb)
  returns CArray[uint8]
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_max (GimpRGB $rgb)
  returns gdouble
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_min (GimpRGB $rgb)
  returns gdouble
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_multiply (
  GimpRGB $rgb1,
  gdouble $factor
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_parse_css (
  GimpRGB $rgb,
  Str     $css,
  gint    $len
)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_parse_hex (
  GimpRGB $rgb,
  Str     $hex,
  gint    $len
)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_parse_name (
  GimpRGB $rgb,
  Str     $name,
  gint    $len
)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_set (
  GimpRGB $rgb,
  gdouble $red,
  gdouble $green,
  gdouble $blue
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_set_alpha (
  GimpRGB $rgb,
  gdouble $alpha
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_set_pixel (
  GimpRGB       $rgb,
  Babl          $format,
  gconstpointer $pixel
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_set_uchar (
  GimpRGB $rgb,
  uint8   $red,
  uint8   $green,
  uint8   $blue
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_subtract (
  GimpRGB $rgb1,
  GimpRGB $rgb2
)
  is      native(gimpcolor)
  is      export
{ * }
