use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::OffsetArea;

### /usr/src/gimp/libgimpwidgets/gimpoffsetarea.h

sub gimp_offset_area_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_offset_area_new (
  gint $orig_width,
  gint $orig_height
)
  returns GimpOffsetArea
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_offset_area_set_offsets (
  GimpOffsetArea $offset_area,
  gint           $offset_x,
  gint           $offset_y
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_offset_area_set_pixbuf (
  GimpOffsetArea $offset_area,
  GdkPixbuf      $pixbuf
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_offset_area_set_size (
  GimpOffsetArea $offset_area,
  gint           $width,
  gint           $height
)
  is      native(gimpwidgets)
  is      export
{ * }
