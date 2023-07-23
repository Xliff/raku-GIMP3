use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::ChainButton;

use GTK::Grid;

use GLib::Roles::Implementor;

our subset GimpChainButtonAncestry is export of Mu
  where GimpChainButton | GtkGridAncestry;

class GIMP::UI::ChainButton is GTK::Grid {
  has GimpChainButton $!g-cb is implementor;

  submethod BUILD ( :$gimp-chain-button ) {
    self.setGimpChainButton($gimp-chain-button) if $gimp-chain-button;
  }

  method setGimpChainButton (GimpChainButtonAncestry $_) {
    my $to-parent;

    $!g-cb = do {
      when GimpChainButton {
        $to-parent = cast(GtkGrid, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpChainButton, $_);
      }
    }
    self.setGtkGrid($to-parent);
  }

  method GIMP::Raw::Definitions::GimpChainButton
    is also<GimpChainButton>
  { $!g-cb }

  multi method new (
     $gimp-chain-button where * ~~ GimpChainButtonAncestry,

    :$ref = True
  ) {
    return unless $gimp-chain-button;

    my $o = self.bless( :$gimp-chain-button );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $position) {
    my GimpChainPosition $p = $position;

    my $gimp-chain-button = gimp_chain_button_new($p);

    $gimp-chain-button ?? self.bless( :$gimp-chain-button ) !! Nil;
  }

  # Type: boolean
  method active is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: GtkIconSize
  method icon-size ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkIconSize) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-size', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GtkIconSizeEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        my GtkIconSize $v = $val;
        $gv.valueFromEnun(GtkIconSize) = $val;
        self.prop_set('icon-size', $gv);
      }
    );
  }

  # Type: GimpChainPosition
  method position ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GimpChainPosition) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position', $gv);
        my $p = $gv.enum;
        return $p unless $enum;
        GimpChainPositionEnum($p);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GimpChainPosition) = $val;
        self.prop_set('position', $gv);
      }
    );
  }

  method toggled {
    self.connect($!g-cb, 'toggled');
  }

  method get_active is also<get-active> {
    gimp_chain_button_get_active($!g-cb);
  }

  method get_button ( :$raw = False ) is also<get-button> {
    propReturnObject(
      gimp_chain_button_get_button($!g-cb),
      $raw,
      |GTK::Button.getTypePair
    );
  }

  method get_icon_size ( :$enum = True ) is also<get-icon-size> {
    my $i = gimp_chain_button_get_icon_size($!g-cb);
    return $i unless $enum;
    GtkIconSizeEnum($i);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_chain_button_get_type, $n, $t );
  }

  method set_active (Int() $active) is also<set-active> {
    my gboolean $a = $active.so.Int;

    gimp_chain_button_set_active($!g-cb, $a);
  }

  method set_icon_size (Int() $size) is also<set-icon-size> {
    my GtkIconSize $s = $size;

    gimp_chain_button_set_icon_size($!g-cb, $s);
  }

}
