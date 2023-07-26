use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Enums;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::ZoomModel;

### /usr/src/gimp/libgimpwidgets/gimpzoommodel.h

sub gimp_zoom_model_get_factor (GimpZoomModel $model)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_zoom_model_get_fraction (
  GimpZoomModel $model,
  gint          $numerator   is rw,
  gint          $denominator is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_zoom_model_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_zoom_button_new (
  GimpZoomModel $model,
  GimpZoomType  $zoom_type,
  GtkIconSize   $icon_size
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_zoom_model_new
  returns GimpZoomModel
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_zoom_model_set_range (
  GimpZoomModel $model,
  gdouble       $min,
  gdouble       $max
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_zoom_model_zoom (
  GimpZoomModel $model,
  GimpZoomType  $zoom_type,
  gdouble       $scale
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_zoom_model_zoom_step (
  GimpZoomType $zoom_type,
  gdouble      $scale,
  gdouble      $delta
)
  returns gdouble
  is      native(gimpwidgets)
  is      export
{ * }
