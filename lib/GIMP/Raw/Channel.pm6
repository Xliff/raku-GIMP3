use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::Channel;

### /usr/src/gimp/libgimp/gimpchannel.h

sub gimp_channel_get_by_id (gint32 $channel_id)
  returns GimpChannel
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_new (
  GimpImage $image,
  Str       $name,
  guint     $width,
  guint     $height,
  gdouble   $opacity,
  GimpRGB   $color
)
  returns GimpChannel
  is      native(gimp)
  is      export
{ * }

### /usr/src/gimp/libgimp/gimpchannel_pdb.h

sub _gimp_channel_new (
  GimpImage $image,
  gint      $width,
  gint      $height,
  Str       $name,
  gdouble   $opacity,
  GimpRGB   $color
)
  returns GimpChannel
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_combine_masks (
  GimpChannel    $channel1,
  GimpChannel    $channel2,
  GimpChannelOps $operation,
  gint           $offx,
  gint           $offy
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_copy (GimpChannel $channel)
  returns GimpChannel
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_get_color (
  GimpChannel $channel,
  GimpRGB     $color
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_get_opacity (GimpChannel $channel)
  returns gdouble
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_get_show_masked (GimpChannel $channel)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_new_from_component (
  GimpImage       $image,
  GimpChannelType $component,
  Str             $name
)
  returns GimpChannel
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_set_color (
  GimpChannel $channel,
  GimpRGB     $color
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_set_opacity (
  GimpChannel $channel,
  gdouble     $opacity
)
  returns uint32
  is      native(gimp)
  is      export
{ * }

sub gimp_channel_set_show_masked (
  GimpChannel $channel,
  gboolean    $show_masked
)
  returns uint32
  is      native(gimp)
  is      export
{ * }
