use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Display;

### /usr/src/gimp/libgimp/gimpdisplay.h

sub gimp_display_get_by_id (gint32 $display_id)
  returns GimpDisplay
  is      native(gimp)
  is      export
{ * }

sub gimp_display_get_id (GimpDisplay $display)
  returns gint32
  is      native(gimp)
  is      export
{ * }

sub gimp_display_get_type
  returns GType
  is      native(gimp)
  is      export
{ * }

sub gimp_display_is_valid (GimpDisplay $display)
  returns uint32
  is      native(gimp)
  is      export
{ * }


### /usr/src/gimp/libgimp/gimpdisplay_pdb.h

sub gimp_display_delete (GimpDisplay $display)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_display_get_window_handle (GimpDisplay $display)
  returns gint
  is      native(gimp)
  is      export
{ * }

sub gimp_displays_flush
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_displays_reconnect (
  GimpImage $old_image,
  GimpImage $new_image
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_display_id_is_valid (gint $display_id)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_display_new (GimpImage $image)
  returns GimpDisplay
  is      native(gimp)
  is      export
{ * }

sub gimp_display_present (GimpDisplay $display)
  returns uint32
  is      native(gimp)
  is      export
{ * }
