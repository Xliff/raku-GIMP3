use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Color::Button;

### /usr/src/gimp/libgimpwidgets/gimpcolorbutton.h

sub gimp_color_button_get_action_group (GimpColorButton $button)
  returns GSimpleActionGroup
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_get_color (
  GimpColorButton $button,
  GimpRGB         $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_get_title (GimpColorButton $button)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_get_update (GimpColorButton $button)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_has_alpha (GimpColorButton $button)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_new (
  Str               $title,
  gint              $width,
  gint              $height,
  GimpRGB           $color,
  GimpColorAreaType $type
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_set_color (
  GimpColorButton $button,
  GimpRGB         $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_set_color_config (
  GimpColorButton $button,
  GimpColorConfig $config
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_set_title (
  GimpColorButton $button,
  Str             $title
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_set_type (
  GimpColorButton   $button,
  GimpColorAreaType $type
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_button_set_update (
  GimpColorButton $button,
  gboolean        $continuous
)
  is      native(gimpwidgets)
  is      export
{ * }
