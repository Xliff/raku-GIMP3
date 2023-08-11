use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Config;

use GLib::Roles::Implementor;

role GIMP::Roles::Config {
  has GimpConfig $!g-c is implementor;

  method roleInit-GimpConfig is also<roleInit_GimpConfig> {
    return unless $!g-c;

    my \i = findProperImplementor(self.^attributes);

    $!g-c = cast( GimpConfig, i.get_value(self) );
  }

  submethod TWEAK {
    $!g-c = cast(GimpConfig, self.GObject);
    nextsame;
  }

  method GIMP::Raw::Definitions::GimpConfig
  { $!g-c }
  method GimpConfig
  { $!g-c }

  method copy (
    GimpConfig()  $dest,
    Int()         $flags
  ) {
    my GParamFlags $f = $flags;

    gimp_config_copy($!g-c, $dest, $f);
  }

  method deserialize (
    GScanner() $scanner,
    Int        $nest_level,
    gpointer   $data
  ) {
    my gint $n = $nest_level;

    gimp_config_deserialize($!g-c, $scanner, $n, $data);
  }

  method deserialize_file (
    GFile()                 $file,
    gpointer                $data  = gpointer,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<deserialize-file>
  {
    clear_error;
    my $rv = so gimp_config_deserialize_file($!g-c, $file, $data, $error);
    set_error($error);
    $rv;
  }

  method deserialize_parasite (
    GimpParasite()          $parasite,
    gpointer                $data  = gpointer,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<deserialize-parasite>
  {
    clear_error;
    my $rv = gimp_config_deserialize_parasite($!g-c, $parasite, $data, $error);
    set_error($error);
    $rv;
  }

  method deserialize_return (
    GScanner() $scanner,
    Int()      $expected_token,
    Int()      $nest_level
  )
    is static
    is also<deserialize-return>
  {
    my GTokenType $e = $expected_token;
    my gint       $n = $nest_level;

    gimp_config_deserialize_return($scanner, $e, $n);
  }

  method deserialize_stream (
    GInputStream()          $input,
    gpointer                $data  = gpointer,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<deserialize-stream>
  {
    clear_error;
    my $rv = gimp_config_deserialize_stream($!g-c, $input, $data, $error);
    set_error($error);
  }

  method deserialize_string (
    Str()                   $text,
    Int()                   $text_len,
    gpointer                $data  = gpointer,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<deserialize-string>
  {
    my gint $t = $text_len;

    clear_error;
    my $rv = gimp_config_deserialize_string($!g-c, $text, $t, $data, $error);
    set_error($error);
    $rv;
  }

  method duplicate ( :$raw = False ) {
    propReturnObject(
      gimp_config_duplicate($!g-c),
      $raw,
      |self.getTypePair
    )
  }

  method is_equal_to (GimpConfig() $b) is also<is-equal-to> {
    so gimp_config_is_equal_to($!g-c, $b);
  }

  method reset {
    gimp_config_reset($!g-c);
  }

  method serialize (GimpConfigWriter() $writer, gpointer $data = gpointer) {
    gimp_config_serialize($!g-c, $writer, $data);
  }

  method serialize_to_fd (
    Int()      $fd,
    gpointer   $data = gpointer;
  )
    is also<serialize-to-fd>
  {
    my gint $f = $fd;

    gimp_config_serialize_to_fd($!g-c, $f, $data);
  }

  method serialize_to_file (
    GFile()                 $file,
    Str()                   $header,
    Str()                   $footer,
    gpointer                $data  = gpointer,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<serialize-to-file>
  {
    gimp_config_serialize_to_file(
      $!g-c,
      $file,
      $header,
      $footer,
      $data,
      $error
    );
  }

  method serialize_to_parasite (
    Str()      $parasite_name,
    Int()      $parasite_flags,
    gpointer   $data            = gpointer
  )
    is also<serialize-to-parasite>
  {
    my guint $p = $parasite_flags;

    gimp_config_serialize_to_parasite($!g-c, $parasite_name, $p, $data);
  }

  method serialize_to_stream (
    GOutputStream()         $output,
    Str()                   $header,
    Str()                   $footer,
    gpointer                $data  = gpointer,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<serialize-to-stream>
  {
    clear_error;
    gimp_config_serialize_to_stream(
      $!g-c,
      $output,
      $header,
      $footer,
      $data,
      $error
    );
    set_error($error);
  }

  method serialize_to_string (gpointer $data = gpointer)
    is also<serialize-to-string>
  {
    gimp_config_serialize_to_string($!g-c, $data);
  }

}


our subset GimpConfigAncestry is export of Mu
  where GimpConfig | GObject;

class GIMP::Config {
  also does GLib::Roles::Object;
  also does GIMP::Roles::Config;

  submethod BUILD ( :$gimp-config ) {
    self.setGimpConfig($gimp-config) if $gimp-config
  }

  method setGimpConfig (GimpConfigAncestry $_) {
    my $to-parent;

    $!g-c = do {
      when GimpConfig {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpConfig, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpConfig
    is also<GimpConfig>
  { $!g-c }

  multi method new ($gimp-config where * ~~ GimpConfigAncestry, :$ref = True) {
    return unless $gimp-config;

    my $o = self.bless( :$gimp-config );
    $o.ref if $ref;
    $o;
  }

}
