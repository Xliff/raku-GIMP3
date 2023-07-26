use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::ZoomPreview;

### /usr/src/gimp/libgimp/gimpzoompreview.h

sub gimp_zoom_preview_get_drawable (GimpZoomPreview $preview)
  returns GimpDrawable
  is      native(gimp)
  is      export
{ * }

sub gimp_zoom_preview_get_factor (GimpZoomPreview $preview)
  returns gdouble
  is      native(gimp)
  is      export
{ * }

sub gimp_zoom_preview_get_model (GimpZoomPreview $preview)
  returns GimpZoomModel
  is      native(gimp)
  is      export
{ * }

sub gimp_zoom_preview_get_source (
  GimpZoomPreview $preview,
  gint            $width    is rw,
  gint            $height   is rw,
  gint            $bpp      is rw
)
  returns CArray[uint8]
  is      native(gimp)
  is      export
{ * }

sub gimp_zoom_preview_get_type
  returns GType
  is      native(gimp)
  is      export
{ * }

sub gimp_zoom_preview_new_from_drawable (GimpDrawable $drawable)
  returns GimpZoomPreview
  is      native(gimp)
  is      export
{ * }

sub gimp_zoom_preview_new_with_model_from_drawable (
  GimpDrawable  $drawable,
  GimpZoomModel $model
)
  returns GimpZoomPreview
  is      native(gimp)
  is      export
{ * }
