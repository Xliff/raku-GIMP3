use v6.c;

use GLib::Raw::Definitions;
use BABL;
use GEGL::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Color::Transform;

### /usr/src/gimp/libgimpcolor/gimpcolortransform.h

sub gimp_color_transform_can_gegl_copy (
  GimpColorProfile $src_profile,
  GimpColorProfile $dest_profile
)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_transform_get_type
  returns GType
  is      native(gimpcolor)
  is      1export
{ * }

sub gimp_color_transform_new (
  GimpColorProfile         $src_profile,
  Babl                     $src_format,
  GimpColorProfile         $dest_profile,
  Babl                     $dest_format,
  GimpColorRenderingIntent $rendering_intent,
  GimpColorTransformFlags  $flags
)
  returns GimpColorTransform
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_transform_new_proofing (
  GimpColorProfile         $src_profile,
  Babl                     $src_format,
  GimpColorProfile         $dest_profile,
  Babl                     $dest_format,
  GimpColorProfile         $proof_profile,
  GimpColorRenderingIntent $proof_intent,
  GimpColorRenderingIntent $display_intent,
  GimpColorTransformFlags  $flags
)
  returns GimpColorTransform
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_transform_process_buffer (
  GimpColorTransform $transform,
  GeglBuffer         $src_buffer,
  GeglRectangle      $src_rect,
  GeglBuffer         $dest_buffer,
  GeglRectangle      $dest_rect
)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_transform_process_pixels (
  GimpColorTransform $transform,
  Babl               $src_format,
  gpointer           $src_pixels,
  Babl               $dest_format,
  gpointer           $dest_pixels,
  gsize              $length
)
  is      native(gimpcolor)
  is      export
{ * }
