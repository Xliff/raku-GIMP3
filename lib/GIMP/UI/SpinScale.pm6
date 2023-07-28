use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::SpinScale;

use GIMP::UI::SpinButton;

use GLib::Roles::Implementor;

our subset GimpSpinScaleAncestry is export of Mu
  where GimpSpinScale | GimpSpinButtonAncestry;

class GIMP::UI::SpinScale is GIMP::UI::SpinButton {
  has GimpSpinScale $!g-ss is implementor;

  submethod BUILD ( :$gimp-spin-scale ) {
    self.setGimpSpinScale($gimp-spin-scale) if $gimp-spin-scale
  }

  method setGimpSpinScale (GimpSpinScaleAncestry $_) {
    my $to-parent;

    $!g-ss = do {
      when GimpSpinScale {
        $to-parent = cast(GimpSpinButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpSpinScale, $_);
      }
    }
    self.setGimpSpinButton($to-parent);
  }

  method GIMP::Raw::Definitions::GimpSpinScale
    is also<GimpSpinScale>
  { $!g-ss }

  multi method new (
     $gimp-spin-scale where * ~~ GimpSpinScaleAncestry,

    :$ref = True
  ) {
    return unless $gimp-spin-scale;

    my $o = self.bless( :$gimp-spin-scale );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    GtkAdjustment() $adjustment,
    Str()           $label,
    Int()           $digits
  ) {
    my gint $d = $digits;

    my $gimp-spin-scale = gimp_spin_scale_new($adjustment, $label, $d);

    $gimp-spin-scale ?? self.bless( :$gimp-spin-scale ) !! Nil;
  }

  method get_constrain_drag is also<get-constrain-drag> {
    gimp_spin_scale_get_constrain_drag($!g-ss);
  }

  method get_gamma is also<get-gamma> {
    gimp_spin_scale_get_gamma($!g-ss);
  }

  method get_label is also<get-label> {
    gimp_spin_scale_get_label($!g-ss);
  }

  method get_mnemonic_keyval is also<get-mnemonic-keyval> {
    gimp_spin_scale_get_mnemonic_keyval($!g-ss);
  }

  proto method get_scale_limits (|)
    is also<get-scale-limits>
  { * }

  multi method get_scale_limits {
    samewith($, $);
  }
  multi method get_scale_limits ($lower is rw, $upper is rw) {
    my gdouble ($l, $u) = 0e0 xx 2;

    gimp_spin_scale_get_scale_limits($!g-ss, $l, $u);
    ($lower, $upper) = ($l, $u);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_spin_scale_get_type, $n, $t );
  }

  method set_constrain_drag (Int() $constrain) is also<set-constrain-drag> {
    my gboolean $c = $constrain;

    gimp_spin_scale_set_constrain_drag($!g-ss, $c);
  }

  method set_gamma (Num() $gamma) is also<set-gamma> {
    my gdouble $g = $gamma;

    gimp_spin_scale_set_gamma($!g-ss, $g);
  }

  method set_label (Str() $label) is also<set-label> {
    gimp_spin_scale_set_label($!g-ss, $label);
  }

  method set_scale_limits (Num() $lower, Num() $upper)
    is also<set-scale-limits>
  {
    my gdouble ($l, $u) = ($lower, $upper);

    gimp_spin_scale_set_scale_limits($!g-ss, $l, $u);
  }

  method unset_scale_limits is also<unset-scale-limits> {
    gimp_spin_scale_unset_scale_limits($!g-ss);
  }

}
