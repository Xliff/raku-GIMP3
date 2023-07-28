use v6.c;

use Method::Also;
use NativeCall;

use GIMP::Raw::Types;

use GTK::SpinButton;

use GLib::Roles::Implementor;

our subset GimpSpinButtonAncestry is export of Mu
  where GimpSpinButton | GtkSpinButtonAncestry;

class GIMP::UI::SpinButton is GTK::SpinButton {
  has GimpSpinButton $!g-sb is implementor;

  submethod BUILD ( :$gimp-spin-button ) {
    self.setGimpSpinButton($gimp-spin-button) if $gimp-spin-button
  }

  method setGimpSpinButton (GimpSpinButtonAncestry $_) {
    my $to-parent;

    $!g-sb = do {
      when GimpSpinButton {
        $to-parent = cast(GtkSpinButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpSpinButton, $_);
      }
    }
    self.setGtkSpinButton($to-parent);
  }

  method GIMP::Raw::Structs::GimpSpinButton
    is also<GimpSpinButton>
  { $!g-sb }

  multi method new (
     $gimp-spin-button where * ~~ GimpSpinButtonAncestry,

    :$ref = True
  ) {
    return unless $gimp-spin-button;

    my $o = self.bless( :$gimp-spin-button );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GtkAdjustment() $adjustment,
    Num()           $climb_rate,
    Int()           $digits
  ) {
    my gdouble $c = $climb_rate;
    my guint   $d = $digits;

    my $gimp-spin-button = gimp_spin_button_new($adjustment, $c, $d);

    $gimp-spin-button ?? self.bless( :$gimp-spin-button ) !! Nil;
  }
  multi method new (
    Num()  $min,
    Num()  $max,
    Num()  $step,
          :r(:$range) is required
  ) {
    ::?CLASS.new_with_range($min, $max, $step);
  }

  method new_with_range (Num() $min, Num() $max, Num() $step)
    is also<new-with-range>
  {
    my gdouble ($n, $x, $s) = ($min, $max, $step);

    my $gimp-spin-button = gimp_spin_button_new_with_range($n, $x, $s);

    $gimp-spin-button ?? self.bless( :$gimp-spin-button ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_spin_button_get_type, $n, $t );
  }

}


### /usr/src/gimp/libgimpwidgets/gimpspinbutton.h

sub gimp_spin_button_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_button_new (
  GtkAdjustment $adjustment,
  gdouble       $climb_rate,
  guint         $digits
)
  returns GimpSpinButton
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_spin_button_new_with_range (
  gdouble $min,
  gdouble $max,
  gdouble $step
)
  returns GimpSpinButton
  is      native(gimpwidgets)
  is      export
{ * }
