use v6.c;

use NativeCall;

role GIMP::Roles::Signals::UI::Color::Selector {
  has %signals-g-cs;

  #  GimpRGB *rgb,  GimpHSV *hsv --> void
  method connect-color-changed (
    $obj,
    $signal = 'color-changed',
    &handler?
  ) {
    my $hid;
    %!signals-g-cs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-color-changed($obj, $signal,
        -> $, $g1, $g2, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $g1, $g2, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-g-cs{$signal}[0].tap(&handler) with &handler;
    %!signals-g-cs{$signal}[0];
  }

}

# GimpColorSelector *selector,  GimpRGB *rgb,  GimpHSV *hsv
sub g-connect-color-changed (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GimpRGB, GimpHSV, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
