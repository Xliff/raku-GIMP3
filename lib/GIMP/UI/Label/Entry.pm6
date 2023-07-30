use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;

use GTK::Widget;
use GIMP::UI::Labeled;

use GLib::Roles::Implementor;

our subset GimpLabelEntryAncestry is export of Mu
  where GimpLabelEntry | GimpLabeledAncestry;

class GIMP::UI::Label::Entry is GIMP::UI::Labeled {
  has GimpLabelEntry $!g-le is implementor;

  submethod BUILD ( :$gimp-label-entry ) {
    self.setGimpLabelEntry($gimp-label-entry) if $gimp-label-entry
  }

  method setGimpLabelEntry (GimpLabelEntryAncestry $_) {
    my $to-parent;

    $!g-le = do {
      when GimpLabelEntry {
        $to-parent = cast(GimpLabeled, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpLabelEntry, $_);
      }
    }
    self.setGimpLabeled($to-parent);
  }

  method GIMP::Raw::Definitions::GimpLabelEntry
    is also<GimpLabelEntry>
  { $!g-le }

  multi method new (
     $gimp-label-entry where * ~~ GimpLabelEntryAncestry,

    :$ref = True
  ) {
    return unless $gimp-label-entry;

    my $o = self.bless( :$gimp-label-entry );
    $o.ref if $ref;
    $o;
  }

  multi method new (Str() $label) {
    my $gimp-label-entry = gimp_label_entry_new($label);

    $gimp-label-entry ?? self.bless( :$gimp-label-entry ) !! Nil;
  }

  # Type: string
  method value is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('value', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('value', $gv);
      }
    );
  }

  method value-changed is also<value_changed> {
    self.connect($!g-le, 'value-changed');
  }

  method get_entry ( :$raw = False ) is also<get-entry> {
    ReturnWidget(
      gimp_label_entry_get_entry($!g-le),
      $raw
    );
  }

  method get_value is also<get-value> {
    gimp_label_entry_get_value($!g-le);
  }

  method set_value (Str() $value) is also<set-value> {
    gimp_label_entry_set_value($!g-le, $value);
  }

}

### /usr/src/gimp/libgimpwidgets/gimplabelentry.h

sub gimp_label_entry_get_entry (GimpLabelEntry $entry)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_entry_get_value (GimpLabelEntry $entry)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_entry_new (Str $label)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_label_entry_set_value (
  GimpLabelEntry $entry,
  Str            $value
)
  is      native(gimpwidgets)
  is      export
{ * }
