use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Color::Profile;

use BABL;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GimpColorProfileAncestry is export of Mu
  where GimpColorProfile | GObject;

class GIMP::Color::Profile {
  also does GLib::Roles::Object;

  has GimpColorProfile $!g-cp is implementor;

  submethod BUILD ( :$gimp-color-profile ) {
    self.setGimpColorProfile($gimp-color-profile)
      if $gimp-color-profile
  }

  method setGimpColorProfile (GimpColorProfileAncestry $_) {
    my $to-parent;

    $!g-cp = do {
      when GimpColorProfile {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorProfile, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Structs::GimpColorProfile
  { $!g-cp }

  multi method new (
    $gimp-color-profile where * ~~ GimpColorProfileAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-profile;

    my $o = self.bless( :$gimp-color-profile );
    $o.ref if $ref;
    $o;
  }

  method new_d50_gray_lab_trc is also<new-d50-gray-lab-trc> {
    my $gimp-color-profile = gimp_color_profile_new_d50_gray_lab_trc();

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_d65_gray_linear is also<new-d65-gray-linear> {
    my $gimp-color-profile = gimp_color_profile_new_d65_gray_linear();

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_d65_gray_srgb_trc is also<new-d65-gray-srgb-trc> {
    my $gimp-color-profile = gimp_color_profile_new_d65_gray_srgb_trc();

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_from_file (
    GFile()                 $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-file>
  {
    clear_error;
    my $gimp-color-profile = gimp_color_profile_new_from_file(
      $!g-cp,
      $file,
      $error
    );
    set_error($error);

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_from_icc_profile (
                            $data,
    Int()                   $length,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<new-from-icc-profile>
  {
    my gsize $l = $length;

    clear_error;
    my $gimp-color-profile = gimp_color_profile_new_from_icc_profile(
      $data,
      $l,
      $error
    );
    set_error($error);

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_from_lcms_profile (
    gpointer                $lcms_profile,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<new-from-lcms-profile>
  {
    clear_error;
    my $gimp-color-profile = gimp_color_profile_new_from_lcms_profile(
      $lcms_profile,
      $error
    );
    set_error($error);

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_linear_from_color_profile (GimpColorProfile() $profile)
    is also<new-linear-from-color-profile>
  {
    my $gimp-color-profile = gimp_color_profile_new_linear_from_color_profile(
      $profile
    );

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_rgb_adobe is also<new-rgb-adobe> {
    my $gimp-color-profile = gimp_color_profile_new_rgb_adobe();

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_rgb_srgb is also<new-rgb-srgb> {
    my $gimp-color-profile = gimp_color_profile_new_rgb_srgb();

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_rgb_srgb_linear is also<new-rgb-srgb-linear> {
    my $gimp-color-profile = gimp_color_profile_new_rgb_srgb_linear();

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method new_srgb_trc_from_color_profile (GimpColorProfile() $profile)
    is also<new-srgb-trc-from-color-profile>
  {
    my &c := &gimp_color_profile_new_srgb_trc_from_color_profile;

    my $gimp-color-profile = c($profile);

    $gimp-color-profile ?? self.bless( :$gimp-color-profile ) !! Nil;
  }

  method get_copyright is also<get-copyright> {
    gimp_color_profile_get_copyright($!g-cp);
  }

  method get_description is also<get-description> {
    gimp_color_profile_get_description($!g-cp);
  }

  method get_format (
    Babl()                   $format,
    Int()                    $intent,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<get-format>
  {
    my GimpColorRenderingIntent $i = $intent;

    clear_error;
    my $b = propReturnObject(
      gimp_color_profile_get_format($!g-cp, $format, $i, $error),
      $raw,
      |Babl.getTypePair
    );
    set_error($error);
    $b;
  }

  proto method get_icc_profile (|)
    is also<get-icc-profile>
  { * }

  multi method get_icc_profile ( :$buf = False ) {
    samewith($, :$buf);
  }
  multi method get_icc_profile ($length is rw, :$buf = False) {
    my gsize $l = 0;

    my $s = gimp_color_profile_get_icc_profile($!g-cp, $length);
    $length = $l;
    return $s unless $buf;
    Buf.new($s);
  }

  method get_label is also<get-label> {
    gimp_color_profile_get_label($!g-cp);
  }

  proto method get_lcms_format (|)
    is also<get-lcms-format>
  { * }

  multi method get_lcms_format (Babl() $format, :$raw = False) {
    samewith($format, $);
  }
  multi method get_lcms_format (
    Babl()  $format,
            $lcms_format is rw,
           :$raw                = False
  )
    is static
  {
    my guint32 $l = 0;

    my $f = propReturnObject(
      gimp_color_profile_get_lcms_format($format, $l),
      $raw,
      |Babl.getTypePair
    );
    $lcms_format = $l;
    $f;
  }

  method get_lcms_profile is also<get-lcms-profile> {
    gimp_color_profile_get_lcms_profile($!g-cp);
  }

  method get_manufacturer is also<get-manufacturer> {
    gimp_color_profile_get_manufacturer($!g-cp);
  }

  method get_model is also<get-model> {
    gimp_color_profile_get_model($!g-cp);
  }

  method get_space (
    Int()                    $intent,
    CArray[Pointer[GError]]  $error  = gerror,
                            :$raw    = False
  )
    is also<get-space>
  {
    my GimpColorRenderingIntent $i = $intent;

    clear_error;
    my $s = propReturnObject(
      gimp_color_profile_get_space($!g-cp, $intent, $error),
      $raw,
      |Babl.getTypePair
    );
    set_error($error);
    $s;
  }

  method get_summary is also<get-summary> {
    gimp_color_profile_get_summary($!g-cp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_profile_get_type, $n, $t );
  }

  method is_cmyk is also<is-cmyk> {
    so gimp_color_profile_is_cmyk($!g-cp);
  }

  method is_equal ( GimpColorProfile() $profile2 ) is also<is-equal> {
    so gimp_color_profile_is_equal($!g-cp, $profile2);
  }

  method is_gray is also<is-gray> {
    so gimp_color_profile_is_gray($!g-cp);
  }

  method is_linear is also<is-linear> {
    so gimp_color_profile_is_linear($!g-cp);
  }

  method is_rgb is also<is-rgb> {
    so gimp_color_profile_is_rgb($!g-cp);
  }

  method save_to_file (
    GFile()                 $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<save-to-file>
  {
    clear_error;
    my $rv = so gimp_color_profile_save_to_file($!g-cp, $file, $error);
    set_error($error);
    $rv;
  }

}
