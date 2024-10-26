use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GTK::Raw::Definitions:ver<3>;
use GTK::Raw::Enums:ver<3>;
use GTK::Raw::Structs:ver<3>;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Properties;

### /usr/src/gimp/libgimpwidgets/gimppropwidgets.h

sub gimp_prop_boolean_combo_box_new (
  GObject $config,
  Str     $property_name,
  Str     $true_text,
  Str     $false_text
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_boolean_radio_frame_new (
  GObject $config,
  Str     $property_name,
  Str     $title,
  Str     $true_text,
  Str     $false_text
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_check_button_new (
  GObject $config,
  Str     $property_name,
  Str     $label
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_color_area_new (
  GObject           $config,
  Str               $property_name,
  gint              $width,
  gint              $height,
  GimpColorAreaType $type
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_color_select_new (
  GObject           $config,
  Str               $property_name,
  gint              $width,
  gint              $height,
  GimpColorAreaType $type
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_coordinates_connect (
  GObject   $config,
  Str       $x_property_name,
  Str       $y_property_name,
  Str       $unit_property_name,
  GtkWidget $sizeentry,
  GtkWidget $chainbutton,
  gdouble   $xresolution,
  gdouble   $yresolution
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_coordinates_new (
  GObject                   $config,
  Str                       $x_property_name,
  Str                       $y_property_name,
  Str                       $unit_property_name,
  Str                       $unit_format,
  GimpSizeEntryUpdatePolicy $update_policy,
  gdouble                   $xresolution,
  gdouble                   $yresolution,
  gboolean                  $has_chainbutton
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_entry_new (
  GObject $config,
  Str     $property_name,
  gint    $max_len
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_enum_check_button_new (
  GObject $config,
  Str     $property_name,
  Str     $label,
  gint    $false_value,
  gint    $true_value
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_enum_combo_box_new (
  GObject $config,
  Str     $property_name,
  gint    $minimum,
  gint    $maximum
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_enum_icon_box_new (
  GObject $config,
  Str     $property_name,
  Str     $icon_prefix,
  gint    $minimum,
  gint    $maximum
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_enum_label_new (
  GObject $config,
  Str     $property_name
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_enum_radio_box_new (
  GObject $config,
  Str     $property_name,
  gint    $minimum,
  gint    $maximum
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_enum_radio_frame_new (
  GObject $config,
  Str     $property_name,
  Str     $title,
  gint    $minimum,
  gint    $maximum
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_expander_new (
  GObject $config,
  Str     $property_name,
  Str     $label
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_file_chooser_button_new (
  GObject              $config,
  Str                  $property_name,
  Str                  $title,
  GtkFileChooserAction $action
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_file_chooser_button_new_with_dialog (
  GObject   $config,
  Str       $property_name,
  GtkWidget $dialog
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_hscale_new (
  GObject $config,
  Str     $property_name,
  gdouble $step_increment,
  gdouble $page_increment,
  gint    $digits
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_icon_image_new (
  GObject     $config,
  Str         $property_name,
  GtkIconSize $icon_size
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_int_combo_box_new (
  GObject      $config,
  Str          $property_name,
  GimpIntStore $store
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_int_radio_frame_new (
  GObject      $config,
  Str          $property_name,
  Str          $title,
  GimpIntStore $store
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_label_color_new (
  GObject  $config,
  Str      $property_name,
  gboolean $editable
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_label_entry_new (
  GObject $config,
  Str     $property_name,
  gint    $max_len
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_label_new (
  GObject $config,
  Str     $property_name
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_label_spin_new (
  GObject $config,
  Str     $property_name,
  gint    $digits
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_memsize_entry_new (
  GObject $config,
  Str     $property_name
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_path_editor_new (
  GObject $config,
  Str     $path_property_name,
  Str     $writable_property_name,
  Str     $filechooser_title
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_pointer_combo_box_new (
  GObject      $config,
  Str          $property_name,
  GimpIntStore $store
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_scale_entry_new (
  GObject  $config,
  Str      $property_name,
  Str      $label,
  gdouble  $factor,
  gboolean $limit_scale,
  gdouble  $lower_limit,
  gdouble  $upper_limit
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_size_entry_new (
  GObject                   $config,
  Str                       $property_name,
  gboolean                  $property_is_pixel,
  Str                       $unit_property_name,
  Str                       $unit_format,
  GimpSizeEntryUpdatePolicy $update_policy,
  gdouble                   $resolution
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_spin_button_new (
  GObject $config,
  Str     $property_name,
  gdouble $step_increment,
  gdouble $page_increment,
  gint    $digits
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_spin_scale_new (
  GObject $config,
  Str     $property_name,
  gdouble $step_increment,
  gdouble $page_increment,
  gint    $digits
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_string_combo_box_new (
  GObject      $config,
  Str          $property_name,
  GtkTreeModel $model,
  gint         $id_column,
  gint         $label_column
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_switch_new (
  GObject           $config,
  Str               $property_name,
  Str               $label,
  CArray[GtkWidget] $label_out,
  CArray[GtkWidget] $switch_out
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_text_buffer_new (
  GObject $config,
  Str     $property_name,
  gint    $max_len
)
  returns GtkTextBuffer
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_unit_combo_box_new (
  GObject $config,
  Str     $property_name
)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_prop_widget_set_factor (
  GtkWidget $widget,
  gdouble   $factor,
  gdouble   $step_increment,
  gdouble   $page_increment,
  gint      $digits
)
  is      native(gimpwidgets)
  is      export
{ * }
