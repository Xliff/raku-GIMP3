use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::ScaleEntry;

### /usr/src/gimp/libgimpwidgets/gimpscaleentry.h

sub gimp_scale_entry_get_logarithmic (GimpScaleEntry $entry)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scale_entry_get_range (GimpScaleEntry $entry)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scale_entry_new (
  Str     $text,
  gdouble $value,
  gdouble $lower,
  gdouble $upper,
  guint   $digits
)
  returns GimpScaleEntry
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scale_entry_set_bounds (
  GimpScaleEntry $entry,
  gdouble        $lower,
  gdouble        $upper,
  gboolean       $limit_scale
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_scale_entry_set_logarithmic (
  GimpScaleEntry $entry,
  gboolean       $logarithmic
)
  is      native(gimpwidgets)
  is      export
{ * }
