use v6.c;

use Method::Also;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Color::Notebook;

use GIMP::UI::Color::Selector;

use GLib::GList;
use GTK::Widget;

use GLib::Roles::Implementor;

our subset GimpColorNotebookAncestry is export of Mu
  where GimpColorNotebook | GimpColorSelectorAncestry;

class GIMP::UI::Color::Notebook is GIMP::UI::Color::Selector {
  has GimpColorNotebook $!g-cn is implementor;

  submethod BUILD ( :$gimp-color-notebook ) {
    self.setGimpColorNotebook($gimp-color-notebook) if $gimp-color-notebook
  }

  method setGimpColorNotebook (GimpColorNotebookAncestry $_) {
    my $to-parent;

    $!g-cn = do {
      when GimpColorNotebook {
        $to-parent = cast(GimpColorSelector, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorNotebook, $_);
      }
    }
    self.setGimpColorSelector($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorNotebook
    is also<GimpColorNotebook>
  { $!g-cn }

  multi method new (
     $gimp-color-notebook where * ~~ GimpColorNotebookAncestry,

    :$ref = True
  ) {
    return unless $$gimp-color-notebook;

    my $o = self.bless( :$gimp-color-notebook );
    $o.ref if $ref;
    $o;
  }

  method get_current_selector ( :$raw = False )
    is also<get-current-selector>
  {
    propReturnObject(
      gimp_color_notebook_get_current_selector($!g-cn),
      $raw,
      |GIMP::Color::Selector.getTypePair
    );
  }

  method get_notebook ( :$raw = False ) is also<get-notebook> {
    ReturnWidget( gimp_color_notebook_get_notebook($!g-cn), $raw )
  }

  method get_selectors ( :$raw = False, :gslist(:$glist) = False )
    is also<get-selectors>
  {
    returnGList(
      gimp_color_notebook_get_selectors($!g-cn),
      $raw,
      $glist,
      |GIMP::Color::Selector.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_notebook_get_type, $n, $t );
  }

  method set_has_page (Int() $page_type, Int() $has_page)
    is also<set-has-page>
  {
    my GType    $p = $page_type;
    my gboolean $h = $has_page.so.Int;

    gimp_color_notebook_set_has_page($!g-cn, $p, $h);
  }

  method set_simulation (
    GimpColorProfile() $profile,
    Int()              $intent,
    Int()              $bpc
  )
    is also<set-simulation>
  {
    my GimpColorRenderingIntent $i = $intent;
    my gboolean                 $b = $bpc.so.Int;

    gimp_color_notebook_set_simulation($!g-cn, $profile, $intent, $b);
  }

}
