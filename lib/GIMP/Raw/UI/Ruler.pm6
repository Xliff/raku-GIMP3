use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use GTK::Raw::Enums;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::UI::Ruler;

### /usr/src/gimp/libgimpwidgets/gimpruler.h

sub gimp_ruler_add_track_widget (GimpRuler $ruler, GtkWidget $widget)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_get_position (GimpRuler $ruler)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_get_range (
  GimpRuler $ruler,
  gdouble   $lower    is rw,
  gdouble   $upper    is rw,
  gdouble   $max_size is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_get_unit (GimpRuler $ruler)
  returns GimpUnit
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_new (GtkOrientation $orientation)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_remove_track_widget (GimpRuler $ruler, GtkWidget $widget)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_set_position (GimpRuler $ruler, gdouble $position)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_set_range (
  GimpRuler $ruler,
  gdouble   $lower,
  gdouble   $upper,
  gdouble   $max_size
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_ruler_set_unit (GimpRuler $ruler, GimpUnit $unit)
  is      native(gimpwidgets)
  is      export
{ * }
