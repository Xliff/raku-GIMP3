use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::FileEntry;

### /usr/src/gimp/libgimpwidgets/gimpfileentry.h

sub gimp_file_entry_get_entry (GimpFileEntry $entry)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_file_entry_get_filename (GimpFileEntry $entry)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_file_entry_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_file_entry_new (
  Str      $title,
  Str      $filename,
  gboolean $dir_only,
  gboolean $check_valid
)
  returns GimpFileEntry
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_file_entry_set_filename (
  GimpFileEntry $entry,
  Str           $filename
)
  is      native(gimpwidgets)
  is      export
{ * }
