use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::RAW::UI::Label::Color;

### /usr/src/gimp/libgimpwidgets/gimplabelcolor.h

sub gimp_label_color_get_color_widget (GimpLabelColor $color)
  is      native(gimpwidgets)
  returns GtkWidget
  is      export
{ * }

sub gimp_label_color_get_value (
  GimpLabelColor $color,
  GimpRGB        $value
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_color_is_editable (GimpLabelColor $color)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_color_new (
  Str      $label,
  GimpRGB  $color,
  gboolean $editable
)
  returns GimpLabelColor
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_color_set_editable (
  GimpLabelColor $color,
  gboolean       $editable
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_color_set_value (
  GimpLabelColor $color,
  GimpRGB        $value
)
  is      native(gimpwidgets)
  is      export
{ * }
