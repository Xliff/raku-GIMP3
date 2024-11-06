use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Int::RadioFrame;

### /usr/src/gimp/libgimpwidgets/gimpintradioframe.h

sub gimp_int_radio_frame_append (
  GimpIntRadioFrame $radio_frame,
  gint              $column,
  gint              $value,
  gint
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_get_active (GimpIntRadioFrame $radio_frame)
  returns gint
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_get_active_user_data (
  GimpIntRadioFrame $radio_frame,
  gpointer          $user_data
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_new (
  Str  $first_label,
  gint $first_value,
  Str
)
  returns GimpIntRadioFrame
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_new_array (CArray[Str] $labels)
  returns GimpIntRadioFrame
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_new_from_store (
  Str          $title,
  GimpIntStore $store
)
  returns GimpIntRadioFrame
  is      native(gimpwidgets)
  is      export
{ * }


sub gimp_int_radio_frame_prepend (
  GimpIntRadioFrame $radio_frame,
  gint              $colum,
  gint              $value,
  gint
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_set_active (
  GimpIntRadioFrame $radio_frame,
  gint              $value
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_set_active_by_user_data (
  GimpIntRadioFrame $radio_frame,
  gpointer          $user_data
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_int_radio_frame_set_sensitivity (
  GimpIntRadioFrame $radio_frame,
                    &func (gint, gpointer, gint is rw, gpointer),
  gpointer          $data,
                    &destroy (gpointer)
)
  is      native(gimpwidgets)
  is      export
{ * }
