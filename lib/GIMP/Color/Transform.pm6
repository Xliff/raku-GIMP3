use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::Color::Transform;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GimpColorTransformAncestry is export of Mu
  where GimpColorTransform | GObject;

class GIMP::Color::Transform {
  also does GLib::Roles::Object;

  has GimpColorTransform $!g-ct is implementor;

  submethod BUILD ( :$gimp-color-transform ) {
    self.setGimpColorTransform($gimp-color-transform)
      if $gimp-color-transform
  }

  method setGimpColorTransform (GimpColorTransformAncestry $_) {
    my $to-parent;

    $!g-ct = do {
      when GimpColorTransform {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorTransform, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Structs::GimpColorTransform
    is also<GimpColorTransform>
  { $!g-ct }

  sub resolveTransformFlags (
    $flags        is copy,
    $optimize,
    $check,
    $compensation,
  ) {
    constant COMP = GIMP_COLOR_TRANSFORM_FLAGS_BLACK_POINT_COMPENSATION;

    adjustFlag($flags, GIMP_COLOR_TRANSFORM_FLAGS_NOOPTIMIZE,  $optimize);
    adjustFlag($flags, GIMP_COLOR_TRANSFORM_FLAGS_GAMUT_CHECK, $check);
    adjustFlag($flags, COMP,                                   $compensation);

    $flags;
  }

  sub resolveIntent ($perceptual, $relative, $saturation, $absolute) {
    unless ($perceptual, $relative, $saturation, $absolute).one.so {
      die X::GLib::OnlyOneOf.new(
        values => <perceptual relative satuation absolute>
      ).throw
    }

    return GIMP_COLOR_RENDERING_INTENT_PERCEPTUAL           if $perceptual;
    return GIMP_COLOR_RENDERING_INTENT_RELATIVE_COLORMETRIC if $colormetric;
    return GIMP_COLOR_RENDERING_INTENT_SATURATION           if $saturation;
    return GIMP_COLOR_RENDERING_INTENT_ABSOLUTE_COLORMETRIC if $absolute;

    0;
  }

  multi method new (
    $gimp-color-transform where * ~~ GimpColorTransformAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-transform;

    my $o = self.bless( :$gimp-color-transform );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GimpColorProfile()  $src_profile,
    Babl()              $src_format,
    GimpColorProfile()  $dest_profile,
    Babl()              $dest_format,
                       :$rendering_intent,
                       :$perceptual,
                       :$relative,
                       :$saturation,
                       :$absolute,
                       :$flags               = 0,
                       :$optimize,
                       :$check,
                       :$compensation,
  ) {
    my $gimp-color-transform = gimp_color_transform_new(
      $src_profile,
      $src_format,
      $dest_profile,
      $dest_format,
      resolveIntent(
        $rendering_intent,
        $perceptual,
        $relative,
        $saturation,
        $absolute
      ),
      resolveTransformFlag(
        $flags,
        $optimize,
        $check,
        $compensation
      ),
    );
  }
  method new (
    GimpColorProfile()  $src_profile,
    Babl()              $src_format,
    GimpColorProfile()  $dest_profile,
    Babl()              $dest_format,
    Int()               $rendering_intent,
    Int()               $flags             = 0;
  ) {
    my GimpColorRenderingIntent $r = $rendering_intent;
    my GimpColorTransformFlags  $f = $flags;

    my $gimp-color-transform = gimp_color_transform_new(
      $src_profile,
      $src_format,
      $dest_profile,
      $dest_format,
      $r,
      $f
    );

    $gimp-color-transform ?? self.bless( :$gimp-color-transform ) !! Nil;
  }

  proto method new_proofing (|)
    is also<new-proofing>
  { * }

  multi method new_proofing (
    GimpColorProfile()  $src_profile,
    Babl()              $src_format,
    GimpColorProfile()  $dest_profile,
    Babl()              $dest_format,
    GimpColorProfile()  $proof_profile,
                       :proof-intent(:$proof_intent),
                       :proof-perceptual(:$proof_perceptual),
                       :proof-relative(:$proof_relative),
                       :proof-saturation(:$proof_saturation),
                       :proof-absolute(:$proof_absolute),
                       :intent(:display-intent(:$display_intent)),
                       :perceptual(:display-perceptual(:$display_perceptual)),
                       :relative(:display-relative(:$display_relative)),
                       :saturation(:display-saturation(:$display_saturation)),
                       :absolute(:display-absolute(:$display_absolute)),
                       :$flags = 0,
                       :$optimize,
                       :$check,
                       :$compensation,
  ) {
    samewith(
      $src_profile,
      $src_format,
      $dest_profile,
      $dest_format,
      $proof_profile,
      resolveIntent(
        $proof_intent,
        $proof_perceptual,
        $proof_relative,
        $proof_saturation,
        $proof_absolute
      ),
      resolveIntent(
        $display_intent,
        $display_perceptual,
        $display_relative,
        $display_saturation,
        $display_absolute
      ),
      resolveTransformFlag(
        $flags,
        $optimize,
        $check,
        $compensation
      )
    );
  }
  multi method new_proofing (
    GimpColorProfile()  $src_profile,
    Babl()              $src_format,
    GimpColorProfile()  $dest_profile,
    Babl()              $dest_format,
    GimpColorProfile()  $proof_profile,
    Int()               $proof_intent,
    Int()               $display_intent,
    Int()               $flags
  ) {
    my GimpColorRenderingIntent $p = $proof_intent;
    my GimpColorRenderingIntent $d = $display_intent;
    my GimpColorTransformFlags  $f = $flags;

    my $gimp-color-transform = gimp_color_transform_new_proofing(
      $!g-ct,
      $src_profile,
      $src_format,
      $dest_profile,
      $dest_format,
      $proof_profile,
      $p,
      $d,
      $f
    );

    $gimp-color-transform ?? self.bless( :$gimp-color-transform ) !! Nil;
  }

  method Progress {
    self.connect-double($!g-ct, 'progress');
  }

  method can_gegl_copy (
    GimpColorProfile() $src_profile,
    GimpColorProfile() $dest_profile
  )
    is static

    is also<can-gegl-copy>
  {
    so gimp_color_transform_can_gegl_copy($!g-ct, $dest_profile);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_transform_get_type, $n, $t );
  }

  method process_buffer (
    GeglBuffer()      $src_buffer,
    GeglRectangle()   $src_rect,
    GeglBuffer()      $dest_buffer,
    GeglRectangle()   $dest_rect
  )
    is also<process-buffer>
  {
    gimp_color_transform_process_buffer(
      $!g-ct,
      $src_buffer,
      $src_rect,
      $dest_buffer,
      $dest_rect
    );
  }

  proto method process_pixels (|)
    is also<process-pixels>
  { * }

  multi method process_pixels (
    Babl() $src_format,
           $src_pixels,
    Babl() $dest_format,
           $dest_pixels
  ) {
    sub resolvePix ($_) {
      do {
        when .^can('Buf')         { .Buf   }
        when .^can('Array')       { .Array }

        when GLib::Roles::Pointer { .p     }

        default {
          X::GLib::InvalidType.new(
            message => "Cannot process pixels of type { .^name }!"
          ).throw;
        }
      }
    }

    samewith(
      $src_format,
      resolvePix($src_pixels),
      $dest_format,
      resolvePix($dest_pixels)
    );
  }
  # Buf
  multi method process_pixels (
    Babl() $src_format,
    Buf    $src_pixels,
    Babl() $dest_format,
    Buf    $dest_pixels
  ) {
    samewith(
      $src_format,
      CArray[uint8].new($src_pixels),
      $dest_format,
      CArray[uint8].new($dest_pixels),
    );
  }
  # Array
  multi method process_pixels (
    Babl() $src_format,
           @src_pixels,
    Babl() $dest_format,
           @dest_pixels
  ) {
    samewith(
      $src_format,
      ArrayToCArray(uint8, @src_pixels),
      $dest_format,
      ArrayToCArray(uint8, @dest_pixels),
    );
  }
  # CArray[uint8]
  multi method process_pixels (
    Babl()        $src_format,
    CArray[uint8] $src_pixels,
    Babl()        $dest_format,
    CArray[uint8] $dest_pixels
  ) {
    samewith(
      $src_format,
      cast(gpointer, $src_pixels),
      $dest_format,
      cast(gpointer, $dest_pixels),
    );
  }
  multi method process_pixels (
    Babl()   $src_format,
    gpointer $src_pixels,
    Babl()   $dest_format,
    gpointer $dest_pixels,
    Int()    $length
  ) {
    my gsize $l = $length;

    gimp_color_transform_process_pixels(
      $!g-ct,
      $src_format,
      $src_pixels,
      $dest_format,
      $dest_pixels,
      $l
    );
  }

}
