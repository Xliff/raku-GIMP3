use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GIMP::Raw::Types;
use GIMP::Raw::UI::Preview;

use GTK::Widget;
use GTK::Box;

use GLib::Roles::Implementor;

our subset GimpPreviewAncestry is export of Mu
  where GimpPreview | GtkBoxAncestry;

class GIMP::Preview is GTK::Box {
  has GimpPreview $!g-p is implementor;

  submethod BUILD ( :$gimp-preview ) {
    self.setGimpPreview($gimp-preview) if $gimp-preview
  }

  method setGimpPreview (GimpPreviewAncestry $_) {
    my $to-parent;

    $!g-p = do {
      when GimpPreview {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpPreview, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GIMP::Raw::Definitions::GimpPreview
    is also<GimpPreview>
  { $!g-p }

  multi method new (
     $gimp-preview where * ~~ GimpPreviewAncestry,

    :$ref = True
  ) {
    return unless $gimp-preview;

    my $o = self.bless( :$gimp-preview );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-preview = GLib::Object.new-object-ptr( self.get_type );

    $gimp-preview ?? self.bless( :$gimp-preview ) !! Nil;
  }


  # Type: int
  method size is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'size does not allow writing'
      }
    );
  }

  # Type: boolean
  method update is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('update', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('update', $gv);
      }
    );
  }

  method Invalidated {
    self.connect($!g-p, 'invalidated');
  }

  method draw {
    gimp_preview_draw($!g-p);
  }

  method draw_buffer (
          $buffer,
    Int() $rowstride
  )
    is also<draw-buffer>
  {
    my gint $r = $rowstride;

    gimp_preview_draw_buffer(
      $!g-p,
      resolveBuffer($buffer),
      $r
    );
  }

  method get_area ( :$raw = False, :$base = GTK::Widget, :$widget = False)
    is also<get-area>
  {
    ReturnWidget(
      gimp_preview_get_area($!g-p),
      :$raw,
      :$base,
      :$widget
    );
  }


  proto method get_bounds (|)
    is also<get-bounds>
  { * }

  multi method get_bounds {
    samewith($, $, $, $);
  }
  multi method get_bounds (
    $xmin is rw,
    $ymin is rw,
    $xmax is rw,
    $ymax is rw
  ) {
    my gint ($x1, $y1, $x2, $y2) = 0 xx 4;

    gimp_preview_get_bounds($!g-p, $x1, $y1, $x2, $y2);
    ($xmin, $ymin, $xmax, $ymax) = ($x1, $y1, $x2, $y2)
  }

  method get_controls (
    :$raw    = False,
    :$base   = GTK::Widget,
    :$widget = False
  )
    is also<get-controls>
  {
    ReturnWidget(
      gimp_preview_get_controls($!g-p),
      :$raw,
      :$base,
      :$widget
    );
  }

  method get_default_cursor ( :$raw = False ) is also<get-default-cursor> {
    propReturnObject(
      gimp_preview_get_default_cursor($!g-p),
      $raw,
      |GDK::Cursor.getTypePair
    );
  }

  method get_frame (
    :$raw    = False,
    :$base   = GTK::ApsectFrame,
    :$widget = False
  )
    is also<get-frame>
  {
    ReturnWidget(
      gimp_preview_get_frame($!g-p),
      :$raw,
      :$base,
      :$widget
    );
  }

  method get_grid (
    :$raw    = False,
    :$base   = GTK::Grid,
    :$widget = False
  )
    is also<get-grid>
  {
    ReturnWidget(
      gimp_preview_get_grid($!g-p),
      :$raw,
      :$base,
      :$widget
    );
  }

  proto method get_offsets (|)
    is also<get-offsets>
  { * }

  multi method get_offsets {
    samewith($, $);
  }
  multi method get_offsets ($xoff is rw, $yoff is rw) {
    my gint ($x, $y) = 0 xx 2;

    gimp_preview_get_offsets($!g-p, $xoff, $yoff);
  }

  proto method get_position (|)
    is also<get-position>
  { * }

  multi method get_position {
    samewith($, $);
  }
  multi method get_position ($x is rw, $y is rw) {
    my gint ($xx, $yy) = 0 xx 2;

    gimp_preview_get_position($!g-p, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    samewith($, $);
  }
  multi method get_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gimp_preview_get_size($!g-p, $width, $height);
    ($width, $height) = ($w, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_preview_get_type, $n, $t );
  }

  method get_update is also<get-update> {
    so gimp_preview_get_update($!g-p);
  }

  method invalidate {
    gimp_preview_invalidate($!g-p);
  }

  method set_bounds (Int() $xmin, Int() $ymin, Int() $xmax, Int() $ymax)
    is also<set-bounds>
  {
    my gint ($x1, $y1, $x2, $y2) = ($xmin, $ymin, $xmax, $ymax);

    gimp_preview_set_bounds($!g-p, $x1, $y1, $x2, $y2);
  }

  method set_default_cursor (GdkCursor() $cursor)
    is also<set-default-cursor>
  {
    gimp_preview_set_default_cursor($!g-p, $cursor);
  }

  proto method set_offsets (|)
    is also<set-offsets>
  { * }

  multi method set_offsets {
    samewith($, $);
  }
  multi method set_offsets (Int() $xoff, Int() $yoff) {
    my gint ($x, $y) = ($xoff, $yoff)
    ;
    gimp_preview_set_offsets($!g-p, $x, $y);
  }

  method set_size (Int() $width, Int() $height) is also<set-size> {
    my gint ($w, $h) = ($width, $height);

    gimp_preview_set_size($!g-p, $width, $height);
  }

  method set_update (Int() $update) is also<set-update> {
    my gboolean $u = $update.so.Int;

    gimp_preview_set_update($!g-p, $u);
  }

  multi method transform (Int() $src_x, Int() $src_y) {
    samewith($src_x, $src_y, $, $);
  }
  multi method transform (
    Int() $src_x,
    Int() $src_y,
          $dest_x is rw,
          $dest_y is rw
  ) {
    my gint ($x, $y)   = ($src_x, $src_y);
    my gint ($dx, $dy) =  0 xx 2;

    gimp_preview_transform($!g-p, $x, $y, $dx, $dy);
    ($dest_x, $dest_y) = ($dx, $dy);
  }

  multi method untransform (Int() $src_x, Int() $src_y) {
    samewith($, $);
  }
  multi method untransform (
    Int() $src_x,
    Int() $src_y,
          $dest_x is rw,
          $dest_y is rw
  ) {
    my gint ($x, $y)   = ($src_x, $src_y);
    my gint ($dx, $dy) =  0 xx 2;

    gimp_preview_untransform($!g-p, $x, $y, $dx, $dy);
    ($dest_x, $dest_y) = ($dx, $dy);
  }

}
