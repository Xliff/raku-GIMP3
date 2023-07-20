use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;

unit package GIMP::Raw::File;

### /usr/src/gimp/libgimp/gimpfile_pdb.h

sub gimp_file_load (
  GimpRunMode $run_mode,
  GFile       $file
)
  returns GimpImage
  is      native(gimp)
  is      export
{ * }

sub gimp_file_load_layer (
  GimpRunMode $run_mode,
  GimpImage   $image,
  GFile       $file
)
  returns GimpLayer
  is      native(gimp)
  is      export
{ * }

sub gimp_file_load_layers (
  GimpRunMode $run_mode,
  GimpImage   $image,
  GFile       $file,
  gint        $num_layers is rw
)
  returns CArray[CArray[GimpLayer]]
  is      native(gimp)
  is      export
{ * }

sub gimp_file_save (
  GimpRunMode      $run_mode,
  GimpImage        $image,
  gint             $num_drawables,
  CArray[GimpItem] $drawables,
  GFile            $file
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_file_save_thumbnail (
  GimpImage $image,
  GFile     $file
)
  returns uint32
  is      native(gimp)
  is      export
{ * }
