use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GEGL::Raw::Definitions;
use GEGL::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Color::DisplayStack;

### /usr/src/gimp/libgimpwidgets/gimpcolordisplaystack.h

sub gimp_color_display_stack_add (
  GimpColorDisplayStack $stack,
  GimpColorDisplay      $display
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_changed (GimpColorDisplayStack $stack)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_clone (GimpColorDisplayStack $stack)
  returns GimpColorDisplayStack
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_convert_buffer (
  GimpColorDisplayStack $stack,
  GeglBuffer            $buffer,
  GeglRectangle         $area
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_get_filters (GimpColorDisplayStack $stack)
  returns GList
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_new
  returns GimpColorDisplayStack
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_remove (
  GimpColorDisplayStack $stack,
  GimpColorDisplay      $display
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_reorder_down (
  GimpColorDisplayStack $stack,
  GimpColorDisplay      $display
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_display_stack_reorder_up (
  GimpColorDisplayStack $stack,
  GimpColorDisplay      $display
)
  is      native(gimpwidgets)
  is      export
{ * }
