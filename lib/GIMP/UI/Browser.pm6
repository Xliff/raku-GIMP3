use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;
use GIMP::Raw::UI::Browser;

use GTK::Pane;

use GLib::Roles::Implementor;

our subset GimpBrowserAncestry is export of Mu
  where GimpBrowser | GtkPaneAncestry;

class GIMP::UI::Browser is GTK::Pane {
  has GimpBrowser $!g-b is implementor;

  submethod BUILD ( :$gimp-browser ) {
    self.setGimpBrowser($gimp-browser) if $gimp-browser
  }

  method setGimpBrowser (GimpBrowserAncestry $_) {
    my $to-parent;

    $!g-b = do {
      when GimpBrowser {
        $to-parent = cast(GtkPaned, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpBrowser, $_);
      }
    }
    self.setGtkPane($to-parent);
  }

  method GIMP::Raw::Definitions::GimpBrowser
    is also<GimpBrowser>
  { $!g-b }

  multi method new (
    $gimp-browser where * ~~ GimpBrowserAncestry,

    :$ref = True
  ) {
    return unless $gimp-browser;

    my $o = self.bless( :$gimp-browser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-browser = gimp_browser_new();

    $gimp-browser ?? self.bless( :$gimp-browser ) !! Nil;
  }

  method search {
    self.connect-string($!g-b, 'search');
  }

  method add_serch_types (@label-ids) is also<add-serch-types> {
    my ($fl, $fi) = @label-ids.unshift xx 2;;

    my $li = CArray[uint64].new;
    for @label-ids -> $l, $i {
      $li.push: +cast( gpointer, CArray[uint8].new($l.encode) );
      $li.push: $i;
    }
    $li.push: 0;
    samewith($fl, $fi, $li);
  }

  method add_search_types (
    Str()          $first_type_label,
    Int()          $first_type_id,
    CArray[uint64] $nt-args
  )
    is also<add-search-types>
  {
    my gint $t  = $first_type_id;
    # cw: Ensures null termination.
    my      $na = resolve-gstrv($nt-args);
    gimp_browser_add_search_types(
      $!g-b,
      $first_type_label,
      $t,
      $na
    );
  }

  # cw: Until the various versions are straight and the mechanisms for widget
  #     creation apparent, we will use the Lowest Common Object.
  method get_left_vbox ( :$raw = False ) is also<get-left-vbox> {
    propReturnObject(
      gimp_browser_get_left_vbox($!g-b),
      $raw,
      |GTK::Box.getTypePair
    );
  }

  method get_right_vbox ( :$raw = False ) is also<get-right-vbox> {
    propReturnObject(
      gimp_browser_get_right_vbox($!g-b),
      $raw,
      |GTK::Box.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_browser_get_type, $n, $t );
  }

  method set_search_summary (Str() $summary) is also<set-search-summary> {
    gimp_browser_set_search_summary($!g-b, $summary);
  }

  method set_widget (GtkWidget() $widget) is also<set-widget> {
    gimp_browser_set_widget($!g-b, $widget);
  }

  method show_message (Str() $message) is also<show-message> {
    gimp_browser_show_message($!g-b, $message);
  }

}
