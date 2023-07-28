use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::NumberPairEntry;

### /usr/src/gimp/libgimpwidgets/gimpnumberpairentry.h

sub gimp_number_pair_entry_get_aspect (GimpNumberPairEntry $entry)
  returns GimpAspectType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_get_default_text (GimpNumberPairEntry $entry)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_get_default_values (
  GimpNumberPairEntry $entry,
  gdouble             $left   is rw,
  gdouble             $right  is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_get_ratio (GimpNumberPairEntry $entry)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_get_user_override (GimpNumberPairEntry $entry)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_get_values (
  GimpNumberPairEntry $entry,
  gdouble             $left   is rw,
  gdouble             $right  is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_new (
  Str      $separators,
  gboolean $allow_simplification,
  gdouble  $min_valid_value,
  gdouble  $max_valid_value
)
  returns GimpNumberPairEntry
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_set_aspect (
  GimpNumberPairEntry $entry,
  GimpAspectType      $aspect
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_set_default_text (
  GimpNumberPairEntry $entry,
  Str                 $string
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_set_default_values (
  GimpNumberPairEntry $entry,
  gdouble             $left,
  gdouble             $right
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_set_ratio (
  GimpNumberPairEntry $entry,
  gdouble             $ratio
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_set_user_override (
  GimpNumberPairEntry $entry,
  gboolean            $user_override
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_number_pair_entry_set_values (
  GimpNumberPairEntry $entry,
  gdouble             $left,
  gdouble             $right
)
  is      native(gimpwidgets)
  is      export
{ * }
