use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GEGL::Raw::Structs;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use GIMP::Raw::Definitions;
use GIMP::Raw::Enums;

unit package GIMP::Raw::Structs;

class GimpRGB is repr<CStruct> is export {
	has gdouble $.r is rw;
	has gdouble $.g is rw;
	has gdouble $.b is rw;
	has gdouble $.a is rw;

	method red   is rw { $!r }
	method green is rw { $!g }
	method blue  is rw { $!b }
	method alpha is rw { $!a }
}

class GPConfig is repr<CStruct> is export {
	has guint32 $.tile_width           is rw;
	has guint32 $.tile_height          is rw;
	has gint32  $.shm_id               is rw;
	has gint8   $.check_size           is rw;
	has gint8   $.check_type           is rw;
	has gint8   $.show_help_button     is rw;
	has gint8   $.use_cpu_accel        is rw;
	has gint8   $.use_opencl           is rw;
	has gint8   $.export_color_profile is rw;
	has gint8   $.export_comment       is rw;
	has gint8   $.export_exif          is rw;
	has gint8   $.export_xmp           is rw;
	has gint8   $.export_iptc          is rw;
	has gint32  $.default_display_id   is rw;
	has Str     $!app_name            ;
	has Str     $!wm_class            ;
	has Str     $!display_name        ;
	has gint32  $.monitor_number       is rw;
	has guint32 $.timestamp            is rw;
	has Str     $!icon_theme_dir      ;
	has guint64 $.tile_cache_size      is rw;
	has Str     $!swap_path           ;
	has Str     $!swap_compression    ;
	has gint32  $.num_processors       is rw;
	has GimpRGB $!check_custom_color1 ;
	has GimpRGB $!check_custom_color2 ;
}

class GPParamArray is repr<CStruct> is export {
	has guint32 $.size is rw;
	has guint8  $.data is rw;
}

class GPParamDefBoolean is repr<CStruct> is export {
	has gint32 $.default_val is rw;
}

class GPParamDefColor is repr<CStruct> is export {
	has gint32  $.has_alpha   is rw;
	has GimpRGB $!default_val;
}

class GPParamDefEnum is repr<CStruct> is export {
	has gint32 $.default_val is rw;
}

class GPParamDefFloat is repr<CStruct> is export {
	has gdouble $.min_val     is rw;
	has gdouble $.max_val     is rw;
	has gdouble $.default_val is rw;
}

class GPParamDefID is repr<CStruct> is export {
	has gint32 $.none_ok is rw;
}

class GPParamDefIDArray is repr<CStruct> is export {
	has Str $!type_name;
}

class GPParamDefInt is repr<CStruct> is export {
	has gint64 $.min_val     is rw;
	has gint64 $.max_val     is rw;
	has gint64 $.default_val is rw;
}

class GPParamDefString is repr<CStruct> is export {
	has Str $!default_val;
}

class GPParamDefUnit is repr<CStruct> is export {
	has gint32 $.allow_pixels  is rw;
	has gint32 $.allow_percent is rw;
	has gint32 $.default_val   is rw;
}

class GPParamIDArray is repr<CStruct> is export {
	has Str     $!type_name;
	has guint32 $.size      is rw;
	has gint32  $.data      is rw;
}

class GPProcInstall is repr<CStruct> is export {
	has Str        $!name         ;
	has guint32    $.type          is rw;
	has guint32    $.n_params      is rw;
	has guint32    $.n_return_vals is rw;
	has GPParamDef $!params       ;
	has GPParamDef $!return_vals  ;
}

class GPProcReturn is repr<CStruct> is export {
	has Str     $!name    ;
	has guint32 $.n_params is rw;
	has GPParam $!params  ;
}

class GPProcRun is repr<CStruct> is export {
	has Str     $!name    ;
	has guint32 $.n_params is rw;
	has GPParam $!params  ;
}

class GPProcUninstall is repr<CStruct> is export {
	has Str $!name;
}

class GPTileData is repr<CStruct> is export {
	has gint32  $.drawable_id is rw;
	has guint32 $.tile_num    is rw;
	has guint32 $.shadow      is rw;
	has guint32 $.bpp         is rw;
	has guint32 $.width       is rw;
	has guint32 $.height      is rw;
	has guint32 $.use_shm     is rw;
	has guchar  $!data       ;
}

class GPTileReq is repr<CStruct> is export {
	has gint32  $.drawable_id is rw;
	has guint32 $.tile_num    is rw;
	has guint32 $.shadow      is rw;
}

class GimpArray is repr<CStruct> is export {
	has guint8   $.data        is rw;
	has gsize    $!length     ;
	has gboolean $!static_data;
}

class GimpPreview is repr<CStruct> is export {
	has GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpAspectPreview is repr<CStruct> is export {
	has GimpPreview $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpProcedure is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpBatchProcedure is repr<CStruct> is export {
	has GimpProcedure $!parent_instance;
	has gpointer      $!priv           ;
}

# class GimpBatchProcedureClass is repr<CStruct> is export {
# 	has GimpProcedureClass $!parent_class;
# }

class GimpBrowser is repr<CStruct> is export {
	has GtkPaned $!parent_instance;
	has gpointer $!priv           ;
}

class GimpBusyBox is repr<CStruct> is export {
	has GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpButton is repr<CStruct> is export {
	has GtkButton $!parent_instance;
	has gpointer  $!priv           ;
}

class GimpCMYK is repr<CStruct> is export {
	has gdouble $.c is rw;
	has gdouble $.m is rw;
	has gdouble $.y is rw;
	has gdouble $.k is rw;
	has gdouble $.a is rw;
}

class GimpCellRendererColor is repr<CStruct> is export {
	has GtkCellRenderer $!parent_instance;
	has gpointer        $!priv           ;
}

class GimpCellRendererToggle is repr<CStruct> is export {
	has GtkCellRendererToggle $!parent_instance;
	has gpointer              $!priv           ;
}

class GimpChainButton is repr<CStruct> is export {
	has GtkGrid  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorArea is repr<CStruct> is export {
	has GtkDrawingArea $!parent_instance;
	has gpointer       $!priv           ;
}

class GimpColorButton is repr<CStruct> is export {
	has GimpButton $!parent_instance;
	has gpointer   $!priv           ;
}

class GimpColorConfig is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorDisplay is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorDisplayStack is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorHexEntry is repr<CStruct> is export {
	has GtkEntry $!parent_instance;
	has gpointer $!priv           ;
}

class GimpHSV is repr<CStruct> is export {
	has gdouble $.h is rw;
	has gdouble $.s is rw;
	has gdouble $.v is rw;
	has gdouble $.a is rw;

	method hue        is rw { $!h }
	method saturation is rw { $!s }
	method value      is rw { $!v }
	method alpha      is rw { $!a }
}

class GimpColorSelector is repr<CStruct> is export {
	has GtkBox                   $!parent_instance  ;
	has gpointer                 $!priv             ;
	has gboolean                 $!toggles_visible  ;
	has gboolean                 $!toggles_sensitive;
	has gboolean                 $!show_alpha       ;
	has GimpRGB                  $!rgb              ;
	has GimpHSV                  $!hsv              ;
	has GimpColorSelectorChannel $!channel          ;
}

class GimpColorNotebook is repr<CStruct> is export {
	has GimpColorSelector $!parent_instance;
	has gpointer          $!priv           ;
}

class GimpColorProfile is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorProfileChooserDialog is repr<CStruct> is export {
	has GtkFileChooserDialog $!parent_instance;
	has gpointer             $!priv           ;
}

class GimpColorProfileComboBox is repr<CStruct> is export {
	has GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpColorProfileStore is repr<CStruct> is export {
	has GtkListStore $!parent_instance;
	has gpointer     $!priv           ;
}

class GimpColorProfileView is repr<CStruct> is export {
	has GtkTextView $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpColorScale is repr<CStruct> is export {
	has GtkScale $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorSelection is repr<CStruct> is export {
	has GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorTransform is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpController is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
	has Str      $!name           ;
	has Str      $!state          ;
}

class GimpControllerEventAny is repr<CStruct> is export {
	has GimpControllerEventType $!type    ;
	has GimpController          $!source  ;
	has gint                    $.event_id is rw;
}

class GimpControllerEventTrigger is repr<CStruct> is export {
	has GimpControllerEventType $!type    ;
	has GimpController          $!source  ;
	has gint                    $.event_id is rw;
}

class GimpControllerEventValue is repr<CStruct> is export {
	has GimpControllerEventType $!type    ;
	has GimpController          $!source  ;
	has gint                    $.event_id is rw;
	has GValue                  $!value   ;
}

class GimpDialog is repr<CStruct> is export {
	has GtkDialog $!parent_instance;
	has gpointer  $!priv           ;
}

class GimpDisplay is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpScrolledPreview is repr<CStruct> is export {
	has GimpPreview $!parent_instance;
}

class GimpDrawablePreview is repr<CStruct> is export {
	has GimpScrolledPreview $!parent_instance;
	has gpointer            $!priv           ;
}

class GimpEevlQuantity is repr<CStruct> is export {
	has gdouble $.value     is rw;
	has gint    $.dimension is rw;
}

class GimpEevlOptions is repr<CStruct> is export {
	has gpointer                 $!unit_resolver_proc; #= GimpEevlUnitResolverProc
	has gpointer                 $!data              ;
	has gboolean                 $!ratio_expressions ;
	has gboolean                 $!ratio_invert      ;
	has GimpEevlQuantity         $!ratio_quantity    ;
}

class GimpIntComboBox is repr<CStruct> is export {
	has GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpEnumComboBox is repr<CStruct> is export {
	has GimpIntComboBox $!parent_instance;
	has gpointer        $!priv           ;
}

class GimpEnumDesc is repr<CStruct> is export {
	has gint $.value      is rw;
	has Str  $!value_desc;
	has Str  $!value_help;
}

class GimpEnumLabel is repr<CStruct> is export {
	has GtkLabel $!parent_instance;
	has gpointer $!priv           ;
}

class GimpIntStore is repr<CStruct> is export {
	has GtkListStore $!parent_instance;
	has gpointer     $!priv           ;
}

class GimpEnumStore is repr<CStruct> is export {
	has GimpIntStore $!parent_instance;
	has gpointer     $!priv           ;
}

class GimpFileEntry is repr<CStruct> is export {
	has GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpFileProcedure is repr<CStruct> is export {
	has GimpProcedure $!parent_instance;
	has gpointer      $!priv           ;
}

# class GimpFileProcedureClass is repr<CStruct> is export {
# 	has GimpProcedureClass $!parent_class;
# }

class GimpFlagsDesc is repr<CStruct> is export {
	has guint $.value      is rw;
	has Str   $!value_desc;
	has Str   $!value_help;
}

class GimpFrame is repr<CStruct> is export {
	has GtkFrame $!parent_instance;
	has gpointer $!priv           ;
}

class GimpHSL is repr<CStruct> is export {
	has gdouble $.h is rw;
	has gdouble $.s is rw;
	has gdouble $.l is rw;
	has gdouble $.a is rw;
}

class GimpHintBox is repr<CStruct> is export {
	has GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpImageProcedure is repr<CStruct> is export {
	has GimpProcedure $!parent_instance;
	has gpointer      $!priv           ;
}

# class GimpImageProcedureClass is repr<CStruct> is export {
# 	has GimpProcedureClass $!parent_class;
# }

class GimpIntRadioFrame is repr<CStruct> is export {
	has GimpFrame $!parent_instance;
}


class GimpLoadProcedure is repr<CStruct> is export {
	has GimpFileProcedure $!parent_instance;
	has gpointer          $!priv           ;
}

# class GimpLoadProcedureClass is repr<CStruct> is export {
# 	has GimpFileProcedureClass $!parent_class;
# }

class GimpMemsizeEntry is repr<CStruct> is export {
	has GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpModule is repr<CStruct> is export {
	has GTypeModule $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpModuleInfo is repr<CStruct> is export {
	has guint32 $.abi_version is rw;
	has Str     $!purpose    ;
	has Str     $!author     ;
	has Str     $!version    ;
	has Str     $!copyright  ;
	has Str     $!date       ;
}

class GimpNumberPairEntry is repr<CStruct> is export {
	has GtkEntry $!parent_instance;
	has gpointer $!priv           ;
}

class GimpObjectArray is repr<CStruct> is export {
	has GType    $!object_type;
	has GObject  $!data       ;
	has gsize    $!length     ;
	has gboolean $!static_data;
}

class GimpOffsetArea is repr<CStruct> is export {
	has GtkDrawingArea $!parent_instance;
	has gpointer       $!priv           ;
}

class GimpPDB is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpPDBProcedure is repr<CStruct> is export {
	has GimpProcedure $!parent_instance;
	has gpointer      $!priv           ;
}

# class GimpPDBProcedureClass is repr<CStruct> is export {
# 	has GimpProcedureClass $!parent_class;
# }

class GimpPageSelector is repr<CStruct> is export {
	has GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

# class GimpParamSpecArray is repr<CStruct> is export {
# 	has GParamSpecBoxed $!parent_instance;
# }
#
# class GimpParamSpecBrush is repr<CStruct> is export {
# 	has GimpParamSpecResource $!parent_instance;
# }
#
# class GimpParamSpecChannel is repr<CStruct> is export {
# 	has GimpParamSpecDrawable $!parent_instance;
# }
#
# class GimpParamSpecDisplay is repr<CStruct> is export {
# 	has GParamSpecObject $!parent_instance;
# 	has gboolean         $!none_ok        ;
# }
#
# class GimpParamSpecDrawable is repr<CStruct> is export {
# 	has GimpParamSpecItem $!parent_instance;
# }
#
# class GimpParamSpecFloatArray is repr<CStruct> is export {
# 	has GimpParamSpecArray $!parent_instance;
# }
#
# class GimpParamSpecFont is repr<CStruct> is export {
# 	has GimpParamSpecResource $!parent_instance;
# }
#
# class GimpParamSpecGradient is repr<CStruct> is export {
# 	has GimpParamSpecResource $!parent_instance;
# }
#
# class GimpParamSpecImage is repr<CStruct> is export {
# 	has GParamSpecObject $!parent_instance;
# 	has gboolean         $!none_ok        ;
# }
#
# class GimpParamSpecItem is repr<CStruct> is export {
# 	has GParamSpecObject $!parent_instance;
# 	has gboolean         $!none_ok        ;
# }
#
# class GimpParamSpecLayer is repr<CStruct> is export {
# 	has GimpParamSpecDrawable $!parent_instance;
# }
#
# class GimpParamSpecLayerMask is repr<CStruct> is export {
# 	has GimpParamSpecChannel $!parent_instance;
# }
#
# class GimpParamSpecObjectArray is repr<CStruct> is export {
# 	has GParamSpecBoxed $!parent_instance;
# 	has GType           $!object_type    ;
# }
#
# class GimpParamSpecPalette is repr<CStruct> is export {
# 	has GimpParamSpecResource $!parent_instance;
# }
#
# class GimpParamSpecPattern is repr<CStruct> is export {
# 	has GimpParamSpecResource $!parent_instance;
# }
#
# class GimpParamSpecRGBArray is repr<CStruct> is export {
# 	has GParamSpecBoxed $!parent_instance;
# }
#
# class GimpParamSpecResource is repr<CStruct> is export {
# 	has GParamSpecObject $!parent_instance;
# 	has gboolean         $!none_ok        ;
# }
#
# class GimpParamSpecSelection is repr<CStruct> is export {
# 	has GimpParamSpecChannel $!parent_instance;
# }
#
# class GimpParamSpecTextLayer is repr<CStruct> is export {
# 	has GimpParamSpecLayer $!parent_instance;
# }
#
# class GimpParamSpecUnit is repr<CStruct> is export {
# 	has GParamSpecInt $!parent_instance;
# 	has gboolean      $!allow_percent  ;
# }
#
# class GimpParamSpecValueArray is repr<CStruct> is export {
# 	has GParamSpec $!parent_instance ;
# 	has GParamSpec $!element_spec    ;
# 	has gint       $.fixed_n_elements is rw;
# }
#
# class GimpParamSpecVectors is repr<CStruct> is export {
# 	has GimpParamSpecItem $!parent_instance;
# }

class GimpParasite is repr<CStruct> is export {
	has Str      $!name ;
	has guint32  $.flags is rw;
	has guint32  $.size  is rw;
	has gpointer $!data ;
}

class GimpPathEditor is repr<CStruct> is export {
	has GtkBox            $!parent_instance;
	has gpointer          $!priv           ;
	has GtkWidget         $!upper_hbox     ;
	has GtkWidget         $!new_button     ;
	has GtkWidget         $!up_button      ;
	has GtkWidget         $!down_button    ;
	has GtkWidget         $!delete_button  ;
	has GtkWidget         $!file_entry     ;
	has GtkListStore      $!dir_list       ;
	has GtkTreeSelection  $!sel            ;
	has GtkTreePath       $!sel_path       ;
	has GtkTreeViewColumn $!writable_column;
	has gint              $.num_items       is rw;
}

class GimpPickButton is repr<CStruct> is export {
	has GtkButton $!parent_instance;
	has gpointer  $!priv           ;
}

class GimpPickButtonPrivate is repr<CStruct> is export {
	has GdkCursor $!cursor     ;
	has GtkWidget $!grab_widget;
}

class GimpPlugIn is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpPreviewArea is repr<CStruct> is export {
	has GtkDrawingArea $!parent_instance;
	has gpointer       $!priv           ;
}

class GimpProcBrowserDialog is repr<CStruct> is export {
	has GimpDialog $!parent_instance;
	has gpointer   $!priv           ;
}

class GimpProcedureConfig is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpProcedureDialog is repr<CStruct> is export {
	has GimpDialog $!parent_instance;
	has gpointer   $!priv           ;
}

class GimpProgressBar is repr<CStruct> is export {
	has GtkProgressBar $!parent_instance  ;
	has Str            $!progress_callback;
	has gboolean       $!cancelable       ;
}

class GimpRuler is repr<CStruct> is export {
	has GtkWidget $!parent_instance;
	has gpointer  $!priv           ;
}

class GimpSaveProcedure is repr<CStruct> is export {
	has GimpFileProcedure $!parent_instance;
	has gpointer          $!priv           ;
}

# class GimpSaveProcedureClass is repr<CStruct> is export {
# 	has GimpFileProcedureClass $!parent_class;
# }

class GimpSaveProcedureDialog is repr<CStruct> is export {
	has GimpProcedureDialog $!parent_instance;
	has gpointer            $!priv           ;
}

class GimpSizeEntry is repr<CStruct> is export {
	has GtkGrid  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpSpinButton is repr<CStruct> is export {
	has GtkSpinButton $!parent_instance;
	has gpointer      $!priv           ;
}

class GimpSpinScale is repr<CStruct> is export {
	has GimpSpinButton $!parent_instance;
}

# class GimpSpinScaleClass is repr<CStruct> is export {
# 	has GimpSpinButtonClass $!parent_class;
# }

class GimpStringComboBox is repr<CStruct> is export {
	has GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpThumbnail is repr<CStruct> is export {
	has GObject        $!parent_instance      ;
	has gpointer       $!priv                 ;
	has GimpThumbState $!image_state          ;
	has Str            $!image_uri            ;
	has Str            $!image_filename       ;
	has gint64         $.image_filesize        is rw;
	has gint64         $.image_mtime           is rw;
	has gint           $.image_not_found_errno is rw;
	has gint           $.image_width           is rw;
	has gint           $.image_height          is rw;
	has Str            $!image_type           ;
	has gint           $.image_num_layers      is rw;
	has GimpThumbState $!thumb_state          ;
	has GimpThumbSize  $!thumb_size           ;
	has Str            $!thumb_filename       ;
	has gint64         $.thumb_filesize        is rw;
	has gint64         $.thumb_mtime           is rw;
	has Str            $!image_mimetype       ;
}

class GimpThumbnailProcedure is repr<CStruct> is export {
	has GimpProcedure $!parent_instance;
	has gpointer      $!priv           ;
}

# class GimpThumbnailProcedureClass is repr<CStruct> is export {
# 	has GimpProcedureClass $!parent_class;
# }

class GimpTileBackendPlugin is repr<CStruct> is export {
	has GeglTileBackend $!parent_instance;
	has gpointer        $!priv           ;
}

# class GimpTileBackendPluginClass is repr<CStruct> is export {
# 	has GeglTileBackendClass $!parent_class;
# }

class GimpUnitComboBox is repr<CStruct> is export {
	has GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpUnitStore is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpWireMessage is repr<CStruct> is export {
	has guint32  $.type is rw;
	has gpointer $!data;
}

class GimpZoomModel is repr<CStruct> is export {
	has GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpZoomPreview is repr<CStruct> is export {
	has GimpScrolledPreview $!parent_instance;
	has gpointer            $!priv           ;
}
