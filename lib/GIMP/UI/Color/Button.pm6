use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Color::Button;

use GIO::SimpleActionGroup;
use GIMP::UI::Button;

use GLib::Roles::Implementor;

our subset GimpColorButtonAncestry is export of Mu
  where GimpColorButton | GimpButtonAncestry;

class GIMP::UI::Color::Button is GIMP::UI::Button {
  has GimpColorButton $!g-cb is implementor;

  submethod BUILD ( :$gimp-color-button ) {
    self.setGimpColorButton($gimp-color-button)
      if $gimp-color-button
  }

  method setGimpColorButton (GimpColorButtonAncestry $_) {
    my $to-parent;

    $!g-cb = do {
      when GimpColorButton {
        $to-parent = cast(GimpButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorButton, $_);
      }
    }
    self.setGimpButton($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorButton
    is also<GimpColorButton>
  { $!g-cb }

  multi method new (
     $gimp-color-button where * ~~ GimpColorButtonAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-button;

    my $o = self.bless( :$gimp-color-button );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()     $title,
    Int()     $width,
    Int()     $height,
    GimpRGB() $color,
    Int()     $type
  ) {
    my GimpColorAreaType  $t      =  $type;
    my gint              ($w, $h) = ($width, $height);

    my $gimp-color-button = gimp_color_button_new(
      $title,
      $w,
      $h,
      $color,
      $type
    );

    $gimp-color-button ?? self.bless( :$gimp-color-button ) !! Nil;
  }

  # Type: int
  method area-height is rw  is g-property is also<area_height> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'area-height does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('area-height', $gv);
      }
    );
  }

  # Type: int
  method area-width is rw  is g-property is also<area_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'area-width does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('area-width', $gv);
      }
    );
  }

  # Type: GimpColorConfig
  method color-config ( :$raw = False )
    is rw
    is g-property
    is also<color_config>
  {
    my $gv = GLib::Value.new( GIMP::Color::Config.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('color-config', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIMP::Color::Config.getTypePair
        );
      },
      STORE => -> $, GimpColorConfig() $val is copy {
        $gv.object = $val;
        self.prop_set('color-config', $gv);
      }
    );
  }

  # Type: boolean
  method continuous-update
    is rw
    is g-property
    is also<continuous_update>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('continuous-update', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('continuous-update', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: GimpColorAreaType
  method type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::typeFromEnum(GimpColorAreaType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GimpColorAreaTypeEnum($t);
      },
      STORE => -> $, Int()  $val is copy {
        $gv.valueFromEnum(GimpColorAreaType) = $val;
        self.prop_set('type', $gv);
      }
    );
  }

  method color-changed is also<color_changed> {
    self.connect($!g-cb, 'color-changed');
  }

  method get_action_group ( :$raw = False ) is also<get-action-group> {
    propReturnObject(
      gimp_color_button_get_action_group($!g-cb),
      $raw,
      |GIO::SimpleActionGroup.getTypePair
    );
  }

  proto method get_color (|)
    is also<get-color>
  { * }

  multi method get_color {
    samewith(GimpRGB.new);
  }
  multi method get_color (GimpRGB() $color, :$raw = False) {
    gimp_color_button_get_color($!g-cb, $color);
    propReturnObject( $color, $raw, |GIMP::RGB.getTypePair )
  }

  method get_title is also<get-title> {
    gimp_color_button_get_title($!g-cb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_button_get_type, $n, $t );
  }

  method get_update is also<get-update> {
    gimp_color_button_get_update($!g-cb);
  }

  method has_alpha is also<has-alpha> {
    so gimp_color_button_has_alpha($!g-cb);
  }

  method set_color (GimpRGB() $color) is also<set-color> {
    gimp_color_button_set_color($!g-cb, $color);
  }

  method set_color_config (GimpColorConfig() $config)
    is also<set-color-config>
  {
    gimp_color_button_set_color_config($!g-cb, $config);
  }

  method set_title (Str() $title) is also<set-title> {
    gimp_color_button_set_title($!g-cb, $title);
  }

  method set_type (Int() $type) is also<set-type> {
    my GimpColorAreaType $t = $type;

    gimp_color_button_set_type($!g-cb, $t);
  }

  method set_update (Int() $continuous) is also<set-update> {
    my gboolean $c = $continuous.so.Int;

    gimp_color_button_set_update($!g-cb, $c);
  }

}
