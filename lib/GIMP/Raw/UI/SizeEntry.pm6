use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::SizeEntry;

### /usr/src/gimp/libgimpwidgets/gimpsizeentry.h

sub gimp_size_entry_add_field (
  GimpSizeEntry $gse,
  GtkSpinButton $value_spinbutton,
  GtkSpinButton $refval_spinbutton
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_attach_label (
  GimpSizeEntry $gse,
  Str           $text,
  gint          $row,
  gint          $column,
  gfloat        $alignment
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_help_widget (
  GimpSizeEntry $gse,
  gint          $field
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_n_fields (GimpSizeEntry $gse)
  returns gint
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_refval (
  GimpSizeEntry $gse,
  gint          $field
)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_unit (GimpSizeEntry $gse)
  returns GimpUnit
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_unit_combo (GimpSizeEntry $gse)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_update_policy (GimpSizeEntry $gse)
  returns GimpSizeEntryUpdatePolicy
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_get_value (
  GimpSizeEntry $gse,
  gint          $field
)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_grab_focus (GimpSizeEntry $gse)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_new (
  gint                      $number_of_fields,
  GimpUnit                  $unit,
  Str                       $unit_format,
  gboolean                  $menu_show_pixels,
  gboolean                  $menu_show_percent,
  gboolean                  $show_refval,
  gint                      $spinbutton_width,
  GimpSizeEntryUpdatePolicy $update_policy
)
  returns GimpSizeEntry
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_activates_default (
  GimpSizeEntry $gse,
  gboolean      $setting
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_pixel_digits (
  GimpSizeEntry $gse,
  gint          $digits
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_refval (
  GimpSizeEntry $gse,
  gint          $field,
  gdouble       $refval
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_refval_boundaries (
  GimpSizeEntry $gse,
  gint          $field,
  gdouble       $lower,
  gdouble       $upper
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_refval_digits (
  GimpSizeEntry $gse,
  gint          $field,
  gint          $digits
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_resolution (
  GimpSizeEntry $gse,
  gint          $field,
  gdouble       $resolution,
  gboolean      $keep_size
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_size (
  GimpSizeEntry $gse,
  gint          $field,
  gdouble       $lower,
  gdouble       $upper
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_unit (
  GimpSizeEntry $gse,
  GimpUnit      $unit
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_value (
  GimpSizeEntry $gse,
  gint          $field,
  gdouble       $value
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_set_value_boundaries (
  GimpSizeEntry $gse,
  gint          $field,
  gdouble       $lower,
  gdouble       $upper
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_size_entry_show_unit_menu (
  GimpSizeEntry $gse,
  gboolean      $show
)
  is      native(gimpwidgets)
  is      export
{ * }
