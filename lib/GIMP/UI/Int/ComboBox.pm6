use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Int::ComboBox;

use GTK::ComboBox:ver<3>;

our subset GimpIntComboBoxAncestry is export of Mu
  where GimpIntComboBox | GtkComboBoxAncestry;

class GIMP::UI::Int::ComboBox is GTK::ComboBox {
  has GimpIntComboBox $!gicb is implementor;

  submethod BUILD ( :$gimp-int-combo ) {
    self.setGimpIntComboBox($gimp-int-combo) if $gimp-int-combo
  }

  method setGimpIntComboBox (GimpIntComboBoxAncestry $_) {
    my $to-parent;

    $!gicb = do {
      when GimpIntComboBox {
        $to-parent = cast(GtkComboBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpIntComboBox, $_);
      }
    }
    self.setGtkComboBox($to-parent);
  }

  method GIMP::Raw::Definitions::GimpIntComboBox
    is also<GimpIntComboBox>
  { $!gicb }

  multi method new (
     $gimp-int-combo where * ~~ GimpIntComboBoxAncestry,

    :$ref = True
  ) {
    return unless $gimp-int-combo;

    my $o = self.bless( :$gimp-int-combo );
    $o.ref if $ref;
    $o;
  }

  method new (
    Str()  $first_label,
    Int()  $first_value,
          *%a
  ) {
    my gint $v = $first_value;

    my $gimp-int-combo = gimp_int_combo_box_new($first_label, $v, Str);

    my $o = $gimp-int-combo ?? self.bless( :$gimp-int-combo ) !! Nil
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  proto method new_array (|)
    is also<new-array>
  { * }

  multi method new_array (@labels, *%a) {
    samewith(@labels.elems, ArrayToCArray(Str, @labels), |%a);
  }
  multi method new_array (Int() $n-values, CArray[Str] $labels, *%a) {
    my gint $n = $n-values;

    my $gimp-int-combo = gimp_int_combo_box_new_array($ns, $labels);

    my $o = $gimp-int-combo ?? self.bless( :$gimp-int-combo ) !! Nil
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: PangoEllipsizeMode
  method ellipsize ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::Enums::EllipsizeMode.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ellipsize', $gv);
        my $e = $gv.enum;
        return $e unless $enum;
        PangoEllipsizeModeEnum($e);
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(PangoEllipsizeMode) = $val;
        self.prop_set('ellipsize', $gv);
      }
    );
  }

  # Type: string
  method label is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: GimpIntComboBoxLayout
  method layout ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GIMP::Enums::UI::Int::ComboBox.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('layout', $gv);
        my $l = $gv.enum;
        return $l unless $enum;
        GimpIntComboBoxLayoutEnum($l)l
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(GimpIntComboBoxLayout) = $val;
        self.prop_set('layout', $gv);
      }
    );
  }

  # Type: int
  method value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('value', $gv);
      }
    );
  }

  method append {
    gimp_int_combo_box_append($!gicb);
  }

  method connect (
    Int()    $value,
             &callback,
    gpointer $data,
             &data_destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    my gint $v = $value;

    gimp_int_combo_box_connect($!gicb, $v, &callback, $data, &data_destroy);
  }

  proto method get_active (|)
    is also<get-active>
  { * }

  multi method get_active {
    samewith($);
  }
  multi method get_active ($value is rw) {
    my gint $v = 0;

    gimp_int_combo_box_get_active($!gicb, $v);
    $value = $v;
  }

  method get_active_user_data (gpointer $user_data) is also<get-active-user-data> {
    gimp_int_combo_box_get_active_user_data($!gicb, $user_data);
  }

  method get_label is also<get-label> {
    gimp_int_combo_box_get_label($!gicb);
  }

  method get_layout ( :$enum = True ) is also<get-layout> {
    my $l = gimp_int_combo_box_get_layout($!gicb);
    return $l unless $enum;
    GimpIntComboBoxLayoutEnum($l);
  }

  method get_type is also<get-type> {
    state ($n, $t)

    unstable_get_type( self.^name, &gimp_int_combo_box_get_type, $n, $t );
  }

  method prepend {
    gimp_int_combo_box_prepend($!gicb);
  }

  method set_active (Int() $value) is also<set-active> {
    my gint $v = $value;

    gimp_int_combo_box_set_active($!gicb, $v);
  }

  method set_active_by_user_data (gpointer $user_data) is also<set-active-by-user-data> {
    gimp_int_combo_box_set_active_by_user_data($!gicb, $user_data);
  }

  method set_label (Str() $label) is also<set-label> {
    gimp_int_combo_box_set_label($!gicb, $label);
  }

  method set_layout (Int() $layout) is also<set-layout> {
    my GimpIntComboBoxLayout $l = $layout;

    gimp_int_combo_box_set_layout($!gicb, $l);
  }

  method set_sensitivity (
             &func,
    gpointer $data,
             &destroy = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-sensitivity>
  {
    gimp_int_combo_box_set_sensitivity($!gicb, &func, $data, &destroy);
  }

}
