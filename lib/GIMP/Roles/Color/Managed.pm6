use v6.c;

use GIMP::Raw::Types;

use GLib::Roles::Implementor;

use GIMP::Color::Profile;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GIMP::Roles::Color::Managed {
  has GimpColorManaged $!g-cm is implementor;

  method roleInit-GimpColorManaged {
    return if $!g-cm;

    my \i = findProperImplementor(self.^attributes);
    $g-cm = cast( GimpColorManaged, i.get_value(self) )
  }

  # Is originally:
  # GimpColorManaged *managed, gpointer --> void
  method Simulation-Bpc-Changed {
    self.connect($!g-cm, 'simulation-bpc-changed');
  }

  # Is originally:
  # GimpColorManaged *managed, gpointer --> void
  method Simulation-Intent-Changed {
    self.connect($!g-cm, 'simulation-intent-changed');
  }

  # Is originally:
  # GimpColorManaged *managed, gpointer --> void
  method Simulation-Profile-Changed {
    self.connect($!g-cm, 'simulation-profile-changed');
  }

  # Is originally:
  # GimpColorManaged *managed, gpointer --> void
  method Profile-Changed {
    self.connect($!g-cm, 'profile-changed');
  }

  method get_color_profile ( :$raw = False ) {
    propReturnObject(
      gimp_color_managed_get_color_profile($!g-cm),
      $raw,
      |GIMP::Color::Profile.getTypePair
    );
  }

  proto method get_icc_profile (|)
  { * }

  multi method get_icc_profile {
    samewith($);
  }
  multi method get_icc_profile ($len is rw) {
    my gsize $l = 0;

    my $s = gimp_color_managed_get_icc_profile($!g-cm, $l);
    $len = $l;
    $s;
  }

  method get_simulation_bpc {
    so gimp_color_managed_get_simulation_bpc($!g-cm);
  }

  method get_simulation_intent ( :$enum = True ) {
    my $i = gimp_color_managed_get_simulation_intent($!g-cm);
    return $i unless $enum;
    GimpColorRenderingIntentEnum($i);
  }

  method get_simulation_profile ( :$raw = False ) {
    propReturnObject(
      gimp_color_managed_get_simulation_profile($!g-cm),
      $raw,
      |GIMP::Color::Profile.getTypePair
    );
  }

  method profile_changed {
    gimp_color_managed_profile_changed($!g-cm);
  }

  method simulation_bpc_changed {
    gimp_color_managed_simulation_bpc_changed($!g-cm);
  }

  method simulation_intent_changed {
    gimp_color_managed_simulation_intent_changed($!g-cm);
  }

  method simulation_profile_changed {
    gimp_color_managed_simulation_profile_changed($!g-cm);
  }

}


our subset GimpColorManagedAncestry is export of Mu
  where GimpColorManaged | GObject;

class GIMP::Color::Managed {
  also does GLib::Roles::Object;
  also does GIMP::Roles::Color::Managed;

  has GimpColorManaged $!g-cm is implementor;

  submethod BUILD ( :$gimp-color-managed ) {
    self.setGimpColorManaged($gimp-color-managed) if $gimp-color-managed;
  }

  method setGimpColorManaged (GimpColorManagedAncestry $_) {
    my $to-parent;

    $!g-cm = do {
      when GimpColorManaged {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorManaged, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorManaged
  { $!g-cm }

  multi method new (
     $gimp-color-managed where * ~~ GimpColorManagedAncestry,

    :$ref = True
  ) {
    return unless $gimp-color-managed;

    my $o = self.bless( :$gimp-color-managed );
    $o.ref if $ref;
    $o;
  }

}
