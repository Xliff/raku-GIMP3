use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;

unit package GIMP::Thumb::gimpthumb;

### /usr/src/gimp/libgimpthumb/gimpthumb-gimpthumb.h

sub _gimp_thumb_filename_from_uri (Str $uri)
  returns Str
  is      native(gimpthumb)
  is      export
{ * }

sub _gimp_thumbs_delete_others (
  Str           $uri,
  GimpThumbSize $size
)
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_ensure_thumb_dir (
  GimpThumbSize           $size,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_ensure_thumb_dir_local (
  Str                     $dirname,
  GimpThumbSize           $size,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_file_test (
  Str    $filename,
  gint64 $mtime is rw,
  gint64 $size is rw,
  gint   $err_no is rw
)
  returns GimpThumbFileType
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_find_thumb (
  Str           $uri,
  GimpThumbSize $size
)
  returns Str
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_get_thumb_base_dir
  returns Str
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_get_thumb_dir (GimpThumbSize $size)
  returns Str
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_get_thumb_dir_local (
  Str           $dirname,
  GimpThumbSize $size
)
  returns Str
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbs_delete_for_uri (Str $uri)
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumbs_delete_for_uri_local (Str $uri)
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_init (
  Str $creator,
  Str $thumb_basedir
)
  returns uint32
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_name_from_uri (
  Str           $uri,
  GimpThumbSize $size
)
  returns Str
  is      native(gimpthumb)
  is      export
{ * }

sub gimp_thumb_name_from_uri_local (
  Str           $uri,
  GimpThumbSize $size
)
  returns Str
  is      native(gimpthumb)
  is      export
{ * }
