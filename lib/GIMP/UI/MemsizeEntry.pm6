use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;

use GTK::Box;
use GTK::SpinButton;

use GLib::Roles::Implementor;

our subset GimpMemsizeEntryAncestry is export of Mu
  where GimpMemsizeEntry | GtkBoxAncestry;

constant SPINBUTTON_VALUE_SHIFT = 10;

class GIMP::UI::MemsizeEntry is GTK::Box {
  has GimpMemsizeEntry $!g-mse is implementor;

  submethod BUILD ( :$gimp-memsize-entry ) {
    self.setGimpMemsizeEntry($gimp-memsize-entry) if $gimp-memsize-entry
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
    Num() :default(:$d)                        = 0.25,
    Num() :upper-default(:upper_default(:$ud)) = 0.5,
    Num() :lower-default(:lower_default(:$ld)) = 0.0,
    Int() :$upper                              = $*KERNEL.total-memory * $ud,
    Int() :$value                              = $upper * $d,
    Int() :$lower                              = $upper * $ld
  ) {
    samewith($value, $lower, $upper);
  }
  multi method new (Int() $value, Int() $lower, Int() $upper) {
    my guint64 ($v, $l, $u) = ($value, $lower, $upper);

    my $gimp-memsize-entry = gimp_memsize_entry_new($v, $l, $u);

    $gimp-memsize-entry ?? self.bless( :$gimp-memsize-entry ) !! Nil;
  }

  method value is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_value    },
      STORE => -> $, \v { self.set_value(v) }
  }

  method value-changed is also<value_changed> {
    self.connect($!g-mse, 'value-changed');
  }

  method get_spinbutton ( :$raw = False )
    is also<
      get-spinbutton
      spinbutton
    >
  {
    returnProperObject(
      gimp_memsize_entry_get_spinbutton($!g-mse),
      $raw,
      |GTK::SpinButton.getTypePair
    );
  }

  method upper {
    self.get_spinbutton.adjustment.upper +< SPINBUTTON_VALUE_SHIFT;
  }

  method lower {
    self.get_spinbutton.adjustment.lower +< SPINBUTTON_VALUE_SHIFT;
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
