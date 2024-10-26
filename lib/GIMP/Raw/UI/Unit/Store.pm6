use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Unit::Store;

### /usr/src/gimp/libgimpwidgets/giimpwidgets.h

sub gimp_unit_store_get_has_percent (GimpUnitStore $store)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_get_has_pixels (GimpUnitStore $store)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_get_nth_value (
  GimpUnitStore $store,
  GimpUnit      $unit,
  gint          $index
)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_new (gint $num_values)
  returns GimpUnitStore
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_set_has_percent (
  GimpUnitStore $store,
  gboolean      $has_percent
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_set_has_pixels (
  GimpUnitStore $store,
  gboolean      $has_pixels
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_set_pixel_value (
  GimpUnitStore $store,
  gint          $index,
  gdouble       $value
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_unit_store_set_resolution (
  GimpUnitStore $store,
  gint          $index,
  gdouble       $resolution
)
  is      native(gimpwidgets)
  is      export
{ * }
