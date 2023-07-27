use v6.c;

use Method::Also;
use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::Color::Config;

use GIMP::Color::Profile;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GimpColorConfigAncestry is export of Mu
  where GimpColorConfig | GObject;

class GIMP::Color::Config {
  also does GLib::Roles::Object;

  has GimpColorConfig $!g-cc is implementor;

  submethod BUILD ( :$gimp-color-config ) {
    self.setGimpColorConfig($gimp-color-config) if $gimp-color-config
  }

  method setGimpColorConfig (GimpColorConfigAncestry $_) {
    my $to-parent;

    $!g-cc = do {
      when GimpColorConfig {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorConfig, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Struct::GimpColorConfig
  { $!g-cc }

  multi method new (
     $gimp-color-config where * ~~ GimpColorConfigAncestry,
    :$ref = True
  ) {
    return unless $gimp-color-config;

    my $o = self.bless( :$gimp-color-config );
    $o.ref if $ref;
    $o;
  }

  method get_cmyk_color_profile (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<get-cmyk-color-profile>
  {
    clear_error;
    my $cp = gimp_color_config_get_cmyk_color_profile($!g-cc, $error);
    set_error($error);
    propReturnObject($cp, $raw, |GIMP::Color::Profile.getTypePair)
  }

  method get_display_bpc is also<get-display-bpc> {
    gimp_color_config_get_display_bpc($!g-cc);
  }

  method get_display_color_profile (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<get-display-color-profile>
  {
    clear_error;
    my $cp = gimp_color_config_get_display_color_profile($!g-cc, $error);
    set_error($error);
    propReturnObject($cp, $raw, |GIMP::Color::Profile.getTypePair)
  }

  method get_display_intent ( :$enum = True ) is also<get-display-intent> {
    my $i = gimp_color_config_get_display_intent($!g-cc);
    return $i unless $enum;
    GimpColorRenderingIntentEnum($i);
  }

  method get_display_optimize is also<get-display-optimize> {
    so gimp_color_config_get_display_optimize($!g-cc);
  }

  method get_display_profile_from_gdk is also<get-display-profile-from-gdk> {
    so gimp_color_config_get_display_profile_from_gdk($!g-cc);
  }

  method get_gray_color_profile (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<get-gray-color-profile>
  {
    clear_error;
    my $cp = gimp_color_config_get_gray_color_profile($!g-cc, $error);
    set_error($error);
    propReturnObject($cp, $raw, |GIMP::Color::Profile.getTypePair)
  }

  method get_mode ( :$enum = True ) is also<get-mode> {
    my $m = gimp_color_config_get_mode($!g-cc);
    return $m unless $enum;
    GimpColorManagementModeEnum($m);
  }

  proto method get_out_of_gamut_color (|)
    is also<get-out-of-gamut-color>
  { * }

  multi method get_out_of_gamut_color ( :$raw = False) {
    samewith(GimpRGB.new, :$raw)
  }
  multi method get_out_of_gamut_color (GimpRGB() $color, :$raw = False) {
    gimp_color_config_get_out_of_gamut_color($!g-cc, $color);
    propReturnObject($color, $raw, |GIMP::RGB.getTypePair);
  }

  method get_rgb_color_profile (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<get-rgb-color-profile>
  {
    clear_error;
    my $cp = gimp_color_config_get_rgb_color_profile($!g-cc, $error);
    set_error($error);
    propReturnObject($cp, $raw, |GIMP::Color::Profile.getTypePair);
  }

  method get_simulation_bpc is also<get-simulation-bpc> {
    gimp_color_config_get_simulation_bpc($!g-cc);
  }

  method get_simulation_color_profile (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<get-simulation-color-profile>
  {
    clear_error;
    my $cp = gimp_color_config_get_simulation_color_profile($!g-cc, $error);
    set_error($error);
    propReturnObject($cp, $raw, |GIMP::Color::Profile.getTypePair);
  }

  method get_simulation_gamut_check is also<get-simulation-gamut-check> {
    so gimp_color_config_get_simulation_gamut_check($!g-cc);
  }

  method get_simulation_intent ( :$enum = True ) is also<get-simulation-intent> {
    my $i = gimp_color_config_get_simulation_intent($!g-cc);
    return $i unless $enum;
    GimpColorRenderingIntentEnum($i);
  }

  method get_simulation_optimize is also<get-simulation-optimize> {
    so gimp_color_config_get_simulation_optimize($!g-cc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_config_get_type, $n, $t );
  }

}
