use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Thumbnail;

### /usr/src/gimp/libgimpthumb/gimpthumbnail.h

sub gimp_thumbnail_check_thumb (
  GimpThumbnail $thumbnail,
  GimpThumbSize $size
)
  returns GimpThumbState
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_delete_failure (GimpThumbnail $thumbnail)
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_delete_others (
  GimpThumbnail $thumbnail,
  GimpThumbSize $size
)
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_get_type
  returns GType
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_has_failed (GimpThumbnail $thumbnail)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_load_thumb (
  GimpThumbnail           $thumbnail,
  GimpThumbSize           $size,
  CArray[Pointer[GError]] $error
)
  returns GdkPixbuf
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_new
  returns GimpThumbnail
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_peek_image (GimpThumbnail $thumbnail)
  returns GimpThumbState
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_peek_thumb (
  GimpThumbnail $thumbnail,
  GimpThumbSize $size
)
  returns GimpThumbState
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_save_failure (
  GimpThumbnail           $thumbnail,
  Str                     $software,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_save_thumb (
  GimpThumbnail           $thumbnail,
  GdkPixbuf               $pixbuf,
  Str                     $software,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_save_thumb_local (
  GimpThumbnail           $thumbnail,
  GdkPixbuf               $pixbuf,
  Str                     $software,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_set_filename (
  GimpThumbnail           $thumbnail,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_set_from_thumb (
  GimpThumbnail           $thumbnail,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbnail_set_uri (
  GimpThumbnail $thumbnail,
  Str           $uri
)
  is      native(gimpthumb)
  is      export
{ * }
