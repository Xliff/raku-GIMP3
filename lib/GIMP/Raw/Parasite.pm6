use v6.c;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;

### /usr/src/gimp/libgimpbase/gimpparasite.h

sub gimp_parasite_compare (
  GimpParasite $a,
  GimpParasite $b
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_copy (GimpParasite $parasite)
  returns GimpParasite
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_free (GimpParasite $parasite)
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_get_data (
  GimpParasite $parasite,
  guint32      $num_bytes is rw
)
  returns gpointer
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_get_flags (GimpParasite $parasite)
  returns gulong
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_get_name (GimpParasite $parasite)
  returns Str
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_get_type
  returns GType
  is      native(gimpbase)
  is      export
{ * }

sub gimp_param_parasite_get_type
  returns GType
  is      native(gimpbase)
  is      export
{ * }

sub gimp_param_spec_parasite (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  GParamFlags $flags
)
  returns GParamSpec
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_has_flag (
  GimpParasite $parasite,
  gulong       $flag
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_is_persistent (GimpParasite $parasite)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_is_type (
  GimpParasite $parasite,
  Str          $name
)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_is_undoable (GimpParasite $parasite)
  returns uint32
  is      native(gimpbase)
  is      export
{ * }

sub gimp_parasite_new (
  Str      $name,
  guint32  $flags,
  guint32  $size,
  gpointer $data
)
  returns GimpParasite
  is      native(gimpbase)
  is      export
{ * }
