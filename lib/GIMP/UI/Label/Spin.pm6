use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Label::Spin;

use GTK::Widget;
use GIMP::UI::Labeled;

use GLib::Roles::Implementor;

our subset GimpLabelSpinAncestry is export of Mu
  where GimpLabelSpin | GimpLabeledAncestry;

class GIMP::UI::Label::Spin {
  has GimpLabelSpin $!g-ls is implementor;

  submethod BUILD ( :$gimp-label-spin ) {
    self.setGimpLabelSpin($gimp-label-spin) if $gimp-label-spin
  }

  method setGimpLabelSpin (GimpLabelSpinAncestry $_) {
    my $to-parent;

    $!g-ls = do {
      when GimpLabelSpin {
        $to-parent = cast(GimpLabeled, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpLabelSpin, $_);
      }
    }
    self.setGimpLabeled($to-parent);
  }

  method GIMP::Raw::Definitions::GimpLabelSpin
    is also<GimpLabelSpin>
  { $!g-ls }

  multi method new (
     $gimp-label-spin where * ~~ GimpLabelSpinAncestry,

    :$ref = True
  ) {
    return unless $gimp-label-spin;

    my $o = self.bless( :$gimp-label-spin );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $text,
    Num() $value,
    Num() $lower,
    Num() $upper,
    Int() $digits
  ) {
    my gdouble ($v, $l, $u) = ($value, $lower, $upper);
    my gint     $d          =  $digits;

    my $gimp-label-spin = gimp_label_spin_new($text, $v, $l, $u, $d);

    $gimp-label-spin ?? self.bless( :$gimp-label-spin ) !! Nil;
  }

  # Type: int
  method digits is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('digits', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('digits', $gv);
      }
    );
  }

  # Type: double
  method lower is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('lower', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('lower', $gv);
      }
    );
  }

  # Type: double
  method upper is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('upper', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('upper', $gv);
      }
    );
  }

  # Type: double
  method value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('value', $gv);
      }
    );
  }

  method value-changed {
    self.connect($!g-ls, 'value-changed');
  }

  method get_spin_button ( :$raw = False ) is also<get-spin-button> {
    ReturnWidget(
      gimp_label_spin_get_spin_button($!g-ls),
      $raw
    );
  }

  method get_value is also<get-value> {
    gimp_label_spin_get_value($!g-ls);
  }

  method set_digits (Int() $digits) is also<set-digits> {
    my gint $d = $digits;

    gimp_label_spin_set_digits($!g-ls, $d);
  }

  method set_increments (Num() $step, Num() $page) is also<set-increments> {
    my gdouble ($s, $p) = ($step, $page);

    gimp_label_spin_set_increments($!g-ls, $s, $p);
  }

  method set_value (Num() $value) is also<set-value> {
    my gdouble $v = $value;

    gimp_label_spin_set_value($!g-ls, $v);
  }

}
