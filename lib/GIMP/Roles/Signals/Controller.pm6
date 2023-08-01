use v6.c;

use NativeCall;

use GIMP::Raw::Types;

role GIMP::Roles::Signals::UI::Controller {
  has %!signals-g-c;

  #  GimpControllerEvent *event --> gboolean
   method connect-event (
     $obj,
     $signal = 'event',
     &handler?
   ) {
    my $hid;
    %!signals-g-c{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-event($obj, $signal,
        -> $, $gce {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gce, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-g-c{$signal}[0].tap(&handler) with &handler;
    %!signals-g-c{$signal}[0];
  }

}

# GimpController *controller,  GimpControllerEvent *event --> gboolean
sub g-connect-event (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GimpControllerEvent, gpointer --> gboolean),
  Pointer $data,
  uint32  $flags
)
 returns uint64
 is      native(gobject)
 is      symbol('g_signal_connect_object')
{ * }
