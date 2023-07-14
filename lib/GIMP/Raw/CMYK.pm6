use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;

unit package GIMP::Raw::CMYK;

### /usr/src/gimp/libgimpcolor/gimpcmyk.h

sub gimp_cmyk_get_type
  returns GType
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cmyk_get_uchar (
  GimpCMYK $cmyk,
  uint8    $cyan    is rw,
  uint8    $magenta is rw,
  uint8    $yellow  is rw,
  uint8    $black   is rw
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cmyka_get_uchar (
  GimpCMYK $cmyka,
  uint8    $cyan    is rw,
  uint8    $magenta is rw,
  uint8    $yellow  is rw,
  uint8    $black   is rw,
  uint8    $alpha   is rw
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cmyka_set (
  GimpCMYK $cmyka,
  gdouble  $cyan,
  gdouble  $magenta,
  gdouble  $yellow,
  gdouble  $black,
  gdouble  $alpha
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cmyka_set_uchar (
  GimpCMYK $cmyka,
  uint8    $cyan,
  uint8    $magenta,
  uint8    $yellow,
  uint8    $black,
  uint8    $alpha
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cmyk_set (
  GimpCMYK $cmyk,
  gdouble  $cyan,
  gdouble  $magenta,
  gdouble  $yellow,
  gdouble  $black
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_cmyk_set_uchar (
  GimpCMYK $cmyk,
  uint8    $cyan,
  uint8    $magenta,
  uint8    $yellow,
  uint8    $black
)
  is      native(gimpcolor)
  is      export
{ * }
