use v6.c;

use Method::Also;

use GIMP::Raw::Types;

use GTK::Button;

our subset GimpButtonAncestry is export of Mu
  where GimpButton | GtkButtonAncestry;

class GIMP::UI::Button is GTK::Button {
  has GimpButton $!g-b is implementor;

  submethod BUILD ( :$gimp-button ) {
    self.setGimpButton($gimp-button) if $gimp-button
  }

  method setGimpButton (GimpButtonAncestry $_) {
    my $to-parent;

    $!g-b = do {
      when GimpButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpButton, $_);
      }
    }
    self.setGtkButton($to-parent);
  }

  method GIMP::Raw::Structs::GimpButton
    is also<GimpButton>
  { $!g-b }

  multi method new (
     $gimp-button where * ~~ GimpButtonAncestry,

    :$ref = True
  ) {
    return unless $gimp-button;

    my $o = self.bless( :$gimp-button );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-button = gimp_button_new();

    $gimp-button ?? self.bless( :$gimp-button ) !! Nil;
  }

  method Extended-Clicked is also<Extended_Clicked> {
    self.connect-uint($!g-b, 'extended-clicked');
  }

  method extended_clicked (Int() $modifier_state)
    is also<
      extended-clicked
      emit_extended-clicked
      emit-extended-clicked
    >
  {
    my GdkModifierType $m = $modifier_state;

    gimp_button_extended_clicked($!g-b, $m);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name.&gimp_button_get_type, $n, $t );
  }

}

### /usr/src/gimp/libgimpwidgets/gimpbutton.h

sub gimp_button_extended_clicked (
  GimpButton      $button,
  GdkModifierType $modifier_state
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_button_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_button_new
  returns GimpButton
  is      native(gimpwidgets)
  is      export
{ * }
