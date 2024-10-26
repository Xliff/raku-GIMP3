use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Properties;

use GTK::ComboBox:ver<3>;
use GTK::CheckButton:ver<3>;
use GTK::ComboBox:ver<3>;
use GTK::Entry:ver<3>;
use GTK::Expander:ver<3>;
use GTK::FileChooserButton:ver<3>;
use GTK::Image:ver<3>;
use GTK::Label:ver<3>;
use GTK::Scale:ver<3>;
use GIMP::UI::ColorArea;
use GIMP::UI::ColorSelect;
use GIMP::UI::ComboBox::Int;
use GIMP::UI::Enum::IconBox;
use GIMP::UI::Enum::RadioBox;
use GIMP::UI::Frame;
use GIMP::UI::Label::Color;
use GIMP::UI::Label::Spin;
use GIMP::UI::MemsizeEntry;
use GIMP::UI::PathEditor;
use GIMP::UI::RadioFrame;
use GIMP::UI::ScaleEntry;
use GIMP::UI::SizeEntry;

use GLib::Roles::StaticClass;

class GIMP::UI::Properties::Boolean {

  method combo_box_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $true_text,
    Str()     $false_text
  ) {
    GTK::ComboBox.new(
      gimp_prop_boolean_combo_box_new(
        $config,
        $property_name,
        $true_text,
        $false_text
      )
    );
  }

  method radio_frame_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $title,
    Str()     $true_text,
    Str()     $false_text
  ) {
    GIMP::UI::Frame.new(
      gimp_prop_boolean_radio_frame_new(
        $config,
        $property_name,
        $title,
        $true_text,
        $false_text
      );
    );
  }

  method check_button_new (
    GObject $config,
    Str     $property_name,
    Str     $label
  ) {
    GTK::CheckButton.new(
      gimp_prop_check_button_new(
        $config,
        $property_name,
        $label
      )
    );
  }

  method expander_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $label
  ) {
    GTK::Expander.new(
      gimp_prop_expander_new($config, $property_name, $label)
    );
  }

  proto method switch_new (|)
  { * }

  multi method switch_new (
     $config,
     $property_name,
     $label,
    :$hash           = False
  ) {
    samewith(
       $config,
       $property_name,
       $label,
       newCArray(GtkWidget),
       newCArray(GtkWidget),
      :$hash
    );
  }
  multi method switch_new (
    GObject()          $config,
    Str()              $property_name,
    Str()              $label,
    CArray[GtkWidget]  $label_out,
    CArray[GtkWidget]  $switch_out,
                      :$hash           = False
  ) {
    my $b = GTK::Box.new(
      gimp_prop_switch_new(
        $config,
        $property_name,
        $label,
        $label_out,
        $switch_out
      )
    );

    return $w unless $hash;
    %{
      box    => $b,
      label  => GTK::Label.new($label_out),
      switch => GTK::Switch.new($switch_out)
    }
  }
}

class GIMP::Properties::Color {

  method area_new (
    GObject() $config,
    Str()     $property_name,
    Int()     $width,
    Int()     $height,
    Int()     $type
  ) {
    my GimpColorAreaType $t = $type;

    GIMP::UI::ColorArea.new(
      gimp_prop_color_area_new(
        $config,
        $property_name,
        $width,
        $height,
        $t
      )
    );
  }

  method select_new (
    GObject() $config,
    Str()     $property_name,
    Int()     $width,
    Int()     $height,
    Int()     $type
  ) {
    my GimpColorAreaType $t = $type;

    GIMP::UI::ColorSelect.new(
      gimp_prop_color_select_new(
        $config,
        $property_name,
        $width,
        $height,
        $type
      )
    );
  }
}

class GIMP::UI::Properties::Coordinates {

  method new (
    GObject() $config,
    Str()     $x_property_name,
    Str()     $y_property_name,
    Str()     $unit_property_name,
    Str()     $unit_format,
    Int()     $update_policy,
    Int()     $xresolution,
    Int()     $yresolution,
    Int()     $has_chainbutton
  ) {
    my gdouble                   ($x, $y) = ($xresolution, $yresolution);
    my GimpSizeEntryUpdatePolicy  $u      =  $update_policy;
    my gboolean                   $h      =  $has_chainbutton.so.Int;

    GIMP::UI::SizeEntry.new(
      gimp_prop_coordinates_new(
        $config,
        $x_property_name,
        $y_property_name,
        $unit_property_name,
        $unit_format,
        $update_policy,
        $x,
        $y,
        $h
      )
    );
  }

  method connect (
    GObject()   $config,
    Str()       $x_property_name,
    Str()       $y_property_name,
    Str()       $unit_property_name,
    GtkWidget() $sizeentry,
    GtkWidget() $chainbutton,
    Num()       $xresolution,
    Num()       $yresolution
  ) {
    my gdouble ($x, $y) = ($xresolution, $yresolution);

    gimp_prop_coordinates_connect(
      $config,
      $x_property_name,
      $y_property_name,
      $unit_property_name,
      $sizeentry,
      $chainbutton,
      $x,
      $y
    );
  }
}


class GIMP::UI::Properties::Entry {

  method new (
    GObject() $config,
    Str()     $property_name,
    Int()     $max_len
  ) {
    my gint $m = $max_len;

    GTK::Entry.new(
      gimp_prop_entry_new(
        $config,
        $property_name,
        $m
      )
    )
  }

  method scale_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $label,
    Num()     $factor,
    Int()     $limit_scale,
    Num()     $lower_limit,
    Num()     $upper_limit
  ) {
    my gdouble  ($f, $l, $u) = ($factor, $lower_limit, $upper_limit);
    my gboolean  $ls         = $limit_scale.so.Int;

    GIMP::UI::ScaleEntry.new(
      gimp_prop_scale_entry_new(
        $config,
        $property_name,
        $label,
        $f,
        $ls,
        $l,
        $u
      )
    );
  }

  method size_entry_new (
    GObject()  $config,
    Str()      $property_name,
    Int()      $property_is_pixel,
    Str()      $unit_property_name,
    Str()      $unit_format,
    Int()      $update_policy,
    Num()      $resolution
  ) {
    my gboolean                  $p = $property_is_pixel.so.Int;
    my GimpSizeEntryUpdatePolicy $u = $update_policy;
    my gdouble                   $r = $resolution;

    GIMP::UI::SizeEntry.new(
      gimp_prop_size_entry_new(
        $config,
        $property_name,
        $p,
        $unit_property_name,
        $unit_format,
        $u,
        $r
      )
    );
  }

}

class GIMP::UI::Properties::Enum {

  method check_button_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $label,
    Int()     $false_value,
    Int()     $true_value
  ) {
    my gint ($f, $t) = ($false_value, $true_value);

    GTK::CheckButton.new(
      gimp_prop_enum_check_button_new(
        $config,
        $property_name,
        $label,
        $f,
        $t
      )
    );
  }

  method combo_box_new (
    GObject() $config,
    Str()     $property_name,
    Int()     $minimum,
    Int()     $maximum
  ) {
    my ($l, $h) = ($minimum, $maximum);

    GTK::ComboBox.new(
      gimp_prop_enum_combo_box_new($config, $property_name, $l, $h)
    )
  }

  method icon_box_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $icon_prefix,
    Int()     $minimum,
    Int()     $maximum
  ) {
    my ($l, $h) = ($minimum, $maximum);

    GIMP::UI::Enum::IconBox.new(
      gimp_prop_enum_icon_box_new(
        $config,
        $property_name,
        $icon_prefix,
        $l,
        $h
      )
    );
  }
}

class GIMP::UI::Properties::Label {

  method new (
    GObject() $config,
    Str()     $property_name
  ) {
    GTK::Label.new(
      gimp_prop_enum_label_new($config, $property_name)
    )
  }
}

class GIMP::UI::Properties::Radio {

  method box_new (
    GObject() $config,
    Str()     $property_name,
    Int()     $minimum,
    Int()     $maximum
  ) {
    my ($l, $h) = ($minimum, $maximum);

    GIMP::UI::Enum::RadioBox.new(
      gimp_prop_enum_radio_box_new(
        $config,
        $property_name,
        $l,
        $h
      )
    )
  }

  method frame_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $title,
    Int()     $minimum,
    Int()     $maximum
  ) {
    my ($l, $h) = ($minimum, $maximum);

    GIMP::UI::RadioFrame.new(
      gimp_prop_enum_radio_frame_new(
        $config,
        $property_name,
        $title,
        $l,
        $h
      )
    );
  }
}

class GIMP::UI::Properties::FileChooser {

  method button_new (
    GObject() $config,
    Str()     $property_name,
    Str()     $title,
    Int()     $action
  ) {
    my GtkFileChooserAction $a = $action;

    GTK::FileChooserButton.new(
      gimp_prop_file_chooser_button_new(
        $config,
        $property_name,
        $title,
        $a
      )
    )
  }

  method new_with_dialog (
    GObject()   $config,
    Str()       $property_name,
    GtkWidget() $dialog
  ) {
    GTK::FileChooserButton.new(
      gimp_prop_file_chooser_button_new_with_dialog(
        $config,
        $property_name,
        $dialog
      )
    )
  }

}

class GIMP::UI::Properties::Scale {

  # cw: No distinction because horizontal is the only orientation offered.
  multi method new (
    GObject $config,
    Str     $property_name,
    gdouble $step_increment,
    gdouble $page_increment,
    gint    $digits
  ) {
    GTK::Scale.new(
      gimp_prop_hscale_new($config, $property_name, $s, $p, $d)
    )
  }

}

class GIMP::UI::Properties::IconImage {

  method new (
    GObject() $config,
    Str()     $property_name,
    Int()     $icon_size
  ) {
    my GtkIconSize $i = $icon_size;

    GTK::Image.new(
      gimp_prop_icon_image_new($config, $property_name, $i)
    );
  }

}


class GIMP::UI::Properties::Integer {

  method combo_box_new (
    GObject()      $config,
    Str()          $property_name,
    GimpIntStore() $store
  ) {
    GTK::ComboBox.new(
      gimp_prop_int_combo_box_new($config, $property_name, $store)
    );
  }

  method radio_frame_new (
    GObject()      $config,
    Str()          $property_name,
    Str()          $title,
    GimpIntStore() $store
  ) {
    GIMP::UI::Frame.new(
      gimp_prop_int_radio_frame_new($config, $property_name, $title, $store)
    );
  }
}

class GIMP::UI::Properties::Label {

  method color_new (
    GObject() $config,
    Str()     $property_name,
    Int()     $editable
  ) {
    my gboolean $e = $editable.so.Int;

    GIMP::UI::Label::Color.new(
      gimp_prop_label_color_new($config, $property_name, $e)
    )
  }

  method entry_new (
    GObject() $config,
    Str()     $property_name,
    Int()     $max_len
  ) {
    my gint $m = $max_len;

    GTK::Entry.new(
      gimp_prop_label_entry_new($config, $property_name, $m)
    );
  }

  method new (
    GObject $config,
    Str     $property_name
  ) {
    GTK::Label.new(
      gimp_prop_label_new($config, $property_name)
    );
  }

  method spin_new (
    GObject() $config,
    Str()     $property_name,
    Int()     $digits         = 0
  ) {
    my gint $d = $digits;

    GIMP::UI::Label::Spin.new(
      gimp_prop_label_spin_new($config, $property_name, $d)
    )
  }

}

class GIMP::UI::Properties::Memsize {

  method entry_new (
    GObject $config,
    Str     $property_name
  ) {
    GIMP::UI::MemsizeEntry.new(
      gimp_prop_memsize_entry_new($config, $property_name)
    )
  }

}

class GIMP::UI::Properties::Path {

  method new (
    GObject() $config,
    Str()     $path_property_name,
    Str()     $writable_property_name = $path_property_name,
    Str()     $filechooser_title      = $path_property_name
  ) {
    GIMP::UI::PathEditor.new(
      gimp_prop_path_editor_new(
        $config,
        $path_property_name,
        $writable_property_name,
        $filechooser_title
      )
    )
  }

}

class GIMP::UI::Properties::Pointer {

  method combo_box_new (
    GObject()      $config,
    Str()          $property_name,
    GimpIntStore() $store
  ) {
    GIMP::UI::ComboBox::Int.new(
      gimp_prop_pointer_combo_box_new($config, $property_name, $store)
    );
  }

}

role Gnome::Shell::UI::Properties::Role::Factor {

  method set_factor (
    Num() $factor,
    Num() $step_increment,
    Num() $page_increment,
    Int() $digits
  ) {
    my gdouble ($f, $s, $p) = ($factor, $step_increment, $page_increment);
    my gint     $d          =  $digits;

    gimp_prop_widget_set_factor(self.GtkWidget, $f, $s, $p, $d);
  }

}

class GIMP::UI::Properties::Spin {

  method button_new (
    GObject() $config,
    Str()     $property_name,
    Num()     $step_increment,
    Num()     $page_increment,
    Int()     $digits           = 0
  ) {
    my gdouble ($s, $p) = ($step_increment, $page_increment);
    my gint     $d      =  $digits;

    GIMP::UI::SpinButton.new(
      gimp_prop_spin_button_new($config, $property_name, $s, $p, $d)
    ) Gnome::Shell::UI::Properties::Role::Factor;
  }

  method scale_new (
    GObject() $config,
    Str()     $property_name,
    Num()     $step_increment,
    Num()     $page_increment,
    Int()     $digits           = 0
  ) {
    my gdouble ($s, $p) = ($step_increment, $page_increment);
    my gint     $d      =  $digits;

    GIMP::UI::SpinScale.new(
      gimp_prop_spin_scale_new($config, $property_name, $s, $p, $d)
    ) but Gnome::Shell::UI::Properties::Role::Factor;
  }
}

class GIMP::UI::Properties::String {

  method combo_box_new (
    GObject()      $config,
    Str()          $property_name,
    GtkTreeModel() $model,
    Int()          $id_column,
    Int()          $label_column
  ) {
    my gint ($i, $l) = ($id_column, $label_column);

    GTK::ComboBox.new(
      gimp_prop_string_combo_box_new(
        $config,
        $property_name,
        $model,
        $i,
        $l
      )
    );
  }

  method text_buffer_new (
    GObject $config,
    Str     $property_name,
    gint    $max_len
  ) {
    my gint $m = $max_len;

    GTK::TextBuffer.new(
      gimp_prop_text_buffer_new($config, $property_name, $m);
    );
  }

}

class Gnome::Shell::UI::Properties::Units {

  method combo_box_new (
    GObject() $config,
    Str()     $property_name
  ) {
    GTK::ComboBox.new(
      gimp_prop_unit_combo_box_new($config, $property_name)
    );
  }

}
