use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::FileEntry;

use GTK::Box;
use GTK::Widget;

use GLib::Roles::Implementor;

our subset GimpFileEntryAncestry is export of Mu
  where GimpFileEntry | GtkBoxAncestry;

class GIMP::UI::FileEntry is GTK::Box {
  has GimpFileEntry $!g-fe is implementor;

  submethod BUILD ( :$gimp-file-entry ) {
    self.setGimpFileEntry($gimp-file-entry) if $gimp-file-entry
  }

  method setGimpFileEntry (GimpFileEntryAncestry $_) {
    my $to-parent;

    $!g-fe = do {
      when GimpFileEntry {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpFileEntry, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GIMP::Raw::Definitions::GimpFileEntry
    is also<GimpFileEntry>
  { $!g-fe }

  multi method new (
     $gimp-file-entry where * ~~ GimpFileEntryAncestry,

    :$ref = True
  ) {
    return unless $gimp-file-entry;

    my $o = self.bless( :$gimp-file-entry );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $title,
    Str() $filename,
    Int() $dir_only,
    Int() $check_valid
  ) {
    my gboolean ($d, $c) = ($dir_only, $check_valid).map( *.so.Int );

    my $gimp-file-entry = gimp_file_entry_new($!g-fe, $filename, $d, $c);

    $gimp-file-entry ?? self.bless( :$gimp-file-entry ) !! Nil;
  }

  method filename is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_filename    },
      STORE => -> $, \v { self.set_filename(v) }
  }

  method filename-changed is also<filename_changed> {
    self.connect($!g-fe, 'filename-changed');
  }

  method get_entry ( :$raw = False ) is also<get-entry> {
    ReturnWidget(
      gimp_file_entry_get_entry($!g-fe),
      $raw
    );
  }

  method get_filename is also<get-filename> {
    gimp_file_entry_get_filename($!g-fe);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_file_entry_get_type, $n, $t );
  }

  method set_filename (Str() $filename) is also<set-filename> {
    gimp_file_entry_set_filename($!g-fe, $filename);
  }

}
