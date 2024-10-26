use v6.c;

use Method::Also;

use GIMP::Raw::Types;

use GTK::Entry:ver<3>;

our subset GimpColorHexEntryAncestry is export of Mu
  where GimpColorHexEntry | GtkEntryAncestry;

class GIMP::UI::Color::HexEntry is GTK::Entry {
  has GimpColorHexEntry $!gche is implementor;

  submethod BUILD ( :$gimp-color-he ) {
    self.setGimpColorHexEntry($gimp-color-he) if $gimp-color-he
  }

  method setGimpColorHexEntry (GimpColorHexEntryAncestry $_) {
    my $to-parent;

    $!gche = do {
      when GimpColorHexEntry {
        $to-parent = cast(GtkEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorHexEntry, $_);
      }
    }
    self.setGtkEntry($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorHexEntry
    is also<GimpColorHexEntry>
  { $!gche }

  multi method new (
     $gimp-color-he where * ~~ GimpColorHexEntryAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-he;

    my $o = self.bless( :$gimp-color-he );
    $o.ref if $ref;
    $o;
  }

  multi method new ( *%a ) {
    my $gimp-color-he = gimp_color_hex_entry_new();

    my $o = $gimp-color-he ?? self.bless( :$gimp-color-he ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Is originally:
  # GimpColorHexEntry *entry --> void
  method Color-Changed is also<Color_Changed> {
    self.connect($!gche, 'color-changed');
  }

  method get_color (GimpRGB() $color) is also<get-color> {
    gimp_color_hex_entry_get_color($!gche, $color);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_hex_entry_get_type, $n, $t );
  }

  method set_color (GimpRGB() $color) is also<set-color> {
    gimp_color_hex_entry_set_color($!gche, $color);
  }

}

### /usr/src/gimp/libgimpwidgets/gimpcolorhexentry.h

sub gimp_color_hex_entry_get_color (
  GimpColorHexEntry $entry,
  GimpRGB           $color
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_hex_entry_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_hex_entry_new
  returns GimpColorHexEntry
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_hex_entry_set_color (
  GimpColorHexEntry $entry,
  GimpRGB           $color
)
  is      native(gimpwidgets)
  is      export
{ * }
