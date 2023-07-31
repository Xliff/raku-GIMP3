use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Label::Spin;

### /usr/src/gimp/libgimpwidgets/gimplabelspin.h

sub gimp_label_spin_get_spin_button (GimpLabelSpin $spin)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_spin_get_value (GimpLabelSpin $spin)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_spin_new (
  Str     $text,
  gdouble $value,
  gdouble $lower,
  gdouble $upper,
  gint    $digits
)
  returns GimpLabelSpin
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_spin_set_digits (
  GimpLabelSpin $spin,
  gint          $digits
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_spin_set_increments (
  GimpLabelSpin $spin,
  gdouble       $step,
  gdouble       $page
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_spin_set_value (
  GimpLabelSpin $spin,
  gdouble       $value
)
  is      native(gimpwidgets)
  is      export
{ * }
