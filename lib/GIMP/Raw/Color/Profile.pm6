use v6.c;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Babl::Raw::Definitions;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;

unit package GIMP::Raw::Color::Profile;

### /usr/src/gimp/libgimpcolor/gimpcolorprofile.h

sub gimp_color_profile_get_copyright (GimpColorProfile $profile)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_description (GimpColorProfile $profile)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_format (
  GimpColorProfile         $profile,
  Babl                     $format,
  GimpColorRenderingIntent $intent,
  CArray[Pointer[GError]]  $error
)
  returns Babl
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_icc_profile (
  GimpColorProfile $profile,
  gsize            $length
)
  returns CArray[guint8]
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_label (GimpColorProfile $profile)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_lcms_format (
  Babl    $format,
  guint32 $lcms_format is rw
)
  returns Babl
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_lcms_profile (GimpColorProfile $profile)
  returns Pointer
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_manufacturer (GimpColorProfile $profile)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_model (GimpColorProfile $profile)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_space (
  GimpColorProfile         $profile,
  GimpColorRenderingIntent $intent,
  CArray[Pointer[GError]]  $error
)
  returns Babl
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_summary (GimpColorProfile $profile)
  returns Str
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_get_type
  returns GType
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_is_cmyk (GimpColorProfile $profile)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_is_equal (
  GimpColorProfile $profile1,
  GimpColorProfile $profile2
)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_is_gray (GimpColorProfile $profile)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_is_linear (GimpColorProfile $profile)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_is_rgb (GimpColorProfile $profile)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_d50_gray_lab_trc
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_d65_gray_linear
  returns GimpColorPrGimpColorRenderingIntentofile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_d65_gray_srgb_trc
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_from_file (
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_from_icc_profile (
  guint8                  $data is rw,
  gsize                   $length,
  CArray[Pointer[GError]] $error
)
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_from_lcms_profile (
  gpointer                $lcms_profile,
  CArray[Pointer[GError]] $error
)
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_linear_from_color_profile (
  GimpColorProfile $profile
)
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_rgb_adobe
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_rgb_srgb
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_rgb_srgb_linear
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_new_srgb_trc_from_color_profile (
  GimpColorProfile $profile
)
  returns GimpColorProfile
  is      native(gimpcolor)
  is      export
{ * }

sub gimp_color_profile_save_to_file (
  GimpColorProfile        $profile,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gimpcolor)
  is      export
{ * }
