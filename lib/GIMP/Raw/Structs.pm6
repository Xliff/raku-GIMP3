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

use GLib::Roles::Pointers;

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

	method new (Num() $rr, Num() $gg, Num() $bb, Num() $aa) {
		my gdouble ($r, $g, $b, $a) = ($rr, $gg, $bb, $aa);

		self.bless(:$r, :$g, :$b, :$a );
	}
}

our %GLOBAL-COLOR is export;

INIT {
	%GLOBAL-COLOR<LIGHT_COLOR_DARK>  = GimpRGB.new(0.8, 0.8, 0.8, 1.0);
	%GLOBAL-COLOR<LIGHT_COLOR_LIGHT> = GimpRGB.new(1.0, 1.0, 1.0, 1.0);
	%GLOBAL-COLOR<GRAY_COLOR_DARK>   = GimpRGB.new(0.4, 0.4, 0.4, 1.0);
	%GLOBAL-COLOR<GRAY_COLOR_LIGHT>  = GimpRGB.new(0.6, 0.6, 0.6, 1.0);
	%GLOBAL-COLOR<DARK_COLOR_DARK>   = GimpRGB.new(0.0, 0.0, 0.0, 1.0);
	%GLOBAL-COLOR<DARK_COLOR_LIGHT>  = GimpRGB.new(0.2, 0.2, 0.2, 1.0);
	%GLOBAL-COLOR<WHITE_COLOR>       = GimpRGB.new(1.0, 1.0, 1.0, 1.0);
	%GLOBAL-COLOR<GRAY_COLOR>        = GimpRGB.new(0.5, 0.5, 0.5, 1.0);
	%GLOBAL-COLOR<BLACK_COLOR>       = GimpRGB.new(0.0, 0.0, 0.0, 1.0);

	# cw: At INIT, .pairs is still HOT during iteration, so we have to save
	#     of a stable copy before we loop.
	my @pc = %GLOBAL-COLOR.pairs;
	for @pc {
		%GLOBAL-COLOR{ .key.subst('_', '-', :g) } = .value;
	}
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
	HAS GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpAspectPreview is repr<CStruct> is export {
	HAS GimpPreview $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpProcedure is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpBatchProcedure is repr<CStruct> is export {
	HAS GimpProcedure $!parent_instance;
	has gpointer      $!priv           ;
}

# class GimpBatchProcedureClass is repr<CStruct> is export {
# 	has GimpProcedureClass $!parent_class;
# }

class GimpBrowser is repr<CStruct> is export {
	HAS GtkPaned $!parent_instance;
	has gpointer $!priv           ;
}

class GimpBusyBox is repr<CStruct> is export {
	HAS GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpButton is repr<CStruct> is export {
	HAS GtkButton $!parent_instance;
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
	HAS GtkCellRenderer $!parent_instance;
	has gpointer        $!priv           ;
}

class GimpCellRendererToggle is repr<CStruct> is export {
	HAS GtkCellRendererToggle $!parent_instance;
	has gpointer              $!priv           ;
}

class GimpChainButton is repr<CStruct> is export {
	HAS GtkGrid  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorArea is repr<CStruct> is export {
	HAS GtkDrawingArea $!parent_instance;
	has gpointer       $!priv           ;
}

class GimpColorButton is repr<CStruct> is export {
	HAS GimpButton $!parent_instance;
	has gpointer   $!priv           ;
}

class GimpColorConfig is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorDisplay is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorDisplayStack is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorHexEntry is repr<CStruct> is export {
	HAS GtkEntry $!parent_instance;
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
	HAS GtkBox                   $!parent_instance  ;
	has gpointer                 $!priv             ;
	has gboolean                 $!toggles_visible  ;
	has gboolean                 $!toggles_sensitive;
	has gboolean                 $!show_alpha       ;
	has GimpRGB                  $!rgb              ;
	has GimpHSV                  $!hsv              ;
	has GimpColorSelectorChannel $!channel          ;
}

class GimpColorNotebook is repr<CStruct> is export {
	HAS GimpColorSelector $!parent_instance;
	has gpointer          $!priv           ;
}

class GimpColorProfile is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorProfileChooserDialog is repr<CStruct> is export {
	HAS GtkFileChooserDialog $!parent_instance;
	has gpointer             $!priv           ;
}

class GimpColorProfileComboBox is repr<CStruct> is export {
	HAS GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpColorProfileStore is repr<CStruct> is export {
	HAS GtkListStore $!parent_instance;
	has gpointer     $!priv           ;
}

class GimpColorProfileView is repr<CStruct> is export {
	HAS GtkTextView $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpColorScale is repr<CStruct> is export {
	HAS GtkScale $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorSelection is repr<CStruct> is export {
	HAS GtkBox   $!parent_instance;
	has gpointer $!priv           ;
}

class GimpColorTransform is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpController is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
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
	HAS GtkDialog $!parent_instance;
	has gpointer  $!priv           ;
}

class GimpDisplay is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpScrolledPreview is repr<CStruct> is export {
	HAS GimpPreview $!parent_instance;
}

class GimpDrawablePreview is repr<CStruct> is export {
	HAS GimpScrolledPreview $!parent_instance;
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
	HAS GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpEnumComboBox is repr<CStruct> is export {
	HAS GimpIntComboBox $!parent_instance;
	has gpointer        $!priv           ;
}

class GimpEnumDesc is repr<CStruct> is export {
	has gint $.value      is rw;
	has Str  $!value_desc;
	has Str  $!value_help;
}

class GimpEnumLabel is repr<CStruct> is export {
	HAS GtkLabel $!parent_instance;
	has gpointer $!priv           ;
}

class GimpIntStore is repr<CStruct> is export {
	HAS GtkListStore $!parent_instance;
	has gpointer     $!priv           ;
}

class GimpEnumStore is repr<CStruct> is export {
	HAS GimpIntStore $!parent_instance;
	has gpointer     $!priv           ;
}

class GimpFileEntry is repr<CStruct> is export {
	HAS GtkBox   $!parent_instance;
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
	HAS GtkFrame $!parent_instance;
	has gpointer $!priv           ;
}

class GimpHSL is repr<CStruct> is export {
	has gdouble $.h is rw;
	has gdouble $.s is rw;
	has gdouble $.l is rw;
	has gdouble $.a is rw;

	method hue        is rw { $!h }
	method saturation is rw { $!s }
	method lightness  is rw { $!l }
	method alpha      is rw { $!a }
}

class GimpHintBox is repr<CStruct> is export {
	HAS GtkBox   $!parent_instance;
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
	HAS GimpFrame $!parent_instance;
}


class GimpLoadProcedure is repr<CStruct> is export {
	has GimpFileProcedure $!parent_instance;
	has gpointer          $!priv           ;
}

# class GimpLoadProcedureClass is repr<CStruct> is export {
# 	has GimpFileProcedureClass $!parent_class;
# }

class GimpMemsizeEntry is repr<CStruct> is export {
	HAS GtkBox   $!parent_instance;
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
	HAS GtkEntry $!parent_instance;
	has gpointer $!priv           ;
}

class GimpObjectArray is repr<CStruct> is export {
	has GType    $!object_type;
	has GObject  $!data       ;
	has gsize    $!length     ;
	has gboolean $!static_data;
}

class GimpOffsetArea is repr<CStruct> is export {
	HAS GtkDrawingArea $!parent_instance;
	has gpointer       $!priv           ;
}

class GimpPDB is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
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
	HAS GtkBox            $!parent_instance;
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
	HAS GtkButton $!parent_instance;
	has gpointer  $!priv           ;
}

class GimpPickButtonPrivate is repr<CStruct> is export {
	HAS GdkCursor $!cursor     ;
	has GtkWidget $!grab_widget;
}

class GimpPlugIn is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpPreviewArea is repr<CStruct> is export {
	HAS GtkDrawingArea $!parent_instance;
	has gpointer       $!priv           ;
}

class GimpProcBrowserDialog is repr<CStruct> is export {
	HAS GimpDialog $!parent_instance;
	has gpointer   $!priv           ;
}

class GimpProcedureConfig is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpProcedureDialog is repr<CStruct> is export {
	HAS GimpDialog $!parent_instance;
	has gpointer   $!priv           ;
}

class GimpProgressBar is repr<CStruct> is export {
	HAS GtkProgressBar $!parent_instance  ;
	has Str            $!progress_callback;
	has gboolean       $!cancelable       ;
}

class GimpRuler is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
	has gpointer  $!priv           ;
}

class GimpSaveProcedure is repr<CStruct> is export {
	HAS GimpFileProcedure $!parent_instance;
	has gpointer          $!priv           ;
}

# class GimpSaveProcedureClass is repr<CStruct> is export {
# 	has GimpFileProcedureClass $!parent_class;
# }

class GimpSaveProcedureDialog is repr<CStruct> is export {
	HAS GimpProcedureDialog $!parent_instance;
	has gpointer            $!priv           ;
}

class GimpSizeEntry is repr<CStruct> is export {
	HAS GtkGrid  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpSpinButton is repr<CStruct> is export {
	HAS GtkSpinButton $!parent_instance;
	has gpointer      $!priv           ;
}

class GimpSpinScale is repr<CStruct> is export {
	HAS GimpSpinButton $!parent_instance;
}

# class GimpSpinScaleClass is repr<CStruct> is export {
# 	has GimpSpinButtonClass $!parent_class;
# }

class GimpStringComboBox is repr<CStruct> is export {
	HAS GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpThumbnail is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject        $!parent_instance      ;
	has gpointer       $!priv                 ;
	has GimpThumbState $.image_state           is rw;
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

	method debug ($n?) {
		qq:to/DEBUG/
			{ self.^name } -->
			  parent_instance       => { $!parent_instance       // '»NIL«'  }
			  priv                  => { $!priv                  // '»NIL«'  }
			  image_state           => { $.image_state           // '»NIL«'  }
			  image_uri             => { $!image_uri             // '»NIL«'  }
			  image_filename        => { $!image_filename        // '»NIL«'  }
			  image_filesize        => { $.image_filesize        // '»NIL«'  }
			  image_mtime           => { $.image_mtime           // '»NIL«'  }
			  image_not_found_errno => { $.image_not_found_errno // '»NIL«'  }
			  image_width           => { $.image_width           // '»NIL«'  }
			  image_height          => { $.image_height          // '»NIL«'  }
			  image_type            => { $!image_type            // '»NIL«'  }
			  image_num_layers      => { $.image_num_layers      // '»NIL«'  }
			  thumb_state           => { $!thumb_state           // '»NIL«'  }
			  thumb_size            => { $!thumb_size            // '»NIL«'  }
			  thumb_filename        => { $!thumb_filename        // '»NIL«'  }
			  thumb_filesize        => { $.thumb_filesize        // '»NIL«'  }
			  thumb_mtime           => { $.thumb_mtime           // '»NIL«'  }
			  image_mimetype        => { $!image_mimetype        // '»NIL«'  }
			DEBUG
	}
}

class GimpThumbnailProcedure is repr<CStruct> is export {
	HAS GimpProcedure $!parent_instance;
	has gpointer      $!priv           ;
}

# class GimpThumbnailProcedureClass is repr<CStruct> is export {
# 	has GimpProcedureClass $!parent_class;
# }

class GimpTileBackendPlugin is repr<CStruct> is export {
	HAS GeglTileBackend $!parent_instance;
	has gpointer        $!priv           ;
}

# class GimpTileBackendPluginClass is repr<CStruct> is export {
# 	has GeglTileBackendClass $!parent_class;
# }

class GimpUnitComboBox is repr<CStruct> is export {
	HAS GtkComboBox $!parent_instance;
	has gpointer    $!priv           ;
}

class GimpUnitStore is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpWireMessage is repr<CStruct> is export {
	has guint32  $.type is rw;
	has gpointer $!data;
}

class GimpZoomModel is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!priv           ;
}

class GimpZoomPreview is repr<CStruct> is export {
	HAS GimpScrolledPreview $!parent_instance;
	has gpointer            $!priv           ;
}
