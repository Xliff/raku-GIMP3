use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GIMP::Raw::Definitions;

constant gimpcolor is export = 'gimpcolor-3.0',v0;
constant gimpbase  is export = 'gimpbase-3.0',v0;

class GPParam            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GPParamDef         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpMetadata       is repr<CPointer> does GLib::Roles::Pointers is export { }
