use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GIMP::Raw::Definitions;

constant gimp        is export = 'gimp-3.0',v0;
constant gimpbase    is export = 'gimpbase-3.0',v0;
constant gimpcolor   is export = 'gimpcolor-3.0',v0;
constant gimpconfig  is export = 'gimpconfig-3.0',v0;
constant gimpthumb   is export = 'gimpthumb-3.0',v0;
constant gimpwidgets is export = 'gimpwidgets-3.0',v0;
constant gimpmath    is export = 'gimpmath-3.0',v0;

constant GIMP_MIN_IMAGE_SIZE is export = 1;
constant GIMP_MAX_IMAGE_SIZE is export = 524288;    #  2^19
constant GIMP_MIN_RESOLUTION is export = 5e-3;      #  shouldn't display as 0.000
constant GIMP_MAX_RESOLUTION is export = 1048576.0;
constant GIMP_MAX_MEMSIZE    is export = 1 +< 42;   #  4 terabyte;

constant GIMP_CHECK_SIZE     is export =   8;
constant GIMP_CHECK_SIZE_SM  is export =   4;
constant GIMP_CHECK_DARK     is export = 0.4;
constant GIMP_CHECK_LIGHT    is export = 0.6;

class GimpChannel        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpColorManaged   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpColorScales    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpDrawable       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpImage          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpItem           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpLabelColor     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpLabeled        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpLabelEntry     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpLabelSpin      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpLayer          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpMetadata       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpScaleEntry     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpSelection      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GimpVectors        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GPParam            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GPParamDef         is repr<CPointer> does GLib::Roles::Pointers is export { }
