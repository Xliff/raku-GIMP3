use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;

unit package GIMP::Raw::Env;

### /usr/src/gimp/libgimpbase/gimpenv.h

sub gimp_cache_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_data_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

# sub gimp_data_directory_file (Str $first_element)
#   returns GFile
#   is      native(gimpbase)
#   is      export
# { * }

sub gimp_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

# sub gimp_directory_file (Str $first_element)
#   returns GFile
#   is      native(gimpbase)
#   is      export
# { * }

sub gimp_installation_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

# sub gimp_installation_directory_file (Str $first_element)
#   returns GFile
#   is      native(gimpbase)
#   is      export
# { * }

sub gimp_locale_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

# sub gimp_locale_directory_file (Str $first_element)
#   returns GFile
#   is      native(gimpbase)
#   is      export
# { * }

sub gimp_path_free (GList $path)
  is      native(gimpbase)
  is      export
{ * }

sub gimp_path_get_user_writable_dir (GList $path)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_path_parse (
  Str                    $path,
  gint                   $max_paths,
  gboolean               $check,
  CArray[Pointer[GList]] $check_failed
)
  returns GList
  is      native(gimpbase)
  is      export
{ * }

sub gimp_path_to_str (GList $path)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_plug_in_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

# sub gimp_plug_in_directory_file (Str $first_element)
#   returns GFile
#   is      native(gimpbase)
#   is      export
# { * }

sub gimp_sysconf_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

# sub gimp_sysconf_directory_file (Str $first_element)
#   returns GFile
#   is      native(gimpbase)
#   is      export
# { * }

sub gimp_temp_directory
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_env_init (gboolean $plug_in)
  is      native(gimpbase)
  is      export
{ * }
