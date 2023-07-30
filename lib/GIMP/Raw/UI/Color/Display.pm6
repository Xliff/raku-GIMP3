use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GEGL::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Color::Display;

### /usr/src/gimp/libgimpwidgets/gimpcolordisplay.h

sub gimp_color_display_changed (GimpColorDisplay $display)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_clone (GimpColorDisplay $display)
  returns GimpColorDisplay
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_configure (GimpColorDisplay $display)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_configure_reset (GimpColorDisplay $display)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_convert_buffer (
  GimpColorDisplay $display,
  GeglBuffer       $buffer,
  GeglRectangle    $area
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_get_config (GimpColorDisplay $display)
  returns GimpColorConfig
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_get_enabled (GimpColorDisplay $display)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_get_managed (GimpColorDisplay $display)
  returns GimpColorManaged
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_load_state (
  GimpColorDisplay $display,
  GimpParasite     $state
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_save_state (GimpColorDisplay $display)
  returns GimpParasite
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_set_enabled (
  GimpColorDisplay $display,
  gboolean         $enabled
)
  is      native(gimpwidgets)
  is      export
{ * }
