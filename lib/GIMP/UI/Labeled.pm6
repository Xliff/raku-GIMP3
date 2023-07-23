use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;

use GTK::Grid;

use GLib::Roles::Implementor;

our subset GimpLabeledAncestry is export of Mu
  where GimpLabeled | GtkGridAncestry;

class GIMP::Labeled is GTK::Grid {
  has GimpLabeled $!g-l is implementor;

  submethod BUILD ( :$gimp-labeled ) {
    self.setGimpLabeled($gimp-labeled) if $gimp-labeled
  }

  method setGimpLabeled (GimpLabeledAncestry $_) {
    my $to-parent;

    $!g-l = do {
      when GimpLabeled {
        $to-parent = cast(GtkGrid, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpLabeled, $_);
      }
    }
    self.setGtkGrid($to-parent);
  }

  method GIMP::Raw::Definitions::GimpLabeled
    is also<GimpLabeled>
  { $!g-l }

  multi method new (
     $gimp-labeled where * ~~ GimpLabeledAncestry,

    :$ref = True
  ) {
    return unless $gimp-labeled;

    my $o = self.bless( :$gimp-labeled );
    $o.ref if $ref;
    $o;
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

  method mnemonic-widget-changed is also<mnemonic_widget_changed> {
    self.connect($!g-l, 'mnemonic-widget-changed');

  }
  method get_label ( :$raw = False ) is also<get-label> {
    propReturnObject(
      gimp_labeled_get_label($!g-l),
      $raw,
      |GTK::Label.getTypePair
    );
  }

  method get_text is also<get-text> {
    gimp_labeled_get_text($!g-l);
  }

  method set_text (Str() $text) is also<set-text> {
    gimp_labeled_set_text($!g-l, $text);
  }

}

### /usr/src/gimp/libgimpwidgets/gimplabeled.h

sub gimp_labeled_get_label (GimpLabeled $labeled)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_labeled_get_text (GimpLabeled $labeled)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_labeled_set_text (
  GimpLabeled $labeled,
  Str         $text
)
  is      native(gimpwidgets)
  is      export
{ * }
