use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Enums;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Color::Scale;

### /usr/src/gimp/libgimpwidgets/gimpcolorscale.h

sub gimp_color_scale_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_scale_new (
  GtkOrientation           $orientation,
  GimpColorSelectorChannel $channel
)
  returns GimpColorScale
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_scale_set_channel (
  GimpColorScale           $scale,
  GimpColorSelectorChannel $channel
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_scale_set_color (
  GimpColorScale $scale,
  GimpRGB        $rgb,
  GimpHSV        $hsv
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_scale_set_color_config (
  GimpColorScale  $scale,
  GimpColorConfig $config
)
  is      native(gimpwidgets)
  is      export
{ * }
