use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::PathEditor;

use GTK::Box;

use GLib::Roles::Implementor;

our subset GimpPathEditorAncestry is export of Mu
  where GimpPathEditor | GtkBoxAncestry;

class GIMP::UI::PathEditor is GTK::Box {
  has GimpPathEditor $!g-pe is implementor;

  submethod BUILD ( :$gimp-path-editor ) {
    self.setGimpPathEditor($gimp-path-editor) if $gimp-path-editor
  }

  method setGimpPathEditor (GimpPathEditorAncestry $_) {
    my $to-parent;

    $!g-pe = do {
      when GimpPathEditor {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpPathEditor, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GIMP::Raw::Definitions::GimpPathEditor
    is also<GimpPathEditor>
  { $!g-pe }

  multi method new (
     $gimp-path-editor where * ~~ GimpPathEditorAncestry,

    :$ref = True
  ) {
    return unless $gimp-path-editor;

    my $o = self.bless( :$gimp-path-editor );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $title, Str() $path) {
    my $gimp-path-editor = gimp_path_editor_new($title, $path);

    $gimp-path-editor ?? self.bless( :$gimp-path-editor ) !! Nil;
  }

  method dir_writable
    is rw
    is g-property
    is also<
      dir-writeable
      dir_writeable
    >
  {
    Proxy.new:
      FETCH => -> $     { self.get_dir_writable    },
      STORE => -> $, \v { self.set_dir_writable(v) }
  }

  method path is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_path    },
      STORE => -> $, \v { self.set_path(v) }
  }

  method writable_path
    is rw
    is g-property
    is also<
      writeable-path
      writeable_path
    >
  {
    Proxy.new:
      FETCH => -> $     { self.get_writable_path    },
      STORE => -> $, \v { self.set_writable_path(v) }
  }

  method path-changed is also<path_changed> {
    self.connect($!g-pe, 'path-changed');
  }

  method writable-changed
    is also<
      writable_changed
      writeable-changed
      writeable_changed
    >
  {
    self.connect($!g-pe, 'writable-changed');
  }

  method get_dir_writable (Str() $directory)
    is also<
      get-dir-writable
      get_dir_writeable
      get-dir-writeable
    >
  {
    so gimp_path_editor_get_dir_writable($!g-pe, $directory);
  }

  method get_path is also<get-path> {
    gimp_path_editor_get_path($!g-pe);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_path_editor_get_type, $n, $t );
  }

  method get_writable_path
    is also<
      get-writable-path
      get-writeable-path
      get_writeable_path
    >
  {
    gimp_path_editor_get_writable_path($!g-pe);
  }

  method set_dir_writable (
    Str() $directory,
    Int() $writable
  )
    is also<
      set-dir-writable
      set_dir_writeable
      set-dir-writeable
    >
  {
    my guint $w = $writable.so.Int;

    gimp_path_editor_set_dir_writable($!g-pe, $directory, $w);
  }

  method set_path (Str() $path) is also<set-path> {
    gimp_path_editor_set_path($!g-pe, $path);
  }

  method set_writable_path (Str() $path)
    is also<
      set-writable-path
      set_writeable_path
      set-writeable-path
    >
  {
    gimp_path_editor_set_writable_path($!g-pe, $path);
  }

}
