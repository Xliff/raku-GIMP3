use v6.c;

use GLib::Raw::Definitions;
use GIMP::Raw::Definitions;

unit package GIMP::Raw::Enums;

class GPConfig is repr<CStruct> is export {
	has guint32 $!tile_width          ;
	has guint32 $!tile_height         ;
	has gint32  $!shm_id              ;
	has gint8   $!check_size          ;
	has gint8   $!check_type          ;
	has gint8   $!show_help_button    ;
	has gint8   $!use_cpu_accel       ;
	has gint8   $!use_opencl          ;
	has gint8   $!export_color_profile;
	has gint8   $!export_comment      ;
	has gint8   $!export_exif         ;
	has gint8   $!export_xmp          ;
	has gint8   $!export_iptc         ;
	has gint32  $!default_display_id  ;
	has gchar   $!app_name            ;
	has gchar   $!wm_class            ;
	has gchar   $!display_name        ;
	has gint32  $!monitor_number      ;
	has guint32 $!timestamp           ;
	has gchar   $!icon_theme_dir      ;
	has guint64 $!tile_cache_size     ;
	has gchar   $!swap_path           ;
	has gchar   $!swap_compression    ;
	has gint32  $!num_processors      ;
	has GimpRGB $!check_custom_color1 ;
	has GimpRGB $!check_custom_color2 ;
}

class GPParamArray is repr<CStruct> is export {
	has guint32 $!size;
	has guint8  $!data;
}

class GPParamDefBoolean is repr<CStruct> is export {
	has gint32 $!default_val;
}

class GPParamDefColor is repr<CStruct> is export {
	has gint32  $!has_alpha  ;
	has GimpRGB $!default_val;
}

class GPParamDefEnum is repr<CStruct> is export {
	has gint32 $!default_val;
}

class GPParamDefFloat is repr<CStruct> is export {
	has gdouble $!min_val    ;
	has gdouble $!max_val    ;
	has gdouble $!default_val;
}

class GPParamDefID is repr<CStruct> is export {
	has gint32 $!none_ok;
}

class GPParamDefIDArray is repr<CStruct> is export {
	has gchar $!type_name;
}

class GPParamDefInt is repr<CStruct> is export {
	has gint64 $!min_val    ;
	has gint64 $!max_val    ;
	has gint64 $!default_val;
}

class GPParamDefString is repr<CStruct> is export {
	has gchar $!default_val;
}

class GPParamDefUnit is repr<CStruct> is export {
	has gint32 $!allow_pixels ;
	has gint32 $!allow_percent;
	has gint32 $!default_val  ;
}

class GPParamIDArray is repr<CStruct> is export {
	has gchar   $!type_name;
	has guint32 $!size     ;
	has gint32  $!data     ;
}

class GPProcInstall is repr<CStruct> is export {
	has gchar      $!name         ;
	has guint32    $!type         ;
	has guint32    $!n_params     ;
	has guint32    $!n_return_vals;
	has GPParamDef $!params       ;
	has GPParamDef $!return_vals  ;
}

class GPProcReturn is repr<CStruct> is export {
	has gchar   $!name    ;
	has guint32 $!n_params;
	has GPParam $!params  ;
}

class GPProcRun is repr<CStruct> is export {
	has gchar   $!name    ;
	has guint32 $!n_params;
	has GPParam $!params  ;
}

class GPProcUninstall is repr<CStruct> is export {
	has gchar $!name;
}

class GPTileData is repr<CStruct> is export {
	has gint32  $!drawable_id;
	has guint32 $!tile_num   ;
	has guint32 $!shadow     ;
	has guint32 $!bpp        ;
	has guint32 $!width      ;
	has guint32 $!height     ;
	has guint32 $!use_shm    ;
	has guchar  $!data       ;
}

class GPTileReq is repr<CStruct> is export {
	has gint32  $!drawable_id;
	has guint32 $!tile_num   ;
	has guint32 $!shadow     ;
}

class GimpArray is repr<CStruct> is export {
	has guint8   $!data       ;
	has gsize    $!length     ;
	has gboolean $!static_data;
}

class GimpAspectPreview is repr<CStruct> is export {
	has GimpPreview              $!parent_instance;
	has GimpAspectPreviewPrivate $!priv           ;
}

class GimpBatchProcedure is repr<CStruct> is export {
	has GimpProcedure             $!parent_instance;
	has GimpBatchProcedurePrivate $!priv           ;
}

class GimpBatchProcedureClass is repr<CStruct> is export {
	has GimpProcedureClass $!parent_class;
}

class GimpBrowser is repr<CStruct> is export {
	has GtkPaned           $!parent_instance;
	has GimpBrowserPrivate $!priv           ;
}

class GimpBusyBox is repr<CStruct> is export {
	has GtkBox             $!parent_instance;
	has GimpBusyBoxPrivate $!priv           ;
}

class GimpButton is repr<CStruct> is export {
	has GtkButton         $!parent_instance;
	has GimpButtonPrivate $!priv           ;
}

class GimpCMYK is repr<CStruct> is export {
	has gdouble $!c;
	has gdouble $!m;
	has gdouble $!y;
	has gdouble $!k;
	has gdouble $!a;
}

class GimpCellRendererColor is repr<CStruct> is export {
	has GtkCellRenderer              $!parent_instance;
	has GimpCellRendererColorPrivate $!priv           ;
}

class GimpCellRendererToggle is repr<CStruct> is export {
	has GtkCellRendererToggle         $!parent_instance;
	has GimpCellRendererTogglePrivate $!priv           ;
}

class GimpChainButton is repr<CStruct> is export {
	has GtkGrid                $!parent_instance;
	has GimpChainButtonPrivate $!priv           ;
}

class GimpColorArea is repr<CStruct> is export {
	has GtkDrawingArea       $!parent_instance;
	has GimpColorAreaPrivate $!priv           ;
}

class GimpColorButton is repr<CStruct> is export {
	has GimpButton             $!parent_instance;
	has GimpColorButtonPrivate $!priv           ;
}

class GimpColorConfig is repr<CStruct> is export {
	has GObject                $!parent_instance;
	has GimpColorConfigPrivate $!priv           ;
}

class GimpColorDisplay is repr<CStruct> is export {
	has GObject                 $!parent_instance;
	has GimpColorDisplayPrivate $!priv           ;
}

class GimpColorDisplayStack is repr<CStruct> is export {
	has GObject                      $!parent_instance;
	has GimpColorDisplayStackPrivate $!priv           ;
}

class GimpColorHexEntry is repr<CStruct> is export {
	has GtkEntry                 $!parent_instance;
	has GimpColorHexEntryPrivate $!priv           ;
}

class GimpColorNotebook is repr<CStruct> is export {
	has GimpColorSelector        $!parent_instance;
	has GimpColorNotebookPrivate $!priv           ;
}

class GimpColorProfile is repr<CStruct> is export {
	has GObject                 $!parent_instance;
	has GimpColorProfilePrivate $!priv           ;
}

class GimpColorProfileChooserDialog is repr<CStruct> is export {
	has GtkFileChooserDialog                 $!parent_instance;
	has GimpColorProfileChooserDialogPrivate $!priv           ;
}

class GimpColorProfileComboBox is repr<CStruct> is export {
	has GtkComboBox                     $!parent_instance;
	has GimpColorProfileComboBoxPrivate $!priv           ;
}

class GimpColorProfileStore is repr<CStruct> is export {
	has GtkListStore                 $!parent_instance;
	has GimpColorProfileStorePrivate $!priv           ;
}

class GimpColorProfileView is repr<CStruct> is export {
	has GtkTextView                 $!parent_instance;
	has GimpColorProfileViewPrivate $!priv           ;
}

class GimpColorScale is repr<CStruct> is export {
	has GtkScale              $!parent_instance;
	has GimpColorScalePrivate $!priv           ;
}

class GimpColorSelection is repr<CStruct> is export {
	has GtkBox                    $!parent_instance;
	has GimpColorSelectionPrivate $!priv           ;
}

class GimpColorSelector is repr<CStruct> is export {
	has GtkBox                   $!parent_instance  ;
	has GimpColorSelectorPrivate $!priv             ;
	has gboolean                 $!toggles_visible  ;
	has gboolean                 $!toggles_sensitive;
	has gboolean                 $!show_alpha       ;
	has GimpRGB                  $!rgb              ;
	has GimpHSV                  $!hsv              ;
	has GimpColorSelectorChannel $!channel          ;
}

class GimpColorTransform is repr<CStruct> is export {
	has GObject                   $!parent_instance;
	has GimpColorTransformPrivate $!priv           ;
}

class GimpController is repr<CStruct> is export {
	has GObject               $!parent_instance;
	has GimpControllerPrivate $!priv           ;
	has gchar                 $!name           ;
	has gchar                 $!state          ;
}

class GimpControllerEventAny is repr<CStruct> is export {
	has GimpControllerEventType $!type    ;
	has GimpController          $!source  ;
	has gint                    $!event_id;
}

class GimpControllerEventTrigger is repr<CStruct> is export {
	has GimpControllerEventType $!type    ;
	has GimpController          $!source  ;
	has gint                    $!event_id;
}

class GimpControllerEventValue is repr<CStruct> is export {
	has GimpControllerEventType $!type    ;
	has GimpController          $!source  ;
	has gint                    $!event_id;
	has GValue                  $!value   ;
}

class GimpDialog is repr<CStruct> is export {
	has GtkDialog         $!parent_instance;
	has GimpDialogPrivate $!priv           ;
}

class GimpDisplay is repr<CStruct> is export {
	has GObject            $!parent_instance;
	has GimpDisplayPrivate $!priv           ;
}

class GimpDrawablePreview is repr<CStruct> is export {
	has GimpScrolledPreview        $!parent_instance;
	has GimpDrawablePreviewPrivate $!priv           ;
}

class GimpEevlOptions is repr<CStruct> is export {
	has GimpEevlUnitResolverProc $!unit_resolver_proc;
	has gpointer                 $!data              ;
	has gboolean                 $!ratio_expressions ;
	has gboolean                 $!ratio_invert      ;
	has GimpEevlQuantity         $!ratio_quantity    ;
}

class GimpEevlQuantity is repr<CStruct> is export {
	has gdouble $!value    ;
	has gint    $!dimension;
}

class GimpEnumComboBox is repr<CStruct> is export {
	has GimpIntComboBox         $!parent_instance;
	has GimpEnumComboBoxPrivate $!priv           ;
}

class GimpEnumDesc is repr<CStruct> is export {
	has gint  $!value     ;
	has gchar $!value_desc;
	has gchar $!value_help;
}

class GimpEnumLabel is repr<CStruct> is export {
	has GtkLabel             $!parent_instance;
	has GimpEnumLabelPrivate $!priv           ;
}

class GimpEnumStore is repr<CStruct> is export {
	has GimpIntStore         $!parent_instance;
	has GimpEnumStorePrivate $!priv           ;
}

class GimpFileEntry is repr<CStruct> is export {
	has GtkBox               $!parent_instance;
	has GimpFileEntryPrivate $!priv           ;
}

class GimpFileProcedure is repr<CStruct> is export {
	has GimpProcedure            $!parent_instance;
	has GimpFileProcedurePrivate $!priv           ;
}

class GimpFileProcedureClass is repr<CStruct> is export {
	has GimpProcedureClass $!parent_class;
}

class GimpFlagsDesc is repr<CStruct> is export {
	has guint $!value     ;
	has gchar $!value_desc;
	has gchar $!value_help;
}

class GimpFrame is repr<CStruct> is export {
	has GtkFrame         $!parent_instance;
	has GimpFramePrivate $!priv           ;
}

class GimpHSL is repr<CStruct> is export {
	has gdouble $!h;
	has gdouble $!s;
	has gdouble $!l;
	has gdouble $!a;
}

class GimpHSV is repr<CStruct> is export {
	has gdouble $!h;
	has gdouble $!s;
	has gdouble $!v;
	has gdouble $!a;
}

class GimpHintBox is repr<CStruct> is export {
	has GtkBox             $!parent_instance;
	has GimpHintBoxPrivate $!priv           ;
}

class GimpImageProcedure is repr<CStruct> is export {
	has GimpProcedure             $!parent_instance;
	has GimpImageProcedurePrivate $!priv           ;
}

class GimpImageProcedureClass is repr<CStruct> is export {
	has GimpProcedureClass $!parent_class;
}

class GimpIntComboBox is repr<CStruct> is export {
	has GtkComboBox            $!parent_instance;
	has GimpIntComboBoxPrivate $!priv           ;
}

class GimpIntRadioFrame is repr<CStruct> is export {
	has GimpFrame $!parent_instance;
}

class GimpIntStore is repr<CStruct> is export {
	has GtkListStore        $!parent_instance;
	has GimpIntStorePrivate $!priv           ;
}

class GimpLoadProcedure is repr<CStruct> is export {
	has GimpFileProcedure        $!parent_instance;
	has GimpLoadProcedurePrivate $!priv           ;
}

class GimpLoadProcedureClass is repr<CStruct> is export {
	has GimpFileProcedureClass $!parent_class;
}

class GimpMemsizeEntry is repr<CStruct> is export {
	has GtkBox                  $!parent_instance;
	has GimpMemsizeEntryPrivate $!priv           ;
}

class GimpModule is repr<CStruct> is export {
	has GTypeModule       $!parent_instance;
	has GimpModulePrivate $!priv           ;
}

class GimpModuleInfo is repr<CStruct> is export {
	has guint32 $!abi_version;
	has gchar   $!purpose    ;
	has gchar   $!author     ;
	has gchar   $!version    ;
	has gchar   $!copyright  ;
	has gchar   $!date       ;
}

class GimpNumberPairEntry is repr<CStruct> is export {
	has GtkEntry                   $!parent_instance;
	has GimpNumberPairEntryPrivate $!priv           ;
}

class GimpObjectArray is repr<CStruct> is export {
	has GType    $!object_type;
	has GObject  $!data       ;
	has gsize    $!length     ;
	has gboolean $!static_data;
}

class GimpOffsetArea is repr<CStruct> is export {
	has GtkDrawingArea        $!parent_instance;
	has GimpOffsetAreaPrivate $!priv           ;
}

class GimpPDB is repr<CStruct> is export {
	has GObject        $!parent_instance;
	has GimpPDBPrivate $!priv           ;
}

class GimpPDBProcedure is repr<CStruct> is export {
	has GimpProcedure           $!parent_instance;
	has GimpPDBProcedurePrivate $!priv           ;
}

class GimpPDBProcedureClass is repr<CStruct> is export {
	has GimpProcedureClass $!parent_class;
}

class GimpPageSelector is repr<CStruct> is export {
	has GtkBox                  $!parent_instance;
	has GimpPageSelectorPrivate $!priv           ;
}

class GimpParamSpecArray is repr<CStruct> is export {
	has GParamSpecBoxed $!parent_instance;
}

class GimpParamSpecBrush is repr<CStruct> is export {
	has GimpParamSpecResource $!parent_instance;
}

class GimpParamSpecChannel is repr<CStruct> is export {
	has GimpParamSpecDrawable $!parent_instance;
}

class GimpParamSpecDisplay is repr<CStruct> is export {
	has GParamSpecObject $!parent_instance;
	has gboolean         $!none_ok        ;
}

class GimpParamSpecDrawable is repr<CStruct> is export {
	has GimpParamSpecItem $!parent_instance;
}

class GimpParamSpecFloatArray is repr<CStruct> is export {
	has GimpParamSpecArray $!parent_instance;
}

class GimpParamSpecFont is repr<CStruct> is export {
	has GimpParamSpecResource $!parent_instance;
}

class GimpParamSpecGradient is repr<CStruct> is export {
	has GimpParamSpecResource $!parent_instance;
}

class GimpParamSpecImage is repr<CStruct> is export {
	has GParamSpecObject $!parent_instance;
	has gboolean         $!none_ok        ;
}

class GimpParamSpecItem is repr<CStruct> is export {
	has GParamSpecObject $!parent_instance;
	has gboolean         $!none_ok        ;
}

class GimpParamSpecLayer is repr<CStruct> is export {
	has GimpParamSpecDrawable $!parent_instance;
}

class GimpParamSpecLayerMask is repr<CStruct> is export {
	has GimpParamSpecChannel $!parent_instance;
}

class GimpParamSpecObjectArray is repr<CStruct> is export {
	has GParamSpecBoxed $!parent_instance;
	has GType           $!object_type    ;
}

class GimpParamSpecPalette is repr<CStruct> is export {
	has GimpParamSpecResource $!parent_instance;
}

class GimpParamSpecPattern is repr<CStruct> is export {
	has GimpParamSpecResource $!parent_instance;
}

class GimpParamSpecRGBArray is repr<CStruct> is export {
	has GParamSpecBoxed $!parent_instance;
}

class GimpParamSpecResource is repr<CStruct> is export {
	has GParamSpecObject $!parent_instance;
	has gboolean         $!none_ok        ;
}

class GimpParamSpecSelection is repr<CStruct> is export {
	has GimpParamSpecChannel $!parent_instance;
}

class GimpParamSpecTextLayer is repr<CStruct> is export {
	has GimpParamSpecLayer $!parent_instance;
}

class GimpParamSpecUnit is repr<CStruct> is export {
	has GParamSpecInt $!parent_instance;
	has gboolean      $!allow_percent  ;
}

class GimpParamSpecValueArray is repr<CStruct> is export {
	has GParamSpec $!parent_instance ;
	has GParamSpec $!element_spec    ;
	has gint       $!fixed_n_elements;
}

class GimpParamSpecVectors is repr<CStruct> is export {
	has GimpParamSpecItem $!parent_instance;
}

class GimpParasite is repr<CStruct> is export {
	has gchar    $!name ;
	has guint32  $!flags;
	has guint32  $!size ;
	has gpointer $!data ;
}

class GimpPathEditor is repr<CStruct> is export {
	has GtkBox                $!parent_instance;
	has GimpPathEditorPrivate $!priv           ;
	has GtkWidget             $!upper_hbox     ;
	has GtkWidget             $!new_button     ;
	has GtkWidget             $!up_button      ;
	has GtkWidget             $!down_button    ;
	has GtkWidget             $!delete_button  ;
	has GtkWidget             $!file_entry     ;
	has GtkListStore          $!dir_list       ;
	has GtkTreeSelection      $!sel            ;
	has GtkTreePath           $!sel_path       ;
	has GtkTreeViewColumn     $!writable_column;
	has gint                  $!num_items      ;
}

class GimpPickButton is repr<CStruct> is export {
	has GtkButton             $!parent_instance;
	has GimpPickButtonPrivate $!priv           ;
}

class GimpPickButtonPrivate is repr<CStruct> is export {
	has GdkCursor $!cursor     ;
	has GtkWidget $!grab_widget;
}

class GimpPlugIn is repr<CStruct> is export {
	has GObject           $!parent_instance;
	has GimpPlugInPrivate $!priv           ;
}

class GimpPreview is repr<CStruct> is export {
	has GtkBox             $!parent_instance;
	has GimpPreviewPrivate $!priv           ;
}

class GimpPreviewArea is repr<CStruct> is export {
	has GtkDrawingArea         $!parent_instance;
	has GimpPreviewAreaPrivate $!priv           ;
}

class GimpProcBrowserDialog is repr<CStruct> is export {
	has GimpDialog                   $!parent_instance;
	has GimpProcBrowserDialogPrivate $!priv           ;
}

class GimpProcedure is repr<CStruct> is export {
	has GObject              $!parent_instance;
	has GimpProcedurePrivate $!priv           ;
}

class GimpProcedureConfig is repr<CStruct> is export {
	has GObject                    $!parent_instance;
	has GimpProcedureConfigPrivate $!priv           ;
}

class GimpProcedureDialog is repr<CStruct> is export {
	has GimpDialog                 $!parent_instance;
	has GimpProcedureDialogPrivate $!priv           ;
}

class GimpProgressBar is repr<CStruct> is export {
	has GtkProgressBar $!parent_instance  ;
	has gchar          $!progress_callback;
	has gboolean       $!cancelable       ;
}

class GimpRGB is repr<CStruct> is export {
	has gdouble $!r;
	has gdouble $!g;
	has gdouble $!b;
	has gdouble $!a;
}

class GimpRuler is repr<CStruct> is export {
	has GtkWidget        $!parent_instance;
	has GimpRulerPrivate $!priv           ;
}

class GimpSaveProcedure is repr<CStruct> is export {
	has GimpFileProcedure        $!parent_instance;
	has GimpSaveProcedurePrivate $!priv           ;
}

class GimpSaveProcedureClass is repr<CStruct> is export {
	has GimpFileProcedureClass $!parent_class;
}

class GimpSaveProcedureDialog is repr<CStruct> is export {
	has GimpProcedureDialog            $!parent_instance;
	has GimpSaveProcedureDialogPrivate $!priv           ;
}

class GimpScrolledPreview is repr<CStruct> is export {
	has GimpPreview $!parent_instance;
}

class GimpSizeEntry is repr<CStruct> is export {
	has GtkGrid              $!parent_instance;
	has GimpSizeEntryPrivate $!priv           ;
}

class GimpSpinButton is repr<CStruct> is export {
	has GtkSpinButton         $!parent_instance;
	has GimpSpinButtonPrivate $!priv           ;
}

class GimpSpinScale is repr<CStruct> is export {
	has GimpSpinButton $!parent_instance;
}

class GimpSpinScaleClass is repr<CStruct> is export {
	has GimpSpinButtonClass $!parent_class;
}

class GimpStringComboBox is repr<CStruct> is export {
	has GtkComboBox               $!parent_instance;
	has GimpStringComboBoxPrivate $!priv           ;
}

class GimpThumbnail is repr<CStruct> is export {
	has GObject              $!parent_instance      ;
	has GimpThumbnailPrivate $!priv                 ;
	has GimpThumbState       $!image_state          ;
	has gchar                $!image_uri            ;
	has gchar                $!image_filename       ;
	has gint64               $!image_filesize       ;
	has gint64               $!image_mtime          ;
	has gint                 $!image_not_found_errno;
	has gint                 $!image_width          ;
	has gint                 $!image_height         ;
	has gchar                $!image_type           ;
	has gint                 $!image_num_layers     ;
	has GimpThumbState       $!thumb_state          ;
	has GimpThumbSize        $!thumb_size           ;
	has gchar                $!thumb_filename       ;
	has gint64               $!thumb_filesize       ;
	has gint64               $!thumb_mtime          ;
	has gchar                $!image_mimetype       ;
}

class GimpThumbnailProcedure is repr<CStruct> is export {
	has GimpProcedure                 $!parent_instance;
	has GimpThumbnailProcedurePrivate $!priv           ;
}

class GimpThumbnailProcedureClass is repr<CStruct> is export {
	has GimpProcedureClass $!parent_class;
}

class GimpTileBackendPlugin is repr<CStruct> is export {
	has GeglTileBackend              $!parent_instance;
	has GimpTileBackendPluginPrivate $!priv           ;
}

class GimpTileBackendPluginClass is repr<CStruct> is export {
	has GeglTileBackendClass $!parent_class;
}

class GimpUnitComboBox is repr<CStruct> is export {
	has GtkComboBox             $!parent_instance;
	has GimpUnitComboBoxPrivate $!priv           ;
}

class GimpUnitStore is repr<CStruct> is export {
	has GObject              $!parent_instance;
	has GimpUnitStorePrivate $!priv           ;
}

class GimpWireMessage is repr<CStruct> is export {
	has guint32  $!type;
	has gpointer $!data;
}

class GimpZoomModel is repr<CStruct> is export {
	has GObject              $!parent_instance;
	has GimpZoomModelPrivate $!priv           ;
}

class GimpZoomPreview is repr<CStruct> is export {
	has GimpScrolledPreview    $!parent_instance;
	has GimpZoomPreviewPrivate $!priv           ;
}
