use v6.c;

use NativeCall;

use GIMP::Raw::Types;

class GIMP::Enums::UI::AspectType {
  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_aspect_type_get_type, $n, $t );
  }
}

sub gimp_aspect_type_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

class GIMP::Enums::UI::ChainPosition {
  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_chain_position_get_type, $n, $t );
  }
}

sub gimp_chain_position_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

class GIMP::Enums::UI::ColorArea {
  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_area_type_get_type, $n, $t );
  }
}

sub gimp_color_area_type_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }


class GIMP::Enums::UI::Color::SelectorChannel {
  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_selector_channel_get_type, $n, $t );
  }
}

sub gimp_color_selector_channel_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

class GIMP::Enums::UI::Color::SelectorModel {
  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_color_selector_model_get_type, $n, $t );
  }
}

sub gimp_color_selector_model_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

class GIMP::Enums::UI::Int::ComboBox::Layout {
  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gimp_int_combo_box_layout_get_type,
      $n,
      $t
    );
  }
}

sub gimp_int_combo_box_layout_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }


class GIMP::Enums::UI::PageSelector::Target {
  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gimp_page_selector_target_get_type,
      $n,
      $t
    );
  }
}

sub gimp_page_selector_target_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

class GIMP::Enums::UI::SizeEntry::UpdatePolicy {
  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gimp_size_entry_update_policy_get_type,
      $n,
      $t
    );
  }
}

sub gimp_size_entry_update_policy_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }

class GIMP::Enums::UI::ZoomType {
  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gimp_zoom_type_get_type, $n, $t );
  }
}

sub gimp_zoom_type_get_type
  returns GType
  is      native(gimpwidgets)
  is      export
{ * }
