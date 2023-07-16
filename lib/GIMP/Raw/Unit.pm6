use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;

unit package GIMP::Raw::Unit;

### /usr/src/gimp/libgimpbase/gimpunit.h

sub gimp_unit_format_string (
  Str      $format,
  GimpUnit $unit
)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_abbreviation (GimpUnit $unit)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_deletion_flag (GimpUnit $unit)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_digits (GimpUnit $unit)
  returns gint
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_factor (GimpUnit $unit)
  returns gdouble
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_identifier (GimpUnit $unit)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_number_of_built_in_units
  returns gint
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_number_of_units
  returns gint
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_plural (GimpUnit $unit)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_scaled_digits (
  GimpUnit $unit,
  gdouble  $resolution
)
  returns gint
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_singular (GimpUnit $unit)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_symbol (GimpUnit $unit)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_get_type
  returns GType
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_is_metric (GimpUnit $unit)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_new (
  Str     $identifier,
  gdouble $factor,
  gint    $digits,
  Str     $symbol,
  Str     $abbreviation,
  Str     $singular,
  Str     $plural
)
  returns GimpUnit
  is      native(gimpbase)
  is      export
{ * }

sub gimp_unit_set_deletion_flag (
  GimpUnit $unit,
  gboolean $deletion_flag
)
  is      native(gimpbase)
  is      export
{ * }

sub gimp_param_spec_unit (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  gboolean    $allow_pixels,
  gboolean    $allow_percent,
  GimpUnit    $default_value,
  GParamFlags $flags
)
  returns GParamSpec
  is      native(gimpbase)
  is      export
{ * }

sub gimp_param_unit_get_type
  returns GType
  is      native(gimpbase)
  is      export
{ * }

sub gimp_pixels_to_units (
  gdouble  $pixels,
  GimpUnit $unit,
  gdouble  $resolution
)
  returns gdouble
  is      native(gimpbase)
  is      export
{ * }

sub gimp_units_to_pixels (
  gdouble  $value,
  GimpUnit $unit,
  gdouble  $resolution
)
  returns gdouble
  is      native(gimpbase)
  is      export
{ * }

sub gimp_units_to_points (
  gdouble  $value,
  GimpUnit $unit,
  gdouble  $resolution
)
  returns gdouble
  is      native(gimpbase)
  is      export
{ * }
