use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Scanner;

### /usr/src/gimp/libgimpconfig/gimpscanner.h

sub gimp_scanner_get_type
  returns GType
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_new_file (
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns GimpScanner
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_new_stream (
  GInputStream            $input,
  CArray[Pointer[GError]] $error
)
  returns GimpScanner
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_new_string (
  Str                     $text,
  gint                    $text_len,
  CArray[Pointer[GError]] $error
)
  returns GimpScanner
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_boolean (
  GimpScanner $scanner,
  gboolean    $dest      is rw
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_color (
  GimpScanner $scanner,
  GimpRGB     $dest
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_data (
  GimpScanner    $scanner,
  gint           $length,
  CArray[guint8] $dest
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_float (
  GimpScanner $scanner,
  gdouble     $dest is rw
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_identifier (
  GimpScanner $scanner,
  Str         $identifier
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_int (
  GimpScanner $scanner,
  gint        $dest is rw
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_int64 (
  GimpScanner $scanner,
  gint64      $dest is rw
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_matrix2 (
  GimpScanner $scanner,
  GimpMatrix2 $dest
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_string (
  GimpScanner $scanner,
  CArray[Str] $dest
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_string_no_validate (
  GimpScanner $scanner,
  CArray[Str] $dest
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_parse_token (
  GimpScanner $scanner,
  GTokenType  $token
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_ref (GimpScanner $scanner)
  returns GimpScanner
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_scanner_unref (GimpScanner $scanner)
  is      native(gimpconfig)
  is      export
{ * }
