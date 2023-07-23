use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;
use GIMP::Raw::Structs;

unit package GIMP::Raw::UI::ChainButton;

### /usr/src/gimp/libgimpwidgets/gimpchainbutton.h

sub gimp_chain_button_get_active (GimpChainButton $button)
  returns uint32
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_chain_button_get_button (GimpChainButton $button)
  returns GtkWidget
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_chain_button_get_icon_size (GimpChainButton $button)
  returns GtkIconSize
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_chain_button_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_chain_button_new (GimpChainPosition $position)
  returns GimpChainButton
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_chain_button_set_active (
  GimpChainButton $button,
  gboolean        $active
)
  is      native(gimpwidgets)
  is      export
{ * }

sub gimp_chain_button_set_icon_size (
  GimpChainButton $button,
  GtkIconSize     $size
)
  is      native(gimpwidgets)
  is      export
{ * }
