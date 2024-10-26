use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;

unit package GIMP::Raw::UI::Int::ComboBox;

### /usr/src/gimp/libgimpwidgets/gimpwidgets.h

sub gimp_int_combo_box_append (GimpIntComboBox $combo_box)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_connect (
  GimpIntComboBox $combo_box,
  gint            $value,
                  &callback (gpointer),
  gpointer        $data,
                  &data_destroy (gpointer)
)
  returns gulong
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_get_active (
  GimpIntComboBox $combo_box,
  gint            $value      is rw
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_get_active_user_data (
  GimpIntComboBox $combo_box,
  gpointer        $user_data
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_get_label (GimpIntComboBox $combo_box)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_get_layout (GimpIntComboBox $combo_box)
  returns GimpIntComboBoxLayout
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_new (
  Str  $first_label,
  gint $first_value
  Str
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_new_array (
  gint        $n_values,
  Carray[Str] $labels
)
  returns GimpIntComboBox
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_prepend (GimpIntComboBox $combo_box)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_set_active (
  GimpIntComboBox $combo_box,
  gint            $value
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_set_active_by_user_data (
  GimpIntComboBox $combo_box,
  gpointer        $user_data
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_set_label (
  GimpIntComboBox $combo_box,
  Str             $label
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_set_layout (
  GimpIntComboBox       $combo_box,
  GimpIntComboBoxLayout $layout
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_combo_box_set_sensitivity (
  GimpIntComboBox $combo_box,
                  &func (gint, gpointer),
  gpointer        $data,
                  &destroy (gpointer)
)
  is      native(gimpwidgets)
  is      export
{ * }
