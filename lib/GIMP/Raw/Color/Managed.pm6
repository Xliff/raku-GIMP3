use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;

unit package GIMP::Raw::Color::Managed;

### /usr/src/gimp/libgimpcolor/gimpcolormanaged.h

sub gimp_color_managed_get_color_profile (GimpColorManaged $managed)
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_get_icc_profile (
  GimpColorManaged $managed,
  gsize            $len
)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_get_simulation_bpc (GimpColorManaged $managed)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_get_simulation_intent (GimpColorManaged $managed)
  returns GimpColorRenderingIntent
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_get_simulation_profile (GimpColorManaged $managed)
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_profile_changed (GimpColorManaged $managed)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_simulation_bpc_changed (GimpColorManaged $managed)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_simulation_intent_changed (GimpColorManaged $managed)
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_managed_simulation_profile_changed (GimpColorManaged $managed)
  is      native(gimpcolor)
  is      export
{ * }
