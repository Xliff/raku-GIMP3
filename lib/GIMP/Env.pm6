use v6.c;

use NativeCall;
use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::Env;

use GLib::GList;

use GLib::Roles::StaticClass;

my %dirs;

class GIMP::Env does Associative {
  also does GLib::Roles::StaticClass;

  method AT-KEY (\k) is also<AT_KEY> {
    %dirs{ k };
  }

  multi method init (Int() $plug_in) {
    my gboolean $p = $plug_in.so.Int;

    gimp_env_init($p);
  }
  multi method init ( :$dirs is required ) {
    %dirs = (
      cache_directory        => self.cache_directory,
      data_directory         => self.data_directory,
      user_directory         => self.main_directory,
      installation_directory => self.installation_directory,
      locale_directory       => self.locale_directory,
      plug_in_directory      => self.plug_in_directory,
      sysconf_directory      => self.sysconf_directory,
      temp_directory         => self.temp_directory,

      cache-directory        => self.cache_directory,
      data-directory         => self.data_directory,
      user-directory         => self.main_directory,
      installation-directory => self.installation_directory,
      locale-directory       => self.locale_directory,
      plug_in-directory      => self.plug_in_directory,
      sysconf-directory      => self.sysconf_directory,
      temp-directory         => self.temp_directory,

      cache                  => self.cache_directory,
      data                   => self.data_directory,
      user                   => self.main_directory,
      installation           => self.installation_directory,
      locale                 => self.locale_directory,
      plug_in                => self.plug_in_directory,
      sysconf                => self.sysconf_directory,
      'temp'                 => self.temp_directory
    );
  }

  method keys      { %dirs.keys      }
  method pairs     { %dirs.pairs     }
  method antipairs { %dirs.antipairs }
  method kv        { %dirs.kv        }

  method dirs is also<directories> { %dirs.Map }

  method cache_directory is also<cache-directory> {
    gimp_cache_directory();
  }

  method data_directory is also<data-directory> {
    gimp_data_directory();
  }

  method main_directory is also<main-directory> {
    gimp_directory();
  }

  method installation_directory is also<installation-directory> {
    gimp_installation_directory();
  }

  method locale_directory is also<locale-directory> {
    gimp_locale_directory();
  }

  method path_free (GList() $path) is also<path-free> {
    gimp_path_free($path);
  }

  proto method path_get_user_writable_dir (|)
    is also<
      path-get-user-writable-dir
      get_user_writable_dir
      get-user-writable-dir
      get_user_writeable_dir
      get-user-writeable-dir
    >
  { * }

  multi method path_get_user_writable_dir (@files) {
    samewith( GLib::GList.new(@files, typed => Str) );
  }
  multi method path_get_user_writable_dir (GList() $path) {
    gimp_path_get_user_writable_dir($path);
  }

  proto method path_parse (|)
    is also<path-parse>
  { * }

  multi method path_parse (
    Str()  $path,
    Int() :max(:max-paths($max_paths)) = 512,
    Int() :$check                      = False,
          :$raw                        = False,
          :gslist(:$glist)             = False
  ) {
    samewith( $path, $max_paths, $check, newCArray(GList) )
  }
  multi method path_parse (
    Str()                  $path,
    Int()                  $max_paths,
    Int()                  $check,
    CArray[Pointer[GList]] $check_failed    = newCArray(GList),
                           :$raw            = False,
                           :gslist(:$glist) = False
  ) {
    my gint $m = $max_paths;

    my $fl = returnGList(
      gimp_path_parse($path, $max_paths, $check, $check_failed),
      $raw,
      $glist,
      Str
    );

    my $cl = returnGList($check_failed, $raw, $glist, Str);

    ($fl, $cl);
  }

  proto method path_to_str (|)
    is also<path-to-str>
  { * }

  multi method path_to_str (@path) {
    samewith( GLib::GList.new(@path, typed => Str) );
  }
  multi method path_to_str (GList() $path) {
    gimp_path_to_str($path);
  }

  method plug_in_directory is also<plug-in-directory> {
    gimp_plug_in_directory();
  }

  method sysconf_directory is also<sysconf-directory> {
    gimp_sysconf_directory();
  }

  method temp_directory is also<temp-directory> {
    gimp_temp_directory();
  }

}

INIT GIMP::Env.init( :dirs );
