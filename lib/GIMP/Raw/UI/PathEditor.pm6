use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::PathEditor;

### /usr/src/gimp/libgimpwidgets/gimppatheditor.h

sub gimp_path_editor_get_dir_writable (
  GimpPathEditor $editor,
  Str            $directory
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_path_editor_get_path (GimpPathEditor $editor)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_path_editor_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_path_editor_get_writable_path (GimpPathEditor $editor)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_path_editor_new (
  Str $title,
  Str $path
)
  returns GimpPathEditor
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_path_editor_set_dir_writable (
  GimpPathEditor $editor,
  Str            $directory,
  gboolean       $writable
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_path_editor_set_path (
  GimpPathEditor $editor,
  Str            $path
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_path_editor_set_writable_path (
  GimpPathEditor $editor,
  Str            $path
)
  is      native(gimpwidgets)
  is      export
{ * }
