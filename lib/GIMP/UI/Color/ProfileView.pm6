use v6.c;

use Method::Also;

use NativeCall;

use GIMP::Raw::Types;

use GTK::TextView;

use GLib::Roles::Implementor;

our subset GimpColorProfileViewAncestry is export of Mu
  where GimpColorProfileView | GtkTextViewAncestry;

class GIMP::UI::Color::ProfileView is GTK::TextView {
  has GimpColorProfileView $!g-cpv is implementor;

  submethod BUILD ( :$gimp-profile-view ) {
    self.setGimpColorProfileView($gimp-profile-view) if $gimp-profile-view
  }

  method setGimpColorProfileView (GimpColorProfileViewAncestry $_) {
    my $to-parent;

    $!g-cpv = do {
      when GimpColorProfileView {
        $to-parent = cast(GtkTextView, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GimpColorProfileView, $_);
      }
    }
    self.setGtkTextView($to-parent);
  }

  method GIMP::Raw::Definitions::GimpColorProfileView
    is also<GimpColorProfileView>
  { $!g-cpv }

  multi method new (
     $gimp-profile-view where * ~~ GimpColorProfileViewAncestry,

    :$ref = True
  ) {
    return unless $gimp-profile-view;

    my $o = self.bless( :$gimp-profile-view );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gimp-profile-view = gimp_color_profile_view_new();

    $gimp-profile-view ?? self.bless( :$gimp-profile-view ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gimp_color_profile_view_get_type,
      $n,
      $t
    );
  }

  method set_error (Str() $message) is also<set-error> {
    gimp_color_profile_view_set_error($!g-cpv, $message);
  }

  method set_profile (GimpColorProfile() $profile) is also<set-profile> {
    gimp_color_profile_view_set_profile($!g-cpv, $profile);
  }

}

### /usr/src/gimp/libgimpwidgets/gimpcolorprofileview.h

sub gimp_color_profile_view_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_profile_view_new
  returns GimpColorProfileView
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_profile_view_set_error (
  GimpColorProfileView $view,
  Str                  $message
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_color_profile_view_set_profile (
  GimpColorProfileView $view,
  GimpColorProfile     $profile
)
  is      native(gimpwidgets)
  is      export
{ * }
