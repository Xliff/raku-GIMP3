use v6.c;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::Thumb::Utils;

use GLib::Roles::StaticClass;

class GIMP::Thumb::Utils {
  also does GLib::Roles::StaticClass;

  # method _filename_from_uri (Str $uri) {
  #   _gimp_thumb_filename_from_uri($uri);
  # }
  #
  # method _gimp_thumbs_delete_others (
  #   Str           $uri,
  #   GimpThumbSize $size
  # ) {
  #   _gimp_thumbs_delete_others($uri, $size);
  # }

  method ensure_thumb_dir (
    GimpThumbSize           $size,
    CArray[Pointer[GError]] $error
  ) {
    gimp_thumb_ensure_thumb_dir($size, $error);
  }

  method ensure_thumb_dir_local (
    Str                     $dirname,
    GimpThumbSize           $size,
    CArray[Pointer[GError]] $error
  ) {
    gimp_thumb_ensure_thumb_dir_local($dirname, $size, $error);
  }

  proto method file_test (|)
  { * }

  multi method file_test (Str() $filename) {
    samewith($filename, $, $, $, :all);
  }
  multi method file_test (
    Str()  $filename,
           $mtime     is rw,
           $size      is rw,
           $err_no    is rw,
          :$all              = False,
          :$enum             = True
  ) {
    my gint64 ($m, $s) = 0 xx 2;
    my gint    $e      = 0;

    my $st = gimp_thumb_file_test($filename, $m, $s, $e);
    $st = GimpThumbFileTypeEnum($st) if $enum;
    ($mtime, $size, $err_no) = ($m, $s, $e);

    $all.not ?? $s !! ($st, $m, $s, $e);
  }

  method find_thumb (
    Str           $uri,
    GimpThumbSize $size
  ) {
    gimp_thumb_find_thumb($uri, $size);
  }

  method get_thumb_base_dir {
    gimp_thumb_get_thumb_base_dir();
  }

  method get_thumb_dir (GimpThumbSize $size) {
    gimp_thumb_get_thumb_dir($size);
  }

  method get_thumb_dir_local (
    Str           $dirname,
    GimpThumbSize $size
  ) {
    gimp_thumb_get_thumb_dir_local($dirname, $size);
  }

  method gimp_thumbs_delete_for_uri (Str $uri) {
    gimp_thumbs_delete_for_uri($uri);
  }

  method gimp_thumbs_delete_for_uri_local (Str $uri) {
    gimp_thumbs_delete_for_uri_local($uri);
  }

  method init (Str() $creator, Str() $thumb_basedir) {
    gimp_thumb_init($creator, $thumb_basedir);
  }

  method name_from_uri (
    Str           $uri,
    GimpThumbSize $size
  ) {
    gimp_thumb_name_from_uri($uri, $size);
  }

  method name_from_uri_local (
    Str           $uri,
    GimpThumbSize $size
  ) {
    gimp_thumb_name_from_uri_local($uri, $size);
  }

}
