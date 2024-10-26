use v6.c;

use GIMP::Raw::Types;

use GLib::Object::Supplyish;

role GIMP::Roles::UI::Color::DisplayStack {
  has %!signals-gcds;

  #  GimpColorDisplay *display,  gint position --> void
  method connect-colordisplay-position (
     $obj,
     $signal,
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-gcds{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-colordisplay-position(
        $obj,
        $signal,
        -> $, $gcd is copy, $g {
          CATCH {
            default { 𝒮.note($_) }
          }

          $gcd = GIMP::UI::Color::Display.new($gcd) unless $raw;

          𝒮.emit( [self, $gcd, $g] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-gcds{$signal}[0].tap(&handler) with &handler;
    %!signals-gcds{$signal}[0];
  }

  #  GimpColorDisplay *display --> void
  method connect-colordisplay (
    $obj,
    $signal = 'removed',
    &handler?
  ) {
    my $hid;
    %!signals-gcds{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-colordisplay(
        $obj,
        $signal,
        -> $, $gcd is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          $gcd = GIMP::UI::Color::Display.new($gcd) unless $raw;

          𝒮.emit( [self, $gcd] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-gcds{$signal}[0].tap(&handler) with &handler;
    %!signals-gcds{$signal}[0];
  }

}

# GimpColorDisplayStack *stack,  GimpColorDisplay *display
sub g-connect-colordisplay (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GimpColorDisplay),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GimpColorDisplayStack *stack,  GimpColorDisplay *display,  gint position
sub g-connect-colordisplay-position (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GimpColorDisplay, gint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
