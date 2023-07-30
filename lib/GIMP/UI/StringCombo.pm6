use v6.c;

use NativeCall;

use GIMP::Raw::Types;

use GTK::ComboBox;

use GLib::Roles::Implementor;

class GIMP::UI::StringCombo is GTK::ComboBox {
  has GimpStringComboBox $!g-scb is implementor;

  # cw: Look into initializing a GtkTreeModel (which is deprecated in
  #     GTK4!) from a hash. Can either guess the field defs from the values
  #     (with help from :$signed and :$double -- Nums are ALWAYS :$double)
  #     Or take the fields from the hash, directly by using :$fields.

  method new (
    GtkTreeModel() $model,
    Int()          $id_column,
    Int()          $label_column
  ) {
    my gint $i = $id_column;
    my gint $l = $label_column;

    my $gimp-combo-string = gimp_string_combo_box_new($model, $i, $l);

    $gimp-combo-string ?? self.bless( :$gimp-combo-string ) !! Nil;
  }

  method get_active {
    gimp_string_combo_box_get_active($!g-scb);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_string_combo_box_get_type, $n, $t );
  }

  method set_active (Str() $id) {
    gimp_string_combo_box_set_active($!g-scb, $id);
  }

}

### /usr/src/gimp/libgimpwidgets/gimpstringcombobox.h

sub gimp_string_combo_box_get_active (GimpStringComboBox $combo_box)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_string_combo_box_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_string_combo_box_new (
  GtkTreeModel $model,
  gint         $id_column,
  gint         $label_column
)
  returns GimpStringComboBox
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_string_combo_box_set_active (
  GimpStringComboBox $combo_box,
  Str                $id
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }
