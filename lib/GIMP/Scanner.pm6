use v6.c;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::Scanner;

use GIMP::RGB;
use GIMP::Matrix;

use GLib::Roles::Implementor;

# BOXED

class GIMP::Scanner {
  has GimpScanner $!g-s is implementor;

  submethod BUILD ( :$gimp-scanner ) {
    $!g-s = $gimp-scanner if $gimp-scanner;
  }

  method GIMP::Raw::Definitions::GimpScanner
  { $!g-s }

  method new_file (GFile() $file, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $gimp-scanner = gimp_scanner_new_file($file, $error);
    set_error($error);

    $gimp-scanner ?? self.bless( :$gimp-scanner ) !! Nil;
  }

  method new_stream (
    GInputStream()          $input,
    CArray[Pointer[GError]] $error  = gerror;
  ) {
    clear_error;
    my $gimp-scanner = gimp_scanner_new_stream($input, $error);
    set_error($error);

    $gimp-scanner ?? self.bless( :$gimp-scanner ) !! Nil;
  }

  method new_string (
    Str()                   $text,
    Int()                   $text_len,
    CArray[Pointer[GError]] $error
  ) {
    my gint $t = $text_len;

    clear_error;
    my $gimp-scanner = gimp_scanner_new_string($text, $t, $error);
    set_error($error);

    $gimp-scanner ?? self.bless( :$gimp-scanner ) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_scanner_get_type, $n, $t );
  }

  proto method parse_boolean (|)
  { * }

  multi method parse_boolean {
    samewith($);
  }
  multi method parse_boolean ($dest is rw) {
    my gboolean $d = 0;

    my $rv = gimp_scanner_parse_boolean($!g-s, $d);
    return Nil unless $rv;
    $dest = $d;
  }

  proto method parse_color (|)
  { * }

  multi method parse_color ( :$raw = False ) {
    samewith(GimpRGB.new, $raw);
  }
  multi method parse_color (GimpRGB() $dest, :$raw = False) {
    my $rv = gimp_scanner_parse_color($!g-s, $dest);
    return Nil unless $rv;
    propReturnObject($dest, $raw, |GIMP::RGB.getTypePair);
  }

  method parse_data (
    Int()           $length,
    CArray[guint8]  $dest,
                   :$carray = False,
                   :$buf    = $carray.not;
  ) {
    my gint $l = $length;

    my $rv = gimp_scanner_parse_data($!g-s, $l, $dest);
    return Nil   unless $rv;
    return $dest if     $carray;
    Buf.new( $dest[ ^$l ] );
  }

  proto method parse_float (|)
  { * }

  multi method parse_float {
    samewith($);
  }
  multi method parse_float ($dest is rw) {
    my gdouble $d = 0e0;
    my $rv = gimp_scanner_parse_float($!g-s, $d);
    return Nil unless $rv;
    $dest = $d;
  }

  method parse_identifier (Str() $identifier) {
    so gimp_scanner_parse_identifier($!g-s, $identifier);
  }

  proto method parse_int (|)
  { * }

  multi method parse_int {
    samewith($);
  }
  multi method parse_int ($dest is rw) {
    my gint $d = 0;
    my $rv = gimp_scanner_parse_int($!g-s, $dest);
    return Nil unless $rv;
    $dest = $d;
  }

  proto method parse_int64 (|)
  { * }

  multi method parse_int64 {
    samewith($);
  }
  multi method parse_int64 ($dest is rw) {
    my gint64 $d = 0;
    my $rv = gimp_scanner_parse_int64($!g-s, $d);
    return Nil unless $rv;
    $dest = $d;
  }

  proto method parse_matrix2 (|)
  { * }

  multi method parse_matrix2 ( :$raw = False ) {
    samewith(GimpMatrix2.new, :$raw);
  }
  multi method parse_matrix2 (GimpMatrix2() $dest, :$raw = False) {
    my $rv = gimp_scanner_parse_matrix2($!g-s, $dest);
    return Nil unless $rv;
    propReturnObject($dest, $raw, |GIMP::Matrix2.getTypePair)
  }

  proto method parse_string (|)
  { * }

  multi method parse_string {
    samewith( newCArray(Str) );
  }
  multi method parse_string (CArray[Str] $dest) {
    my $rv = gimp_scanner_parse_string($!g-s, $dest);
    return Nil unless $rv;
    ppr($dest);
  }

  proto method parse_string_no_validate (|)
  { * }

  multi method parse_string_no_validate {
    samewith( newCArray(Str) );
  }
  multi method parse_string_no_validate (CArray[Str] $dest) {
    my $rv = gimp_scanner_parse_string_no_validate($!g-s, $dest);
    return Nil unless $rv;
    ppr($dest);
  }

  method parse_token (Int() $token) {
    my GTokenType $t = $token;

    so gimp_scanner_parse_token($!g-s, $t);
  }

  method ref {
    gimp_scanner_ref($!g-s);
    self;
  }

  method unref {
    gimp_scanner_unref($!g-s);
  }

}
