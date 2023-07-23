use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Label::Color;

use GTK::Widget;
use GIMP::UI::Labeled;

use GLib::Roles::Implementor;

our subset GimpLabelColorAncestry is export of Mu
  where GimpLabelColor | GimpLabeledAncestry;

class GIMP::UI::Label::Color is GIMP::UI::Labeled {
  has GimpLabelColor $!g-lc is implementor;

  submethod BUILD ( :$gimp-label-color ) {
    self.setGimpLabelColor($gimp-label-color) if $gimp-label-color
  }

  method setGimpLabelColor (GimpLabelColorAncestry $_) {
    my $to-parent;

    $!g-lc = do {
      when GimpLabelColor {
        $to-parent = cast(GimpLabeled, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpLabelColor, $_);
      }
    }
    self.setGimpLabeled($to-parent);
  }

  method GIMP::Raw::Definitions::GimpLabelColor
    is also<GimpLabelColor>
  { $!g-lc }

  multi method new (
     $gimp-label-color where * ~~ GimpLabelColorAncestry,

    :$ref = True
  ) {
    return unless $gimp-label-color;

    my $o = self.bless( :$gimp-label-color );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()     $label,
    GimpRGB() $color,
    Int()     $editable = False
  ) {
    my gboolean $e = $editable.so.Int;

    my $gimp-label-color = gimp_label_color_new($label, $color, $e);

    $gimp-label-color ?? self.bless( :$gimp-label-color ) !!Nil;
  }

  method get_color_widget ( :$raw = False ) is also<get-color-widget> {
    ReturnWidget(
      gimp_label_color_get_color_widget($!g-lc),
      $raw
    )
  }

  proto method get_value (|)
    is also<get-value>
  { * }

  multi method get_value ( :$raw = False ) {
    samewith(GimpRGB.new, :$raw);
  }
  multi method get_value (GimpRGB() $value, :$raw = False) {
    gimp_label_color_get_value($!g-lc, $value),
    propReturnObject( $value, $raw, |GIMP::RGB.getTypePair )
  }

  method is_editable is also<is-editable> {
    so gimp_label_color_is_editable($!g-lc);
  }

  method set_editable (Int() $editable) is also<set-editable> {
    my gboolean $e = $editable.so.Int;

    gimp_label_color_set_editable($!g-lc, $e);
  }

  method set_value (GimpRGB() $value) is also<set-value> {
    gimp_label_color_set_value($!g-lc, $value);
  }

}
