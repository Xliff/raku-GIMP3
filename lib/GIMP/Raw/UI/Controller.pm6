use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::Controller;

### /usr/src/gimp/libgimpwidgets/gimpcontroller.h

sub gimp_controller_event (
  GimpController      $controller,
  GimpControllerEvent $event
)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_controller_get_event_blurb (
  GimpController $controller,
  gint           $event_id
)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_controller_get_event_name (
  GimpController $controller,
  gint           $event_id
)
  returns Str
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_controller_get_n_events (GimpController $controller)
  returns gint
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_controller_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_controller_new (GType $controller_type)
  returns GimpController
  is      native(gimpwidgets)
  is      export
{ * }
