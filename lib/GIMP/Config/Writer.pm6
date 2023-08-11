use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::Config::Writer;

use GLib::Roles::Implementor;

# BOXED

class GIMP::Config::Writer {
  has GimpConfigWriter $!g-cw is implementor;

  submethod BUILD ( :$gimp-config-writer ) {
    $!g-cw = $gimp-config-writer if $gimp-config-writer;
  }

  method GIMP::Raw::Definitions::GimpConfigWriter
    is also<GimpConfigWriter>
  { $!g-cw }

  method new_from_fd (gint $fd) is also<new-from-fd> {
    my gint $f = $fd;

    my $gimp-config-writer = gimp_config_writer_new_from_fd($!g-cw, $f);

    $gimp-config-writer ?? self.bless( :$gimp-config-writer ) !! Nil;
  }

  method new_from_file (
    GFile()                 $file,
    Int()                   $atomic,
    Str                     $header,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<new-from-file>
  {
    my gboolean $a = $atomic.so.Int;

    clear_error;
    my $gimp-config-writer = gimp_config_writer_new_from_file(
      $file,
      $a,
      $header,
      $error
    );
    set_error($error);

    $gimp-config-writer ?? self.bless( :$gimp-config-writer ) !! Nil;
  }

  method new_from_stream (
    GOutputStream()         $output,
    Str()                   $header,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<new-from-stream>
  {
    clear_error;
    my $gimp-config-writer = gimp_config_writer_new_from_stream(
      $output,
      $header,
      $error
    );
    set_error($error);

    $gimp-config-writer ?? self.bless( :$gimp-config-writer ) !! Nil;
  }

  method new_from_string (Str() $string) is also<new-from-string> {
    my $gimp-config-writer = gimp_config_writer_new_from_string($string);

    $gimp-config-writer ?? self.bless( :$gimp-config-writer ) !! Nil;
  }

  method close {
    gimp_config_writer_close($!g-cw);
  }

  method comment (Str() $comment) {
    gimp_config_writer_comment($!g-cw, $comment);
  }

  method comment_mode (Int() $enable) is also<comment-mode> {
    my gboolean $e = $enable.so.Int;

    gimp_config_writer_comment_mode($!g-cw, $e);
  }

  method data (Int() $length, $data) {
    my gint $l = $length;

    gimp_config_writer_data( $!g-cw, $l, resolveBuffer($data) );
  }

  method finish (Str() $footer, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = gimp_config_writer_finish($!g-cw, $footer, $error);
    set_error($error);
    $rv;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_config_writer_get_type, $n, $t );
  }

  method identifier (Str() $identifier) {
    gimp_config_writer_identifier($!g-cw, $identifier);
  }

  method linefeed {
    gimp_config_writer_linefeed($!g-cw);
  }

  method open (Str() $name) {
    gimp_config_writer_open($!g-cw, $name);
  }

  method print (Str() $string, Int() $len = -1) {
    my gint $l = $len;

    gimp_config_writer_print($!g-cw, $string, $l);
  }

  method ref {
    gimp_config_writer_ref($!g-cw);
    self;
  }

  method revert {
    gimp_config_writer_revert($!g-cw);
  }

  method string (Str() $string) {
    gimp_config_writer_string($!g-cw, $string);
  }

  method unref {
    gimp_config_writer_unref($!g-cw);
  }

}
