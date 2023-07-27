use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Selection;

### /usr/src/gimp/libgimpwidgets/gimpcolorselection.h

sub gimp_color_selection_color_changed (GimpColorSelection $selection)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_get_color (
  GimpColorSelection $selection,
  GimpRGB            $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_get_notebook (GimpColorSelection $selection)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_get_old_color (
  GimpColorSelection $selection,
  GimpRGB            $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_get_right_vbox (GimpColorSelection $selection)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_get_show_alpha (GimpColorSelection $selection)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_new
  returns GimpColorSelection
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_reset (GimpColorSelection $selection)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_set_color (
  GimpColorSelection $selection,
  GimpRGB            $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_set_config (
  GimpColorSelection $selection,
  GimpColorConfig    $config
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_set_old_color (
  GimpColorSelection $selection,
  GimpRGB            $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_set_show_alpha (
  GimpColorSelection $selection,
  gboolean           $show_alpha
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selection_set_simulation (
  GimpColorSelection       $selection,
  GimpColorProfile         $profile,
  GimpColorRenderingIntent $intent,
  gboolean                 $bpc
)
  is      native(gimpwidgets)
  is      export
{ * }
