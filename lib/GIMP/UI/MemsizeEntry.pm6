use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;

use GTK::Box;
use GTK::Widget;

use GLib::Roles::Implementor;

our subset GimpMemsizeEntryAncestry is export of Mu
  where GimpMemsizeEntry | GtkBoxAncestry;

class GIMP::UI::MemsizeEntry is GTK::Box {
  has GimpMemsizeEntry $!g-mse is implementor;

  submethod BUILD ( :$gimp-memsize-entry ) {
    self.setGimpMemsizeEntry($gimp-memsize-entry)
      if $gimp-memsize-entry
  }

  method setGimpMemsizeEntry (GimpMemsizeEntryAncestry $_) {
    my $to-parent;

    $!g-mse = do {
      when GimpMemsizeEntry {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpMemsizeEntry, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GIMP::Raw::Definitions::GimpMemsizeEntry
    is also<GimpMemsizeEntry>
  { $!g-mse }

  multi method new (
     $gimp-memsize-entry where * ~~ GimpMemsizeEntryAncestry,

    :$ref = True
  ) {
    return unless $gimp-memsize-entry;

    my $o = self.bless( :$gimp-memsize-entry );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Num() :$default = 0.25,
    Int() :$upper   = $*KERNEL.total-memory,
    Int() :$value   = $upper * $default,
    Int() :$lower   = 0,
  ) {
    samewith($value, $lower, $upper);
  }
  multi method new (Int() $value, Int() $lower, Int() $upper) {
    my guint64 ($v, $l, $u) = ($value, $lower, $upper);

    gimp_memsize_entry_new($!g-mse, $lower, $upper);
  }

  method value-changed is also<value_changed> {
    self.connect($!g-mse, 'value-changed');
  }

  method get_spinbutton ( :$raw = False ) is also<get-spinbutton> {
    ReturnWidget(
      gimp_memsize_entry_get_spinbutton($!g-mse),
      $raw
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_memsize_entry_get_type, $n, $t );
  }

  method get_value is also<get-value> {
    gimp_memsize_entry_get_value($!g-mse);
  }

  method set_value (Int() $value ) is also<set-value> {
    my guint64 $v = $value;

    gimp_memsize_entry_set_value($!g-mse, $v);
  }

}

### /usr/src/gimp/libgimpwidgets/gimpmemsizeentry.h

sub gimp_memsize_entry_get_spinbutton (GimpMemsizeEntry $entry)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_memsize_entry_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_memsize_entry_get_value (GimpMemsizeEntry $entry)
  returns guint64
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_memsize_entry_new (
  guint64 $value,
  guint64 $lower,
  guint64 $upper
)
  returns GimpMemsizeEntry
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_memsize_entry_set_value (
  GimpMemsizeEntry $entry,
  guint64          $value
)
  is      native(gimpwidgets)
  is      export
{ * }
