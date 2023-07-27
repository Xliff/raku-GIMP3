use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Enums;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Color::Area;

### /usr/src/gimp/libgimpwidgets/gimpcolorarea.h

sub gimp_color_area_enable_drag (
  GimpColorArea   $area,
  GdkModifierType $drag_mask
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_get_color (
  GimpColorArea $area,
  GimpRGB       $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_has_alpha (GimpColorArea $area)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_new (
  GimpRGB           $color,
  GimpColorAreaType $type,
  GdkModifierType   $drag_mask
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_set_color (
  GimpColorArea $area,
  GimpRGB       $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_set_color_config (
  GimpColorArea   $area,
  GimpColorConfig $config
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_set_draw_border (
  GimpColorArea $area,
  gboolean      $draw_border
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_set_out_of_gamut (
  GimpColorArea $area,
  gboolean      $out_of_gamut
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_area_set_type (
  GimpColorArea     $area,
  GimpColorAreaType $type
)
  is      native(gimpwidgets)
  is      export
{ * }
