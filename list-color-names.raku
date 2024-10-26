use v6;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Subs;
use GIMP::Raw::Structs;
use GIMP::Raw::RGB;

use GLib::Roles::TypedBuffer;

proto sub list_names (|)
{ * }

multi sub list_names ( :$raw = False ) {
  my $ccs = CArray[Pointer[Str]].new;
  $ccs[0] = Pointer[Str];

  samewith(
     $ccs,
     newCArray( GimpRGB ),
     $,
    :$raw
  );
}
multi sub list_names (
  CArray[Pointer[Str]]      $names,
  CArray[Pointer[GimpRGB]]  $colors,
                            $n_colors is rw,
                           :$raw            = False,
                           :$hash           = True
) {
  my gint $n = 0;

  gimp_rgb_list_names($names, $colors, $n);

  my $na = cast( CArray[Str], $names[0] );
  my $cb = GLib::Roles::TypedBuffer[GimpRGB].new( $colors[0], size => $n );

  my %h;
  my @a = ( $na[^$n], $cb.Array );
  return @a unless $hash;
  %h{ @a.head[$_] } = @a.tail[$_] for ^$n;
  %h;
}

my $r = list_names;
.gist.say for $r.pairs.sort( *.key );
