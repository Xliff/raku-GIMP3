use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Config;

### /usr/src/gimp/libgimpconfig/gimpconfig-gimpconfig.h

sub gimp_config_copy (
  GimpConfig  $src,
  GimpConfig  $dest,
  GParamFlags $flags
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_deserialize (
  GimpConfig $config,
  GScanner   $scanner,
  gint       $nest_level,
  gpointer   $data
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_deserialize_file (
  GimpConfig              $config,
  GFile                   $file,
  gpointer                $data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_deserialize_parasite (
  GimpConfig              $config,
  GimpParasite            $parasite,
  gpointer                $data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_deserialize_return (
  GScanner   $scanner,
  GTokenType $expected_token,
  gint       $nest_level
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_deserialize_stream (
  GimpConfig              $config,
  GInputStream            $input,
  gpointer                $data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_deserialize_string (
  GimpConfig              $config,
  Str                     $text,
  gint                    $text_len,
  gpointer                $data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_duplicate (GimpConfig $config)
  returns Pointer
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_is_equal_to (
  GimpConfig $a,
  GimpConfig $b
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_reset (GimpConfig $config)
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_serialize (
  GimpConfig       $config,
  GimpConfigWriter $writer,
  gpointer         $data
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_serialize_to_fd (
  GimpConfig $config,
  gint       $fd,
  gpointer   $data
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_serialize_to_file (
  GimpConfig              $config,
  GFile                   $file,
  Str                     $header,
  Str                     $footer,
  gpointer                $data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_serialize_to_parasite (
  GimpConfig $config,
  Str        $parasite_name,
  guint      $parasite_flags,
  gpointer   $data
)
  returns GimpParasite
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_serialize_to_stream (
  GimpConfig              $config,
  GOutputStream           $output,
  Str                     $header,
  Str                     $footer,
  gpointer                $data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpconfig)
  is      export
{ * }

sub gimp_config_serialize_to_string (
  GimpConfig $config,
  gpointer   $data
)
  returns Str
  is      native(gimpconfig)
  is      export
{ * }
