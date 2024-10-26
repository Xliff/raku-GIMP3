use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Module;

### /usr/src/gimp/libgimpmodule/gimpmodule.h

sub gimp_module_error_quark
  returns GQuark
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_get_auto_load (GimpModule $module)
  returns uint32
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_get_file (GimpModule $module)
  returns GFile
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_get_info (GimpModule $module)
  returns GimpModuleInfo
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_get_last_error (GimpModule $module)
  returns Str
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_get_state (GimpModule $module)
  returns GimpModuleState
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_get_type
  returns GType
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_is_loaded (GimpModule $module)
  returns uint32
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_is_on_disk (GimpModule $module)
  returns uint32
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_new (
  GFile    $file,
  gboolean $auto_load,
  gboolean $verbose
)
  returns GimpModule
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_query (GTypeModule $module)
  returns GimpModuleInfo
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_query_module (GimpModule $module)
  returns uint32
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_register (GTypeModule $module)
  returns uint32
  is      native(gimpmodule)
  is      export
{ * }

sub gimp_module_set_auto_load (
  GimpModule $module,
  gboolean   $auto_load
)
  is      native(gimpmodule)
  is      export
{ * }
