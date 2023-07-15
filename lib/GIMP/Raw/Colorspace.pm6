use v6.c;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;

### /usr/src/gimp/libgimpcolor/gimpcolorspace.h

sub gimp_cmyk_to_rgb (
  GimpCMYK $cmyk,
  GimpRGB  $rgb
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_hsl_to_rgb (
  GimpHSL $hsl,
  GimpRGB $rgb
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_hsv_to_rgb (
  GimpHSV $hsv,
  GimpRGB $rgb
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_to_cmyk (
  GimpRGB  $rgb,
  gdouble  $pullout,
  GimpCMYK $cmyk
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_to_hsl (
  GimpRGB $rgb,
  GimpHSL $hsl
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_rgb_to_hsv (
  GimpRGB $rgb,
  GimpHSV $hsv
)
  is      native(gimpcolor)
  is      export
{ * }
