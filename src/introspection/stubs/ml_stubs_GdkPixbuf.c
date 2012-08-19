#include <caml/mlvalues.h>
#include <caml/alloc.h>
#define Val_double(val) caml_copy_double(val)
#define Val_string_new(val) caml_copy_string(val)
#define Val_int32(val) caml_copy_int32(val)
#define Val_int32_new(val) caml_copy_int32(val)
/* conversion for record 'GArray' */
#define GArray_val(val) ((GArray*)val)
/* conversion for record 'GAsyncQueue' */
#define GAsyncQueue_val(val) ((GAsyncQueue*)val)
/* conversion for record 'GBookmarkFile' */
#define GBookmarkFile_val(val) ((GBookmarkFile*)val)
/* conversion for record 'GByteArray' */
#define GByteArray_val(val) ((GByteArray*)val)
/* conversion for record 'GBytes' */
#define GBytes_val(val) ((GBytes*)val)
/* conversion for record 'GChecksum' */
#define GChecksum_val(val) ((GChecksum*)val)
/* conversion for record 'GCond' */
#define GCond_val(val) ((GCond*)val)
/* conversion for record 'GData' */
#define GData_val(val) ((GData*)val)
/* conversion for record 'GDate' */
#define GDate_val(val) ((GDate*)val)
/* conversion for record 'GDateTime' */
#define GDateTime_val(val) ((GDateTime*)val)
/* conversion for record 'GDebugKey' */
#define GDebugKey_val(val) ((GDebugKey*)val)
/* conversion for record 'GDir' */
#define GDir_val(val) ((GDir*)val)
/* conversion for record 'GError' */
#define GError_val(val) ((GError*)val)
/* conversion for record 'GHashTable' */
#define GHashTable_val(val) ((GHashTable*)val)
/* conversion for record 'GHashTableIter' */
#define GHashTableIter_val(val) ((GHashTableIter*)val)
/* conversion for record 'GHmac' */
#define GHmac_val(val) ((GHmac*)val)
/* conversion for record 'GHook' */
#define GHook_val(val) ((GHook*)val)
/* conversion for record 'GHookList' */
#define GHookList_val(val) ((GHookList*)val)
/* conversion for record 'GIConv' */
#define GIConv_val(val) ((GIConv*)val)
/* conversion for record 'GIOChannel' */
#define GIOChannel_val(val) ((GIOChannel*)val)
/* conversion for record 'GIOFuncs' */
#define GIOFuncs_val(val) ((GIOFuncs*)val)
/* conversion for record 'GKeyFile' */
#define GKeyFile_val(val) ((GKeyFile*)val)
/* conversion for record 'GList' */
#define GList_val(val) ((GList*)val)
/* conversion for record 'GMainContext' */
#define GMainContext_val(val) ((GMainContext*)val)
/* conversion for record 'GMainLoop' */
#define GMainLoop_val(val) ((GMainLoop*)val)
/* conversion for record 'GMappedFile' */
#define GMappedFile_val(val) ((GMappedFile*)val)
/* conversion for record 'GMarkupParseContext' */
#define GMarkupParseContext_val(val) ((GMarkupParseContext*)val)
/* conversion for record 'GMarkupParser' */
#define GMarkupParser_val(val) ((GMarkupParser*)val)
/* conversion for record 'GMatchInfo' */
#define GMatchInfo_val(val) ((GMatchInfo*)val)
/* conversion for record 'GMemVTable' */
#define GMemVTable_val(val) ((GMemVTable*)val)
/* conversion for record 'GNode' */
#define GNode_val(val) ((GNode*)val)
/* conversion for record 'GOnce' */
#define GOnce_val(val) ((GOnce*)val)
/* conversion for record 'GOptionContext' */
#define GOptionContext_val(val) ((GOptionContext*)val)
/* conversion for record 'GOptionEntry' */
#define GOptionEntry_val(val) ((GOptionEntry*)val)
/* conversion for record 'GOptionGroup' */
#define GOptionGroup_val(val) ((GOptionGroup*)val)
/* conversion for record 'GPatternSpec' */
#define GPatternSpec_val(val) ((GPatternSpec*)val)
/* conversion for record 'GPollFD' */
#define GPollFD_val(val) ((GPollFD*)val)
/* conversion for record 'GPrivate' */
#define GPrivate_val(val) ((GPrivate*)val)
/* conversion for record 'GPtrArray' */
#define GPtrArray_val(val) ((GPtrArray*)val)
/* conversion for record 'GQueue' */
#define GQueue_val(val) ((GQueue*)val)
/* conversion for record 'GRWLock' */
#define GRWLock_val(val) ((GRWLock*)val)
/* conversion for record 'GRand' */
#define GRand_val(val) ((GRand*)val)
/* conversion for record 'GRecMutex' */
#define GRecMutex_val(val) ((GRecMutex*)val)
/* conversion for record 'GRegex' */
#define GRegex_val(val) ((GRegex*)val)
/* conversion for record 'GSList' */
#define GSList_val(val) ((GSList*)val)
/* conversion for record 'GScanner' */
#define GScanner_val(val) ((GScanner*)val)
/* conversion for record 'GScannerConfig' */
#define GScannerConfig_val(val) ((GScannerConfig*)val)
/* conversion for record 'GSequence' */
#define GSequence_val(val) ((GSequence*)val)
/* conversion for record 'GSequenceIter' */
#define GSequenceIter_val(val) ((GSequenceIter*)val)
/* conversion for record 'GSource' */
#define GSource_val(val) ((GSource*)val)
/* conversion for record 'GSourceCallbackFuncs' */
#define GSourceCallbackFuncs_val(val) ((GSourceCallbackFuncs*)val)
/* conversion for record 'GSourceFuncs' */
#define GSourceFuncs_val(val) ((GSourceFuncs*)val)
/* conversion for record 'GSourcePrivate' */
#define GSourcePrivate_val(val) ((GSourcePrivate*)val)
/* conversion for record 'GStatBuf' */
#define GStatBuf_val(val) ((GStatBuf*)val)
/* conversion for record 'GString' */
#define GString_val(val) ((GString*)val)
/* conversion for record 'GStringChunk' */
#define GStringChunk_val(val) ((GStringChunk*)val)
/* conversion for record 'GTestCase' */
#define GTestCase_val(val) ((GTestCase*)val)
/* conversion for record 'GTestConfig' */
#define GTestConfig_val(val) ((GTestConfig*)val)
/* conversion for record 'GTestLogBuffer' */
#define GTestLogBuffer_val(val) ((GTestLogBuffer*)val)
/* conversion for record 'GTestLogMsg' */
#define GTestLogMsg_val(val) ((GTestLogMsg*)val)
/* conversion for record 'GTestSuite' */
#define GTestSuite_val(val) ((GTestSuite*)val)
/* conversion for record 'GThread' */
#define GThread_val(val) ((GThread*)val)
/* conversion for record 'GThreadPool' */
#define GThreadPool_val(val) ((GThreadPool*)val)
/* conversion for record 'GTimeVal' */
#define GTimeVal_val(val) ((GTimeVal*)val)
/* conversion for record 'GTimeZone' */
#define GTimeZone_val(val) ((GTimeZone*)val)
/* conversion for record 'GTimer' */
#define GTimer_val(val) ((GTimer*)val)
/* conversion for record 'GTrashStack' */
#define GTrashStack_val(val) ((GTrashStack*)val)
/* conversion for record 'GTree' */
#define GTree_val(val) ((GTree*)val)
/* conversion for record 'GVariant' */
#define GVariant_val(val) ((GVariant*)val)
/* conversion for record 'GVariantBuilder' */
#define GVariantBuilder_val(val) ((GVariantBuilder*)val)
/* conversion for record 'GVariantIter' */
#define GVariantIter_val(val) ((GVariantIter*)val)
/* conversion for record 'GVariantType' */
#define GVariantType_val(val) ((GVariantType*)val)
#define GBinding_val(val) check_cast(G_BINDING,val)
#define Val_GBinding(val) Val_GObject((GObject*)val)
#define Val_GBinding_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GCClosure' */
#define GCClosure_val(val) ((GCClosure*)val)
/* conversion for record 'GClosure' */
#define GClosure_val(val) ((GClosure*)val)
/* conversion for record 'GClosureNotifyData' */
#define GClosureNotifyData_val(val) ((GClosureNotifyData*)val)
/* conversion for record 'GEnumClass' */
#define GEnumClass_val(val) ((GEnumClass*)val)
/* conversion for record 'GEnumValue' */
#define GEnumValue_val(val) ((GEnumValue*)val)
/* conversion for record 'GFlagsClass' */
#define GFlagsClass_val(val) ((GFlagsClass*)val)
/* conversion for record 'GFlagsValue' */
#define GFlagsValue_val(val) ((GFlagsValue*)val)
#define GInitiallyUnowned_val(val) check_cast(G_INITIALLY_UNOWNED,val)
#define Val_GInitiallyUnowned(val) Val_GObject((GObject*)val)
#define Val_GInitiallyUnowned_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GInitiallyUnownedClass' */
#define GInitiallyUnownedClass_val(val) ((GInitiallyUnownedClass*)val)
/* conversion for record 'GInterfaceInfo' */
#define GInterfaceInfo_val(val) ((GInterfaceInfo*)val)
/* conversion for record 'GObjectClass' */
#define GObjectClass_val(val) ((GObjectClass*)val)
/* conversion for record 'GObjectConstructParam' */
#define GObjectConstructParam_val(val) ((GObjectConstructParam*)val)
#define GParamSpec_val(val) check_cast(G_PARAM_SPEC,val)
#define Val_GParamSpec(val) Val_GObject((GObject*)val)
#define Val_GParamSpec_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecBoolean_val(val) check_cast(G_PARAM_SPEC_BOOLEAN,val)
#define Val_GParamSpecBoolean(val) Val_GObject((GObject*)val)
#define Val_GParamSpecBoolean_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecBoxed_val(val) check_cast(G_PARAM_SPEC_BOXED,val)
#define Val_GParamSpecBoxed(val) Val_GObject((GObject*)val)
#define Val_GParamSpecBoxed_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecChar_val(val) check_cast(G_PARAM_SPEC_CHAR,val)
#define Val_GParamSpecChar(val) Val_GObject((GObject*)val)
#define Val_GParamSpecChar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GParamSpecClass' */
#define GParamSpecClass_val(val) ((GParamSpecClass*)val)
#define GParamSpecDouble_val(val) check_cast(G_PARAM_SPEC_DOUBLE,val)
#define Val_GParamSpecDouble(val) Val_GObject((GObject*)val)
#define Val_GParamSpecDouble_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecEnum_val(val) check_cast(G_PARAM_SPEC_ENUM,val)
#define Val_GParamSpecEnum(val) Val_GObject((GObject*)val)
#define Val_GParamSpecEnum_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecFlags_val(val) check_cast(G_PARAM_SPEC_FLAGS,val)
#define Val_GParamSpecFlags(val) Val_GObject((GObject*)val)
#define Val_GParamSpecFlags_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecFloat_val(val) check_cast(G_PARAM_SPEC_FLOAT,val)
#define Val_GParamSpecFloat(val) Val_GObject((GObject*)val)
#define Val_GParamSpecFloat_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecGType_val(val) check_cast(G_PARAM_SPEC_G_TYPE,val)
#define Val_GParamSpecGType(val) Val_GObject((GObject*)val)
#define Val_GParamSpecGType_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecInt_val(val) check_cast(G_PARAM_SPEC_INT,val)
#define Val_GParamSpecInt(val) Val_GObject((GObject*)val)
#define Val_GParamSpecInt_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecInt64_val(val) check_cast(G_PARAM_SPEC_INT64,val)
#define Val_GParamSpecInt64(val) Val_GObject((GObject*)val)
#define Val_GParamSpecInt64_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecLong_val(val) check_cast(G_PARAM_SPEC_LONG,val)
#define Val_GParamSpecLong(val) Val_GObject((GObject*)val)
#define Val_GParamSpecLong_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecObject_val(val) check_cast(G_PARAM_SPEC_OBJECT,val)
#define Val_GParamSpecObject(val) Val_GObject((GObject*)val)
#define Val_GParamSpecObject_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecOverride_val(val) check_cast(G_PARAM_SPEC_OVERRIDE,val)
#define Val_GParamSpecOverride(val) Val_GObject((GObject*)val)
#define Val_GParamSpecOverride_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecParam_val(val) check_cast(G_PARAM_SPEC_PARAM,val)
#define Val_GParamSpecParam(val) Val_GObject((GObject*)val)
#define Val_GParamSpecParam_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecPointer_val(val) check_cast(G_PARAM_SPEC_POINTER,val)
#define Val_GParamSpecPointer(val) Val_GObject((GObject*)val)
#define Val_GParamSpecPointer_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GParamSpecPool' */
#define GParamSpecPool_val(val) ((GParamSpecPool*)val)
#define GParamSpecString_val(val) check_cast(G_PARAM_SPEC_STRING,val)
#define Val_GParamSpecString(val) Val_GObject((GObject*)val)
#define Val_GParamSpecString_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GParamSpecTypeInfo' */
#define GParamSpecTypeInfo_val(val) ((GParamSpecTypeInfo*)val)
#define GParamSpecUChar_val(val) check_cast(G_PARAM_SPEC_U_CHAR,val)
#define Val_GParamSpecUChar(val) Val_GObject((GObject*)val)
#define Val_GParamSpecUChar_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecUInt_val(val) check_cast(G_PARAM_SPEC_U_INT,val)
#define Val_GParamSpecUInt(val) Val_GObject((GObject*)val)
#define Val_GParamSpecUInt_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecUInt64_val(val) check_cast(G_PARAM_SPEC_U_INT64,val)
#define Val_GParamSpecUInt64(val) Val_GObject((GObject*)val)
#define Val_GParamSpecUInt64_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecULong_val(val) check_cast(G_PARAM_SPEC_U_LONG,val)
#define Val_GParamSpecULong(val) Val_GObject((GObject*)val)
#define Val_GParamSpecULong_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecUnichar_val(val) check_cast(G_PARAM_SPEC_UNICHAR,val)
#define Val_GParamSpecUnichar(val) Val_GObject((GObject*)val)
#define Val_GParamSpecUnichar_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecValueArray_val(val) check_cast(G_PARAM_SPEC_VALUE_ARRAY,val)
#define Val_GParamSpecValueArray(val) Val_GObject((GObject*)val)
#define Val_GParamSpecValueArray_new(val) Val_GObject_new((GObject*)val)
#define GParamSpecVariant_val(val) check_cast(G_PARAM_SPEC_VARIANT,val)
#define Val_GParamSpecVariant(val) Val_GObject((GObject*)val)
#define Val_GParamSpecVariant_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GParameter' */
#define GParameter_val(val) ((GParameter*)val)
/* conversion for record 'GSignalInvocationHint' */
#define GSignalInvocationHint_val(val) ((GSignalInvocationHint*)val)
/* conversion for record 'GSignalQuery' */
#define GSignalQuery_val(val) ((GSignalQuery*)val)
/* conversion for record 'GTypeClass' */
#define GTypeClass_val(val) ((GTypeClass*)val)
/* conversion for record 'GTypeFundamentalInfo' */
#define GTypeFundamentalInfo_val(val) ((GTypeFundamentalInfo*)val)
/* conversion for record 'GTypeInfo' */
#define GTypeInfo_val(val) ((GTypeInfo*)val)
/* conversion for record 'GTypeInstance' */
#define GTypeInstance_val(val) ((GTypeInstance*)val)
/* conversion for record 'GTypeInterface' */
#define GTypeInterface_val(val) ((GTypeInterface*)val)
#define GTypeModule_val(val) check_cast(G_TYPE_MODULE,val)
#define Val_GTypeModule(val) Val_GObject((GObject*)val)
#define Val_GTypeModule_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTypeModuleClass' */
#define GTypeModuleClass_val(val) ((GTypeModuleClass*)val)
/* conversion for record 'GTypePluginClass' */
#define GTypePluginClass_val(val) ((GTypePluginClass*)val)
/* conversion for record 'GTypeQuery' */
#define GTypeQuery_val(val) ((GTypeQuery*)val)
/* conversion for record 'GTypeValueTable' */
#define GTypeValueTable_val(val) ((GTypeValueTable*)val)
/* conversion for record 'GValue' */
#define GValue_val(val) ((GValue*)val)
/* conversion for record 'GValueArray' */
#define GValueArray_val(val) ((GValueArray*)val)
/* conversion for record 'GWeakRef' */
#define GWeakRef_val(val) ((GWeakRef*)val)
/* conversion for record 'AtkActionIface' */
#define AtkActionIface_val(val) ((AtkActionIface*)val)
/* conversion for record 'AtkAttribute' */
#define AtkAttribute_val(val) ((AtkAttribute*)val)
/* conversion for record 'AtkComponentIface' */
#define AtkComponentIface_val(val) ((AtkComponentIface*)val)
/* conversion for record 'AtkDocumentIface' */
#define AtkDocumentIface_val(val) ((AtkDocumentIface*)val)
/* conversion for record 'AtkEditableTextIface' */
#define AtkEditableTextIface_val(val) ((AtkEditableTextIface*)val)
#define AtkGObjectAccessible_val(val) check_cast(ATK_G_OBJECT_ACCESSIBLE,val)
#define Val_AtkGObjectAccessible(val) Val_GObject((GObject*)val)
#define Val_AtkGObjectAccessible_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkGObjectAccessibleClass' */
#define AtkGObjectAccessibleClass_val(val) ((AtkGObjectAccessibleClass*)val)
#define AtkHyperlink_val(val) check_cast(ATK_HYPERLINK,val)
#define Val_AtkHyperlink(val) Val_GObject((GObject*)val)
#define Val_AtkHyperlink_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkHyperlinkClass' */
#define AtkHyperlinkClass_val(val) ((AtkHyperlinkClass*)val)
/* conversion for record 'AtkHyperlinkImplIface' */
#define AtkHyperlinkImplIface_val(val) ((AtkHyperlinkImplIface*)val)
/* conversion for record 'AtkHypertextIface' */
#define AtkHypertextIface_val(val) ((AtkHypertextIface*)val)
/* conversion for record 'AtkImageIface' */
#define AtkImageIface_val(val) ((AtkImageIface*)val)
/* conversion for record 'AtkImplementor' */
#define AtkImplementor_val(val) ((AtkImplementor*)val)
/* conversion for record 'AtkKeyEventStruct' */
#define AtkKeyEventStruct_val(val) ((AtkKeyEventStruct*)val)
#define AtkMisc_val(val) check_cast(ATK_MISC,val)
#define Val_AtkMisc(val) Val_GObject((GObject*)val)
#define Val_AtkMisc_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkMiscClass' */
#define AtkMiscClass_val(val) ((AtkMiscClass*)val)
#define AtkNoOpObject_val(val) check_cast(ATK_NO_OP_OBJECT,val)
#define Val_AtkNoOpObject(val) Val_GObject((GObject*)val)
#define Val_AtkNoOpObject_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkNoOpObjectClass' */
#define AtkNoOpObjectClass_val(val) ((AtkNoOpObjectClass*)val)
#define AtkNoOpObjectFactory_val(val) check_cast(ATK_NO_OP_OBJECT_FACTORY,val)
#define Val_AtkNoOpObjectFactory(val) Val_GObject((GObject*)val)
#define Val_AtkNoOpObjectFactory_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkNoOpObjectFactoryClass' */
#define AtkNoOpObjectFactoryClass_val(val) ((AtkNoOpObjectFactoryClass*)val)
#define AtkObject_val(val) check_cast(ATK_OBJECT,val)
#define Val_AtkObject(val) Val_GObject((GObject*)val)
#define Val_AtkObject_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkObjectClass' */
#define AtkObjectClass_val(val) ((AtkObjectClass*)val)
#define AtkObjectFactory_val(val) check_cast(ATK_OBJECT_FACTORY,val)
#define Val_AtkObjectFactory(val) Val_GObject((GObject*)val)
#define Val_AtkObjectFactory_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkObjectFactoryClass' */
#define AtkObjectFactoryClass_val(val) ((AtkObjectFactoryClass*)val)
#define AtkPlug_val(val) check_cast(ATK_PLUG,val)
#define Val_AtkPlug(val) Val_GObject((GObject*)val)
#define Val_AtkPlug_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkPlugClass' */
#define AtkPlugClass_val(val) ((AtkPlugClass*)val)
/* conversion for record 'AtkRectangle' */
#define AtkRectangle_val(val) ((AtkRectangle*)val)
#define AtkRelation_val(val) check_cast(ATK_RELATION,val)
#define Val_AtkRelation(val) Val_GObject((GObject*)val)
#define Val_AtkRelation_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkRelationClass' */
#define AtkRelationClass_val(val) ((AtkRelationClass*)val)
#define AtkRelationSet_val(val) check_cast(ATK_RELATION_SET,val)
#define Val_AtkRelationSet(val) Val_GObject((GObject*)val)
#define Val_AtkRelationSet_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkRelationSetClass' */
#define AtkRelationSetClass_val(val) ((AtkRelationSetClass*)val)
/* conversion for record 'AtkSelectionIface' */
#define AtkSelectionIface_val(val) ((AtkSelectionIface*)val)
#define AtkSocket_val(val) check_cast(ATK_SOCKET,val)
#define Val_AtkSocket(val) Val_GObject((GObject*)val)
#define Val_AtkSocket_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkSocketClass' */
#define AtkSocketClass_val(val) ((AtkSocketClass*)val)
#define AtkStateSet_val(val) check_cast(ATK_STATE_SET,val)
#define Val_AtkStateSet(val) Val_GObject((GObject*)val)
#define Val_AtkStateSet_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkStateSetClass' */
#define AtkStateSetClass_val(val) ((AtkStateSetClass*)val)
/* conversion for record 'AtkStreamableContentIface' */
#define AtkStreamableContentIface_val(val) ((AtkStreamableContentIface*)val)
/* conversion for record 'AtkTableIface' */
#define AtkTableIface_val(val) ((AtkTableIface*)val)
/* conversion for record 'AtkTextIface' */
#define AtkTextIface_val(val) ((AtkTextIface*)val)
/* conversion for record 'AtkTextRange' */
#define AtkTextRange_val(val) ((AtkTextRange*)val)
/* conversion for record 'AtkTextRectangle' */
#define AtkTextRectangle_val(val) ((AtkTextRectangle*)val)
#define AtkUtil_val(val) check_cast(ATK_UTIL,val)
#define Val_AtkUtil(val) Val_GObject((GObject*)val)
#define Val_AtkUtil_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'AtkUtilClass' */
#define AtkUtilClass_val(val) ((AtkUtilClass*)val)
/* conversion for record 'AtkValueIface' */
#define AtkValueIface_val(val) ((AtkValueIface*)val)
/* conversion for record 'AtkWindowIface' */
#define AtkWindowIface_val(val) ((AtkWindowIface*)val)
/* conversion for record '_AtkPropertyValues' */
#define _AtkPropertyValues_val(val) ((_AtkPropertyValues*)val)
/* conversion for record '_AtkRegistry' */
#define _AtkRegistry_val(val) ((_AtkRegistry*)val)
/* conversion for record '_AtkRegistryClass' */
#define _AtkRegistryClass_val(val) ((_AtkRegistryClass*)val)
/* conversion for record 'GModule' */
#define GModule_val(val) ((GModule*)val)
/* conversion for record 'GActionEntry' */
#define GActionEntry_val(val) ((GActionEntry*)val)
/* conversion for record 'GActionGroupInterface' */
#define GActionGroupInterface_val(val) ((GActionGroupInterface*)val)
/* conversion for record 'GActionInterface' */
#define GActionInterface_val(val) ((GActionInterface*)val)
/* conversion for record 'GActionMapInterface' */
#define GActionMapInterface_val(val) ((GActionMapInterface*)val)
/* conversion for record 'GAppInfoIface' */
#define GAppInfoIface_val(val) ((GAppInfoIface*)val)
#define GAppLaunchContext_val(val) check_cast(G_APP_LAUNCH_CONTEXT,val)
#define Val_GAppLaunchContext(val) Val_GObject((GObject*)val)
#define Val_GAppLaunchContext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GAppLaunchContextClass' */
#define GAppLaunchContextClass_val(val) ((GAppLaunchContextClass*)val)
/* conversion for record 'GAppLaunchContextPrivate' */
#define GAppLaunchContextPrivate_val(val) ((GAppLaunchContextPrivate*)val)
#define GApplication_val(val) check_cast(G_APPLICATION,val)
#define Val_GApplication(val) Val_GObject((GObject*)val)
#define Val_GApplication_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GApplicationClass' */
#define GApplicationClass_val(val) ((GApplicationClass*)val)
#define GApplicationCommandLine_val(val) check_cast(G_APPLICATION_COMMAND_LINE,val)
#define Val_GApplicationCommandLine(val) Val_GObject((GObject*)val)
#define Val_GApplicationCommandLine_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GApplicationCommandLineClass' */
#define GApplicationCommandLineClass_val(val) ((GApplicationCommandLineClass*)val)
/* conversion for record 'GApplicationCommandLinePrivate' */
#define GApplicationCommandLinePrivate_val(val) ((GApplicationCommandLinePrivate*)val)
/* conversion for record 'GApplicationPrivate' */
#define GApplicationPrivate_val(val) ((GApplicationPrivate*)val)
/* conversion for record 'GAsyncInitableIface' */
#define GAsyncInitableIface_val(val) ((GAsyncInitableIface*)val)
/* conversion for record 'GAsyncResultIface' */
#define GAsyncResultIface_val(val) ((GAsyncResultIface*)val)
#define GBufferedInputStream_val(val) check_cast(G_BUFFERED_INPUT_STREAM,val)
#define Val_GBufferedInputStream(val) Val_GObject((GObject*)val)
#define Val_GBufferedInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GBufferedInputStreamClass' */
#define GBufferedInputStreamClass_val(val) ((GBufferedInputStreamClass*)val)
/* conversion for record 'GBufferedInputStreamPrivate' */
#define GBufferedInputStreamPrivate_val(val) ((GBufferedInputStreamPrivate*)val)
#define GBufferedOutputStream_val(val) check_cast(G_BUFFERED_OUTPUT_STREAM,val)
#define Val_GBufferedOutputStream(val) Val_GObject((GObject*)val)
#define Val_GBufferedOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GBufferedOutputStreamClass' */
#define GBufferedOutputStreamClass_val(val) ((GBufferedOutputStreamClass*)val)
/* conversion for record 'GBufferedOutputStreamPrivate' */
#define GBufferedOutputStreamPrivate_val(val) ((GBufferedOutputStreamPrivate*)val)
#define GCancellable_val(val) check_cast(G_CANCELLABLE,val)
#define Val_GCancellable(val) Val_GObject((GObject*)val)
#define Val_GCancellable_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GCancellableClass' */
#define GCancellableClass_val(val) ((GCancellableClass*)val)
/* conversion for record 'GCancellablePrivate' */
#define GCancellablePrivate_val(val) ((GCancellablePrivate*)val)
#define GCharsetConverter_val(val) check_cast(G_CHARSET_CONVERTER,val)
#define Val_GCharsetConverter(val) Val_GObject((GObject*)val)
#define Val_GCharsetConverter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GCharsetConverterClass' */
#define GCharsetConverterClass_val(val) ((GCharsetConverterClass*)val)
/* conversion for record 'GConverterIface' */
#define GConverterIface_val(val) ((GConverterIface*)val)
#define GConverterInputStream_val(val) check_cast(G_CONVERTER_INPUT_STREAM,val)
#define Val_GConverterInputStream(val) Val_GObject((GObject*)val)
#define Val_GConverterInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GConverterInputStreamClass' */
#define GConverterInputStreamClass_val(val) ((GConverterInputStreamClass*)val)
/* conversion for record 'GConverterInputStreamPrivate' */
#define GConverterInputStreamPrivate_val(val) ((GConverterInputStreamPrivate*)val)
#define GConverterOutputStream_val(val) check_cast(G_CONVERTER_OUTPUT_STREAM,val)
#define Val_GConverterOutputStream(val) Val_GObject((GObject*)val)
#define Val_GConverterOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GConverterOutputStreamClass' */
#define GConverterOutputStreamClass_val(val) ((GConverterOutputStreamClass*)val)
/* conversion for record 'GConverterOutputStreamPrivate' */
#define GConverterOutputStreamPrivate_val(val) ((GConverterOutputStreamPrivate*)val)
#define GCredentials_val(val) check_cast(G_CREDENTIALS,val)
#define Val_GCredentials(val) Val_GObject((GObject*)val)
#define Val_GCredentials_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GCredentialsClass' */
#define GCredentialsClass_val(val) ((GCredentialsClass*)val)
#define GDBusActionGroup_val(val) check_cast(G_D_BUS_ACTION_GROUP,val)
#define Val_GDBusActionGroup(val) Val_GObject((GObject*)val)
#define Val_GDBusActionGroup_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusAnnotationInfo' */
#define GDBusAnnotationInfo_val(val) ((GDBusAnnotationInfo*)val)
/* conversion for record 'GDBusArgInfo' */
#define GDBusArgInfo_val(val) ((GDBusArgInfo*)val)
#define GDBusAuthObserver_val(val) check_cast(G_D_BUS_AUTH_OBSERVER,val)
#define Val_GDBusAuthObserver(val) Val_GObject((GObject*)val)
#define Val_GDBusAuthObserver_new(val) Val_GObject_new((GObject*)val)
#define GDBusConnection_val(val) check_cast(G_D_BUS_CONNECTION,val)
#define Val_GDBusConnection(val) Val_GObject((GObject*)val)
#define Val_GDBusConnection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusErrorEntry' */
#define GDBusErrorEntry_val(val) ((GDBusErrorEntry*)val)
/* conversion for record 'GDBusInterfaceIface' */
#define GDBusInterfaceIface_val(val) ((GDBusInterfaceIface*)val)
/* conversion for record 'GDBusInterfaceInfo' */
#define GDBusInterfaceInfo_val(val) ((GDBusInterfaceInfo*)val)
#define GDBusInterfaceSkeleton_val(val) check_cast(G_D_BUS_INTERFACE_SKELETON,val)
#define Val_GDBusInterfaceSkeleton(val) Val_GObject((GObject*)val)
#define Val_GDBusInterfaceSkeleton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusInterfaceSkeletonClass' */
#define GDBusInterfaceSkeletonClass_val(val) ((GDBusInterfaceSkeletonClass*)val)
/* conversion for record 'GDBusInterfaceSkeletonPrivate' */
#define GDBusInterfaceSkeletonPrivate_val(val) ((GDBusInterfaceSkeletonPrivate*)val)
/* conversion for record 'GDBusInterfaceVTable' */
#define GDBusInterfaceVTable_val(val) ((GDBusInterfaceVTable*)val)
#define GDBusMenuModel_val(val) check_cast(G_D_BUS_MENU_MODEL,val)
#define Val_GDBusMenuModel(val) Val_GObject((GObject*)val)
#define Val_GDBusMenuModel_new(val) Val_GObject_new((GObject*)val)
#define GDBusMessage_val(val) check_cast(G_D_BUS_MESSAGE,val)
#define Val_GDBusMessage(val) Val_GObject((GObject*)val)
#define Val_GDBusMessage_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusMethodInfo' */
#define GDBusMethodInfo_val(val) ((GDBusMethodInfo*)val)
#define GDBusMethodInvocation_val(val) check_cast(G_D_BUS_METHOD_INVOCATION,val)
#define Val_GDBusMethodInvocation(val) Val_GObject((GObject*)val)
#define Val_GDBusMethodInvocation_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusNodeInfo' */
#define GDBusNodeInfo_val(val) ((GDBusNodeInfo*)val)
/* conversion for record 'GDBusObjectIface' */
#define GDBusObjectIface_val(val) ((GDBusObjectIface*)val)
#define GDBusObjectManagerClient_val(val) check_cast(G_D_BUS_OBJECT_MANAGER_CLIENT,val)
#define Val_GDBusObjectManagerClient(val) Val_GObject((GObject*)val)
#define Val_GDBusObjectManagerClient_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusObjectManagerClientClass' */
#define GDBusObjectManagerClientClass_val(val) ((GDBusObjectManagerClientClass*)val)
/* conversion for record 'GDBusObjectManagerClientPrivate' */
#define GDBusObjectManagerClientPrivate_val(val) ((GDBusObjectManagerClientPrivate*)val)
/* conversion for record 'GDBusObjectManagerIface' */
#define GDBusObjectManagerIface_val(val) ((GDBusObjectManagerIface*)val)
#define GDBusObjectManagerServer_val(val) check_cast(G_D_BUS_OBJECT_MANAGER_SERVER,val)
#define Val_GDBusObjectManagerServer(val) Val_GObject((GObject*)val)
#define Val_GDBusObjectManagerServer_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusObjectManagerServerClass' */
#define GDBusObjectManagerServerClass_val(val) ((GDBusObjectManagerServerClass*)val)
/* conversion for record 'GDBusObjectManagerServerPrivate' */
#define GDBusObjectManagerServerPrivate_val(val) ((GDBusObjectManagerServerPrivate*)val)
#define GDBusObjectProxy_val(val) check_cast(G_D_BUS_OBJECT_PROXY,val)
#define Val_GDBusObjectProxy(val) Val_GObject((GObject*)val)
#define Val_GDBusObjectProxy_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusObjectProxyClass' */
#define GDBusObjectProxyClass_val(val) ((GDBusObjectProxyClass*)val)
/* conversion for record 'GDBusObjectProxyPrivate' */
#define GDBusObjectProxyPrivate_val(val) ((GDBusObjectProxyPrivate*)val)
#define GDBusObjectSkeleton_val(val) check_cast(G_D_BUS_OBJECT_SKELETON,val)
#define Val_GDBusObjectSkeleton(val) Val_GObject((GObject*)val)
#define Val_GDBusObjectSkeleton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusObjectSkeletonClass' */
#define GDBusObjectSkeletonClass_val(val) ((GDBusObjectSkeletonClass*)val)
/* conversion for record 'GDBusObjectSkeletonPrivate' */
#define GDBusObjectSkeletonPrivate_val(val) ((GDBusObjectSkeletonPrivate*)val)
/* conversion for record 'GDBusPropertyInfo' */
#define GDBusPropertyInfo_val(val) ((GDBusPropertyInfo*)val)
#define GDBusProxy_val(val) check_cast(G_D_BUS_PROXY,val)
#define Val_GDBusProxy(val) Val_GObject((GObject*)val)
#define Val_GDBusProxy_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusProxyClass' */
#define GDBusProxyClass_val(val) ((GDBusProxyClass*)val)
/* conversion for record 'GDBusProxyPrivate' */
#define GDBusProxyPrivate_val(val) ((GDBusProxyPrivate*)val)
#define GDBusServer_val(val) check_cast(G_D_BUS_SERVER,val)
#define Val_GDBusServer(val) Val_GObject((GObject*)val)
#define Val_GDBusServer_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDBusSignalInfo' */
#define GDBusSignalInfo_val(val) ((GDBusSignalInfo*)val)
/* conversion for record 'GDBusSubtreeVTable' */
#define GDBusSubtreeVTable_val(val) ((GDBusSubtreeVTable*)val)
#define GDataInputStream_val(val) check_cast(G_DATA_INPUT_STREAM,val)
#define Val_GDataInputStream(val) Val_GObject((GObject*)val)
#define Val_GDataInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDataInputStreamClass' */
#define GDataInputStreamClass_val(val) ((GDataInputStreamClass*)val)
/* conversion for record 'GDataInputStreamPrivate' */
#define GDataInputStreamPrivate_val(val) ((GDataInputStreamPrivate*)val)
#define GDataOutputStream_val(val) check_cast(G_DATA_OUTPUT_STREAM,val)
#define Val_GDataOutputStream(val) Val_GObject((GObject*)val)
#define Val_GDataOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDataOutputStreamClass' */
#define GDataOutputStreamClass_val(val) ((GDataOutputStreamClass*)val)
/* conversion for record 'GDataOutputStreamPrivate' */
#define GDataOutputStreamPrivate_val(val) ((GDataOutputStreamPrivate*)val)
#define GDesktopAppInfo_val(val) check_cast(G_DESKTOP_APP_INFO,val)
#define Val_GDesktopAppInfo(val) Val_GObject((GObject*)val)
#define Val_GDesktopAppInfo_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GDesktopAppInfoClass' */
#define GDesktopAppInfoClass_val(val) ((GDesktopAppInfoClass*)val)
/* conversion for record 'GDesktopAppInfoLookupIface' */
#define GDesktopAppInfoLookupIface_val(val) ((GDesktopAppInfoLookupIface*)val)
/* conversion for record 'GDriveIface' */
#define GDriveIface_val(val) ((GDriveIface*)val)
#define GEmblem_val(val) check_cast(G_EMBLEM,val)
#define Val_GEmblem(val) Val_GObject((GObject*)val)
#define Val_GEmblem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GEmblemClass' */
#define GEmblemClass_val(val) ((GEmblemClass*)val)
#define GEmblemedIcon_val(val) check_cast(G_EMBLEMED_ICON,val)
#define Val_GEmblemedIcon(val) Val_GObject((GObject*)val)
#define Val_GEmblemedIcon_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GEmblemedIconClass' */
#define GEmblemedIconClass_val(val) ((GEmblemedIconClass*)val)
/* conversion for record 'GEmblemedIconPrivate' */
#define GEmblemedIconPrivate_val(val) ((GEmblemedIconPrivate*)val)
/* conversion for record 'GFileAttributeInfo' */
#define GFileAttributeInfo_val(val) ((GFileAttributeInfo*)val)
/* conversion for record 'GFileAttributeInfoList' */
#define GFileAttributeInfoList_val(val) ((GFileAttributeInfoList*)val)
/* conversion for record 'GFileAttributeMatcher' */
#define GFileAttributeMatcher_val(val) ((GFileAttributeMatcher*)val)
/* conversion for record 'GFileDescriptorBasedIface' */
#define GFileDescriptorBasedIface_val(val) ((GFileDescriptorBasedIface*)val)
#define GFileEnumerator_val(val) check_cast(G_FILE_ENUMERATOR,val)
#define Val_GFileEnumerator(val) Val_GObject((GObject*)val)
#define Val_GFileEnumerator_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFileEnumeratorClass' */
#define GFileEnumeratorClass_val(val) ((GFileEnumeratorClass*)val)
/* conversion for record 'GFileEnumeratorPrivate' */
#define GFileEnumeratorPrivate_val(val) ((GFileEnumeratorPrivate*)val)
#define GFileIOStream_val(val) check_cast(G_FILE_I_O_STREAM,val)
#define Val_GFileIOStream(val) Val_GObject((GObject*)val)
#define Val_GFileIOStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFileIOStreamClass' */
#define GFileIOStreamClass_val(val) ((GFileIOStreamClass*)val)
/* conversion for record 'GFileIOStreamPrivate' */
#define GFileIOStreamPrivate_val(val) ((GFileIOStreamPrivate*)val)
#define GFileIcon_val(val) check_cast(G_FILE_ICON,val)
#define Val_GFileIcon(val) Val_GObject((GObject*)val)
#define Val_GFileIcon_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFileIconClass' */
#define GFileIconClass_val(val) ((GFileIconClass*)val)
/* conversion for record 'GFileIface' */
#define GFileIface_val(val) ((GFileIface*)val)
#define GFileInfo_val(val) check_cast(G_FILE_INFO,val)
#define Val_GFileInfo(val) Val_GObject((GObject*)val)
#define Val_GFileInfo_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFileInfoClass' */
#define GFileInfoClass_val(val) ((GFileInfoClass*)val)
#define GFileInputStream_val(val) check_cast(G_FILE_INPUT_STREAM,val)
#define Val_GFileInputStream(val) Val_GObject((GObject*)val)
#define Val_GFileInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFileInputStreamClass' */
#define GFileInputStreamClass_val(val) ((GFileInputStreamClass*)val)
/* conversion for record 'GFileInputStreamPrivate' */
#define GFileInputStreamPrivate_val(val) ((GFileInputStreamPrivate*)val)
#define GFileMonitor_val(val) check_cast(G_FILE_MONITOR,val)
#define Val_GFileMonitor(val) Val_GObject((GObject*)val)
#define Val_GFileMonitor_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFileMonitorClass' */
#define GFileMonitorClass_val(val) ((GFileMonitorClass*)val)
/* conversion for record 'GFileMonitorPrivate' */
#define GFileMonitorPrivate_val(val) ((GFileMonitorPrivate*)val)
#define GFileOutputStream_val(val) check_cast(G_FILE_OUTPUT_STREAM,val)
#define Val_GFileOutputStream(val) Val_GObject((GObject*)val)
#define Val_GFileOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFileOutputStreamClass' */
#define GFileOutputStreamClass_val(val) ((GFileOutputStreamClass*)val)
/* conversion for record 'GFileOutputStreamPrivate' */
#define GFileOutputStreamPrivate_val(val) ((GFileOutputStreamPrivate*)val)
#define GFilenameCompleter_val(val) check_cast(G_FILENAME_COMPLETER,val)
#define Val_GFilenameCompleter(val) Val_GObject((GObject*)val)
#define Val_GFilenameCompleter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFilenameCompleterClass' */
#define GFilenameCompleterClass_val(val) ((GFilenameCompleterClass*)val)
#define GFilterInputStream_val(val) check_cast(G_FILTER_INPUT_STREAM,val)
#define Val_GFilterInputStream(val) Val_GObject((GObject*)val)
#define Val_GFilterInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFilterInputStreamClass' */
#define GFilterInputStreamClass_val(val) ((GFilterInputStreamClass*)val)
#define GFilterOutputStream_val(val) check_cast(G_FILTER_OUTPUT_STREAM,val)
#define Val_GFilterOutputStream(val) Val_GObject((GObject*)val)
#define Val_GFilterOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GFilterOutputStreamClass' */
#define GFilterOutputStreamClass_val(val) ((GFilterOutputStreamClass*)val)
/* conversion for record 'GIOExtension' */
#define GIOExtension_val(val) ((GIOExtension*)val)
/* conversion for record 'GIOExtensionPoint' */
#define GIOExtensionPoint_val(val) ((GIOExtensionPoint*)val)
#define GIOModule_val(val) check_cast(G_I_O_MODULE,val)
#define Val_GIOModule(val) Val_GObject((GObject*)val)
#define Val_GIOModule_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GIOModuleClass' */
#define GIOModuleClass_val(val) ((GIOModuleClass*)val)
/* conversion for record 'GIOModuleScope' */
#define GIOModuleScope_val(val) ((GIOModuleScope*)val)
/* conversion for record 'GIOSchedulerJob' */
#define GIOSchedulerJob_val(val) ((GIOSchedulerJob*)val)
#define GIOStream_val(val) check_cast(G_I_O_STREAM,val)
#define Val_GIOStream(val) Val_GObject((GObject*)val)
#define Val_GIOStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GIOStreamAdapter' */
#define GIOStreamAdapter_val(val) ((GIOStreamAdapter*)val)
/* conversion for record 'GIOStreamClass' */
#define GIOStreamClass_val(val) ((GIOStreamClass*)val)
/* conversion for record 'GIOStreamPrivate' */
#define GIOStreamPrivate_val(val) ((GIOStreamPrivate*)val)
/* conversion for record 'GIconIface' */
#define GIconIface_val(val) ((GIconIface*)val)
#define GInetAddress_val(val) check_cast(G_INET_ADDRESS,val)
#define Val_GInetAddress(val) Val_GObject((GObject*)val)
#define Val_GInetAddress_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GInetAddressClass' */
#define GInetAddressClass_val(val) ((GInetAddressClass*)val)
#define GInetAddressMask_val(val) check_cast(G_INET_ADDRESS_MASK,val)
#define Val_GInetAddressMask(val) Val_GObject((GObject*)val)
#define Val_GInetAddressMask_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GInetAddressMaskClass' */
#define GInetAddressMaskClass_val(val) ((GInetAddressMaskClass*)val)
/* conversion for record 'GInetAddressMaskPrivate' */
#define GInetAddressMaskPrivate_val(val) ((GInetAddressMaskPrivate*)val)
/* conversion for record 'GInetAddressPrivate' */
#define GInetAddressPrivate_val(val) ((GInetAddressPrivate*)val)
#define GInetSocketAddress_val(val) check_cast(G_INET_SOCKET_ADDRESS,val)
#define Val_GInetSocketAddress(val) Val_GObject((GObject*)val)
#define Val_GInetSocketAddress_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GInetSocketAddressClass' */
#define GInetSocketAddressClass_val(val) ((GInetSocketAddressClass*)val)
/* conversion for record 'GInetSocketAddressPrivate' */
#define GInetSocketAddressPrivate_val(val) ((GInetSocketAddressPrivate*)val)
/* conversion for record 'GInitableIface' */
#define GInitableIface_val(val) ((GInitableIface*)val)
#define GInputStream_val(val) check_cast(G_INPUT_STREAM,val)
#define Val_GInputStream(val) Val_GObject((GObject*)val)
#define Val_GInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GInputStreamClass' */
#define GInputStreamClass_val(val) ((GInputStreamClass*)val)
/* conversion for record 'GInputStreamPrivate' */
#define GInputStreamPrivate_val(val) ((GInputStreamPrivate*)val)
/* conversion for record 'GInputVector' */
#define GInputVector_val(val) ((GInputVector*)val)
/* conversion for record 'GLoadableIconIface' */
#define GLoadableIconIface_val(val) ((GLoadableIconIface*)val)
#define GMemoryInputStream_val(val) check_cast(G_MEMORY_INPUT_STREAM,val)
#define Val_GMemoryInputStream(val) Val_GObject((GObject*)val)
#define Val_GMemoryInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GMemoryInputStreamClass' */
#define GMemoryInputStreamClass_val(val) ((GMemoryInputStreamClass*)val)
/* conversion for record 'GMemoryInputStreamPrivate' */
#define GMemoryInputStreamPrivate_val(val) ((GMemoryInputStreamPrivate*)val)
#define GMemoryOutputStream_val(val) check_cast(G_MEMORY_OUTPUT_STREAM,val)
#define Val_GMemoryOutputStream(val) Val_GObject((GObject*)val)
#define Val_GMemoryOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GMemoryOutputStreamClass' */
#define GMemoryOutputStreamClass_val(val) ((GMemoryOutputStreamClass*)val)
/* conversion for record 'GMemoryOutputStreamPrivate' */
#define GMemoryOutputStreamPrivate_val(val) ((GMemoryOutputStreamPrivate*)val)
#define GMenu_val(val) check_cast(G_MENU,val)
#define Val_GMenu(val) Val_GObject((GObject*)val)
#define Val_GMenu_new(val) Val_GObject_new((GObject*)val)
#define GMenuAttributeIter_val(val) check_cast(G_MENU_ATTRIBUTE_ITER,val)
#define Val_GMenuAttributeIter(val) Val_GObject((GObject*)val)
#define Val_GMenuAttributeIter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GMenuAttributeIterClass' */
#define GMenuAttributeIterClass_val(val) ((GMenuAttributeIterClass*)val)
/* conversion for record 'GMenuAttributeIterPrivate' */
#define GMenuAttributeIterPrivate_val(val) ((GMenuAttributeIterPrivate*)val)
#define GMenuItem_val(val) check_cast(G_MENU_ITEM,val)
#define Val_GMenuItem(val) Val_GObject((GObject*)val)
#define Val_GMenuItem_new(val) Val_GObject_new((GObject*)val)
#define GMenuLinkIter_val(val) check_cast(G_MENU_LINK_ITER,val)
#define Val_GMenuLinkIter(val) Val_GObject((GObject*)val)
#define Val_GMenuLinkIter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GMenuLinkIterClass' */
#define GMenuLinkIterClass_val(val) ((GMenuLinkIterClass*)val)
/* conversion for record 'GMenuLinkIterPrivate' */
#define GMenuLinkIterPrivate_val(val) ((GMenuLinkIterPrivate*)val)
#define GMenuModel_val(val) check_cast(G_MENU_MODEL,val)
#define Val_GMenuModel(val) Val_GObject((GObject*)val)
#define Val_GMenuModel_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GMenuModelClass' */
#define GMenuModelClass_val(val) ((GMenuModelClass*)val)
/* conversion for record 'GMenuModelPrivate' */
#define GMenuModelPrivate_val(val) ((GMenuModelPrivate*)val)
/* conversion for record 'GMountIface' */
#define GMountIface_val(val) ((GMountIface*)val)
#define GMountOperation_val(val) check_cast(G_MOUNT_OPERATION,val)
#define Val_GMountOperation(val) Val_GObject((GObject*)val)
#define Val_GMountOperation_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GMountOperationClass' */
#define GMountOperationClass_val(val) ((GMountOperationClass*)val)
/* conversion for record 'GMountOperationPrivate' */
#define GMountOperationPrivate_val(val) ((GMountOperationPrivate*)val)
#define GNativeVolumeMonitor_val(val) check_cast(G_NATIVE_VOLUME_MONITOR,val)
#define Val_GNativeVolumeMonitor(val) Val_GObject((GObject*)val)
#define Val_GNativeVolumeMonitor_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GNativeVolumeMonitorClass' */
#define GNativeVolumeMonitorClass_val(val) ((GNativeVolumeMonitorClass*)val)
#define GNetworkAddress_val(val) check_cast(G_NETWORK_ADDRESS,val)
#define Val_GNetworkAddress(val) Val_GObject((GObject*)val)
#define Val_GNetworkAddress_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GNetworkAddressClass' */
#define GNetworkAddressClass_val(val) ((GNetworkAddressClass*)val)
/* conversion for record 'GNetworkAddressPrivate' */
#define GNetworkAddressPrivate_val(val) ((GNetworkAddressPrivate*)val)
/* conversion for record 'GNetworkMonitorInterface' */
#define GNetworkMonitorInterface_val(val) ((GNetworkMonitorInterface*)val)
#define GNetworkService_val(val) check_cast(G_NETWORK_SERVICE,val)
#define Val_GNetworkService(val) Val_GObject((GObject*)val)
#define Val_GNetworkService_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GNetworkServiceClass' */
#define GNetworkServiceClass_val(val) ((GNetworkServiceClass*)val)
/* conversion for record 'GNetworkServicePrivate' */
#define GNetworkServicePrivate_val(val) ((GNetworkServicePrivate*)val)
#define GOutputStream_val(val) check_cast(G_OUTPUT_STREAM,val)
#define Val_GOutputStream(val) Val_GObject((GObject*)val)
#define Val_GOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GOutputStreamClass' */
#define GOutputStreamClass_val(val) ((GOutputStreamClass*)val)
/* conversion for record 'GOutputStreamPrivate' */
#define GOutputStreamPrivate_val(val) ((GOutputStreamPrivate*)val)
/* conversion for record 'GOutputVector' */
#define GOutputVector_val(val) ((GOutputVector*)val)
#define GPermission_val(val) check_cast(G_PERMISSION,val)
#define Val_GPermission(val) Val_GObject((GObject*)val)
#define Val_GPermission_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GPermissionClass' */
#define GPermissionClass_val(val) ((GPermissionClass*)val)
/* conversion for record 'GPermissionPrivate' */
#define GPermissionPrivate_val(val) ((GPermissionPrivate*)val)
/* conversion for record 'GPollableInputStreamInterface' */
#define GPollableInputStreamInterface_val(val) ((GPollableInputStreamInterface*)val)
/* conversion for record 'GPollableOutputStreamInterface' */
#define GPollableOutputStreamInterface_val(val) ((GPollableOutputStreamInterface*)val)
#define GProxyAddress_val(val) check_cast(G_PROXY_ADDRESS,val)
#define Val_GProxyAddress(val) Val_GObject((GObject*)val)
#define Val_GProxyAddress_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GProxyAddressClass' */
#define GProxyAddressClass_val(val) ((GProxyAddressClass*)val)
#define GProxyAddressEnumerator_val(val) check_cast(G_PROXY_ADDRESS_ENUMERATOR,val)
#define Val_GProxyAddressEnumerator(val) Val_GObject((GObject*)val)
#define Val_GProxyAddressEnumerator_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GProxyAddressEnumeratorClass' */
#define GProxyAddressEnumeratorClass_val(val) ((GProxyAddressEnumeratorClass*)val)
/* conversion for record 'GProxyAddressEnumeratorPrivate' */
#define GProxyAddressEnumeratorPrivate_val(val) ((GProxyAddressEnumeratorPrivate*)val)
/* conversion for record 'GProxyAddressPrivate' */
#define GProxyAddressPrivate_val(val) ((GProxyAddressPrivate*)val)
/* conversion for record 'GProxyInterface' */
#define GProxyInterface_val(val) ((GProxyInterface*)val)
/* conversion for record 'GProxyResolverInterface' */
#define GProxyResolverInterface_val(val) ((GProxyResolverInterface*)val)
/* conversion for record 'GRemoteActionGroupInterface' */
#define GRemoteActionGroupInterface_val(val) ((GRemoteActionGroupInterface*)val)
#define GResolver_val(val) check_cast(G_RESOLVER,val)
#define Val_GResolver(val) Val_GObject((GObject*)val)
#define Val_GResolver_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GResolverClass' */
#define GResolverClass_val(val) ((GResolverClass*)val)
/* conversion for record 'GResolverPrivate' */
#define GResolverPrivate_val(val) ((GResolverPrivate*)val)
/* conversion for record 'GResource' */
#define GResource_val(val) ((GResource*)val)
/* conversion for record 'GSeekableIface' */
#define GSeekableIface_val(val) ((GSeekableIface*)val)
#define GSettings_val(val) check_cast(G_SETTINGS,val)
#define Val_GSettings(val) Val_GObject((GObject*)val)
#define Val_GSettings_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSettingsBackend' */
#define GSettingsBackend_val(val) ((GSettingsBackend*)val)
/* conversion for record 'GSettingsClass' */
#define GSettingsClass_val(val) ((GSettingsClass*)val)
/* conversion for record 'GSettingsPrivate' */
#define GSettingsPrivate_val(val) ((GSettingsPrivate*)val)
/* conversion for record 'GSettingsSchema' */
#define GSettingsSchema_val(val) ((GSettingsSchema*)val)
/* conversion for record 'GSettingsSchemaSource' */
#define GSettingsSchemaSource_val(val) ((GSettingsSchemaSource*)val)
#define GSimpleAction_val(val) check_cast(G_SIMPLE_ACTION,val)
#define Val_GSimpleAction(val) Val_GObject((GObject*)val)
#define Val_GSimpleAction_new(val) Val_GObject_new((GObject*)val)
#define GSimpleActionGroup_val(val) check_cast(G_SIMPLE_ACTION_GROUP,val)
#define Val_GSimpleActionGroup(val) Val_GObject((GObject*)val)
#define Val_GSimpleActionGroup_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSimpleActionGroupClass' */
#define GSimpleActionGroupClass_val(val) ((GSimpleActionGroupClass*)val)
/* conversion for record 'GSimpleActionGroupPrivate' */
#define GSimpleActionGroupPrivate_val(val) ((GSimpleActionGroupPrivate*)val)
#define GSimpleAsyncResult_val(val) check_cast(G_SIMPLE_ASYNC_RESULT,val)
#define Val_GSimpleAsyncResult(val) Val_GObject((GObject*)val)
#define Val_GSimpleAsyncResult_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSimpleAsyncResultClass' */
#define GSimpleAsyncResultClass_val(val) ((GSimpleAsyncResultClass*)val)
#define GSimplePermission_val(val) check_cast(G_SIMPLE_PERMISSION,val)
#define Val_GSimplePermission(val) Val_GObject((GObject*)val)
#define Val_GSimplePermission_new(val) Val_GObject_new((GObject*)val)
#define GSocket_val(val) check_cast(G_SOCKET,val)
#define Val_GSocket(val) Val_GObject((GObject*)val)
#define Val_GSocket_new(val) Val_GObject_new((GObject*)val)
#define GSocketAddress_val(val) check_cast(G_SOCKET_ADDRESS,val)
#define Val_GSocketAddress(val) Val_GObject((GObject*)val)
#define Val_GSocketAddress_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSocketAddressClass' */
#define GSocketAddressClass_val(val) ((GSocketAddressClass*)val)
#define GSocketAddressEnumerator_val(val) check_cast(G_SOCKET_ADDRESS_ENUMERATOR,val)
#define Val_GSocketAddressEnumerator(val) Val_GObject((GObject*)val)
#define Val_GSocketAddressEnumerator_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSocketAddressEnumeratorClass' */
#define GSocketAddressEnumeratorClass_val(val) ((GSocketAddressEnumeratorClass*)val)
/* conversion for record 'GSocketClass' */
#define GSocketClass_val(val) ((GSocketClass*)val)
#define GSocketClient_val(val) check_cast(G_SOCKET_CLIENT,val)
#define Val_GSocketClient(val) Val_GObject((GObject*)val)
#define Val_GSocketClient_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSocketClientClass' */
#define GSocketClientClass_val(val) ((GSocketClientClass*)val)
/* conversion for record 'GSocketClientPrivate' */
#define GSocketClientPrivate_val(val) ((GSocketClientPrivate*)val)
/* conversion for record 'GSocketConnectableIface' */
#define GSocketConnectableIface_val(val) ((GSocketConnectableIface*)val)
#define GSocketConnection_val(val) check_cast(G_SOCKET_CONNECTION,val)
#define Val_GSocketConnection(val) Val_GObject((GObject*)val)
#define Val_GSocketConnection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSocketConnectionClass' */
#define GSocketConnectionClass_val(val) ((GSocketConnectionClass*)val)
/* conversion for record 'GSocketConnectionPrivate' */
#define GSocketConnectionPrivate_val(val) ((GSocketConnectionPrivate*)val)
#define GSocketControlMessage_val(val) check_cast(G_SOCKET_CONTROL_MESSAGE,val)
#define Val_GSocketControlMessage(val) Val_GObject((GObject*)val)
#define Val_GSocketControlMessage_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSocketControlMessageClass' */
#define GSocketControlMessageClass_val(val) ((GSocketControlMessageClass*)val)
/* conversion for record 'GSocketControlMessagePrivate' */
#define GSocketControlMessagePrivate_val(val) ((GSocketControlMessagePrivate*)val)
#define GSocketListener_val(val) check_cast(G_SOCKET_LISTENER,val)
#define Val_GSocketListener(val) Val_GObject((GObject*)val)
#define Val_GSocketListener_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSocketListenerClass' */
#define GSocketListenerClass_val(val) ((GSocketListenerClass*)val)
/* conversion for record 'GSocketListenerPrivate' */
#define GSocketListenerPrivate_val(val) ((GSocketListenerPrivate*)val)
/* conversion for record 'GSocketPrivate' */
#define GSocketPrivate_val(val) ((GSocketPrivate*)val)
#define GSocketService_val(val) check_cast(G_SOCKET_SERVICE,val)
#define Val_GSocketService(val) Val_GObject((GObject*)val)
#define Val_GSocketService_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GSocketServiceClass' */
#define GSocketServiceClass_val(val) ((GSocketServiceClass*)val)
/* conversion for record 'GSocketServicePrivate' */
#define GSocketServicePrivate_val(val) ((GSocketServicePrivate*)val)
/* conversion for record 'GSrvTarget' */
#define GSrvTarget_val(val) ((GSrvTarget*)val)
/* conversion for record 'GStaticResource' */
#define GStaticResource_val(val) ((GStaticResource*)val)
#define GTcpConnection_val(val) check_cast(G_TCP_CONNECTION,val)
#define Val_GTcpConnection(val) Val_GObject((GObject*)val)
#define Val_GTcpConnection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTcpConnectionClass' */
#define GTcpConnectionClass_val(val) ((GTcpConnectionClass*)val)
/* conversion for record 'GTcpConnectionPrivate' */
#define GTcpConnectionPrivate_val(val) ((GTcpConnectionPrivate*)val)
#define GTcpWrapperConnection_val(val) check_cast(G_TCP_WRAPPER_CONNECTION,val)
#define Val_GTcpWrapperConnection(val) Val_GObject((GObject*)val)
#define Val_GTcpWrapperConnection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTcpWrapperConnectionClass' */
#define GTcpWrapperConnectionClass_val(val) ((GTcpWrapperConnectionClass*)val)
/* conversion for record 'GTcpWrapperConnectionPrivate' */
#define GTcpWrapperConnectionPrivate_val(val) ((GTcpWrapperConnectionPrivate*)val)
#define GThemedIcon_val(val) check_cast(G_THEMED_ICON,val)
#define Val_GThemedIcon(val) Val_GObject((GObject*)val)
#define Val_GThemedIcon_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GThemedIconClass' */
#define GThemedIconClass_val(val) ((GThemedIconClass*)val)
#define GThreadedSocketService_val(val) check_cast(G_THREADED_SOCKET_SERVICE,val)
#define Val_GThreadedSocketService(val) Val_GObject((GObject*)val)
#define Val_GThreadedSocketService_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GThreadedSocketServiceClass' */
#define GThreadedSocketServiceClass_val(val) ((GThreadedSocketServiceClass*)val)
/* conversion for record 'GThreadedSocketServicePrivate' */
#define GThreadedSocketServicePrivate_val(val) ((GThreadedSocketServicePrivate*)val)
/* conversion for record 'GTlsBackendInterface' */
#define GTlsBackendInterface_val(val) ((GTlsBackendInterface*)val)
#define GTlsCertificate_val(val) check_cast(G_TLS_CERTIFICATE,val)
#define Val_GTlsCertificate(val) Val_GObject((GObject*)val)
#define Val_GTlsCertificate_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTlsCertificateClass' */
#define GTlsCertificateClass_val(val) ((GTlsCertificateClass*)val)
/* conversion for record 'GTlsCertificatePrivate' */
#define GTlsCertificatePrivate_val(val) ((GTlsCertificatePrivate*)val)
/* conversion for record 'GTlsClientConnectionInterface' */
#define GTlsClientConnectionInterface_val(val) ((GTlsClientConnectionInterface*)val)
#define GTlsConnection_val(val) check_cast(G_TLS_CONNECTION,val)
#define Val_GTlsConnection(val) Val_GObject((GObject*)val)
#define Val_GTlsConnection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTlsConnectionClass' */
#define GTlsConnectionClass_val(val) ((GTlsConnectionClass*)val)
/* conversion for record 'GTlsConnectionPrivate' */
#define GTlsConnectionPrivate_val(val) ((GTlsConnectionPrivate*)val)
#define GTlsDatabase_val(val) check_cast(G_TLS_DATABASE,val)
#define Val_GTlsDatabase(val) Val_GObject((GObject*)val)
#define Val_GTlsDatabase_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTlsDatabaseClass' */
#define GTlsDatabaseClass_val(val) ((GTlsDatabaseClass*)val)
/* conversion for record 'GTlsDatabasePrivate' */
#define GTlsDatabasePrivate_val(val) ((GTlsDatabasePrivate*)val)
/* conversion for record 'GTlsFileDatabaseInterface' */
#define GTlsFileDatabaseInterface_val(val) ((GTlsFileDatabaseInterface*)val)
#define GTlsInteraction_val(val) check_cast(G_TLS_INTERACTION,val)
#define Val_GTlsInteraction(val) Val_GObject((GObject*)val)
#define Val_GTlsInteraction_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTlsInteractionClass' */
#define GTlsInteractionClass_val(val) ((GTlsInteractionClass*)val)
/* conversion for record 'GTlsInteractionPrivate' */
#define GTlsInteractionPrivate_val(val) ((GTlsInteractionPrivate*)val)
#define GTlsPassword_val(val) check_cast(G_TLS_PASSWORD,val)
#define Val_GTlsPassword(val) Val_GObject((GObject*)val)
#define Val_GTlsPassword_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GTlsPasswordClass' */
#define GTlsPasswordClass_val(val) ((GTlsPasswordClass*)val)
/* conversion for record 'GTlsPasswordPrivate' */
#define GTlsPasswordPrivate_val(val) ((GTlsPasswordPrivate*)val)
/* conversion for record 'GTlsServerConnectionInterface' */
#define GTlsServerConnectionInterface_val(val) ((GTlsServerConnectionInterface*)val)
#define GUnixConnection_val(val) check_cast(G_UNIX_CONNECTION,val)
#define Val_GUnixConnection(val) Val_GObject((GObject*)val)
#define Val_GUnixConnection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixConnectionClass' */
#define GUnixConnectionClass_val(val) ((GUnixConnectionClass*)val)
/* conversion for record 'GUnixConnectionPrivate' */
#define GUnixConnectionPrivate_val(val) ((GUnixConnectionPrivate*)val)
#define GUnixCredentialsMessage_val(val) check_cast(G_UNIX_CREDENTIALS_MESSAGE,val)
#define Val_GUnixCredentialsMessage(val) Val_GObject((GObject*)val)
#define Val_GUnixCredentialsMessage_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixCredentialsMessageClass' */
#define GUnixCredentialsMessageClass_val(val) ((GUnixCredentialsMessageClass*)val)
/* conversion for record 'GUnixCredentialsMessagePrivate' */
#define GUnixCredentialsMessagePrivate_val(val) ((GUnixCredentialsMessagePrivate*)val)
#define GUnixFDList_val(val) check_cast(G_UNIX_F_D_LIST,val)
#define Val_GUnixFDList(val) Val_GObject((GObject*)val)
#define Val_GUnixFDList_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixFDListClass' */
#define GUnixFDListClass_val(val) ((GUnixFDListClass*)val)
/* conversion for record 'GUnixFDListPrivate' */
#define GUnixFDListPrivate_val(val) ((GUnixFDListPrivate*)val)
#define GUnixFDMessage_val(val) check_cast(G_UNIX_F_D_MESSAGE,val)
#define Val_GUnixFDMessage(val) Val_GObject((GObject*)val)
#define Val_GUnixFDMessage_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixFDMessageClass' */
#define GUnixFDMessageClass_val(val) ((GUnixFDMessageClass*)val)
/* conversion for record 'GUnixFDMessagePrivate' */
#define GUnixFDMessagePrivate_val(val) ((GUnixFDMessagePrivate*)val)
#define GUnixInputStream_val(val) check_cast(G_UNIX_INPUT_STREAM,val)
#define Val_GUnixInputStream(val) Val_GObject((GObject*)val)
#define Val_GUnixInputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixInputStreamClass' */
#define GUnixInputStreamClass_val(val) ((GUnixInputStreamClass*)val)
/* conversion for record 'GUnixInputStreamPrivate' */
#define GUnixInputStreamPrivate_val(val) ((GUnixInputStreamPrivate*)val)
/* conversion for record 'GUnixMountEntry' */
#define GUnixMountEntry_val(val) ((GUnixMountEntry*)val)
#define GUnixMountMonitor_val(val) check_cast(G_UNIX_MOUNT_MONITOR,val)
#define Val_GUnixMountMonitor(val) Val_GObject((GObject*)val)
#define Val_GUnixMountMonitor_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixMountMonitorClass' */
#define GUnixMountMonitorClass_val(val) ((GUnixMountMonitorClass*)val)
/* conversion for record 'GUnixMountPoint' */
#define GUnixMountPoint_val(val) ((GUnixMountPoint*)val)
#define GUnixOutputStream_val(val) check_cast(G_UNIX_OUTPUT_STREAM,val)
#define Val_GUnixOutputStream(val) Val_GObject((GObject*)val)
#define Val_GUnixOutputStream_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixOutputStreamClass' */
#define GUnixOutputStreamClass_val(val) ((GUnixOutputStreamClass*)val)
/* conversion for record 'GUnixOutputStreamPrivate' */
#define GUnixOutputStreamPrivate_val(val) ((GUnixOutputStreamPrivate*)val)
#define GUnixSocketAddress_val(val) check_cast(G_UNIX_SOCKET_ADDRESS,val)
#define Val_GUnixSocketAddress(val) Val_GObject((GObject*)val)
#define Val_GUnixSocketAddress_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GUnixSocketAddressClass' */
#define GUnixSocketAddressClass_val(val) ((GUnixSocketAddressClass*)val)
/* conversion for record 'GUnixSocketAddressPrivate' */
#define GUnixSocketAddressPrivate_val(val) ((GUnixSocketAddressPrivate*)val)
#define GVfs_val(val) check_cast(G_VFS,val)
#define Val_GVfs(val) Val_GObject((GObject*)val)
#define Val_GVfs_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GVfsClass' */
#define GVfsClass_val(val) ((GVfsClass*)val)
/* conversion for record 'GVolumeIface' */
#define GVolumeIface_val(val) ((GVolumeIface*)val)
#define GVolumeMonitor_val(val) check_cast(G_VOLUME_MONITOR,val)
#define Val_GVolumeMonitor(val) Val_GObject((GObject*)val)
#define Val_GVolumeMonitor_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GVolumeMonitorClass' */
#define GVolumeMonitorClass_val(val) ((GVolumeMonitorClass*)val)
#define GZlibCompressor_val(val) check_cast(G_ZLIB_COMPRESSOR,val)
#define Val_GZlibCompressor(val) Val_GObject((GObject*)val)
#define Val_GZlibCompressor_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GZlibCompressorClass' */
#define GZlibCompressorClass_val(val) ((GZlibCompressorClass*)val)
#define GZlibDecompressor_val(val) check_cast(G_ZLIB_DECOMPRESSOR,val)
#define Val_GZlibDecompressor(val) Val_GObject((GObject*)val)
#define Val_GZlibDecompressor_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GZlibDecompressorClass' */
#define GZlibDecompressorClass_val(val) ((GZlibDecompressorClass*)val)
#define GdkPixbuf_val(val) check_cast(GDK_PIXBUF,val)
#define Val_GdkPixbuf(val) Val_GObject((GObject*)val)
#define Val_GdkPixbuf_new(val) Val_GObject_new((GObject*)val)
#define GdkPixbufAnimation_val(val) check_cast(GDK_PIXBUF_ANIMATION,val)
#define Val_GdkPixbufAnimation(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufAnimation_new(val) Val_GObject_new((GObject*)val)
#define GdkPixbufAnimationIter_val(val) check_cast(GDK_PIXBUF_ANIMATION_ITER,val)
#define Val_GdkPixbufAnimationIter(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufAnimationIter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkPixbufFormat' */
#define GdkPixbufFormat_val(val) ((GdkPixbufFormat*)val)
#define GdkPixbufLoader_val(val) check_cast(GDK_PIXBUF_LOADER,val)
#define Val_GdkPixbufLoader(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufLoader_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkPixbufLoaderClass' */
#define GdkPixbufLoaderClass_val(val) ((GdkPixbufLoaderClass*)val)
#define GdkPixbufSimpleAnim_val(val) check_cast(GDK_PIXBUF_SIMPLE_ANIM,val)
#define Val_GdkPixbufSimpleAnim(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufSimpleAnim_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkPixbufSimpleAnimClass' */
#define GdkPixbufSimpleAnimClass_val(val) ((GdkPixbufSimpleAnimClass*)val)
/* conversion for record 'GdkPixdata' */
#define GdkPixdata_val(val) ((GdkPixdata*)val)
/* conversion for record 'cairo_t' */
#define cairo_t_val(val) ((cairo_t*)val)
/* conversion for record 'cairo_surface_t' */
#define cairo_surface_t_val(val) ((cairo_surface_t*)val)
/* conversion for record 'cairo_matrix_t' */
#define cairo_matrix_t_val(val) ((cairo_matrix_t*)val)
/* conversion for record 'cairo_pattern_t' */
#define cairo_pattern_t_val(val) ((cairo_pattern_t*)val)
/* conversion for record 'cairo_region_t' */
#define cairo_region_t_val(val) ((cairo_region_t*)val)
/* conversion for record 'cairo_font_options_t' */
#define cairo_font_options_t_val(val) ((cairo_font_options_t*)val)
/* conversion for record 'cairo_font_type_t' */
#define cairo_font_type_t_val(val) ((cairo_font_type_t*)val)
/* conversion for record 'cairo_font_face_t' */
#define cairo_font_face_t_val(val) ((cairo_font_face_t*)val)
/* conversion for record 'cairo_scaled_font_t' */
#define cairo_scaled_font_t_val(val) ((cairo_scaled_font_t*)val)
/* conversion for record 'cairo_path_t' */
#define cairo_path_t_val(val) ((cairo_path_t*)val)
/* conversion for record 'cairo_rectangle_int_t' */
#define cairo_rectangle_int_t_val(val) ((cairo_rectangle_int_t*)val)
/* conversion for record 'PangoAnalysis' */
#define PangoAnalysis_val(val) ((PangoAnalysis*)val)
/* conversion for record 'PangoAttrClass' */
#define PangoAttrClass_val(val) ((PangoAttrClass*)val)
/* conversion for record 'PangoAttrColor' */
#define PangoAttrColor_val(val) ((PangoAttrColor*)val)
/* conversion for record 'PangoAttrFloat' */
#define PangoAttrFloat_val(val) ((PangoAttrFloat*)val)
/* conversion for record 'PangoAttrFontDesc' */
#define PangoAttrFontDesc_val(val) ((PangoAttrFontDesc*)val)
/* conversion for record 'PangoAttrInt' */
#define PangoAttrInt_val(val) ((PangoAttrInt*)val)
/* conversion for record 'PangoAttrIterator' */
#define PangoAttrIterator_val(val) ((PangoAttrIterator*)val)
/* conversion for record 'PangoAttrLanguage' */
#define PangoAttrLanguage_val(val) ((PangoAttrLanguage*)val)
/* conversion for record 'PangoAttrList' */
#define PangoAttrList_val(val) ((PangoAttrList*)val)
/* conversion for record 'PangoAttrShape' */
#define PangoAttrShape_val(val) ((PangoAttrShape*)val)
/* conversion for record 'PangoAttrSize' */
#define PangoAttrSize_val(val) ((PangoAttrSize*)val)
/* conversion for record 'PangoAttrString' */
#define PangoAttrString_val(val) ((PangoAttrString*)val)
/* conversion for record 'PangoAttribute' */
#define PangoAttribute_val(val) ((PangoAttribute*)val)
/* conversion for record 'PangoColor' */
#define PangoColor_val(val) ((PangoColor*)val)
#define PangoContext_val(val) check_cast(PANGO_CONTEXT,val)
#define Val_PangoContext(val) Val_GObject((GObject*)val)
#define Val_PangoContext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'PangoContextClass' */
#define PangoContextClass_val(val) ((PangoContextClass*)val)
/* conversion for record 'PangoCoverage' */
#define PangoCoverage_val(val) ((PangoCoverage*)val)
/* conversion for record 'PangoEngineLang' */
#define PangoEngineLang_val(val) ((PangoEngineLang*)val)
/* conversion for record 'PangoEngineShape' */
#define PangoEngineShape_val(val) ((PangoEngineShape*)val)
#define PangoFont_val(val) check_cast(PANGO_FONT,val)
#define Val_PangoFont(val) Val_GObject((GObject*)val)
#define Val_PangoFont_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'PangoFontDescription' */
#define PangoFontDescription_val(val) ((PangoFontDescription*)val)
#define PangoFontFace_val(val) check_cast(PANGO_FONT_FACE,val)
#define Val_PangoFontFace(val) Val_GObject((GObject*)val)
#define Val_PangoFontFace_new(val) Val_GObject_new((GObject*)val)
#define PangoFontFamily_val(val) check_cast(PANGO_FONT_FAMILY,val)
#define Val_PangoFontFamily(val) Val_GObject((GObject*)val)
#define Val_PangoFontFamily_new(val) Val_GObject_new((GObject*)val)
#define PangoFontMap_val(val) check_cast(PANGO_FONT_MAP,val)
#define Val_PangoFontMap(val) Val_GObject((GObject*)val)
#define Val_PangoFontMap_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'PangoFontMetrics' */
#define PangoFontMetrics_val(val) ((PangoFontMetrics*)val)
#define PangoFontset_val(val) check_cast(PANGO_FONTSET,val)
#define Val_PangoFontset(val) Val_GObject((GObject*)val)
#define Val_PangoFontset_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'PangoGlyphGeometry' */
#define PangoGlyphGeometry_val(val) ((PangoGlyphGeometry*)val)
/* conversion for record 'PangoGlyphInfo' */
#define PangoGlyphInfo_val(val) ((PangoGlyphInfo*)val)
/* conversion for record 'PangoGlyphItem' */
#define PangoGlyphItem_val(val) ((PangoGlyphItem*)val)
/* conversion for record 'PangoGlyphItemIter' */
#define PangoGlyphItemIter_val(val) ((PangoGlyphItemIter*)val)
/* conversion for record 'PangoGlyphString' */
#define PangoGlyphString_val(val) ((PangoGlyphString*)val)
/* conversion for record 'PangoGlyphVisAttr' */
#define PangoGlyphVisAttr_val(val) ((PangoGlyphVisAttr*)val)
/* conversion for record 'PangoItem' */
#define PangoItem_val(val) ((PangoItem*)val)
/* conversion for record 'PangoLanguage' */
#define PangoLanguage_val(val) ((PangoLanguage*)val)
#define PangoLayout_val(val) check_cast(PANGO_LAYOUT,val)
#define Val_PangoLayout(val) Val_GObject((GObject*)val)
#define Val_PangoLayout_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'PangoLayoutClass' */
#define PangoLayoutClass_val(val) ((PangoLayoutClass*)val)
/* conversion for record 'PangoLayoutIter' */
#define PangoLayoutIter_val(val) ((PangoLayoutIter*)val)
/* conversion for record 'PangoLayoutLine' */
#define PangoLayoutLine_val(val) ((PangoLayoutLine*)val)
/* conversion for record 'PangoLogAttr' */
#define PangoLogAttr_val(val) ((PangoLogAttr*)val)
/* conversion for record 'PangoMatrix' */
#define PangoMatrix_val(val) ((PangoMatrix*)val)
/* conversion for record 'PangoRectangle' */
#define PangoRectangle_val(val) ((PangoRectangle*)val)
#define PangoRenderer_val(val) check_cast(PANGO_RENDERER,val)
#define Val_PangoRenderer(val) Val_GObject((GObject*)val)
#define Val_PangoRenderer_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'PangoRendererClass' */
#define PangoRendererClass_val(val) ((PangoRendererClass*)val)
/* conversion for record 'PangoRendererPrivate' */
#define PangoRendererPrivate_val(val) ((PangoRendererPrivate*)val)
/* conversion for record 'PangoScriptIter' */
#define PangoScriptIter_val(val) ((PangoScriptIter*)val)
/* conversion for record 'PangoTabArray' */
#define PangoTabArray_val(val) ((PangoTabArray*)val)
/* conversion for record '_PangoScriptForLang' */
#define _PangoScriptForLang_val(val) ((_PangoScriptForLang*)val)
#define GdkAppLaunchContext_val(val) check_cast(GDK_APP_LAUNCH_CONTEXT,val)
#define Val_GdkAppLaunchContext(val) Val_GObject((GObject*)val)
#define Val_GdkAppLaunchContext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkAtom' */
#define GdkAtom_val(val) ((GdkAtom*)val)
/* conversion for record 'GdkColor' */
#define GdkColor_val(val) ((GdkColor*)val)
#define GdkCursor_val(val) check_cast(GDK_CURSOR,val)
#define Val_GdkCursor(val) Val_GObject((GObject*)val)
#define Val_GdkCursor_new(val) Val_GObject_new((GObject*)val)
#define GdkDevice_val(val) check_cast(GDK_DEVICE,val)
#define Val_GdkDevice(val) Val_GObject((GObject*)val)
#define Val_GdkDevice_new(val) Val_GObject_new((GObject*)val)
#define GdkDeviceManager_val(val) check_cast(GDK_DEVICE_MANAGER,val)
#define Val_GdkDeviceManager(val) Val_GObject((GObject*)val)
#define Val_GdkDeviceManager_new(val) Val_GObject_new((GObject*)val)
#define GdkDisplay_val(val) check_cast(GDK_DISPLAY_OBJECT,val)
#define Val_GdkDisplay(val) Val_GObject((GObject*)val)
#define Val_GdkDisplay_new(val) Val_GObject_new((GObject*)val)
#define GdkDisplayManager_val(val) check_cast(GDK_DISPLAY_MANAGER,val)
#define Val_GdkDisplayManager(val) Val_GObject((GObject*)val)
#define Val_GdkDisplayManager_new(val) Val_GObject_new((GObject*)val)
#define GdkDragContext_val(val) check_cast(GDK_DRAG_CONTEXT,val)
#define Val_GdkDragContext(val) Val_GObject((GObject*)val)
#define Val_GdkDragContext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkEventAny' */
#define GdkEventAny_val(val) ((GdkEventAny*)val)
/* conversion for record 'GdkEventButton' */
#define GdkEventButton_val(val) ((GdkEventButton*)val)
/* conversion for record 'GdkEventConfigure' */
#define GdkEventConfigure_val(val) ((GdkEventConfigure*)val)
/* conversion for record 'GdkEventCrossing' */
#define GdkEventCrossing_val(val) ((GdkEventCrossing*)val)
/* conversion for record 'GdkEventDND' */
#define GdkEventDND_val(val) ((GdkEventDND*)val)
/* conversion for record 'GdkEventExpose' */
#define GdkEventExpose_val(val) ((GdkEventExpose*)val)
/* conversion for record 'GdkEventFocus' */
#define GdkEventFocus_val(val) ((GdkEventFocus*)val)
/* conversion for record 'GdkEventGrabBroken' */
#define GdkEventGrabBroken_val(val) ((GdkEventGrabBroken*)val)
/* conversion for record 'GdkEventKey' */
#define GdkEventKey_val(val) ((GdkEventKey*)val)
/* conversion for record 'GdkEventMotion' */
#define GdkEventMotion_val(val) ((GdkEventMotion*)val)
/* conversion for record 'GdkEventOwnerChange' */
#define GdkEventOwnerChange_val(val) ((GdkEventOwnerChange*)val)
/* conversion for record 'GdkEventProperty' */
#define GdkEventProperty_val(val) ((GdkEventProperty*)val)
/* conversion for record 'GdkEventProximity' */
#define GdkEventProximity_val(val) ((GdkEventProximity*)val)
/* conversion for record 'GdkEventScroll' */
#define GdkEventScroll_val(val) ((GdkEventScroll*)val)
/* conversion for record 'GdkEventSelection' */
#define GdkEventSelection_val(val) ((GdkEventSelection*)val)
/* conversion for record 'GdkEventSequence' */
#define GdkEventSequence_val(val) ((GdkEventSequence*)val)
/* conversion for record 'GdkEventSetting' */
#define GdkEventSetting_val(val) ((GdkEventSetting*)val)
/* conversion for record 'GdkEventTouch' */
#define GdkEventTouch_val(val) ((GdkEventTouch*)val)
/* conversion for record 'GdkEventVisibility' */
#define GdkEventVisibility_val(val) ((GdkEventVisibility*)val)
/* conversion for record 'GdkEventWindowState' */
#define GdkEventWindowState_val(val) ((GdkEventWindowState*)val)
/* conversion for record 'GdkGeometry' */
#define GdkGeometry_val(val) ((GdkGeometry*)val)
#define GdkKeymap_val(val) check_cast(GDK_KEYMAP,val)
#define Val_GdkKeymap(val) Val_GObject((GObject*)val)
#define Val_GdkKeymap_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkKeymapKey' */
#define GdkKeymapKey_val(val) ((GdkKeymapKey*)val)
/* conversion for record 'GdkPoint' */
#define GdkPoint_val(val) ((GdkPoint*)val)
/* conversion for record 'GdkRGBA' */
#define GdkRGBA_val(val) ((GdkRGBA*)val)
#define GdkScreen_val(val) check_cast(GDK_SCREEN,val)
#define Val_GdkScreen(val) Val_GObject((GObject*)val)
#define Val_GdkScreen_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkTimeCoord' */
#define GdkTimeCoord_val(val) ((GdkTimeCoord*)val)
#define GdkVisual_val(val) check_cast(GDK_VISUAL,val)
#define Val_GdkVisual(val) Val_GObject((GObject*)val)
#define Val_GdkVisual_new(val) Val_GObject_new((GObject*)val)
#define GdkWindow_val(val) check_cast(GDK_WINDOW,val)
#define Val_GdkWindow(val) Val_GObject((GObject*)val)
#define Val_GdkWindow_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GdkWindowAttr' */
#define GdkWindowAttr_val(val) ((GdkWindowAttr*)val)
/* conversion for record 'GdkWindowClass' */
#define GdkWindowClass_val(val) ((GdkWindowClass*)val)
/* conversion for record 'GdkWindowRedirect' */
#define GdkWindowRedirect_val(val) ((GdkWindowRedirect*)val)
/* conversion for record 'Display' */
#define Display_val(val) ((Display*)val)
/* conversion for record 'Screen' */
#define Screen_val(val) ((Screen*)val)
/* conversion for record 'Visual' */
#define Visual_val(val) ((Visual*)val)
/* conversion for record 'XConfigureEvent' */
#define XConfigureEvent_val(val) ((XConfigureEvent*)val)
/* conversion for record 'XImage' */
#define XImage_val(val) ((XImage*)val)
/* conversion for record 'XFontStruct' */
#define XFontStruct_val(val) ((XFontStruct*)val)
/* conversion for record 'XTrapezoid' */
#define XTrapezoid_val(val) ((XTrapezoid*)val)
/* conversion for record 'XVisualInfo' */
#define XVisualInfo_val(val) ((XVisualInfo*)val)
/* conversion for record 'XWindowAttributes' */
#define XWindowAttributes_val(val) ((XWindowAttributes*)val)
#define GtkAboutDialog_val(val) check_cast(GTK_ABOUT_DIALOG,val)
#define Val_GtkAboutDialog(val) Val_GObject((GObject*)val)
#define Val_GtkAboutDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAboutDialogClass' */
#define GtkAboutDialogClass_val(val) ((GtkAboutDialogClass*)val)
/* conversion for record 'GtkAboutDialogPrivate' */
#define GtkAboutDialogPrivate_val(val) ((GtkAboutDialogPrivate*)val)
#define GtkAccelGroup_val(val) check_cast(GTK_ACCEL_GROUP,val)
#define Val_GtkAccelGroup(val) Val_GObject((GObject*)val)
#define Val_GtkAccelGroup_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAccelGroupClass' */
#define GtkAccelGroupClass_val(val) ((GtkAccelGroupClass*)val)
/* conversion for record 'GtkAccelGroupEntry' */
#define GtkAccelGroupEntry_val(val) ((GtkAccelGroupEntry*)val)
/* conversion for record 'GtkAccelGroupPrivate' */
#define GtkAccelGroupPrivate_val(val) ((GtkAccelGroupPrivate*)val)
/* conversion for record 'GtkAccelKey' */
#define GtkAccelKey_val(val) ((GtkAccelKey*)val)
#define GtkAccelLabel_val(val) check_cast(GTK_ACCEL_LABEL,val)
#define Val_GtkAccelLabel(val) Val_GObject((GObject*)val)
#define Val_GtkAccelLabel_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAccelLabelClass' */
#define GtkAccelLabelClass_val(val) ((GtkAccelLabelClass*)val)
/* conversion for record 'GtkAccelLabelPrivate' */
#define GtkAccelLabelPrivate_val(val) ((GtkAccelLabelPrivate*)val)
#define GtkAccelMap_val(val) check_cast(GTK_ACCEL_MAP,val)
#define Val_GtkAccelMap(val) Val_GObject((GObject*)val)
#define Val_GtkAccelMap_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAccelMapClass' */
#define GtkAccelMapClass_val(val) ((GtkAccelMapClass*)val)
#define GtkAccessible_val(val) check_cast(GTK_ACCESSIBLE,val)
#define Val_GtkAccessible(val) Val_GObject((GObject*)val)
#define Val_GtkAccessible_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAccessibleClass' */
#define GtkAccessibleClass_val(val) ((GtkAccessibleClass*)val)
/* conversion for record 'GtkAccessiblePrivate' */
#define GtkAccessiblePrivate_val(val) ((GtkAccessiblePrivate*)val)
#define GtkAction_val(val) check_cast(GTK_ACTION,val)
#define Val_GtkAction(val) Val_GObject((GObject*)val)
#define Val_GtkAction_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkActionClass' */
#define GtkActionClass_val(val) ((GtkActionClass*)val)
/* conversion for record 'GtkActionEntry' */
#define GtkActionEntry_val(val) ((GtkActionEntry*)val)
#define GtkActionGroup_val(val) check_cast(GTK_ACTION_GROUP,val)
#define Val_GtkActionGroup(val) Val_GObject((GObject*)val)
#define Val_GtkActionGroup_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkActionGroupClass' */
#define GtkActionGroupClass_val(val) ((GtkActionGroupClass*)val)
/* conversion for record 'GtkActionGroupPrivate' */
#define GtkActionGroupPrivate_val(val) ((GtkActionGroupPrivate*)val)
/* conversion for record 'GtkActionPrivate' */
#define GtkActionPrivate_val(val) ((GtkActionPrivate*)val)
/* conversion for record 'GtkActionableInterface' */
#define GtkActionableInterface_val(val) ((GtkActionableInterface*)val)
/* conversion for record 'GtkActivatableIface' */
#define GtkActivatableIface_val(val) ((GtkActivatableIface*)val)
#define GtkAdjustment_val(val) check_cast(GTK_ADJUSTMENT,val)
#define Val_GtkAdjustment(val) Val_GObject((GObject*)val)
#define Val_GtkAdjustment_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAdjustmentClass' */
#define GtkAdjustmentClass_val(val) ((GtkAdjustmentClass*)val)
/* conversion for record 'GtkAdjustmentPrivate' */
#define GtkAdjustmentPrivate_val(val) ((GtkAdjustmentPrivate*)val)
#define GtkAlignment_val(val) check_cast(GTK_ALIGNMENT,val)
#define Val_GtkAlignment(val) Val_GObject((GObject*)val)
#define Val_GtkAlignment_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAlignmentClass' */
#define GtkAlignmentClass_val(val) ((GtkAlignmentClass*)val)
/* conversion for record 'GtkAlignmentPrivate' */
#define GtkAlignmentPrivate_val(val) ((GtkAlignmentPrivate*)val)
#define GtkAppChooserButton_val(val) check_cast(GTK_APP_CHOOSER_BUTTON,val)
#define Val_GtkAppChooserButton(val) Val_GObject((GObject*)val)
#define Val_GtkAppChooserButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAppChooserButtonClass' */
#define GtkAppChooserButtonClass_val(val) ((GtkAppChooserButtonClass*)val)
/* conversion for record 'GtkAppChooserButtonPrivate' */
#define GtkAppChooserButtonPrivate_val(val) ((GtkAppChooserButtonPrivate*)val)
#define GtkAppChooserDialog_val(val) check_cast(GTK_APP_CHOOSER_DIALOG,val)
#define Val_GtkAppChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkAppChooserDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAppChooserDialogClass' */
#define GtkAppChooserDialogClass_val(val) ((GtkAppChooserDialogClass*)val)
/* conversion for record 'GtkAppChooserDialogPrivate' */
#define GtkAppChooserDialogPrivate_val(val) ((GtkAppChooserDialogPrivate*)val)
#define GtkAppChooserWidget_val(val) check_cast(GTK_APP_CHOOSER_WIDGET,val)
#define Val_GtkAppChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkAppChooserWidget_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAppChooserWidgetClass' */
#define GtkAppChooserWidgetClass_val(val) ((GtkAppChooserWidgetClass*)val)
/* conversion for record 'GtkAppChooserWidgetPrivate' */
#define GtkAppChooserWidgetPrivate_val(val) ((GtkAppChooserWidgetPrivate*)val)
#define GtkApplication_val(val) check_cast(GTK_APPLICATION,val)
#define Val_GtkApplication(val) Val_GObject((GObject*)val)
#define Val_GtkApplication_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkApplicationClass' */
#define GtkApplicationClass_val(val) ((GtkApplicationClass*)val)
/* conversion for record 'GtkApplicationPrivate' */
#define GtkApplicationPrivate_val(val) ((GtkApplicationPrivate*)val)
#define GtkApplicationWindow_val(val) check_cast(GTK_APPLICATION_WINDOW,val)
#define Val_GtkApplicationWindow(val) Val_GObject((GObject*)val)
#define Val_GtkApplicationWindow_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkApplicationWindowClass' */
#define GtkApplicationWindowClass_val(val) ((GtkApplicationWindowClass*)val)
/* conversion for record 'GtkApplicationWindowPrivate' */
#define GtkApplicationWindowPrivate_val(val) ((GtkApplicationWindowPrivate*)val)
#define GtkArrow_val(val) check_cast(GTK_ARROW,val)
#define Val_GtkArrow(val) Val_GObject((GObject*)val)
#define Val_GtkArrow_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkArrowClass' */
#define GtkArrowClass_val(val) ((GtkArrowClass*)val)
/* conversion for record 'GtkArrowPrivate' */
#define GtkArrowPrivate_val(val) ((GtkArrowPrivate*)val)
#define GtkAspectFrame_val(val) check_cast(GTK_ASPECT_FRAME,val)
#define Val_GtkAspectFrame(val) Val_GObject((GObject*)val)
#define Val_GtkAspectFrame_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAspectFrameClass' */
#define GtkAspectFrameClass_val(val) ((GtkAspectFrameClass*)val)
/* conversion for record 'GtkAspectFramePrivate' */
#define GtkAspectFramePrivate_val(val) ((GtkAspectFramePrivate*)val)
#define GtkAssistant_val(val) check_cast(GTK_ASSISTANT,val)
#define Val_GtkAssistant(val) Val_GObject((GObject*)val)
#define Val_GtkAssistant_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkAssistantClass' */
#define GtkAssistantClass_val(val) ((GtkAssistantClass*)val)
/* conversion for record 'GtkAssistantPrivate' */
#define GtkAssistantPrivate_val(val) ((GtkAssistantPrivate*)val)
#define GtkBin_val(val) check_cast(GTK_BIN,val)
#define Val_GtkBin(val) Val_GObject((GObject*)val)
#define Val_GtkBin_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkBinClass' */
#define GtkBinClass_val(val) ((GtkBinClass*)val)
/* conversion for record 'GtkBinPrivate' */
#define GtkBinPrivate_val(val) ((GtkBinPrivate*)val)
/* conversion for record 'GtkBindingArg' */
#define GtkBindingArg_val(val) ((GtkBindingArg*)val)
/* conversion for record 'GtkBindingEntry' */
#define GtkBindingEntry_val(val) ((GtkBindingEntry*)val)
/* conversion for record 'GtkBindingSet' */
#define GtkBindingSet_val(val) ((GtkBindingSet*)val)
/* conversion for record 'GtkBindingSignal' */
#define GtkBindingSignal_val(val) ((GtkBindingSignal*)val)
/* conversion for record 'GtkBorder' */
#define GtkBorder_val(val) ((GtkBorder*)val)
#define GtkBox_val(val) check_cast(GTK_BOX,val)
#define Val_GtkBox(val) Val_GObject((GObject*)val)
#define Val_GtkBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkBoxClass' */
#define GtkBoxClass_val(val) ((GtkBoxClass*)val)
/* conversion for record 'GtkBoxPrivate' */
#define GtkBoxPrivate_val(val) ((GtkBoxPrivate*)val)
/* conversion for record 'GtkBuildableIface' */
#define GtkBuildableIface_val(val) ((GtkBuildableIface*)val)
#define GtkBuilder_val(val) check_cast(GTK_BUILDER,val)
#define Val_GtkBuilder(val) Val_GObject((GObject*)val)
#define Val_GtkBuilder_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkBuilderClass' */
#define GtkBuilderClass_val(val) ((GtkBuilderClass*)val)
/* conversion for record 'GtkBuilderPrivate' */
#define GtkBuilderPrivate_val(val) ((GtkBuilderPrivate*)val)
#define GtkButton_val(val) check_cast(GTK_BUTTON,val)
#define Val_GtkButton(val) Val_GObject((GObject*)val)
#define Val_GtkButton_new(val) Val_GObject_new((GObject*)val)
#define GtkButtonBox_val(val) check_cast(GTK_BUTTON_BOX,val)
#define Val_GtkButtonBox(val) Val_GObject((GObject*)val)
#define Val_GtkButtonBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkButtonBoxClass' */
#define GtkButtonBoxClass_val(val) ((GtkButtonBoxClass*)val)
/* conversion for record 'GtkButtonBoxPrivate' */
#define GtkButtonBoxPrivate_val(val) ((GtkButtonBoxPrivate*)val)
/* conversion for record 'GtkButtonClass' */
#define GtkButtonClass_val(val) ((GtkButtonClass*)val)
/* conversion for record 'GtkButtonPrivate' */
#define GtkButtonPrivate_val(val) ((GtkButtonPrivate*)val)
#define GtkCalendar_val(val) check_cast(GTK_CALENDAR,val)
#define Val_GtkCalendar(val) Val_GObject((GObject*)val)
#define Val_GtkCalendar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCalendarClass' */
#define GtkCalendarClass_val(val) ((GtkCalendarClass*)val)
/* conversion for record 'GtkCalendarPrivate' */
#define GtkCalendarPrivate_val(val) ((GtkCalendarPrivate*)val)
#define GtkCellArea_val(val) check_cast(GTK_CELL_AREA,val)
#define Val_GtkCellArea(val) Val_GObject((GObject*)val)
#define Val_GtkCellArea_new(val) Val_GObject_new((GObject*)val)
#define GtkCellAreaBox_val(val) check_cast(GTK_CELL_AREA_BOX,val)
#define Val_GtkCellAreaBox(val) Val_GObject((GObject*)val)
#define Val_GtkCellAreaBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellAreaBoxClass' */
#define GtkCellAreaBoxClass_val(val) ((GtkCellAreaBoxClass*)val)
/* conversion for record 'GtkCellAreaBoxPrivate' */
#define GtkCellAreaBoxPrivate_val(val) ((GtkCellAreaBoxPrivate*)val)
/* conversion for record 'GtkCellAreaClass' */
#define GtkCellAreaClass_val(val) ((GtkCellAreaClass*)val)
#define GtkCellAreaContext_val(val) check_cast(GTK_CELL_AREA_CONTEXT,val)
#define Val_GtkCellAreaContext(val) Val_GObject((GObject*)val)
#define Val_GtkCellAreaContext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellAreaContextClass' */
#define GtkCellAreaContextClass_val(val) ((GtkCellAreaContextClass*)val)
/* conversion for record 'GtkCellAreaContextPrivate' */
#define GtkCellAreaContextPrivate_val(val) ((GtkCellAreaContextPrivate*)val)
/* conversion for record 'GtkCellAreaPrivate' */
#define GtkCellAreaPrivate_val(val) ((GtkCellAreaPrivate*)val)
/* conversion for record 'GtkCellEditableIface' */
#define GtkCellEditableIface_val(val) ((GtkCellEditableIface*)val)
/* conversion for record 'GtkCellLayoutIface' */
#define GtkCellLayoutIface_val(val) ((GtkCellLayoutIface*)val)
#define GtkCellRenderer_val(val) check_cast(GTK_CELL_RENDERER,val)
#define Val_GtkCellRenderer(val) Val_GObject((GObject*)val)
#define Val_GtkCellRenderer_new(val) Val_GObject_new((GObject*)val)
#define GtkCellRendererAccel_val(val) check_cast(GTK_CELL_RENDERER_ACCEL,val)
#define Val_GtkCellRendererAccel(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererAccel_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererAccelClass' */
#define GtkCellRendererAccelClass_val(val) ((GtkCellRendererAccelClass*)val)
/* conversion for record 'GtkCellRendererAccelPrivate' */
#define GtkCellRendererAccelPrivate_val(val) ((GtkCellRendererAccelPrivate*)val)
/* conversion for record 'GtkCellRendererClass' */
#define GtkCellRendererClass_val(val) ((GtkCellRendererClass*)val)
/* conversion for record 'GtkCellRendererClassPrivate' */
#define GtkCellRendererClassPrivate_val(val) ((GtkCellRendererClassPrivate*)val)
#define GtkCellRendererCombo_val(val) check_cast(GTK_CELL_RENDERER_COMBO,val)
#define Val_GtkCellRendererCombo(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererCombo_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererComboClass' */
#define GtkCellRendererComboClass_val(val) ((GtkCellRendererComboClass*)val)
/* conversion for record 'GtkCellRendererComboPrivate' */
#define GtkCellRendererComboPrivate_val(val) ((GtkCellRendererComboPrivate*)val)
#define GtkCellRendererPixbuf_val(val) check_cast(GTK_CELL_RENDERER_PIXBUF,val)
#define Val_GtkCellRendererPixbuf(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererPixbuf_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererPixbufClass' */
#define GtkCellRendererPixbufClass_val(val) ((GtkCellRendererPixbufClass*)val)
/* conversion for record 'GtkCellRendererPixbufPrivate' */
#define GtkCellRendererPixbufPrivate_val(val) ((GtkCellRendererPixbufPrivate*)val)
/* conversion for record 'GtkCellRendererPrivate' */
#define GtkCellRendererPrivate_val(val) ((GtkCellRendererPrivate*)val)
#define GtkCellRendererProgress_val(val) check_cast(GTK_CELL_RENDERER_PROGRESS,val)
#define Val_GtkCellRendererProgress(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererProgress_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererProgressClass' */
#define GtkCellRendererProgressClass_val(val) ((GtkCellRendererProgressClass*)val)
/* conversion for record 'GtkCellRendererProgressPrivate' */
#define GtkCellRendererProgressPrivate_val(val) ((GtkCellRendererProgressPrivate*)val)
#define GtkCellRendererSpin_val(val) check_cast(GTK_CELL_RENDERER_SPIN,val)
#define Val_GtkCellRendererSpin(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererSpin_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererSpinClass' */
#define GtkCellRendererSpinClass_val(val) ((GtkCellRendererSpinClass*)val)
/* conversion for record 'GtkCellRendererSpinPrivate' */
#define GtkCellRendererSpinPrivate_val(val) ((GtkCellRendererSpinPrivate*)val)
#define GtkCellRendererSpinner_val(val) check_cast(GTK_CELL_RENDERER_SPINNER,val)
#define Val_GtkCellRendererSpinner(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererSpinner_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererSpinnerClass' */
#define GtkCellRendererSpinnerClass_val(val) ((GtkCellRendererSpinnerClass*)val)
/* conversion for record 'GtkCellRendererSpinnerPrivate' */
#define GtkCellRendererSpinnerPrivate_val(val) ((GtkCellRendererSpinnerPrivate*)val)
#define GtkCellRendererText_val(val) check_cast(GTK_CELL_RENDERER_TEXT,val)
#define Val_GtkCellRendererText(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererText_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererTextClass' */
#define GtkCellRendererTextClass_val(val) ((GtkCellRendererTextClass*)val)
/* conversion for record 'GtkCellRendererTextPrivate' */
#define GtkCellRendererTextPrivate_val(val) ((GtkCellRendererTextPrivate*)val)
#define GtkCellRendererToggle_val(val) check_cast(GTK_CELL_RENDERER_TOGGLE,val)
#define Val_GtkCellRendererToggle(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererToggle_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellRendererToggleClass' */
#define GtkCellRendererToggleClass_val(val) ((GtkCellRendererToggleClass*)val)
/* conversion for record 'GtkCellRendererTogglePrivate' */
#define GtkCellRendererTogglePrivate_val(val) ((GtkCellRendererTogglePrivate*)val)
#define GtkCellView_val(val) check_cast(GTK_CELL_VIEW,val)
#define Val_GtkCellView(val) Val_GObject((GObject*)val)
#define Val_GtkCellView_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCellViewClass' */
#define GtkCellViewClass_val(val) ((GtkCellViewClass*)val)
/* conversion for record 'GtkCellViewPrivate' */
#define GtkCellViewPrivate_val(val) ((GtkCellViewPrivate*)val)
#define GtkCheckButton_val(val) check_cast(GTK_CHECK_BUTTON,val)
#define Val_GtkCheckButton(val) Val_GObject((GObject*)val)
#define Val_GtkCheckButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCheckButtonClass' */
#define GtkCheckButtonClass_val(val) ((GtkCheckButtonClass*)val)
#define GtkCheckMenuItem_val(val) check_cast(GTK_CHECK_MENU_ITEM,val)
#define Val_GtkCheckMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkCheckMenuItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCheckMenuItemClass' */
#define GtkCheckMenuItemClass_val(val) ((GtkCheckMenuItemClass*)val)
/* conversion for record 'GtkCheckMenuItemPrivate' */
#define GtkCheckMenuItemPrivate_val(val) ((GtkCheckMenuItemPrivate*)val)
#define GtkClipboard_val(val) check_cast(GTK_CLIPBOARD,val)
#define Val_GtkClipboard(val) Val_GObject((GObject*)val)
#define Val_GtkClipboard_new(val) Val_GObject_new((GObject*)val)
#define GtkColorButton_val(val) check_cast(GTK_COLOR_BUTTON,val)
#define Val_GtkColorButton(val) Val_GObject((GObject*)val)
#define Val_GtkColorButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkColorButtonClass' */
#define GtkColorButtonClass_val(val) ((GtkColorButtonClass*)val)
/* conversion for record 'GtkColorButtonPrivate' */
#define GtkColorButtonPrivate_val(val) ((GtkColorButtonPrivate*)val)
#define GtkColorChooserDialog_val(val) check_cast(GTK_COLOR_CHOOSER_DIALOG,val)
#define Val_GtkColorChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkColorChooserDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkColorChooserDialogClass' */
#define GtkColorChooserDialogClass_val(val) ((GtkColorChooserDialogClass*)val)
/* conversion for record 'GtkColorChooserDialogPrivate' */
#define GtkColorChooserDialogPrivate_val(val) ((GtkColorChooserDialogPrivate*)val)
/* conversion for record 'GtkColorChooserInterface' */
#define GtkColorChooserInterface_val(val) ((GtkColorChooserInterface*)val)
#define GtkColorChooserWidget_val(val) check_cast(GTK_COLOR_CHOOSER_WIDGET,val)
#define Val_GtkColorChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkColorChooserWidget_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkColorChooserWidgetClass' */
#define GtkColorChooserWidgetClass_val(val) ((GtkColorChooserWidgetClass*)val)
/* conversion for record 'GtkColorChooserWidgetPrivate' */
#define GtkColorChooserWidgetPrivate_val(val) ((GtkColorChooserWidgetPrivate*)val)
#define GtkColorSelection_val(val) check_cast(GTK_COLOR_SELECTION,val)
#define Val_GtkColorSelection(val) Val_GObject((GObject*)val)
#define Val_GtkColorSelection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkColorSelectionClass' */
#define GtkColorSelectionClass_val(val) ((GtkColorSelectionClass*)val)
#define GtkColorSelectionDialog_val(val) check_cast(GTK_COLOR_SELECTION_DIALOG,val)
#define Val_GtkColorSelectionDialog(val) Val_GObject((GObject*)val)
#define Val_GtkColorSelectionDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkColorSelectionDialogClass' */
#define GtkColorSelectionDialogClass_val(val) ((GtkColorSelectionDialogClass*)val)
/* conversion for record 'GtkColorSelectionDialogPrivate' */
#define GtkColorSelectionDialogPrivate_val(val) ((GtkColorSelectionDialogPrivate*)val)
/* conversion for record 'GtkColorSelectionPrivate' */
#define GtkColorSelectionPrivate_val(val) ((GtkColorSelectionPrivate*)val)
#define GtkComboBox_val(val) check_cast(GTK_COMBO_BOX,val)
#define Val_GtkComboBox(val) Val_GObject((GObject*)val)
#define Val_GtkComboBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkComboBoxClass' */
#define GtkComboBoxClass_val(val) ((GtkComboBoxClass*)val)
/* conversion for record 'GtkComboBoxPrivate' */
#define GtkComboBoxPrivate_val(val) ((GtkComboBoxPrivate*)val)
#define GtkComboBoxText_val(val) check_cast(GTK_COMBO_BOX_TEXT,val)
#define Val_GtkComboBoxText(val) Val_GObject((GObject*)val)
#define Val_GtkComboBoxText_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkComboBoxTextClass' */
#define GtkComboBoxTextClass_val(val) ((GtkComboBoxTextClass*)val)
/* conversion for record 'GtkComboBoxTextPrivate' */
#define GtkComboBoxTextPrivate_val(val) ((GtkComboBoxTextPrivate*)val)
#define GtkContainer_val(val) check_cast(GTK_CONTAINER,val)
#define Val_GtkContainer(val) Val_GObject((GObject*)val)
#define Val_GtkContainer_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkContainerClass' */
#define GtkContainerClass_val(val) ((GtkContainerClass*)val)
/* conversion for record 'GtkContainerPrivate' */
#define GtkContainerPrivate_val(val) ((GtkContainerPrivate*)val)
#define GtkCssProvider_val(val) check_cast(GTK_CSS_PROVIDER,val)
#define Val_GtkCssProvider(val) Val_GObject((GObject*)val)
#define Val_GtkCssProvider_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkCssProviderClass' */
#define GtkCssProviderClass_val(val) ((GtkCssProviderClass*)val)
/* conversion for record 'GtkCssProviderPrivate' */
#define GtkCssProviderPrivate_val(val) ((GtkCssProviderPrivate*)val)
/* conversion for record 'GtkCssSection' */
#define GtkCssSection_val(val) ((GtkCssSection*)val)
#define GtkDialog_val(val) check_cast(GTK_DIALOG,val)
#define Val_GtkDialog(val) Val_GObject((GObject*)val)
#define Val_GtkDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkDialogClass' */
#define GtkDialogClass_val(val) ((GtkDialogClass*)val)
/* conversion for record 'GtkDialogPrivate' */
#define GtkDialogPrivate_val(val) ((GtkDialogPrivate*)val)
#define GtkDrawingArea_val(val) check_cast(GTK_DRAWING_AREA,val)
#define Val_GtkDrawingArea(val) Val_GObject((GObject*)val)
#define Val_GtkDrawingArea_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkDrawingAreaClass' */
#define GtkDrawingAreaClass_val(val) ((GtkDrawingAreaClass*)val)
/* conversion for record 'GtkEditableInterface' */
#define GtkEditableInterface_val(val) ((GtkEditableInterface*)val)
#define GtkEntry_val(val) check_cast(GTK_ENTRY,val)
#define Val_GtkEntry(val) Val_GObject((GObject*)val)
#define Val_GtkEntry_new(val) Val_GObject_new((GObject*)val)
#define GtkEntryBuffer_val(val) check_cast(GTK_ENTRY_BUFFER,val)
#define Val_GtkEntryBuffer(val) Val_GObject((GObject*)val)
#define Val_GtkEntryBuffer_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkEntryBufferClass' */
#define GtkEntryBufferClass_val(val) ((GtkEntryBufferClass*)val)
/* conversion for record 'GtkEntryBufferPrivate' */
#define GtkEntryBufferPrivate_val(val) ((GtkEntryBufferPrivate*)val)
/* conversion for record 'GtkEntryClass' */
#define GtkEntryClass_val(val) ((GtkEntryClass*)val)
#define GtkEntryCompletion_val(val) check_cast(GTK_ENTRY_COMPLETION,val)
#define Val_GtkEntryCompletion(val) Val_GObject((GObject*)val)
#define Val_GtkEntryCompletion_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkEntryCompletionClass' */
#define GtkEntryCompletionClass_val(val) ((GtkEntryCompletionClass*)val)
/* conversion for record 'GtkEntryCompletionPrivate' */
#define GtkEntryCompletionPrivate_val(val) ((GtkEntryCompletionPrivate*)val)
/* conversion for record 'GtkEntryPrivate' */
#define GtkEntryPrivate_val(val) ((GtkEntryPrivate*)val)
#define GtkEventBox_val(val) check_cast(GTK_EVENT_BOX,val)
#define Val_GtkEventBox(val) Val_GObject((GObject*)val)
#define Val_GtkEventBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkEventBoxClass' */
#define GtkEventBoxClass_val(val) ((GtkEventBoxClass*)val)
/* conversion for record 'GtkEventBoxPrivate' */
#define GtkEventBoxPrivate_val(val) ((GtkEventBoxPrivate*)val)
#define GtkExpander_val(val) check_cast(GTK_EXPANDER,val)
#define Val_GtkExpander(val) Val_GObject((GObject*)val)
#define Val_GtkExpander_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkExpanderClass' */
#define GtkExpanderClass_val(val) ((GtkExpanderClass*)val)
/* conversion for record 'GtkExpanderPrivate' */
#define GtkExpanderPrivate_val(val) ((GtkExpanderPrivate*)val)
#define GtkFileChooserButton_val(val) check_cast(GTK_FILE_CHOOSER_BUTTON,val)
#define Val_GtkFileChooserButton(val) Val_GObject((GObject*)val)
#define Val_GtkFileChooserButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFileChooserButtonClass' */
#define GtkFileChooserButtonClass_val(val) ((GtkFileChooserButtonClass*)val)
/* conversion for record 'GtkFileChooserButtonPrivate' */
#define GtkFileChooserButtonPrivate_val(val) ((GtkFileChooserButtonPrivate*)val)
#define GtkFileChooserDialog_val(val) check_cast(GTK_FILE_CHOOSER_DIALOG,val)
#define Val_GtkFileChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkFileChooserDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFileChooserDialogClass' */
#define GtkFileChooserDialogClass_val(val) ((GtkFileChooserDialogClass*)val)
/* conversion for record 'GtkFileChooserDialogPrivate' */
#define GtkFileChooserDialogPrivate_val(val) ((GtkFileChooserDialogPrivate*)val)
#define GtkFileChooserWidget_val(val) check_cast(GTK_FILE_CHOOSER_WIDGET,val)
#define Val_GtkFileChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkFileChooserWidget_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFileChooserWidgetClass' */
#define GtkFileChooserWidgetClass_val(val) ((GtkFileChooserWidgetClass*)val)
/* conversion for record 'GtkFileChooserWidgetPrivate' */
#define GtkFileChooserWidgetPrivate_val(val) ((GtkFileChooserWidgetPrivate*)val)
#define GtkFileFilter_val(val) check_cast(GTK_FILE_FILTER,val)
#define Val_GtkFileFilter(val) Val_GObject((GObject*)val)
#define Val_GtkFileFilter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFileFilterInfo' */
#define GtkFileFilterInfo_val(val) ((GtkFileFilterInfo*)val)
#define GtkFixed_val(val) check_cast(GTK_FIXED,val)
#define Val_GtkFixed(val) Val_GObject((GObject*)val)
#define Val_GtkFixed_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFixedChild' */
#define GtkFixedChild_val(val) ((GtkFixedChild*)val)
/* conversion for record 'GtkFixedClass' */
#define GtkFixedClass_val(val) ((GtkFixedClass*)val)
/* conversion for record 'GtkFixedPrivate' */
#define GtkFixedPrivate_val(val) ((GtkFixedPrivate*)val)
#define GtkFontButton_val(val) check_cast(GTK_FONT_BUTTON,val)
#define Val_GtkFontButton(val) Val_GObject((GObject*)val)
#define Val_GtkFontButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFontButtonClass' */
#define GtkFontButtonClass_val(val) ((GtkFontButtonClass*)val)
/* conversion for record 'GtkFontButtonPrivate' */
#define GtkFontButtonPrivate_val(val) ((GtkFontButtonPrivate*)val)
#define GtkFontChooserDialog_val(val) check_cast(GTK_FONT_CHOOSER_DIALOG,val)
#define Val_GtkFontChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkFontChooserDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFontChooserDialogClass' */
#define GtkFontChooserDialogClass_val(val) ((GtkFontChooserDialogClass*)val)
/* conversion for record 'GtkFontChooserDialogPrivate' */
#define GtkFontChooserDialogPrivate_val(val) ((GtkFontChooserDialogPrivate*)val)
/* conversion for record 'GtkFontChooserIface' */
#define GtkFontChooserIface_val(val) ((GtkFontChooserIface*)val)
#define GtkFontChooserWidget_val(val) check_cast(GTK_FONT_CHOOSER_WIDGET,val)
#define Val_GtkFontChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkFontChooserWidget_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFontChooserWidgetClass' */
#define GtkFontChooserWidgetClass_val(val) ((GtkFontChooserWidgetClass*)val)
/* conversion for record 'GtkFontChooserWidgetPrivate' */
#define GtkFontChooserWidgetPrivate_val(val) ((GtkFontChooserWidgetPrivate*)val)
#define GtkFontSelection_val(val) check_cast(GTK_FONT_SELECTION,val)
#define Val_GtkFontSelection(val) Val_GObject((GObject*)val)
#define Val_GtkFontSelection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFontSelectionClass' */
#define GtkFontSelectionClass_val(val) ((GtkFontSelectionClass*)val)
#define GtkFontSelectionDialog_val(val) check_cast(GTK_FONT_SELECTION_DIALOG,val)
#define Val_GtkFontSelectionDialog(val) Val_GObject((GObject*)val)
#define Val_GtkFontSelectionDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFontSelectionDialogClass' */
#define GtkFontSelectionDialogClass_val(val) ((GtkFontSelectionDialogClass*)val)
/* conversion for record 'GtkFontSelectionDialogPrivate' */
#define GtkFontSelectionDialogPrivate_val(val) ((GtkFontSelectionDialogPrivate*)val)
/* conversion for record 'GtkFontSelectionPrivate' */
#define GtkFontSelectionPrivate_val(val) ((GtkFontSelectionPrivate*)val)
#define GtkFrame_val(val) check_cast(GTK_FRAME,val)
#define Val_GtkFrame(val) Val_GObject((GObject*)val)
#define Val_GtkFrame_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkFrameClass' */
#define GtkFrameClass_val(val) ((GtkFrameClass*)val)
/* conversion for record 'GtkFramePrivate' */
#define GtkFramePrivate_val(val) ((GtkFramePrivate*)val)
/* conversion for record 'GtkGradient' */
#define GtkGradient_val(val) ((GtkGradient*)val)
#define GtkGrid_val(val) check_cast(GTK_GRID,val)
#define Val_GtkGrid(val) Val_GObject((GObject*)val)
#define Val_GtkGrid_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkGridClass' */
#define GtkGridClass_val(val) ((GtkGridClass*)val)
/* conversion for record 'GtkGridPrivate' */
#define GtkGridPrivate_val(val) ((GtkGridPrivate*)val)
#define GtkHBox_val(val) check_cast(GTK_H_BOX,val)
#define Val_GtkHBox(val) Val_GObject((GObject*)val)
#define Val_GtkHBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHBoxClass' */
#define GtkHBoxClass_val(val) ((GtkHBoxClass*)val)
#define GtkHButtonBox_val(val) check_cast(GTK_H_BUTTON_BOX,val)
#define Val_GtkHButtonBox(val) Val_GObject((GObject*)val)
#define Val_GtkHButtonBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHButtonBoxClass' */
#define GtkHButtonBoxClass_val(val) ((GtkHButtonBoxClass*)val)
#define GtkHPaned_val(val) check_cast(GTK_H_PANED,val)
#define Val_GtkHPaned(val) Val_GObject((GObject*)val)
#define Val_GtkHPaned_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHPanedClass' */
#define GtkHPanedClass_val(val) ((GtkHPanedClass*)val)
#define GtkHSV_val(val) check_cast(GTK_HSV,val)
#define Val_GtkHSV(val) Val_GObject((GObject*)val)
#define Val_GtkHSV_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHSVClass' */
#define GtkHSVClass_val(val) ((GtkHSVClass*)val)
/* conversion for record 'GtkHSVPrivate' */
#define GtkHSVPrivate_val(val) ((GtkHSVPrivate*)val)
#define GtkHScale_val(val) check_cast(GTK_H_SCALE,val)
#define Val_GtkHScale(val) Val_GObject((GObject*)val)
#define Val_GtkHScale_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHScaleClass' */
#define GtkHScaleClass_val(val) ((GtkHScaleClass*)val)
#define GtkHScrollbar_val(val) check_cast(GTK_H_SCROLLBAR,val)
#define Val_GtkHScrollbar(val) Val_GObject((GObject*)val)
#define Val_GtkHScrollbar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHScrollbarClass' */
#define GtkHScrollbarClass_val(val) ((GtkHScrollbarClass*)val)
#define GtkHSeparator_val(val) check_cast(GTK_H_SEPARATOR,val)
#define Val_GtkHSeparator(val) Val_GObject((GObject*)val)
#define Val_GtkHSeparator_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHSeparatorClass' */
#define GtkHSeparatorClass_val(val) ((GtkHSeparatorClass*)val)
#define GtkHandleBox_val(val) check_cast(GTK_HANDLE_BOX,val)
#define Val_GtkHandleBox(val) Val_GObject((GObject*)val)
#define Val_GtkHandleBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkHandleBoxClass' */
#define GtkHandleBoxClass_val(val) ((GtkHandleBoxClass*)val)
/* conversion for record 'GtkHandleBoxPrivate' */
#define GtkHandleBoxPrivate_val(val) ((GtkHandleBoxPrivate*)val)
#define GtkIMContext_val(val) check_cast(GTK_IM_CONTEXT,val)
#define Val_GtkIMContext(val) Val_GObject((GObject*)val)
#define Val_GtkIMContext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkIMContextClass' */
#define GtkIMContextClass_val(val) ((GtkIMContextClass*)val)
/* conversion for record 'GtkIMContextInfo' */
#define GtkIMContextInfo_val(val) ((GtkIMContextInfo*)val)
#define GtkIMContextSimple_val(val) check_cast(GTK_I_M_CONTEXT_SIMPLE,val)
#define Val_GtkIMContextSimple(val) Val_GObject((GObject*)val)
#define Val_GtkIMContextSimple_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkIMContextSimpleClass' */
#define GtkIMContextSimpleClass_val(val) ((GtkIMContextSimpleClass*)val)
/* conversion for record 'GtkIMContextSimplePrivate' */
#define GtkIMContextSimplePrivate_val(val) ((GtkIMContextSimplePrivate*)val)
#define GtkIMMulticontext_val(val) check_cast(GTK_IM_MULTICONTEXT,val)
#define Val_GtkIMMulticontext(val) Val_GObject((GObject*)val)
#define Val_GtkIMMulticontext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkIMMulticontextClass' */
#define GtkIMMulticontextClass_val(val) ((GtkIMMulticontextClass*)val)
/* conversion for record 'GtkIMMulticontextPrivate' */
#define GtkIMMulticontextPrivate_val(val) ((GtkIMMulticontextPrivate*)val)
#define GtkIconFactory_val(val) check_cast(GTK_ICON_FACTORY,val)
#define Val_GtkIconFactory(val) Val_GObject((GObject*)val)
#define Val_GtkIconFactory_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkIconFactoryClass' */
#define GtkIconFactoryClass_val(val) ((GtkIconFactoryClass*)val)
/* conversion for record 'GtkIconFactoryPrivate' */
#define GtkIconFactoryPrivate_val(val) ((GtkIconFactoryPrivate*)val)
/* conversion for record 'GtkIconInfo' */
#define GtkIconInfo_val(val) ((GtkIconInfo*)val)
/* conversion for record 'GtkIconSet' */
#define GtkIconSet_val(val) ((GtkIconSet*)val)
/* conversion for record 'GtkIconSource' */
#define GtkIconSource_val(val) ((GtkIconSource*)val)
#define GtkIconTheme_val(val) check_cast(GTK_ICON_THEME,val)
#define Val_GtkIconTheme(val) Val_GObject((GObject*)val)
#define Val_GtkIconTheme_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkIconThemeClass' */
#define GtkIconThemeClass_val(val) ((GtkIconThemeClass*)val)
/* conversion for record 'GtkIconThemePrivate' */
#define GtkIconThemePrivate_val(val) ((GtkIconThemePrivate*)val)
#define GtkIconView_val(val) check_cast(GTK_ICON_VIEW,val)
#define Val_GtkIconView(val) Val_GObject((GObject*)val)
#define Val_GtkIconView_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkIconViewClass' */
#define GtkIconViewClass_val(val) ((GtkIconViewClass*)val)
/* conversion for record 'GtkIconViewPrivate' */
#define GtkIconViewPrivate_val(val) ((GtkIconViewPrivate*)val)
#define GtkImage_val(val) check_cast(GTK_IMAGE,val)
#define Val_GtkImage(val) Val_GObject((GObject*)val)
#define Val_GtkImage_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkImageClass' */
#define GtkImageClass_val(val) ((GtkImageClass*)val)
#define GtkImageMenuItem_val(val) check_cast(GTK_IMAGE_MENU_ITEM,val)
#define Val_GtkImageMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkImageMenuItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkImageMenuItemClass' */
#define GtkImageMenuItemClass_val(val) ((GtkImageMenuItemClass*)val)
/* conversion for record 'GtkImageMenuItemPrivate' */
#define GtkImageMenuItemPrivate_val(val) ((GtkImageMenuItemPrivate*)val)
/* conversion for record 'GtkImagePrivate' */
#define GtkImagePrivate_val(val) ((GtkImagePrivate*)val)
#define GtkInfoBar_val(val) check_cast(GTK_INFO_BAR,val)
#define Val_GtkInfoBar(val) Val_GObject((GObject*)val)
#define Val_GtkInfoBar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkInfoBarClass' */
#define GtkInfoBarClass_val(val) ((GtkInfoBarClass*)val)
/* conversion for record 'GtkInfoBarPrivate' */
#define GtkInfoBarPrivate_val(val) ((GtkInfoBarPrivate*)val)
#define GtkInvisible_val(val) check_cast(GTK_INVISIBLE,val)
#define Val_GtkInvisible(val) Val_GObject((GObject*)val)
#define Val_GtkInvisible_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkInvisibleClass' */
#define GtkInvisibleClass_val(val) ((GtkInvisibleClass*)val)
/* conversion for record 'GtkInvisiblePrivate' */
#define GtkInvisiblePrivate_val(val) ((GtkInvisiblePrivate*)val)
#define GtkLabel_val(val) check_cast(GTK_LABEL,val)
#define Val_GtkLabel(val) Val_GObject((GObject*)val)
#define Val_GtkLabel_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkLabelClass' */
#define GtkLabelClass_val(val) ((GtkLabelClass*)val)
/* conversion for record 'GtkLabelPrivate' */
#define GtkLabelPrivate_val(val) ((GtkLabelPrivate*)val)
/* conversion for record 'GtkLabelSelectionInfo' */
#define GtkLabelSelectionInfo_val(val) ((GtkLabelSelectionInfo*)val)
#define GtkLayout_val(val) check_cast(GTK_LAYOUT,val)
#define Val_GtkLayout(val) Val_GObject((GObject*)val)
#define Val_GtkLayout_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkLayoutClass' */
#define GtkLayoutClass_val(val) ((GtkLayoutClass*)val)
/* conversion for record 'GtkLayoutPrivate' */
#define GtkLayoutPrivate_val(val) ((GtkLayoutPrivate*)val)
#define GtkLinkButton_val(val) check_cast(GTK_LINK_BUTTON,val)
#define Val_GtkLinkButton(val) Val_GObject((GObject*)val)
#define Val_GtkLinkButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkLinkButtonClass' */
#define GtkLinkButtonClass_val(val) ((GtkLinkButtonClass*)val)
/* conversion for record 'GtkLinkButtonPrivate' */
#define GtkLinkButtonPrivate_val(val) ((GtkLinkButtonPrivate*)val)
#define GtkListStore_val(val) check_cast(GTK_LIST_STORE,val)
#define Val_GtkListStore(val) Val_GObject((GObject*)val)
#define Val_GtkListStore_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkListStoreClass' */
#define GtkListStoreClass_val(val) ((GtkListStoreClass*)val)
/* conversion for record 'GtkListStorePrivate' */
#define GtkListStorePrivate_val(val) ((GtkListStorePrivate*)val)
#define GtkLockButton_val(val) check_cast(GTK_LOCK_BUTTON,val)
#define Val_GtkLockButton(val) Val_GObject((GObject*)val)
#define Val_GtkLockButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkLockButtonClass' */
#define GtkLockButtonClass_val(val) ((GtkLockButtonClass*)val)
/* conversion for record 'GtkLockButtonPrivate' */
#define GtkLockButtonPrivate_val(val) ((GtkLockButtonPrivate*)val)
#define GtkMenu_val(val) check_cast(GTK_MENU,val)
#define Val_GtkMenu(val) Val_GObject((GObject*)val)
#define Val_GtkMenu_new(val) Val_GObject_new((GObject*)val)
#define GtkMenuBar_val(val) check_cast(GTK_MENU_BAR,val)
#define Val_GtkMenuBar(val) Val_GObject((GObject*)val)
#define Val_GtkMenuBar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkMenuBarClass' */
#define GtkMenuBarClass_val(val) ((GtkMenuBarClass*)val)
/* conversion for record 'GtkMenuBarPrivate' */
#define GtkMenuBarPrivate_val(val) ((GtkMenuBarPrivate*)val)
/* conversion for record 'GtkMenuClass' */
#define GtkMenuClass_val(val) ((GtkMenuClass*)val)
#define GtkMenuItem_val(val) check_cast(GTK_MENU_ITEM,val)
#define Val_GtkMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkMenuItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkMenuItemClass' */
#define GtkMenuItemClass_val(val) ((GtkMenuItemClass*)val)
/* conversion for record 'GtkMenuItemPrivate' */
#define GtkMenuItemPrivate_val(val) ((GtkMenuItemPrivate*)val)
/* conversion for record 'GtkMenuPrivate' */
#define GtkMenuPrivate_val(val) ((GtkMenuPrivate*)val)
#define GtkMenuShell_val(val) check_cast(GTK_MENU_SHELL,val)
#define Val_GtkMenuShell(val) Val_GObject((GObject*)val)
#define Val_GtkMenuShell_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkMenuShellClass' */
#define GtkMenuShellClass_val(val) ((GtkMenuShellClass*)val)
/* conversion for record 'GtkMenuShellPrivate' */
#define GtkMenuShellPrivate_val(val) ((GtkMenuShellPrivate*)val)
#define GtkMenuToolButton_val(val) check_cast(GTK_MENU_TOOL_BUTTON,val)
#define Val_GtkMenuToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkMenuToolButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkMenuToolButtonClass' */
#define GtkMenuToolButtonClass_val(val) ((GtkMenuToolButtonClass*)val)
/* conversion for record 'GtkMenuToolButtonPrivate' */
#define GtkMenuToolButtonPrivate_val(val) ((GtkMenuToolButtonPrivate*)val)
#define GtkMessageDialog_val(val) check_cast(GTK_MESSAGE_DIALOG,val)
#define Val_GtkMessageDialog(val) Val_GObject((GObject*)val)
#define Val_GtkMessageDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkMessageDialogClass' */
#define GtkMessageDialogClass_val(val) ((GtkMessageDialogClass*)val)
/* conversion for record 'GtkMessageDialogPrivate' */
#define GtkMessageDialogPrivate_val(val) ((GtkMessageDialogPrivate*)val)
#define GtkMisc_val(val) check_cast(GTK_MISC,val)
#define Val_GtkMisc(val) Val_GObject((GObject*)val)
#define Val_GtkMisc_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkMiscClass' */
#define GtkMiscClass_val(val) ((GtkMiscClass*)val)
/* conversion for record 'GtkMiscPrivate' */
#define GtkMiscPrivate_val(val) ((GtkMiscPrivate*)val)
#define GtkMountOperation_val(val) check_cast(GTK_MOUNT_OPERATION,val)
#define Val_GtkMountOperation(val) Val_GObject((GObject*)val)
#define Val_GtkMountOperation_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkMountOperationClass' */
#define GtkMountOperationClass_val(val) ((GtkMountOperationClass*)val)
/* conversion for record 'GtkMountOperationPrivate' */
#define GtkMountOperationPrivate_val(val) ((GtkMountOperationPrivate*)val)
#define GtkNotebook_val(val) check_cast(GTK_NOTEBOOK,val)
#define Val_GtkNotebook(val) Val_GObject((GObject*)val)
#define Val_GtkNotebook_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkNotebookClass' */
#define GtkNotebookClass_val(val) ((GtkNotebookClass*)val)
/* conversion for record 'GtkNotebookPrivate' */
#define GtkNotebookPrivate_val(val) ((GtkNotebookPrivate*)val)
#define GtkNumerableIcon_val(val) check_cast(GTK_NUMERABLE_ICON,val)
#define Val_GtkNumerableIcon(val) Val_GObject((GObject*)val)
#define Val_GtkNumerableIcon_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkNumerableIconClass' */
#define GtkNumerableIconClass_val(val) ((GtkNumerableIconClass*)val)
/* conversion for record 'GtkNumerableIconPrivate' */
#define GtkNumerableIconPrivate_val(val) ((GtkNumerableIconPrivate*)val)
#define GtkOffscreenWindow_val(val) check_cast(GTK_OFFSCREEN_WINDOW,val)
#define Val_GtkOffscreenWindow(val) Val_GObject((GObject*)val)
#define Val_GtkOffscreenWindow_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkOffscreenWindowClass' */
#define GtkOffscreenWindowClass_val(val) ((GtkOffscreenWindowClass*)val)
/* conversion for record 'GtkOrientableIface' */
#define GtkOrientableIface_val(val) ((GtkOrientableIface*)val)
#define GtkOverlay_val(val) check_cast(GTK_OVERLAY,val)
#define Val_GtkOverlay(val) Val_GObject((GObject*)val)
#define Val_GtkOverlay_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkOverlayClass' */
#define GtkOverlayClass_val(val) ((GtkOverlayClass*)val)
/* conversion for record 'GtkOverlayPrivate' */
#define GtkOverlayPrivate_val(val) ((GtkOverlayPrivate*)val)
/* conversion for record 'GtkPageRange' */
#define GtkPageRange_val(val) ((GtkPageRange*)val)
#define GtkPageSetup_val(val) check_cast(GTK_PAGE_SETUP,val)
#define Val_GtkPageSetup(val) Val_GObject((GObject*)val)
#define Val_GtkPageSetup_new(val) Val_GObject_new((GObject*)val)
#define GtkPaned_val(val) check_cast(GTK_PANED,val)
#define Val_GtkPaned(val) Val_GObject((GObject*)val)
#define Val_GtkPaned_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkPanedClass' */
#define GtkPanedClass_val(val) ((GtkPanedClass*)val)
/* conversion for record 'GtkPanedPrivate' */
#define GtkPanedPrivate_val(val) ((GtkPanedPrivate*)val)
/* conversion for record 'GtkPaperSize' */
#define GtkPaperSize_val(val) ((GtkPaperSize*)val)
#define GtkPlug_val(val) check_cast(GTK_PLUG,val)
#define Val_GtkPlug(val) Val_GObject((GObject*)val)
#define Val_GtkPlug_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkPlugClass' */
#define GtkPlugClass_val(val) ((GtkPlugClass*)val)
/* conversion for record 'GtkPlugPrivate' */
#define GtkPlugPrivate_val(val) ((GtkPlugPrivate*)val)
#define GtkPrintContext_val(val) check_cast(GTK_PRINT_CONTEXT,val)
#define Val_GtkPrintContext(val) Val_GObject((GObject*)val)
#define Val_GtkPrintContext_new(val) Val_GObject_new((GObject*)val)
#define GtkPrintOperation_val(val) check_cast(GTK_PRINT_OPERATION,val)
#define Val_GtkPrintOperation(val) Val_GObject((GObject*)val)
#define Val_GtkPrintOperation_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkPrintOperationClass' */
#define GtkPrintOperationClass_val(val) ((GtkPrintOperationClass*)val)
/* conversion for record 'GtkPrintOperationPreviewIface' */
#define GtkPrintOperationPreviewIface_val(val) ((GtkPrintOperationPreviewIface*)val)
/* conversion for record 'GtkPrintOperationPrivate' */
#define GtkPrintOperationPrivate_val(val) ((GtkPrintOperationPrivate*)val)
#define GtkPrintSettings_val(val) check_cast(GTK_PRINT_SETTINGS,val)
#define Val_GtkPrintSettings(val) Val_GObject((GObject*)val)
#define Val_GtkPrintSettings_new(val) Val_GObject_new((GObject*)val)
#define GtkProgressBar_val(val) check_cast(GTK_PROGRESS_BAR,val)
#define Val_GtkProgressBar(val) Val_GObject((GObject*)val)
#define Val_GtkProgressBar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkProgressBarClass' */
#define GtkProgressBarClass_val(val) ((GtkProgressBarClass*)val)
/* conversion for record 'GtkProgressBarPrivate' */
#define GtkProgressBarPrivate_val(val) ((GtkProgressBarPrivate*)val)
#define GtkRadioAction_val(val) check_cast(GTK_RADIO_ACTION,val)
#define Val_GtkRadioAction(val) Val_GObject((GObject*)val)
#define Val_GtkRadioAction_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRadioActionClass' */
#define GtkRadioActionClass_val(val) ((GtkRadioActionClass*)val)
/* conversion for record 'GtkRadioActionEntry' */
#define GtkRadioActionEntry_val(val) ((GtkRadioActionEntry*)val)
/* conversion for record 'GtkRadioActionPrivate' */
#define GtkRadioActionPrivate_val(val) ((GtkRadioActionPrivate*)val)
#define GtkRadioButton_val(val) check_cast(GTK_RADIO_BUTTON,val)
#define Val_GtkRadioButton(val) Val_GObject((GObject*)val)
#define Val_GtkRadioButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRadioButtonClass' */
#define GtkRadioButtonClass_val(val) ((GtkRadioButtonClass*)val)
/* conversion for record 'GtkRadioButtonPrivate' */
#define GtkRadioButtonPrivate_val(val) ((GtkRadioButtonPrivate*)val)
#define GtkRadioMenuItem_val(val) check_cast(GTK_RADIO_MENU_ITEM,val)
#define Val_GtkRadioMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkRadioMenuItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRadioMenuItemClass' */
#define GtkRadioMenuItemClass_val(val) ((GtkRadioMenuItemClass*)val)
/* conversion for record 'GtkRadioMenuItemPrivate' */
#define GtkRadioMenuItemPrivate_val(val) ((GtkRadioMenuItemPrivate*)val)
#define GtkRadioToolButton_val(val) check_cast(GTK_RADIO_TOOL_BUTTON,val)
#define Val_GtkRadioToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkRadioToolButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRadioToolButtonClass' */
#define GtkRadioToolButtonClass_val(val) ((GtkRadioToolButtonClass*)val)
#define GtkRange_val(val) check_cast(GTK_RANGE,val)
#define Val_GtkRange(val) Val_GObject((GObject*)val)
#define Val_GtkRange_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRangeClass' */
#define GtkRangeClass_val(val) ((GtkRangeClass*)val)
/* conversion for record 'GtkRangePrivate' */
#define GtkRangePrivate_val(val) ((GtkRangePrivate*)val)
/* conversion for record 'GtkRcContext' */
#define GtkRcContext_val(val) ((GtkRcContext*)val)
#define GtkRcStyle_val(val) check_cast(GTK_RC_STYLE,val)
#define Val_GtkRcStyle(val) Val_GObject((GObject*)val)
#define Val_GtkRcStyle_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRcStyleClass' */
#define GtkRcStyleClass_val(val) ((GtkRcStyleClass*)val)
#define GtkRecentAction_val(val) check_cast(GTK_RECENT_ACTION,val)
#define Val_GtkRecentAction(val) Val_GObject((GObject*)val)
#define Val_GtkRecentAction_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRecentActionClass' */
#define GtkRecentActionClass_val(val) ((GtkRecentActionClass*)val)
/* conversion for record 'GtkRecentActionPrivate' */
#define GtkRecentActionPrivate_val(val) ((GtkRecentActionPrivate*)val)
#define GtkRecentChooserDialog_val(val) check_cast(GTK_RECENT_CHOOSER_DIALOG,val)
#define Val_GtkRecentChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkRecentChooserDialog_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRecentChooserDialogClass' */
#define GtkRecentChooserDialogClass_val(val) ((GtkRecentChooserDialogClass*)val)
/* conversion for record 'GtkRecentChooserDialogPrivate' */
#define GtkRecentChooserDialogPrivate_val(val) ((GtkRecentChooserDialogPrivate*)val)
/* conversion for record 'GtkRecentChooserIface' */
#define GtkRecentChooserIface_val(val) ((GtkRecentChooserIface*)val)
#define GtkRecentChooserMenu_val(val) check_cast(GTK_RECENT_CHOOSER_MENU,val)
#define Val_GtkRecentChooserMenu(val) Val_GObject((GObject*)val)
#define Val_GtkRecentChooserMenu_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRecentChooserMenuClass' */
#define GtkRecentChooserMenuClass_val(val) ((GtkRecentChooserMenuClass*)val)
/* conversion for record 'GtkRecentChooserMenuPrivate' */
#define GtkRecentChooserMenuPrivate_val(val) ((GtkRecentChooserMenuPrivate*)val)
#define GtkRecentChooserWidget_val(val) check_cast(GTK_RECENT_CHOOSER_WIDGET,val)
#define Val_GtkRecentChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkRecentChooserWidget_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRecentChooserWidgetClass' */
#define GtkRecentChooserWidgetClass_val(val) ((GtkRecentChooserWidgetClass*)val)
/* conversion for record 'GtkRecentChooserWidgetPrivate' */
#define GtkRecentChooserWidgetPrivate_val(val) ((GtkRecentChooserWidgetPrivate*)val)
/* conversion for record 'GtkRecentData' */
#define GtkRecentData_val(val) ((GtkRecentData*)val)
#define GtkRecentFilter_val(val) check_cast(GTK_RECENT_FILTER,val)
#define Val_GtkRecentFilter(val) Val_GObject((GObject*)val)
#define Val_GtkRecentFilter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRecentFilterInfo' */
#define GtkRecentFilterInfo_val(val) ((GtkRecentFilterInfo*)val)
/* conversion for record 'GtkRecentInfo' */
#define GtkRecentInfo_val(val) ((GtkRecentInfo*)val)
#define GtkRecentManager_val(val) check_cast(GTK_RECENT_MANAGER,val)
#define Val_GtkRecentManager(val) Val_GObject((GObject*)val)
#define Val_GtkRecentManager_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkRecentManagerClass' */
#define GtkRecentManagerClass_val(val) ((GtkRecentManagerClass*)val)
/* conversion for record 'GtkRecentManagerPrivate' */
#define GtkRecentManagerPrivate_val(val) ((GtkRecentManagerPrivate*)val)
/* conversion for record 'GtkRequestedSize' */
#define GtkRequestedSize_val(val) ((GtkRequestedSize*)val)
/* conversion for record 'GtkRequisition' */
#define GtkRequisition_val(val) ((GtkRequisition*)val)
#define GtkScale_val(val) check_cast(GTK_SCALE,val)
#define Val_GtkScale(val) Val_GObject((GObject*)val)
#define Val_GtkScale_new(val) Val_GObject_new((GObject*)val)
#define GtkScaleButton_val(val) check_cast(GTK_SCALE_BUTTON,val)
#define Val_GtkScaleButton(val) Val_GObject((GObject*)val)
#define Val_GtkScaleButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkScaleButtonClass' */
#define GtkScaleButtonClass_val(val) ((GtkScaleButtonClass*)val)
/* conversion for record 'GtkScaleButtonPrivate' */
#define GtkScaleButtonPrivate_val(val) ((GtkScaleButtonPrivate*)val)
/* conversion for record 'GtkScaleClass' */
#define GtkScaleClass_val(val) ((GtkScaleClass*)val)
/* conversion for record 'GtkScalePrivate' */
#define GtkScalePrivate_val(val) ((GtkScalePrivate*)val)
/* conversion for record 'GtkScrollableInterface' */
#define GtkScrollableInterface_val(val) ((GtkScrollableInterface*)val)
#define GtkScrollbar_val(val) check_cast(GTK_SCROLLBAR,val)
#define Val_GtkScrollbar(val) Val_GObject((GObject*)val)
#define Val_GtkScrollbar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkScrollbarClass' */
#define GtkScrollbarClass_val(val) ((GtkScrollbarClass*)val)
#define GtkScrolledWindow_val(val) check_cast(GTK_SCROLLED_WINDOW,val)
#define Val_GtkScrolledWindow(val) Val_GObject((GObject*)val)
#define Val_GtkScrolledWindow_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkScrolledWindowClass' */
#define GtkScrolledWindowClass_val(val) ((GtkScrolledWindowClass*)val)
/* conversion for record 'GtkScrolledWindowPrivate' */
#define GtkScrolledWindowPrivate_val(val) ((GtkScrolledWindowPrivate*)val)
/* conversion for record 'GtkSelectionData' */
#define GtkSelectionData_val(val) ((GtkSelectionData*)val)
#define GtkSeparator_val(val) check_cast(GTK_SEPARATOR,val)
#define Val_GtkSeparator(val) Val_GObject((GObject*)val)
#define Val_GtkSeparator_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSeparatorClass' */
#define GtkSeparatorClass_val(val) ((GtkSeparatorClass*)val)
#define GtkSeparatorMenuItem_val(val) check_cast(GTK_SEPARATOR_MENU_ITEM,val)
#define Val_GtkSeparatorMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkSeparatorMenuItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSeparatorMenuItemClass' */
#define GtkSeparatorMenuItemClass_val(val) ((GtkSeparatorMenuItemClass*)val)
/* conversion for record 'GtkSeparatorPrivate' */
#define GtkSeparatorPrivate_val(val) ((GtkSeparatorPrivate*)val)
#define GtkSeparatorToolItem_val(val) check_cast(GTK_SEPARATOR_TOOL_ITEM,val)
#define Val_GtkSeparatorToolItem(val) Val_GObject((GObject*)val)
#define Val_GtkSeparatorToolItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSeparatorToolItemClass' */
#define GtkSeparatorToolItemClass_val(val) ((GtkSeparatorToolItemClass*)val)
/* conversion for record 'GtkSeparatorToolItemPrivate' */
#define GtkSeparatorToolItemPrivate_val(val) ((GtkSeparatorToolItemPrivate*)val)
#define GtkSettings_val(val) check_cast(GTK_SETTINGS,val)
#define Val_GtkSettings(val) Val_GObject((GObject*)val)
#define Val_GtkSettings_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSettingsClass' */
#define GtkSettingsClass_val(val) ((GtkSettingsClass*)val)
/* conversion for record 'GtkSettingsPrivate' */
#define GtkSettingsPrivate_val(val) ((GtkSettingsPrivate*)val)
/* conversion for record 'GtkSettingsValue' */
#define GtkSettingsValue_val(val) ((GtkSettingsValue*)val)
#define GtkSizeGroup_val(val) check_cast(GTK_SIZE_GROUP,val)
#define Val_GtkSizeGroup(val) Val_GObject((GObject*)val)
#define Val_GtkSizeGroup_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSizeGroupClass' */
#define GtkSizeGroupClass_val(val) ((GtkSizeGroupClass*)val)
/* conversion for record 'GtkSizeGroupPrivate' */
#define GtkSizeGroupPrivate_val(val) ((GtkSizeGroupPrivate*)val)
#define GtkSocket_val(val) check_cast(GTK_SOCKET,val)
#define Val_GtkSocket(val) Val_GObject((GObject*)val)
#define Val_GtkSocket_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSocketClass' */
#define GtkSocketClass_val(val) ((GtkSocketClass*)val)
/* conversion for record 'GtkSocketPrivate' */
#define GtkSocketPrivate_val(val) ((GtkSocketPrivate*)val)
#define GtkSpinButton_val(val) check_cast(GTK_SPIN_BUTTON,val)
#define Val_GtkSpinButton(val) Val_GObject((GObject*)val)
#define Val_GtkSpinButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSpinButtonClass' */
#define GtkSpinButtonClass_val(val) ((GtkSpinButtonClass*)val)
/* conversion for record 'GtkSpinButtonPrivate' */
#define GtkSpinButtonPrivate_val(val) ((GtkSpinButtonPrivate*)val)
#define GtkSpinner_val(val) check_cast(GTK_SPINNER,val)
#define Val_GtkSpinner(val) Val_GObject((GObject*)val)
#define Val_GtkSpinner_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSpinnerClass' */
#define GtkSpinnerClass_val(val) ((GtkSpinnerClass*)val)
/* conversion for record 'GtkSpinnerPrivate' */
#define GtkSpinnerPrivate_val(val) ((GtkSpinnerPrivate*)val)
#define GtkStatusIcon_val(val) check_cast(GTK_STATUS_ICON,val)
#define Val_GtkStatusIcon(val) Val_GObject((GObject*)val)
#define Val_GtkStatusIcon_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkStatusIconClass' */
#define GtkStatusIconClass_val(val) ((GtkStatusIconClass*)val)
/* conversion for record 'GtkStatusIconPrivate' */
#define GtkStatusIconPrivate_val(val) ((GtkStatusIconPrivate*)val)
#define GtkStatusbar_val(val) check_cast(GTK_STATUSBAR,val)
#define Val_GtkStatusbar(val) Val_GObject((GObject*)val)
#define Val_GtkStatusbar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkStatusbarClass' */
#define GtkStatusbarClass_val(val) ((GtkStatusbarClass*)val)
/* conversion for record 'GtkStatusbarPrivate' */
#define GtkStatusbarPrivate_val(val) ((GtkStatusbarPrivate*)val)
/* conversion for record 'GtkStockItem' */
#define GtkStockItem_val(val) ((GtkStockItem*)val)
#define GtkStyle_val(val) check_cast(GTK_STYLE,val)
#define Val_GtkStyle(val) Val_GObject((GObject*)val)
#define Val_GtkStyle_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkStyleClass' */
#define GtkStyleClass_val(val) ((GtkStyleClass*)val)
#define GtkStyleContext_val(val) check_cast(GTK_STYLE_CONTEXT,val)
#define Val_GtkStyleContext(val) Val_GObject((GObject*)val)
#define Val_GtkStyleContext_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkStyleContextClass' */
#define GtkStyleContextClass_val(val) ((GtkStyleContextClass*)val)
/* conversion for record 'GtkStyleContextPrivate' */
#define GtkStyleContextPrivate_val(val) ((GtkStyleContextPrivate*)val)
#define GtkStyleProperties_val(val) check_cast(GTK_STYLE_PROPERTIES,val)
#define Val_GtkStyleProperties(val) Val_GObject((GObject*)val)
#define Val_GtkStyleProperties_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkStylePropertiesClass' */
#define GtkStylePropertiesClass_val(val) ((GtkStylePropertiesClass*)val)
/* conversion for record 'GtkStylePropertiesPrivate' */
#define GtkStylePropertiesPrivate_val(val) ((GtkStylePropertiesPrivate*)val)
/* conversion for record 'GtkStyleProviderIface' */
#define GtkStyleProviderIface_val(val) ((GtkStyleProviderIface*)val)
#define GtkSwitch_val(val) check_cast(GTK_SWITCH,val)
#define Val_GtkSwitch(val) Val_GObject((GObject*)val)
#define Val_GtkSwitch_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkSwitchClass' */
#define GtkSwitchClass_val(val) ((GtkSwitchClass*)val)
/* conversion for record 'GtkSwitchPrivate' */
#define GtkSwitchPrivate_val(val) ((GtkSwitchPrivate*)val)
/* conversion for record 'GtkSymbolicColor' */
#define GtkSymbolicColor_val(val) ((GtkSymbolicColor*)val)
#define GtkTable_val(val) check_cast(GTK_TABLE,val)
#define Val_GtkTable(val) Val_GObject((GObject*)val)
#define Val_GtkTable_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTableChild' */
#define GtkTableChild_val(val) ((GtkTableChild*)val)
/* conversion for record 'GtkTableClass' */
#define GtkTableClass_val(val) ((GtkTableClass*)val)
/* conversion for record 'GtkTablePrivate' */
#define GtkTablePrivate_val(val) ((GtkTablePrivate*)val)
/* conversion for record 'GtkTableRowCol' */
#define GtkTableRowCol_val(val) ((GtkTableRowCol*)val)
/* conversion for record 'GtkTargetEntry' */
#define GtkTargetEntry_val(val) ((GtkTargetEntry*)val)
/* conversion for record 'GtkTargetList' */
#define GtkTargetList_val(val) ((GtkTargetList*)val)
#define GtkTearoffMenuItem_val(val) check_cast(GTK_TEAROFF_MENU_ITEM,val)
#define Val_GtkTearoffMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkTearoffMenuItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTearoffMenuItemClass' */
#define GtkTearoffMenuItemClass_val(val) ((GtkTearoffMenuItemClass*)val)
/* conversion for record 'GtkTearoffMenuItemPrivate' */
#define GtkTearoffMenuItemPrivate_val(val) ((GtkTearoffMenuItemPrivate*)val)
/* conversion for record 'GtkTextAppearance' */
#define GtkTextAppearance_val(val) ((GtkTextAppearance*)val)
/* conversion for record 'GtkTextAttributes' */
#define GtkTextAttributes_val(val) ((GtkTextAttributes*)val)
/* conversion for record 'GtkTextBTree' */
#define GtkTextBTree_val(val) ((GtkTextBTree*)val)
#define GtkTextBuffer_val(val) check_cast(GTK_TEXT_BUFFER,val)
#define Val_GtkTextBuffer(val) Val_GObject((GObject*)val)
#define Val_GtkTextBuffer_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTextBufferClass' */
#define GtkTextBufferClass_val(val) ((GtkTextBufferClass*)val)
/* conversion for record 'GtkTextBufferPrivate' */
#define GtkTextBufferPrivate_val(val) ((GtkTextBufferPrivate*)val)
#define GtkTextChildAnchor_val(val) check_cast(GTK_TEXT_CHILD_ANCHOR,val)
#define Val_GtkTextChildAnchor(val) Val_GObject((GObject*)val)
#define Val_GtkTextChildAnchor_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTextChildAnchorClass' */
#define GtkTextChildAnchorClass_val(val) ((GtkTextChildAnchorClass*)val)
/* conversion for record 'GtkTextIter' */
#define GtkTextIter_val(val) ((GtkTextIter*)val)
#define GtkTextMark_val(val) check_cast(GTK_TEXT_MARK,val)
#define Val_GtkTextMark(val) Val_GObject((GObject*)val)
#define Val_GtkTextMark_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTextMarkClass' */
#define GtkTextMarkClass_val(val) ((GtkTextMarkClass*)val)
#define GtkTextTag_val(val) check_cast(GTK_TEXT_TAG,val)
#define Val_GtkTextTag(val) Val_GObject((GObject*)val)
#define Val_GtkTextTag_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTextTagClass' */
#define GtkTextTagClass_val(val) ((GtkTextTagClass*)val)
/* conversion for record 'GtkTextTagPrivate' */
#define GtkTextTagPrivate_val(val) ((GtkTextTagPrivate*)val)
#define GtkTextTagTable_val(val) check_cast(GTK_TEXT_TAG_TABLE,val)
#define Val_GtkTextTagTable(val) Val_GObject((GObject*)val)
#define Val_GtkTextTagTable_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTextTagTableClass' */
#define GtkTextTagTableClass_val(val) ((GtkTextTagTableClass*)val)
/* conversion for record 'GtkTextTagTablePrivate' */
#define GtkTextTagTablePrivate_val(val) ((GtkTextTagTablePrivate*)val)
#define GtkTextView_val(val) check_cast(GTK_TEXT_VIEW,val)
#define Val_GtkTextView(val) Val_GObject((GObject*)val)
#define Val_GtkTextView_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTextViewClass' */
#define GtkTextViewClass_val(val) ((GtkTextViewClass*)val)
/* conversion for record 'GtkTextViewPrivate' */
#define GtkTextViewPrivate_val(val) ((GtkTextViewPrivate*)val)
/* conversion for record 'GtkThemeEngine' */
#define GtkThemeEngine_val(val) ((GtkThemeEngine*)val)
#define GtkThemingEngine_val(val) check_cast(GTK_THEMING_ENGINE,val)
#define Val_GtkThemingEngine(val) Val_GObject((GObject*)val)
#define Val_GtkThemingEngine_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkThemingEngineClass' */
#define GtkThemingEngineClass_val(val) ((GtkThemingEngineClass*)val)
/* conversion for record 'GtkThemingEnginePrivate' */
#define GtkThemingEnginePrivate_val(val) ((GtkThemingEnginePrivate*)val)
#define GtkToggleAction_val(val) check_cast(GTK_TOGGLE_ACTION,val)
#define Val_GtkToggleAction(val) Val_GObject((GObject*)val)
#define Val_GtkToggleAction_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToggleActionClass' */
#define GtkToggleActionClass_val(val) ((GtkToggleActionClass*)val)
/* conversion for record 'GtkToggleActionEntry' */
#define GtkToggleActionEntry_val(val) ((GtkToggleActionEntry*)val)
/* conversion for record 'GtkToggleActionPrivate' */
#define GtkToggleActionPrivate_val(val) ((GtkToggleActionPrivate*)val)
#define GtkToggleButton_val(val) check_cast(GTK_TOGGLE_BUTTON,val)
#define Val_GtkToggleButton(val) Val_GObject((GObject*)val)
#define Val_GtkToggleButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToggleButtonClass' */
#define GtkToggleButtonClass_val(val) ((GtkToggleButtonClass*)val)
/* conversion for record 'GtkToggleButtonPrivate' */
#define GtkToggleButtonPrivate_val(val) ((GtkToggleButtonPrivate*)val)
#define GtkToggleToolButton_val(val) check_cast(GTK_TOGGLE_TOOL_BUTTON,val)
#define Val_GtkToggleToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkToggleToolButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToggleToolButtonClass' */
#define GtkToggleToolButtonClass_val(val) ((GtkToggleToolButtonClass*)val)
/* conversion for record 'GtkToggleToolButtonPrivate' */
#define GtkToggleToolButtonPrivate_val(val) ((GtkToggleToolButtonPrivate*)val)
#define GtkToolButton_val(val) check_cast(GTK_TOOL_BUTTON,val)
#define Val_GtkToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkToolButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToolButtonClass' */
#define GtkToolButtonClass_val(val) ((GtkToolButtonClass*)val)
/* conversion for record 'GtkToolButtonPrivate' */
#define GtkToolButtonPrivate_val(val) ((GtkToolButtonPrivate*)val)
#define GtkToolItem_val(val) check_cast(GTK_TOOL_ITEM,val)
#define Val_GtkToolItem(val) Val_GObject((GObject*)val)
#define Val_GtkToolItem_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToolItemClass' */
#define GtkToolItemClass_val(val) ((GtkToolItemClass*)val)
#define GtkToolItemGroup_val(val) check_cast(GTK_TOOL_ITEM_GROUP,val)
#define Val_GtkToolItemGroup(val) Val_GObject((GObject*)val)
#define Val_GtkToolItemGroup_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToolItemGroupClass' */
#define GtkToolItemGroupClass_val(val) ((GtkToolItemGroupClass*)val)
/* conversion for record 'GtkToolItemGroupPrivate' */
#define GtkToolItemGroupPrivate_val(val) ((GtkToolItemGroupPrivate*)val)
/* conversion for record 'GtkToolItemPrivate' */
#define GtkToolItemPrivate_val(val) ((GtkToolItemPrivate*)val)
#define GtkToolPalette_val(val) check_cast(GTK_TOOL_PALETTE,val)
#define Val_GtkToolPalette(val) Val_GObject((GObject*)val)
#define Val_GtkToolPalette_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToolPaletteClass' */
#define GtkToolPaletteClass_val(val) ((GtkToolPaletteClass*)val)
/* conversion for record 'GtkToolPalettePrivate' */
#define GtkToolPalettePrivate_val(val) ((GtkToolPalettePrivate*)val)
/* conversion for record 'GtkToolShellIface' */
#define GtkToolShellIface_val(val) ((GtkToolShellIface*)val)
#define GtkToolbar_val(val) check_cast(GTK_TOOLBAR,val)
#define Val_GtkToolbar(val) Val_GObject((GObject*)val)
#define Val_GtkToolbar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkToolbarClass' */
#define GtkToolbarClass_val(val) ((GtkToolbarClass*)val)
/* conversion for record 'GtkToolbarPrivate' */
#define GtkToolbarPrivate_val(val) ((GtkToolbarPrivate*)val)
#define GtkTooltip_val(val) check_cast(GTK_TOOLTIP,val)
#define Val_GtkTooltip(val) Val_GObject((GObject*)val)
#define Val_GtkTooltip_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTreeDragDestIface' */
#define GtkTreeDragDestIface_val(val) ((GtkTreeDragDestIface*)val)
/* conversion for record 'GtkTreeDragSourceIface' */
#define GtkTreeDragSourceIface_val(val) ((GtkTreeDragSourceIface*)val)
/* conversion for record 'GtkTreeIter' */
#define GtkTreeIter_val(val) ((GtkTreeIter*)val)
#define GtkTreeModelFilter_val(val) check_cast(GTK_TREE_MODEL_FILTER,val)
#define Val_GtkTreeModelFilter(val) Val_GObject((GObject*)val)
#define Val_GtkTreeModelFilter_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTreeModelFilterClass' */
#define GtkTreeModelFilterClass_val(val) ((GtkTreeModelFilterClass*)val)
/* conversion for record 'GtkTreeModelFilterPrivate' */
#define GtkTreeModelFilterPrivate_val(val) ((GtkTreeModelFilterPrivate*)val)
/* conversion for record 'GtkTreeModelIface' */
#define GtkTreeModelIface_val(val) ((GtkTreeModelIface*)val)
#define GtkTreeModelSort_val(val) check_cast(GTK_TREE_MODEL_SORT,val)
#define Val_GtkTreeModelSort(val) Val_GObject((GObject*)val)
#define Val_GtkTreeModelSort_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTreeModelSortClass' */
#define GtkTreeModelSortClass_val(val) ((GtkTreeModelSortClass*)val)
/* conversion for record 'GtkTreeModelSortPrivate' */
#define GtkTreeModelSortPrivate_val(val) ((GtkTreeModelSortPrivate*)val)
/* conversion for record 'GtkTreePath' */
#define GtkTreePath_val(val) ((GtkTreePath*)val)
/* conversion for record 'GtkTreeRowReference' */
#define GtkTreeRowReference_val(val) ((GtkTreeRowReference*)val)
#define GtkTreeSelection_val(val) check_cast(GTK_TREE_SELECTION,val)
#define Val_GtkTreeSelection(val) Val_GObject((GObject*)val)
#define Val_GtkTreeSelection_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTreeSelectionClass' */
#define GtkTreeSelectionClass_val(val) ((GtkTreeSelectionClass*)val)
/* conversion for record 'GtkTreeSelectionPrivate' */
#define GtkTreeSelectionPrivate_val(val) ((GtkTreeSelectionPrivate*)val)
/* conversion for record 'GtkTreeSortableIface' */
#define GtkTreeSortableIface_val(val) ((GtkTreeSortableIface*)val)
#define GtkTreeStore_val(val) check_cast(GTK_TREE_STORE,val)
#define Val_GtkTreeStore(val) Val_GObject((GObject*)val)
#define Val_GtkTreeStore_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTreeStoreClass' */
#define GtkTreeStoreClass_val(val) ((GtkTreeStoreClass*)val)
/* conversion for record 'GtkTreeStorePrivate' */
#define GtkTreeStorePrivate_val(val) ((GtkTreeStorePrivate*)val)
#define GtkTreeView_val(val) check_cast(GTK_TREE_VIEW,val)
#define Val_GtkTreeView(val) Val_GObject((GObject*)val)
#define Val_GtkTreeView_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTreeViewClass' */
#define GtkTreeViewClass_val(val) ((GtkTreeViewClass*)val)
#define GtkTreeViewColumn_val(val) check_cast(GTK_TREE_VIEW_COLUMN,val)
#define Val_GtkTreeViewColumn(val) Val_GObject((GObject*)val)
#define Val_GtkTreeViewColumn_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkTreeViewColumnClass' */
#define GtkTreeViewColumnClass_val(val) ((GtkTreeViewColumnClass*)val)
/* conversion for record 'GtkTreeViewColumnPrivate' */
#define GtkTreeViewColumnPrivate_val(val) ((GtkTreeViewColumnPrivate*)val)
/* conversion for record 'GtkTreeViewPrivate' */
#define GtkTreeViewPrivate_val(val) ((GtkTreeViewPrivate*)val)
#define GtkUIManager_val(val) check_cast(GTK_UI_MANAGER,val)
#define Val_GtkUIManager(val) Val_GObject((GObject*)val)
#define Val_GtkUIManager_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkUIManagerClass' */
#define GtkUIManagerClass_val(val) ((GtkUIManagerClass*)val)
/* conversion for record 'GtkUIManagerPrivate' */
#define GtkUIManagerPrivate_val(val) ((GtkUIManagerPrivate*)val)
#define GtkVBox_val(val) check_cast(GTK_V_BOX,val)
#define Val_GtkVBox(val) Val_GObject((GObject*)val)
#define Val_GtkVBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkVBoxClass' */
#define GtkVBoxClass_val(val) ((GtkVBoxClass*)val)
#define GtkVButtonBox_val(val) check_cast(GTK_V_BUTTON_BOX,val)
#define Val_GtkVButtonBox(val) Val_GObject((GObject*)val)
#define Val_GtkVButtonBox_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkVButtonBoxClass' */
#define GtkVButtonBoxClass_val(val) ((GtkVButtonBoxClass*)val)
#define GtkVPaned_val(val) check_cast(GTK_V_PANED,val)
#define Val_GtkVPaned(val) Val_GObject((GObject*)val)
#define Val_GtkVPaned_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkVPanedClass' */
#define GtkVPanedClass_val(val) ((GtkVPanedClass*)val)
#define GtkVScale_val(val) check_cast(GTK_V_SCALE,val)
#define Val_GtkVScale(val) Val_GObject((GObject*)val)
#define Val_GtkVScale_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkVScaleClass' */
#define GtkVScaleClass_val(val) ((GtkVScaleClass*)val)
#define GtkVScrollbar_val(val) check_cast(GTK_V_SCROLLBAR,val)
#define Val_GtkVScrollbar(val) Val_GObject((GObject*)val)
#define Val_GtkVScrollbar_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkVScrollbarClass' */
#define GtkVScrollbarClass_val(val) ((GtkVScrollbarClass*)val)
#define GtkVSeparator_val(val) check_cast(GTK_V_SEPARATOR,val)
#define Val_GtkVSeparator(val) Val_GObject((GObject*)val)
#define Val_GtkVSeparator_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkVSeparatorClass' */
#define GtkVSeparatorClass_val(val) ((GtkVSeparatorClass*)val)
#define GtkViewport_val(val) check_cast(GTK_VIEWPORT,val)
#define Val_GtkViewport(val) Val_GObject((GObject*)val)
#define Val_GtkViewport_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkViewportClass' */
#define GtkViewportClass_val(val) ((GtkViewportClass*)val)
/* conversion for record 'GtkViewportPrivate' */
#define GtkViewportPrivate_val(val) ((GtkViewportPrivate*)val)
#define GtkVolumeButton_val(val) check_cast(GTK_VOLUME_BUTTON,val)
#define Val_GtkVolumeButton(val) Val_GObject((GObject*)val)
#define Val_GtkVolumeButton_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkVolumeButtonClass' */
#define GtkVolumeButtonClass_val(val) ((GtkVolumeButtonClass*)val)
#define GtkWidget_val(val) check_cast(GTK_WIDGET,val)
#define Val_GtkWidget(val) Val_GObject((GObject*)val)
#define Val_GtkWidget_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkWidgetAuxInfo' */
#define GtkWidgetAuxInfo_val(val) ((GtkWidgetAuxInfo*)val)
/* conversion for record 'GtkWidgetClass' */
#define GtkWidgetClass_val(val) ((GtkWidgetClass*)val)
/* conversion for record 'GtkWidgetClassPrivate' */
#define GtkWidgetClassPrivate_val(val) ((GtkWidgetClassPrivate*)val)
/* conversion for record 'GtkWidgetPath' */
#define GtkWidgetPath_val(val) ((GtkWidgetPath*)val)
/* conversion for record 'GtkWidgetPrivate' */
#define GtkWidgetPrivate_val(val) ((GtkWidgetPrivate*)val)
#define GtkWindow_val(val) check_cast(GTK_WINDOW,val)
#define Val_GtkWindow(val) Val_GObject((GObject*)val)
#define Val_GtkWindow_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkWindowClass' */
#define GtkWindowClass_val(val) ((GtkWindowClass*)val)
/* conversion for record 'GtkWindowGeometryInfo' */
#define GtkWindowGeometryInfo_val(val) ((GtkWindowGeometryInfo*)val)
#define GtkWindowGroup_val(val) check_cast(GTK_WINDOW_GROUP,val)
#define Val_GtkWindowGroup(val) Val_GObject((GObject*)val)
#define Val_GtkWindowGroup_new(val) Val_GObject_new((GObject*)val)
/* conversion for record 'GtkWindowGroupClass' */
#define GtkWindowGroupClass_val(val) ((GtkWindowGroupClass*)val)
/* conversion for record 'GtkWindowGroupPrivate' */
#define GtkWindowGroupPrivate_val(val) ((GtkWindowGroupPrivate*)val)
/* conversion for record 'GtkWindowPrivate' */
#define GtkWindowPrivate_val(val) ((GtkWindowPrivate*)val)
/* conversion for record '_GtkRcProperty' */
#define _GtkRcProperty_val(val) ((_GtkRcProperty*)val)

#include <gdk-pixbuf/gdk-pixbuf.h>
#include "../wrappers.h"
#include "../ml_gobject.h"
/* Module Pixdata */
/* end of Pixdata */
/* Module PixbufSimpleAnim */
ML_2(gdk_pixbuf_simple_anim_set_loop,GdkPixbufSimpleAnim_val, Bool_val, Unit)
ML_1(gdk_pixbuf_simple_anim_get_loop,GdkPixbufSimpleAnim_val, Val_bool)
ML_2(gdk_pixbuf_simple_anim_add_frame,GdkPixbufSimpleAnim_val, GdkPixbuf_val, Unit)
/* end of PixbufSimpleAnim */
/* Module PixbufLoader */
ML_3(gdk_pixbuf_loader_set_size,GdkPixbufLoader_val, Int_val, Int_val, Unit)
ML_1(gdk_pixbuf_loader_get_pixbuf,GdkPixbufLoader_val, Val_GdkPixbuf)
ML_1(gdk_pixbuf_loader_get_format,GdkPixbufLoader_val, Val_GdkPixbufFormat)
ML_1(gdk_pixbuf_loader_get_animation,GdkPixbufLoader_val, Val_GdkPixbufAnimation)
/* end of PixbufLoader */
/* Module PixbufFormat */
ML_2(gdk_pixbuf_format_set_disabled,GdkPixbufFormat_val, Bool_val, Unit)
ML_1(gdk_pixbuf_format_is_writable,GdkPixbufFormat_val, Val_bool)
ML_1(gdk_pixbuf_format_is_scalable,GdkPixbufFormat_val, Val_bool)
ML_1(gdk_pixbuf_format_is_disabled,GdkPixbufFormat_val, Val_bool)
ML_1(gdk_pixbuf_format_get_name,GdkPixbufFormat_val, Val_string_new)
ML_1(gdk_pixbuf_format_get_license,GdkPixbufFormat_val, Val_string_new)
ML_1(gdk_pixbuf_format_get_description,GdkPixbufFormat_val, Val_string_new)
ML_1(gdk_pixbuf_format_free,GdkPixbufFormat_val, Unit)
ML_1(gdk_pixbuf_format_copy,GdkPixbufFormat_val, Val_GdkPixbufFormat_new)
/* end of PixbufFormat */
/* Module PixbufAnimationIter */
ML_1(gdk_pixbuf_animation_iter_on_currently_loading_frame,GdkPixbufAnimationIter_val, Val_bool)
ML_1(gdk_pixbuf_animation_iter_get_pixbuf,GdkPixbufAnimationIter_val, Val_GdkPixbuf)
ML_1(gdk_pixbuf_animation_iter_get_delay_time,GdkPixbufAnimationIter_val, Val_int)
ML_2(gdk_pixbuf_animation_iter_advance,GdkPixbufAnimationIter_val, GTimeVal_val, Val_bool)
/* end of PixbufAnimationIter */
/* Module PixbufAnimation */
ML_1(gdk_pixbuf_animation_is_static_image,GdkPixbufAnimation_val, Val_bool)
ML_1(gdk_pixbuf_animation_get_width,GdkPixbufAnimation_val, Val_int)
ML_1(gdk_pixbuf_animation_get_static_image,GdkPixbufAnimation_val, Val_GdkPixbuf)
ML_2(gdk_pixbuf_animation_get_iter,GdkPixbufAnimation_val, GTimeVal_val, Val_GdkPixbufAnimationIter_new)
ML_1(gdk_pixbuf_animation_get_height,GdkPixbufAnimation_val, Val_int)
/* end of PixbufAnimation */
/* Module Pixbuf */
ML_5(gdk_pixbuf_new_subpixbuf,GdkPixbuf_val, Int_val, Int_val, Int_val, Int_val, Val_GdkPixbuf_new)
ML_1(gdk_pixbuf_get_width,GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_rowstride,GdkPixbuf_val, Val_int)
ML_2(gdk_pixbuf_get_option,GdkPixbuf_val, String_val, Val_string)
ML_1(gdk_pixbuf_get_n_channels,GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_height,GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_has_alpha,GdkPixbuf_val, Val_bool)
ML_1(gdk_pixbuf_get_byte_length,GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_bits_per_sample,GdkPixbuf_val, Val_int)
ML_2(gdk_pixbuf_flip,GdkPixbuf_val, Bool_val, Val_GdkPixbuf_new)
ML_2(gdk_pixbuf_fill,GdkPixbuf_val, Int32_val, Unit)
ML_8(gdk_pixbuf_copy_area,GdkPixbuf_val, Int_val, Int_val, Int_val, Int_val, GdkPixbuf_val, Int_val, Int_val, Unit)
ML_bc8(ml_gdk_pixbuf_copy_area)
ML_1(gdk_pixbuf_copy,GdkPixbuf_val, Val_GdkPixbuf_new)
ML_1(gdk_pixbuf_apply_embedded_orientation,GdkPixbuf_val, Val_GdkPixbuf_new)
ML_5(gdk_pixbuf_add_alpha,GdkPixbuf_val, Bool_val, Int_val, Int_val, Int_val, Val_GdkPixbuf_new)
ML_1(gdk_pixbuf_gettext,String_val, Val_string)
ML_0(gdk_pixbuf_get_formats,Val_GSList)
/* end of Pixbuf */
/* Global functions */
/* End of global functions */

