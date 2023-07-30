use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::ScrolledPreview;

use GIMP::UI::Preview;

use GLib::Roles::Implementor;

our subset GimpScrolledPreviewAncestry is export of Mu
  where GimpScrolledPreview | GimpPreviewAncestry;

class GIMP::UI::ScrolledPreview is GIMP::UI::Preview {
  has GimpScrolledPreview $!g-sp is implementor;

  submethod BUILD ( :$gimp-scrolled-preview ) {
    self.setGimpScrolledPreview($gimp-scrolled-preview)
      if $gimp-scrolled-preview
  }

  method setGimpScrolledPreview (GimpScrolledPreviewAncestry $_) {
    my $to-parent;

    $!g-sp = do {
      when GimpScrolledPreview {
        $to-parent = cast(GimpPreview, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpScrolledPreview, $_);
      }
    }
    self.setGimpPreview($to-parent);
  }

  method GIMP::Raw::Definitions::GimpScrolledPreview
    is also<GimpScrolledPreview>
  { $!g-sp }

  multi method new (
     $gimp-scrolled-preview where * ~~ GimpScrolledPreviewAncestry,

    :$ref = True
  ) {
    return unless $gimp-scrolled-preview;

    my $o = self.bless( :$gimp-scrolled-preview );
    $o.ref if $ref;
    $o;
  }

  method freeze {
    gimp_scrolled_preview_freeze($!g-sp);
  }

  proto method get_adjustments (|)
    is also<get-adjustments>
  { * }

  multi method get_adjustments {
    samewith(GTK::Adjustment.new, GTK::Adjustment.new)
  }
  multi method get_adjustments (
    GtkAdjustment()  $hadj,
    GtkAdjustment()  $vadj,
                    :$raw   = False
  ) {
    my $rv = gimp_scrolled_preview_get_adjustments($!g-sp, $hadj, $vadj);

    my $h = returnProperObject($hadj, $raw, |GTK::Adjustment.getTypePair);
    my $v = returnProperObject($vadj, $raw, |GTK::Adjustment.getTypePair);

    $rv ?? ($h, $v) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_scrolled_preview_get_type, $n, $t );
  }

  method set_policy (Int() $hscrollbar_policy, Int() $vscrollbar_policy)
    is also<set-policy>
  {
    my GtkPolicyType ($h, $v) = ($hscrollbar_policy, $vscrollbar_policy);

    gimp_scrolled_preview_set_policy($!g-sp, $h, $v);
  }

  method set_position (Int() $x, Int() $y) is also<set-position> {
    my gint ($xx, $yy) = ($x, $y);

    gimp_scrolled_preview_set_position($!g-sp, $xx, $yy);
  }

  method thaw {
    gimp_scrolled_preview_thaw($!g-sp);
  }

}

role GIMP::Roles::ScrolledPreview::Event {

  proto method adjustment_values (|)
    is also<adjustment-values>
  { * }

  multi method adjustment_values (
    GtkAdjustment() $hadj,
    GtkAdjustment() $vadj
  ) {
    samewith($hadj, $vadj, $, $);
  }
  multi method adjustment_values (
    GtkAdjustment() $hadj,
    GtkAdjustment() $vadj,
                    $hvalue is rw,
                    $vvalue is rw
  ) {
    my gdouble ($h, $v) = 0e0 xx 2;

    gimp_scroll_adjustment_values(self.GdkEvent, $hadj, $vadj, $h, $v);
    ($hvalue, $vvalue) = ($h, $v);
  }

}
