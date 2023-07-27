use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Color::Selector;

### /usr/src/gimp/libgimpwidgets/gimpcolorselector.h

sub gimp_color_selector_emit_channel_changed (GimpColorSelector $selector)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_emit_color_changed (GimpColorSelector $selector)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_emit_model_visible_changed (
  GimpColorSelector      $selector,
  GimpColorSelectorModel $model
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_get_channel (GimpColorSelector $selector)
  returns GimpColorSelectorChannel
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_get_color (
  GimpColorSelector $selector,
  GimpRGB           $rgb,
  GimpHSV           $hsv
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_get_model_visible (
  GimpColorSelector      $selector,
  GimpColorSelectorModel $model
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_get_show_alpha (GimpColorSelector $selector)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_get_toggles_sensitive (GimpColorSelector $selector)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_get_toggles_visible (GimpColorSelector $selector)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_new (
  GType                    $selector_type,
  GimpRGB                  $rgb,
  GimpHSV                  $hsv,
  GimpColorSelectorChannel $channel
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_channel (
  GimpColorSelector        $selector,
  GimpColorSelectorChannel $channel
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_color (
  GimpColorSelector $selector,
  GimpRGB           $rgb,
  GimpHSV           $hsv
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_config (
  GimpColorSelector $selector,
  GimpColorConfig   $config
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_model_visible (
  GimpColorSelector      $selector,
  GimpColorSelectorModel $model,
  gboolean               $visible
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_show_alpha (
  GimpColorSelector $selector,
  gboolean          $show_alpha
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_simulation (
  GimpColorSelector        $selector,
  GimpColorProfile         $profile,
  GimpColorRenderingIntent $intent,
  gboolean                 $bpc
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_toggles_sensitive (
  GimpColorSelector $selector,
  gboolean          $sensitive
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_selector_set_toggles_visible (
  GimpColorSelector $selector,
  gboolean          $visible
)
  is      native(gimpwidgets)
  is      export
{ * }
