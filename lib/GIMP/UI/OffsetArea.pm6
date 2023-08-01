use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::OffsetArea;

use GTK::DrawingArea;

use GLib::Roles::Implementor;

our subset GimpOffsetAreaAncestry is export of Mu
  where GimpOffsetArea | GtkDrawingAreaAncestry;

class GIMP::UI::OffsetArea {
  has GimpOffsetArea $!g-oa is implementor handles(
    get-offset-x => 'offset-x',
    get-offset-y => 'offset-y',
    get_offset_x => 'offset_x',
    get_offset_y => 'offset_y'
  );

  submethod BUILD ( :$gimp-offset-area ) {
    self.setGimpOffsetArea($gimp-offset-area) if $gimp-offset-area
  }

  method setGimpOffsetArea (GimpOffsetAreaAncestry $_) {
    my $to-parent;

    $!g-oa = do {
      when GimpOffsetArea {
        $to-parent = cast(GtkDrawingArea, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpOffsetArea, $_);
      }
    }
    self.setGtkDrawingArea($to-parent);
  }

  method GIMP::Raw::Definitions::GimpOffsetArea
    is also<GimpOffsetArea>
  { $!g-oa }

  multi method new (
     $gimp-offset-area where * ~~ GimpOffsetAreaAncestry,

    :$ref = True
  ) {
    return unless $gimp-offset-area;

    my $o = self.bless( :$gimp-offset-area );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    my $gimp-offset-area = gimp_offset_area_new($w, $h);

    $gimp-offset-area ?? self.bless( :$gimp-offset-area ) !! Nil;
  }

  method offsets-changed is also<offsets_changed> {
    self.connect-intint($!g-oa, 'offsets-changed');
  }

  method offset_x is also<offset-x> {
    Proxy.new:
      FETCH => -> $     { self.get_offset_x }
      STORE => -> $, \v { self.set_offsets( \v, self.offset_y ) };
  }

  method offset_y is also<offset-y> {
    Proxy.new:
      FETCH => -> $     { self.get_offset_y }
      STORE => -> $, \v { self.set_offsets(self.offset_x, v) };
  }

  method get_type is also<get-type> {
    state ($n, $t);

    gimp_offset_area_get_type();
  }

  method set_offsets (Int() $offset_x, Int() $offset_y) is also<set-offsets> {
    my gint ($x, $y) = ($offset_x, $offset_y);

    gimp_offset_area_set_offsets($!g-oa, $x, $y);
  }

  method set_pixbuf (GdkPixbuf() $pixbuf) is also<set-pixbuf> {
    gimp_offset_area_set_pixbuf($!g-oa, $pixbuf);
  }

  method set_size (Int() $width, Int() $height) is also<set-size> {
    my gint ($w, $h) = ($width, $height);

    gimp_offset_area_set_size($!g-oa, $w, $h);
  }

}
