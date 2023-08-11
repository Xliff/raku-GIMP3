use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Config::Writer;

### /usr/src/gimp/libgimpconfig/gimpconfigwriter.h

sub gimp_config_writer_close (GimpConfigWriter $writer)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_comment (
  GimpConfigWriter $writer,
  Str              $comment
)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_comment_mode (
  GimpConfigWriter $writer,
  gboolean         $enable
)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_data (
  GimpConfigWriter $writer,
  gint             $length,
  guint8           $data is rw
)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_finish (
  GimpConfigWriter        $writer,
  Str                     $footer,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_get_type
  returns GType
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_identifier (
  GimpConfigWriter $writer,
  Str              $identifier
)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_linefeed (GimpConfigWriter $writer)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_new_from_fd (gint $fd)
  returns GimpConfigWriter
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_new_from_file (
  GFile                   $file,
  gboolean                $atomic,
  Str                     $header,
  CArray[Pointer[GError]] $error
)
  returns GimpConfigWriter
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_new_from_stream (
  GOutputStream           $output,
  Str                     $header,
  CArray[Pointer[GError]] $error
)
  returns GimpConfigWriter
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_new_from_string (GString $string)
  returns GimpConfigWriter
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_open (
  GimpConfigWriter $writer,
  Str              $name
)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_print (
  GimpConfigWriter $writer,
  Str              $string,
  gint             $len
)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_ref (GimpConfigWriter $writer)
  returns GimpConfigWriter
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_revert (GimpConfigWriter $writer)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_string (
  GimpConfigWriter $writer,
  Str              $string
)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_writer_unref (GimpConfigWriter $writer)
  is      native(gimpconfig)
  is      export
{ * }
