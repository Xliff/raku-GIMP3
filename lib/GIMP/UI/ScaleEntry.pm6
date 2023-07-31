use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::ScaleEntry;

use GTK::Widget;
use GIMP::UI::Label::Spin;

use GLib::Roles::Implementor;

our subset GimpScaleEntryAncestry is export of Mu
  where GimpScaleEntry | GimpLabelSpinAncestry;

class GIMP::UI::ScaleEntry is GIMP::UI::Label::Spin {
  has GimpScaleEntry $!g-se is implementor;

  submethod BUILD ( :$gimp-scale-entry ) {
    self.setGimpScaleEntry($gimp-scale-entry) if $gimp-scale-entry
  }

  method setGimpScaleEntry (GimpScaleEntryAncestry $_) {
    my $to-parent;

    $!g-se = do {
      when GimpScaleEntry {
        $to-parent = cast(GimpLabelSpin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpScaleEntry, $_);
      }
    }
    self.setGimpLabelSpin($to-parent);
  }

  method GIMP::Raw::Definitions::GimpScaleEntry
    is also<GimpScaleEntry>
  { $!g-se }

  multi method new (
     $gimp-scale-entry where * ~~ GimpScaleEntryAncestry,

    :$ref = True
  ) {
    return unless $gimp-scale-entry;

    my $o = self.bless( :$gimp-scale-entry );
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

    my $gimp-scale-entry = gimp_scale_entry_new($text, $v, $l, $u, $d);

    $gimp-scale-entry ?? self.bless( :$gimp-scale-entry ) !! Nil;
  }

  method get_logarithmic is also<get-logarithmic> {
    so gimp_scale_entry_get_logarithmic($!g-se);
  }

  method get_range ( :$raw = False ) is also<get-range> {
    ReturnWidget(
      gimp_scale_entry_get_range($!g-se),
      $raw
    );
  }

  method set_bounds (Num() $lower, Num() $upper, Int() $limit_scale)
    is also<set-bounds>
  {
    my gdouble  ($l, $u) = ($lower, $upper);
    my gboolean  $ls     =  $limit_scale.so.Int;

    gimp_scale_entry_set_bounds($!g-se, $l, $u, $ls);
  }

  method set_logarithmic (Int() $logarithmic) is also<set-logarithmic> {
    my gboolean $l = $logarithmic.so.Int;

    gimp_scale_entry_set_logarithmic($!g-se, $l);
  }

}
