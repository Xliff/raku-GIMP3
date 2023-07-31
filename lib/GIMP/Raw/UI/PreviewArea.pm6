use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::PreviewArea;

### /usr/src/gimp/libgimpwidgets/gimppreviewarea.h

sub gimp_preview_area_blend (
  GimpPreviewArea $area,
  gint            $x,
  gint            $y,
  gint            $width,
  gint            $height,
  GimpImageType   $type,
  CArray[uint8]   $buf1,
  gint            $rowstride1,
  CArray[uint8]   $buf2,
  gint            $rowstride2,
  uint8           $opacity
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_draw (
  GimpPreviewArea $area,
  gint            $x,
  gint            $y,
  gint            $width,
  gint            $height,
  GimpImageType   $type,
  CArray[uint8]   $buf,
  gint            $rowstride
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_fill (
  GimpPreviewArea $area,
  gint            $x,
  gint            $y,
  gint            $width,
  gint            $height,
  uint8           $red,
  uint8           $green,
  uint8           $blue
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_get_size (
  GimpPreviewArea $area,
  gint            $width is rw,
  gint            $height is rw
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_mask (
  GimpPreviewArea $area,
  gint            $x,
  gint            $y,
  gint            $width,
  gint            $height,
  GimpImageType   $type,
  CArray[uint8]   $buf1,
  gint            $rowstride1,
  CArray[uint8]   $buf2,
  gint            $rowstride2,
  CArray[uint8]   $mask,
  gint            $rowstride_mask
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_menu_popup (
  GimpPreviewArea $area,
  GdkEventButton  $event
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_new
  returns GimpPreviewArea
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_set_color_config (
  GimpPreviewArea $area,
  GimpColorConfig $config
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_set_colormap (
  GimpPreviewArea $area,
  CArray[uint8]   $colormap,
  gint            $num_colors
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_set_max_size (
  GimpPreviewArea $area,
  gint            $width,
  gint            $height
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_preview_area_set_offsets (
  GimpPreviewArea $area,
  gint            $x,
  gint            $y
)
  is      native(gimpwidgets)
  is      export
{ * }
