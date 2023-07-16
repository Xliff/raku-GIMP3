use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Metadata;

### /usr/src/gimp/libgimpbase/gimpmetadata.h

sub gimp_metadata_add_xmp_history (
  GimpMetadata $metadata,
  Str          $state_status
)
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_deserialize (Str $metadata_xml)
  returns GimpMetadata
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_duplicate (GimpMetadata $metadata)
  returns GimpMetadata
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_get_colorspace (GimpMetadata $metadata)
  returns GimpMetadataColorspace
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_get_guid
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_get_resolution (
  GimpMetadata $metadata,
  gdouble      $xres is rw,
  gdouble      $yres is rw,
  GimpUnit     $unit
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_get_type
  returns GType
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_is_tag_supported (
  Str $tag,
  Str $mime_type
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_load_from_file (
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns GimpMetadata
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_new
  returns GimpMetadata
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_save_to_file (
  GimpMetadata            $metadata,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_serialize (GimpMetadata $metadata)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_set_bits_per_sample (
  GimpMetadata $metadata,
  gint         $bits_per_sample
)
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_set_colorspace (
  GimpMetadata           $metadata,
  GimpMetadataColorspace $colorspace
)
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_set_from_exif (
  GimpMetadata            $metadata,
  Str                     $exif_data,
  gint                    $exif_data_length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_set_from_iptc (
  GimpMetadata            $metadata,
  Str                     $iptc_data,
  gint                    $iptc_data_length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_set_from_xmp (
  GimpMetadata            $metadata,
  Str                     $xmp_data,
  gint                    $xmp_data_length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_set_pixel_size (
  GimpMetadata $metadata,
  gint         $width,
  gint         $height
)
  is      native(gimpbase)
  is      export
{ * }

sub gimp_metadata_set_resolution (
  GimpMetadata $metadata,
  gdouble      $xres,
  gdouble      $yres,
  GimpUnit     $unit
)
  is      native(gimpbase)
  is      export
{ * }
