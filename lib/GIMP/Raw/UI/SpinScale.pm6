use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::SpinScale;

### /usr/src/gimp/libgimpwidgets/gimpspinscale.h

sub gimp_spin_scale_get_constrain_drag (GimpSpinScale $scale)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_get_gamma (GimpSpinScale $scale)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_get_label (GimpSpinScale $scale)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_get_mnemonic_keyval (GimpSpinScale $scale)
  returns guint
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_get_scale_limits (
  GimpSpinScale $scale,
  gdouble       $lower  is rw,
  gdouble       $upper  is rw
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_new (
  GtkAdjustment $adjustment,
  Str           $label,
  gint          $digits
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_set_constrain_drag (
  GimpSpinScale $scale,
  gboolean      $constrain
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_set_gamma (
  GimpSpinScale $scale,
  gdouble       $gamma
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_set_label (
  GimpSpinScale $scale,
  Str           $label
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_set_scale_limits (
  GimpSpinScale $scale,
  gdouble       $lower,
  gdouble       $upper
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_scale_unset_scale_limits (GimpSpinScale $scale)
  is      native(gimpwidgets)
  is      export
{ * }
