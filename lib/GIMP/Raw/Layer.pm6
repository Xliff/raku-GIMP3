use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Layer;

### /usr/src/gimp/libgimp/gimplayer.h

sub gimp_layer_copy (GimpLayer $layer)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_layer_get_by_id (gint32 $layer_id)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_layer_new (
  GimpImage     $image,
  Str           $name,
  gint          $width,
  gint          $height,
  GimpImageType $type,
  gdouble       $opacity,
  GimpLayerMode $mode
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_layer_new_from_pixbuf (
  GimpImage     $image,
  Str           $name,
  GdkPixbuf     $pixbuf,
  gdouble       $opacity,
  GimpLayerMode $mode,
  gdouble       $progress_start,
  gdouble       $progress_end
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_layer_new_from_surface (
  GimpImage       $image,
  Str             $name,
  cairo_surface_t $surface,
  gdouble         $progress_start,
  gdouble         $progress_end
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }
