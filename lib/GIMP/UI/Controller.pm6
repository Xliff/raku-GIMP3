use v6.c;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Controller;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GIMP::UI::Controller {
  also does GLib::Roles::Object;
  also does GIMP::Roles::Signals::UI::Controller;

  has GimpController $!g-c is implementor;

  method new (Int() $controller-type) {
    my GType $c = $controller-type;

    my $gimp-controller = gimp_controller_new($c);

    $gimp-controller ?? self.bless( :$gimp-controller ) !! Nil;
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: string
  method state is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('state', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('state', $gv);
      }
    );
  }

  method Event {
    self.connect($!g-c, 'event');
  }

  method event ($event) {
    my $e = do given $event {
      when .^can('GimpControllerEventTrigger') { .GimpControllerEventTrigger }
      when .^can('GimpControllerEventValue')   { .GimpControllerEventValue   }
      when .^can('GimpControllerEventAny')     { .GimpControllerEventAny     }

      default {
        X::GLib::InvalidType.new(
          message => "Argument to .event must be {
                      ''}GimpControllerEvent-compatible. An instance of {
                      .^name }does not appear to be so."
        ).throw;
      }
    }
    cast(GimpControllerEvent, $e);

    samewith($e);
  }
  method event (GimpControllerEvent() $event) {
    gimp_controller_event($!g-c, $event);
  }

  method get_event_blurb (Int() $event_id) {
    my gint $e = $event_id;

    gimp_controller_get_event_blurb($!g-c, $e);
  }

  method get_event_name (Int() $event_id) {
    my gint $e = $event_id;

    gimp_controller_get_event_name($!g-c, $e);
  }

  method get_n_events {
    gimp_controller_get_n_events($!g-c);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_controller_get_type, $n, $t );
  }

}
