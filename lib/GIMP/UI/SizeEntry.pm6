use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::SizeEntry;

use GTK::Grid;

use GLib::Roles::Implementor;

our subset GimpSizeEntryAncestry is export of Mu
  where GimpSizeEntry | GtkGridAncestry;

class GIMP::UI::SizeEntry is GTK::Grid {
  has GimpSizeEntry $!g-se is implementor;

  submethod BUILD ( :$gimp-size-entry ) {
    self.setGimpSizeEntry($gimp-size-entry) if $gimp-size-entry
  }

  method setGimpSizeEntry (GimpSizeEntryAncestry $_) {
    my $to-parent;

    $!g-se = do {
      when GimpSizeEntry {
        $to-parent = cast(GtkGrid, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpSizeEntry, $_);
      }
    }
    self.setGtkGrid($to-parent);
  }

  method GIMP::Raw::Structs::GimpSizeEntry
    is also<GimpSizeEntry>
  { $!g-se }

  multi method new (
     $gimp-size-entry where * ~~ GimpSizeEntryAncestry,

    :$ref = True
  ) {
    return unless $gimp-size-entry;

    my $o = self.bless( :$gimp-size-entry );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int() $number_of_fields,
    Int() $unit,
    Str() $unit_format,
    Int() $menu_show_pixels,
    Int() $menu_show_percent,
    Int() $show_refval,
    Int() $spinbutton_width,
    Int() $update_policy
  ) {
    my gboolean ($px, $pt, $rv) =
      ($menu_show_pixels, $menu_show_percent, $show_refval).map( *.so.Int);

    my GimpUnit                  $n   = $unit;
    my GimpSizeEntryUpdatePolicy $u   = $update_policy;
    my gint                      $num = $number_of_fields;
    my gint                      $s   = $spinbutton_width;

    my $gimp-size-entry = gimp_size_entry_new(
      $num,
      $n,
      $unit_format,
      $px,
      $pt,
      $rv,
      $s,
      $u
    );

    $gimp-size-entry ?? self.bless( :$gimp-size-entry ) !! Nil;
  }

  method value-changed {
    self.connect($!g-se, 'value-changed');
  }

  method refval-changed {
    self.connect($!g-se, 'refval-changed');
  }

  method unit-changed {
    self.connect($!g-se, 'unit-changed');
  }

  method add_field (
    GtkSpinButton() $value_spinbutton,
    GtkSpinButton() $refval_spinbutton
  )
    is also<add-field>
  {
    gimp_size_entry_add_field(
      $!g-se,
      $value_spinbutton,
      $refval_spinbutton
    );
  }

  method attach_label (
    Str() $text,
    Int() $row,
    Int() $column,
    Num() $alignment
  )
    is also<attach-label>
  {
    my gint   ($r, $c) = ($row, $column);
    my gfloat  $a      =  $alignment;

    gimp_size_entry_attach_label(
      $!g-se,
      $text,
      $r,
      $c,
      $alignment
    );
  }

  method get_help_widget (Int() $field) is also<get-help-widget> {
    my gint $f = $field;

    gimp_size_entry_get_help_widget($!g-se, $f);
  }

  method get_n_fields is also<get-n-fields> {
    gimp_size_entry_get_n_fields($!g-se);
  }

  method get_refval (Int() $field) is also<get-refval> {
    my gint $f = $field;

    gimp_size_entry_get_refval($!g-se, $f);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_size_entry_get_type, $n, $t );
  }

  method get_unit is also<get-unit> {
    gimp_size_entry_get_unit($!g-se);
  }

  method get_unit_combo is also<get-unit-combo> {
    gimp_size_entry_get_unit_combo($!g-se);
  }

  method get_update_policy ( :$enum = True ) is also<get-update-policy> {
    my $p = gimp_size_entry_get_update_policy($!g-se);
    return $p unless $enum;
    GimpSizeEntryUpdatePolicyEnum($p)
  }

  method get_value (Int() $field) is also<get-value> {
    my gint $f = $field;

    gimp_size_entry_get_value($!g-se, $f);
  }

  method grab_focus is also<grab-focus> {
    gimp_size_entry_grab_focus($!g-se);
  }

  method set_activates_default (Int() $setting)
    is also<set-activates-default>
  {
    my gboolean $s = $setting;

    gimp_size_entry_set_activates_default($!g-se, $s);
  }

  method set_pixel_digits (Int() $digits) is also<set-pixel-digits> {
    my gint $d = $digits;

    gimp_size_entry_set_pixel_digits($!g-se, $d);
  }

  method set_refval (Int() $field, Num() $refval) is also<set-refval> {
    my gint    $f = $field;
    my gdouble $r = $refval;

    gimp_size_entry_set_refval($!g-se, $f, $r);
  }

  method set_refval_boundaries (Int() $field, Num() $lower, Num() $upper)
    is also<set-refval-boundaries>
  {
    my gint     $f      =  $field;
    my gdouble ($l, $u) = ($lower, $upper);

    gimp_size_entry_set_refval_boundaries($!g-se, $f, $l, $u);
  }

  method set_refval_digits (Int() $field, Int() $digits)
    is also<set-refval-digits>
  {
    my gint ($f, $d) = ($field, $digits);

    gimp_size_entry_set_refval_digits($!g-se, $f, $d);
  }

  method set_resolution (
    Int() $field,
    Num() $resolution,
    Int() $keep_size
  )
    is also<set-resolution>
  {
    my gint     $f = $field;
    my gdouble  $r = $resolution;
    my gboolean $k = $keep_size.so.Int;

    gimp_size_entry_set_resolution($!g-se, $f, $r, $k);
  }

  method set_size ( Int() $field, Num() $lower, Num() $upper)
    is also<set-size>
  {
    my gint     $f      =  $field;
    my gdouble ($l, $u) = ($lower, $upper);

    gimp_size_entry_set_size($!g-se, $f, $l, $u);
  }

  method set_unit (Int() $unit) is also<set-unit> {
    my GimpUnit $u = $unit;

    gimp_size_entry_set_unit($!g-se, $u);
  }

  method set_value (Int() $field, Num() $value) is also<set-value> {
    my gint    $f = $field;
    my gdouble $v = $value;

    gimp_size_entry_set_value($!g-se, $f, $v);
  }

  method set_value_boundaries (Int() $field, Num() $lower, Num() $upper)
    is also<set-value-boundaries>
  {
    my gint     $f      =  $field;
    my gdouble ($l, $u) = ($lower, $upper);

    gimp_size_entry_set_value_boundaries($!g-se, $field, $lower, $upper);
  }

  method show_unit_menu (Int() $show) is also<show-unit-menu> {
    my gboolean $s = $show;

    gimp_size_entry_show_unit_menu($!g-se, $s);
  }

}
