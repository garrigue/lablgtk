#include <caml/mlvalues.h>
#include <caml/alloc.h>
#define Val_double(val) caml_copy_double(val)
#define Val_string_new(val) caml_copy_string(val)
#define Val_int32(val) caml_copy_int32(val)
#define Val_int32_new(val) caml_copy_int32(val)
/*TODO: conversion for record 'GAllocator' */
/*TODO: conversion for record 'GArray' */
/*TODO: conversion for record 'GAsyncQueue' */
/*TODO: conversion for record 'GBookmarkFile' */
/*TODO: conversion for record 'GByteArray' */
/*TODO: conversion for record 'GCache' */
/*TODO: conversion for record 'GChecksum' */
/*TODO: conversion for record 'GCompletion' */
/*TODO: conversion for record 'GCond' */
/*TODO: conversion for record 'GData' */
/*TODO: conversion for record 'GDate' */
/*TODO: conversion for record 'GDateTime' */
/*TODO: conversion for record 'GDebugKey' */
/*TODO: conversion for record 'GDir' */
/*TODO: conversion for record 'GError' */
/*TODO: conversion for record 'GHashTable' */
/*TODO: conversion for record 'GHashTableIter' */
/*TODO: conversion for record 'GHook' */
/*TODO: conversion for record 'GHookList' */
/*TODO: conversion for record 'GIConv' */
/*TODO: conversion for record 'GIOChannel' */
/*TODO: conversion for record 'GIOFuncs' */
/*TODO: conversion for record 'GKeyFile' */
/*TODO: conversion for record 'GList' */
/*TODO: conversion for record 'GMainContext' */
/*TODO: conversion for record 'GMainLoop' */
/*TODO: conversion for record 'GMappedFile' */
/*TODO: conversion for record 'GMarkupParseContext' */
/*TODO: conversion for record 'GMarkupParser' */
/*TODO: conversion for record 'GMatchInfo' */
/*TODO: conversion for record 'GMemChunk' */
/*TODO: conversion for record 'GMemVTable' */
/*TODO: conversion for record 'GMutex' */
/*TODO: conversion for record 'GNode' */
/*TODO: conversion for record 'GOnce' */
/*TODO: conversion for record 'GOptionContext' */
/*TODO: conversion for record 'GOptionEntry' */
/*TODO: conversion for record 'GOptionGroup' */
/*TODO: conversion for record 'GPatternSpec' */
/*TODO: conversion for record 'GPollFD' */
/*TODO: conversion for record 'GPrivate' */
/*TODO: conversion for record 'GPtrArray' */
/*TODO: conversion for record 'GQueue' */
/*TODO: conversion for record 'GRand' */
/*TODO: conversion for record 'GRegex' */
/*TODO: conversion for record 'GRelation' */
/*TODO: conversion for record 'GSList' */
/*TODO: conversion for record 'GScanner' */
/*TODO: conversion for record 'GScannerConfig' */
/*TODO: conversion for record 'GSequence' */
/*TODO: conversion for record 'GSequenceIter' */
/*TODO: conversion for record 'GSource' */
/*TODO: conversion for record 'GSourceCallbackFuncs' */
/*TODO: conversion for record 'GSourceFuncs' */
/*TODO: conversion for record 'GSourcePrivate' */
/*TODO: conversion for record 'GStatBuf' */
/*TODO: conversion for record 'GStaticMutex' */
/*TODO: conversion for record 'GStaticPrivate' */
/*TODO: conversion for record 'GStaticRWLock' */
/*TODO: conversion for record 'GStaticRecMutex' */
/*TODO: conversion for record 'GString' */
/*TODO: conversion for record 'GStringChunk' */
/*TODO: conversion for record 'GTestCase' */
/*TODO: conversion for record 'GTestConfig' */
/*TODO: conversion for record 'GTestLogBuffer' */
/*TODO: conversion for record 'GTestLogMsg' */
/*TODO: conversion for record 'GTestSuite' */
/*TODO: conversion for record 'GThread' */
/*TODO: conversion for record 'GThreadFunctions' */
/*TODO: conversion for record 'GThreadPool' */
/*TODO: conversion for record 'GTimeVal' */
/*TODO: conversion for record 'GTimeZone' */
/*TODO: conversion for record 'GTimer' */
/*TODO: conversion for record 'GTrashStack' */
/*TODO: conversion for record 'GTree' */
/*TODO: conversion for record 'GTuples' */
/*TODO: conversion for record 'GVariant' */
/*TODO: conversion for record 'GVariantBuilder' */
/*TODO: conversion for record 'GVariantIter' */
/*TODO: conversion for record 'GVariantType' */
#define GBinding_val(val) check_cast(G_BINDING,val)
#define Val_GBinding(val) Val_GObject((GObject*)val)
#define Val_GBinding_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GCClosure' */
/*TODO: conversion for record 'GClosure' */
/*TODO: conversion for record 'GClosureNotifyData' */
/*TODO: conversion for record 'GEnumClass' */
/*TODO: conversion for record 'GEnumValue' */
/*TODO: conversion for record 'GFlagsClass' */
/*TODO: conversion for record 'GFlagsValue' */
/*TODO: conversion for record 'GInitiallyUnownedClass' */
/*TODO: conversion for record 'GInterfaceInfo' */
/*TODO: conversion for record 'GObjectClass' */
/*TODO: conversion for record 'GObjectConstructParam' */
/*TODO: conversion for record 'GParamSpec' */
/*TODO: conversion for record 'GParamSpecBoolean' */
/*TODO: conversion for record 'GParamSpecBoxed' */
/*TODO: conversion for record 'GParamSpecChar' */
/*TODO: conversion for record 'GParamSpecClass' */
/*TODO: conversion for record 'GParamSpecDouble' */
/*TODO: conversion for record 'GParamSpecEnum' */
/*TODO: conversion for record 'GParamSpecFlags' */
/*TODO: conversion for record 'GParamSpecFloat' */
/*TODO: conversion for record 'GParamSpecGType' */
/*TODO: conversion for record 'GParamSpecInt' */
/*TODO: conversion for record 'GParamSpecInt64' */
/*TODO: conversion for record 'GParamSpecLong' */
/*TODO: conversion for record 'GParamSpecObject' */
/*TODO: conversion for record 'GParamSpecOverride' */
/*TODO: conversion for record 'GParamSpecParam' */
/*TODO: conversion for record 'GParamSpecPointer' */
/*TODO: conversion for record 'GParamSpecPool' */
/*TODO: conversion for record 'GParamSpecString' */
/*TODO: conversion for record 'GParamSpecTypeInfo' */
/*TODO: conversion for record 'GParamSpecUChar' */
/*TODO: conversion for record 'GParamSpecUInt' */
/*TODO: conversion for record 'GParamSpecUInt64' */
/*TODO: conversion for record 'GParamSpecULong' */
/*TODO: conversion for record 'GParamSpecUnichar' */
/*TODO: conversion for record 'GParamSpecValueArray' */
/*TODO: conversion for record 'GParamSpecVariant' */
/*TODO: conversion for record 'GParameter' */
/*TODO: conversion for record 'GSignalInvocationHint' */
/*TODO: conversion for record 'GSignalQuery' */
/*TODO: conversion for record 'GTypeClass' */
/*TODO: conversion for record 'GTypeFundamentalInfo' */
/*TODO: conversion for record 'GTypeInfo' */
/*TODO: conversion for record 'GTypeInstance' */
/*TODO: conversion for record 'GTypeInterface' */
#define GTypeModule_val(val) check_cast(G_TYPE_MODULE,val)
#define Val_GTypeModule(val) Val_GObject((GObject*)val)
#define Val_GTypeModule_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GTypeModuleClass' */
/*TODO: conversion for record 'GTypePluginClass' */
/*TODO: conversion for record 'GTypeQuery' */
/*TODO: conversion for record 'GTypeValueTable' */
/*TODO: conversion for record 'GValue' */
/*TODO: conversion for record 'GValueArray' */
/*TODO: conversion for record 'AtkActionIface' */
/*TODO: conversion for record 'AtkAttribute' */
/*TODO: conversion for record 'AtkComponentIface' */
/*TODO: conversion for record 'AtkDocumentIface' */
/*TODO: conversion for record 'AtkEditableTextIface' */
#define AtkGObjectAccessible_val(val) check_cast(ATK_G_OBJECT_ACCESSIBLE,val)
#define Val_AtkGObjectAccessible(val) Val_GObject((GObject*)val)
#define Val_AtkGObjectAccessible_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkGObjectAccessibleClass' */
#define AtkHyperlink_val(val) check_cast(ATK_HYPERLINK,val)
#define Val_AtkHyperlink(val) Val_GObject((GObject*)val)
#define Val_AtkHyperlink_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkHyperlinkClass' */
/*TODO: conversion for record 'AtkHyperlinkImplIface' */
/*TODO: conversion for record 'AtkHypertextIface' */
/*TODO: conversion for record 'AtkImageIface' */
/*TODO: conversion for record 'AtkImplementor' */
/*TODO: conversion for record 'AtkKeyEventStruct' */
#define AtkMisc_val(val) check_cast(ATK_MISC,val)
#define Val_AtkMisc(val) Val_GObject((GObject*)val)
#define Val_AtkMisc_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkMiscClass' */
#define AtkNoOpObject_val(val) check_cast(ATK_NO_OP_OBJECT,val)
#define Val_AtkNoOpObject(val) Val_GObject((GObject*)val)
#define Val_AtkNoOpObject_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkNoOpObjectClass' */
#define AtkNoOpObjectFactory_val(val) check_cast(ATK_NO_OP_OBJECT_FACTORY,val)
#define Val_AtkNoOpObjectFactory(val) Val_GObject((GObject*)val)
#define Val_AtkNoOpObjectFactory_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkNoOpObjectFactoryClass' */
#define AtkObject_val(val) check_cast(ATK_OBJECT,val)
#define Val_AtkObject(val) Val_GObject((GObject*)val)
#define Val_AtkObject_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkObjectClass' */
#define AtkObjectFactory_val(val) check_cast(ATK_OBJECT_FACTORY,val)
#define Val_AtkObjectFactory(val) Val_GObject((GObject*)val)
#define Val_AtkObjectFactory_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkObjectFactoryClass' */
#define AtkPlug_val(val) check_cast(ATK_PLUG,val)
#define Val_AtkPlug(val) Val_GObject((GObject*)val)
#define Val_AtkPlug_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkPlugClass' */
/*TODO: conversion for record 'AtkRectangle' */
#define AtkRelation_val(val) check_cast(ATK_RELATION,val)
#define Val_AtkRelation(val) Val_GObject((GObject*)val)
#define Val_AtkRelation_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkRelationClass' */
#define AtkRelationSet_val(val) check_cast(ATK_RELATION_SET,val)
#define Val_AtkRelationSet(val) Val_GObject((GObject*)val)
#define Val_AtkRelationSet_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkRelationSetClass' */
/*TODO: conversion for record 'AtkSelectionIface' */
#define AtkSocket_val(val) check_cast(ATK_SOCKET,val)
#define Val_AtkSocket(val) Val_GObject((GObject*)val)
#define Val_AtkSocket_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkSocketClass' */
#define AtkStateSet_val(val) check_cast(ATK_STATE_SET,val)
#define Val_AtkStateSet(val) Val_GObject((GObject*)val)
#define Val_AtkStateSet_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkStateSetClass' */
/*TODO: conversion for record 'AtkStreamableContentIface' */
/*TODO: conversion for record 'AtkTableIface' */
/*TODO: conversion for record 'AtkTextIface' */
/*TODO: conversion for record 'AtkTextRange' */
/*TODO: conversion for record 'AtkTextRectangle' */
#define AtkUtil_val(val) check_cast(ATK_UTIL,val)
#define Val_AtkUtil(val) Val_GObject((GObject*)val)
#define Val_AtkUtil_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'AtkUtilClass' */
/*TODO: conversion for record 'AtkValueIface' */
/*TODO: conversion for record '_AtkPropertyValues' */
/*TODO: conversion for record '_AtkRegistry' */
/*TODO: conversion for record '_AtkRegistryClass' */
/*TODO: conversion for record 'GModule' */
/*TODO: conversion for record 'GActionGroupInterface' */
/*TODO: conversion for record 'GActionInterface' */
/*TODO: conversion for record 'GAppInfoIface' */
#define GAppLaunchContext_val(val) check_cast(G_APP_LAUNCH_CONTEXT,val)
#define Val_GAppLaunchContext(val) Val_GObject((GObject*)val)
#define Val_GAppLaunchContext_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GAppLaunchContextClass' */
/*TODO: conversion for record 'GAppLaunchContextPrivate' */
#define GApplication_val(val) check_cast(G_APPLICATION,val)
#define Val_GApplication(val) Val_GObject((GObject*)val)
#define Val_GApplication_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GApplicationClass' */
#define GApplicationCommandLine_val(val) check_cast(G_APPLICATION_COMMAND_LINE,val)
#define Val_GApplicationCommandLine(val) Val_GObject((GObject*)val)
#define Val_GApplicationCommandLine_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GApplicationCommandLineClass' */
/*TODO: conversion for record 'GApplicationCommandLinePrivate' */
/*TODO: conversion for record 'GApplicationPrivate' */
/*TODO: conversion for record 'GAsyncInitableIface' */
/*TODO: conversion for record 'GAsyncResultIface' */
#define GBufferedInputStream_val(val) check_cast(G_BUFFERED_INPUT_STREAM,val)
#define Val_GBufferedInputStream(val) Val_GObject((GObject*)val)
#define Val_GBufferedInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GBufferedInputStreamClass' */
/*TODO: conversion for record 'GBufferedInputStreamPrivate' */
#define GBufferedOutputStream_val(val) check_cast(G_BUFFERED_OUTPUT_STREAM,val)
#define Val_GBufferedOutputStream(val) Val_GObject((GObject*)val)
#define Val_GBufferedOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GBufferedOutputStreamClass' */
/*TODO: conversion for record 'GBufferedOutputStreamPrivate' */
#define GCancellable_val(val) check_cast(G_CANCELLABLE,val)
#define Val_GCancellable(val) Val_GObject((GObject*)val)
#define Val_GCancellable_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GCancellableClass' */
/*TODO: conversion for record 'GCancellablePrivate' */
#define GCharsetConverter_val(val) check_cast(G_CHARSET_CONVERTER,val)
#define Val_GCharsetConverter(val) Val_GObject((GObject*)val)
#define Val_GCharsetConverter_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GCharsetConverterClass' */
/*TODO: conversion for record 'GConverterIface' */
#define GConverterInputStream_val(val) check_cast(G_CONVERTER_INPUT_STREAM,val)
#define Val_GConverterInputStream(val) Val_GObject((GObject*)val)
#define Val_GConverterInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GConverterInputStreamClass' */
/*TODO: conversion for record 'GConverterInputStreamPrivate' */
#define GConverterOutputStream_val(val) check_cast(G_CONVERTER_OUTPUT_STREAM,val)
#define Val_GConverterOutputStream(val) Val_GObject((GObject*)val)
#define Val_GConverterOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GConverterOutputStreamClass' */
/*TODO: conversion for record 'GConverterOutputStreamPrivate' */
#define GCredentials_val(val) check_cast(G_CREDENTIALS,val)
#define Val_GCredentials(val) Val_GObject((GObject*)val)
#define Val_GCredentials_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GCredentialsClass' */
/*TODO: conversion for record 'GDBusAnnotationInfo' */
/*TODO: conversion for record 'GDBusArgInfo' */
#define GDBusAuthObserver_val(val) check_cast(G_D_BUS_AUTH_OBSERVER,val)
#define Val_GDBusAuthObserver(val) Val_GObject((GObject*)val)
#define Val_GDBusAuthObserver_new(val) Val_GObject_new((GObject*)val)
#define GDBusConnection_val(val) check_cast(G_D_BUS_CONNECTION,val)
#define Val_GDBusConnection(val) Val_GObject((GObject*)val)
#define Val_GDBusConnection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDBusErrorEntry' */
/*TODO: conversion for record 'GDBusInterfaceInfo' */
/*TODO: conversion for record 'GDBusInterfaceVTable' */
#define GDBusMessage_val(val) check_cast(G_D_BUS_MESSAGE,val)
#define Val_GDBusMessage(val) Val_GObject((GObject*)val)
#define Val_GDBusMessage_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDBusMethodInfo' */
#define GDBusMethodInvocation_val(val) check_cast(G_D_BUS_METHOD_INVOCATION,val)
#define Val_GDBusMethodInvocation(val) Val_GObject((GObject*)val)
#define Val_GDBusMethodInvocation_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDBusNodeInfo' */
/*TODO: conversion for record 'GDBusPropertyInfo' */
#define GDBusProxy_val(val) check_cast(G_D_BUS_PROXY,val)
#define Val_GDBusProxy(val) Val_GObject((GObject*)val)
#define Val_GDBusProxy_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDBusProxyClass' */
/*TODO: conversion for record 'GDBusProxyPrivate' */
#define GDBusServer_val(val) check_cast(G_D_BUS_SERVER,val)
#define Val_GDBusServer(val) Val_GObject((GObject*)val)
#define Val_GDBusServer_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDBusSignalInfo' */
/*TODO: conversion for record 'GDBusSubtreeVTable' */
#define GDataInputStream_val(val) check_cast(G_DATA_INPUT_STREAM,val)
#define Val_GDataInputStream(val) Val_GObject((GObject*)val)
#define Val_GDataInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDataInputStreamClass' */
/*TODO: conversion for record 'GDataInputStreamPrivate' */
#define GDataOutputStream_val(val) check_cast(G_DATA_OUTPUT_STREAM,val)
#define Val_GDataOutputStream(val) Val_GObject((GObject*)val)
#define Val_GDataOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDataOutputStreamClass' */
/*TODO: conversion for record 'GDataOutputStreamPrivate' */
#define GDesktopAppInfo_val(val) check_cast(G_DESKTOP_APP_INFO,val)
#define Val_GDesktopAppInfo(val) Val_GObject((GObject*)val)
#define Val_GDesktopAppInfo_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GDesktopAppInfoClass' */
/*TODO: conversion for record 'GDesktopAppInfoLaunchHandlerIface' */
/*TODO: conversion for record 'GDesktopAppInfoLookupIface' */
/*TODO: conversion for record 'GDriveIface' */
#define GEmblem_val(val) check_cast(G_EMBLEM,val)
#define Val_GEmblem(val) Val_GObject((GObject*)val)
#define Val_GEmblem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GEmblemClass' */
#define GEmblemedIcon_val(val) check_cast(G_EMBLEMED_ICON,val)
#define Val_GEmblemedIcon(val) Val_GObject((GObject*)val)
#define Val_GEmblemedIcon_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GEmblemedIconClass' */
/*TODO: conversion for record 'GEmblemedIconPrivate' */
/*TODO: conversion for record 'GFileAttributeInfo' */
/*TODO: conversion for record 'GFileAttributeInfoList' */
/*TODO: conversion for record 'GFileAttributeMatcher' */
/*TODO: conversion for record 'GFileDescriptorBasedIface' */
#define GFileEnumerator_val(val) check_cast(G_FILE_ENUMERATOR,val)
#define Val_GFileEnumerator(val) Val_GObject((GObject*)val)
#define Val_GFileEnumerator_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFileEnumeratorClass' */
/*TODO: conversion for record 'GFileEnumeratorPrivate' */
#define GFileIOStream_val(val) check_cast(G_FILE_I_O_STREAM,val)
#define Val_GFileIOStream(val) Val_GObject((GObject*)val)
#define Val_GFileIOStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFileIOStreamClass' */
/*TODO: conversion for record 'GFileIOStreamPrivate' */
#define GFileIcon_val(val) check_cast(G_FILE_ICON,val)
#define Val_GFileIcon(val) Val_GObject((GObject*)val)
#define Val_GFileIcon_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFileIconClass' */
/*TODO: conversion for record 'GFileIface' */
#define GFileInfo_val(val) check_cast(G_FILE_INFO,val)
#define Val_GFileInfo(val) Val_GObject((GObject*)val)
#define Val_GFileInfo_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFileInfoClass' */
#define GFileInputStream_val(val) check_cast(G_FILE_INPUT_STREAM,val)
#define Val_GFileInputStream(val) Val_GObject((GObject*)val)
#define Val_GFileInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFileInputStreamClass' */
/*TODO: conversion for record 'GFileInputStreamPrivate' */
#define GFileMonitor_val(val) check_cast(G_FILE_MONITOR,val)
#define Val_GFileMonitor(val) Val_GObject((GObject*)val)
#define Val_GFileMonitor_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFileMonitorClass' */
/*TODO: conversion for record 'GFileMonitorPrivate' */
#define GFileOutputStream_val(val) check_cast(G_FILE_OUTPUT_STREAM,val)
#define Val_GFileOutputStream(val) Val_GObject((GObject*)val)
#define Val_GFileOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFileOutputStreamClass' */
/*TODO: conversion for record 'GFileOutputStreamPrivate' */
#define GFilenameCompleter_val(val) check_cast(G_FILENAME_COMPLETER,val)
#define Val_GFilenameCompleter(val) Val_GObject((GObject*)val)
#define Val_GFilenameCompleter_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFilenameCompleterClass' */
#define GFilterInputStream_val(val) check_cast(G_FILTER_INPUT_STREAM,val)
#define Val_GFilterInputStream(val) Val_GObject((GObject*)val)
#define Val_GFilterInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFilterInputStreamClass' */
#define GFilterOutputStream_val(val) check_cast(G_FILTER_OUTPUT_STREAM,val)
#define Val_GFilterOutputStream(val) Val_GObject((GObject*)val)
#define Val_GFilterOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GFilterOutputStreamClass' */
/*TODO: conversion for record 'GIOExtension' */
/*TODO: conversion for record 'GIOExtensionPoint' */
#define GIOModule_val(val) check_cast(G_I_O_MODULE,val)
#define Val_GIOModule(val) Val_GObject((GObject*)val)
#define Val_GIOModule_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GIOModuleClass' */
/*TODO: conversion for record 'GIOSchedulerJob' */
#define GIOStream_val(val) check_cast(G_I_O_STREAM,val)
#define Val_GIOStream(val) Val_GObject((GObject*)val)
#define Val_GIOStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GIOStreamAdapter' */
/*TODO: conversion for record 'GIOStreamClass' */
/*TODO: conversion for record 'GIOStreamPrivate' */
/*TODO: conversion for record 'GIconIface' */
#define GInetAddress_val(val) check_cast(G_INET_ADDRESS,val)
#define Val_GInetAddress(val) Val_GObject((GObject*)val)
#define Val_GInetAddress_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GInetAddressClass' */
/*TODO: conversion for record 'GInetAddressPrivate' */
#define GInetSocketAddress_val(val) check_cast(G_INET_SOCKET_ADDRESS,val)
#define Val_GInetSocketAddress(val) Val_GObject((GObject*)val)
#define Val_GInetSocketAddress_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GInetSocketAddressClass' */
/*TODO: conversion for record 'GInetSocketAddressPrivate' */
/*TODO: conversion for record 'GInitableIface' */
#define GInputStream_val(val) check_cast(G_INPUT_STREAM,val)
#define Val_GInputStream(val) Val_GObject((GObject*)val)
#define Val_GInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GInputStreamClass' */
/*TODO: conversion for record 'GInputStreamPrivate' */
/*TODO: conversion for record 'GInputVector' */
/*TODO: conversion for record 'GLoadableIconIface' */
#define GMemoryInputStream_val(val) check_cast(G_MEMORY_INPUT_STREAM,val)
#define Val_GMemoryInputStream(val) Val_GObject((GObject*)val)
#define Val_GMemoryInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GMemoryInputStreamClass' */
/*TODO: conversion for record 'GMemoryInputStreamPrivate' */
#define GMemoryOutputStream_val(val) check_cast(G_MEMORY_OUTPUT_STREAM,val)
#define Val_GMemoryOutputStream(val) Val_GObject((GObject*)val)
#define Val_GMemoryOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GMemoryOutputStreamClass' */
/*TODO: conversion for record 'GMemoryOutputStreamPrivate' */
/*TODO: conversion for record 'GMountIface' */
#define GMountOperation_val(val) check_cast(G_MOUNT_OPERATION,val)
#define Val_GMountOperation(val) Val_GObject((GObject*)val)
#define Val_GMountOperation_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GMountOperationClass' */
/*TODO: conversion for record 'GMountOperationPrivate' */
#define GNativeVolumeMonitor_val(val) check_cast(G_NATIVE_VOLUME_MONITOR,val)
#define Val_GNativeVolumeMonitor(val) Val_GObject((GObject*)val)
#define Val_GNativeVolumeMonitor_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GNativeVolumeMonitorClass' */
#define GNetworkAddress_val(val) check_cast(G_NETWORK_ADDRESS,val)
#define Val_GNetworkAddress(val) Val_GObject((GObject*)val)
#define Val_GNetworkAddress_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GNetworkAddressClass' */
/*TODO: conversion for record 'GNetworkAddressPrivate' */
#define GNetworkService_val(val) check_cast(G_NETWORK_SERVICE,val)
#define Val_GNetworkService(val) Val_GObject((GObject*)val)
#define Val_GNetworkService_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GNetworkServiceClass' */
/*TODO: conversion for record 'GNetworkServicePrivate' */
#define GOutputStream_val(val) check_cast(G_OUTPUT_STREAM,val)
#define Val_GOutputStream(val) Val_GObject((GObject*)val)
#define Val_GOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GOutputStreamClass' */
/*TODO: conversion for record 'GOutputStreamPrivate' */
/*TODO: conversion for record 'GOutputVector' */
#define GPermission_val(val) check_cast(G_PERMISSION,val)
#define Val_GPermission(val) Val_GObject((GObject*)val)
#define Val_GPermission_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GPermissionClass' */
/*TODO: conversion for record 'GPermissionPrivate' */
/*TODO: conversion for record 'GPollableInputStreamInterface' */
/*TODO: conversion for record 'GPollableOutputStreamInterface' */
#define GProxyAddress_val(val) check_cast(G_PROXY_ADDRESS,val)
#define Val_GProxyAddress(val) Val_GObject((GObject*)val)
#define Val_GProxyAddress_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GProxyAddressClass' */
#define GProxyAddressEnumerator_val(val) check_cast(G_PROXY_ADDRESS_ENUMERATOR,val)
#define Val_GProxyAddressEnumerator(val) Val_GObject((GObject*)val)
#define Val_GProxyAddressEnumerator_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GProxyAddressEnumeratorClass' */
/*TODO: conversion for record 'GProxyAddressEnumeratorPrivate' */
/*TODO: conversion for record 'GProxyAddressPrivate' */
/*TODO: conversion for record 'GProxyInterface' */
/*TODO: conversion for record 'GProxyResolverInterface' */
#define GResolver_val(val) check_cast(G_RESOLVER,val)
#define Val_GResolver(val) Val_GObject((GObject*)val)
#define Val_GResolver_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GResolverClass' */
/*TODO: conversion for record 'GResolverPrivate' */
/*TODO: conversion for record 'GSeekableIface' */
#define GSettings_val(val) check_cast(G_SETTINGS,val)
#define Val_GSettings(val) Val_GObject((GObject*)val)
#define Val_GSettings_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSettingsBackend' */
/*TODO: conversion for record 'GSettingsClass' */
/*TODO: conversion for record 'GSettingsPrivate' */
#define GSimpleAction_val(val) check_cast(G_SIMPLE_ACTION,val)
#define Val_GSimpleAction(val) Val_GObject((GObject*)val)
#define Val_GSimpleAction_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSimpleActionClass' */
#define GSimpleActionGroup_val(val) check_cast(G_SIMPLE_ACTION_GROUP,val)
#define Val_GSimpleActionGroup(val) Val_GObject((GObject*)val)
#define Val_GSimpleActionGroup_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSimpleActionGroupClass' */
/*TODO: conversion for record 'GSimpleActionGroupPrivate' */
/*TODO: conversion for record 'GSimpleActionPrivate' */
#define GSimpleAsyncResult_val(val) check_cast(G_SIMPLE_ASYNC_RESULT,val)
#define Val_GSimpleAsyncResult(val) Val_GObject((GObject*)val)
#define Val_GSimpleAsyncResult_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSimpleAsyncResultClass' */
#define GSimplePermission_val(val) check_cast(G_SIMPLE_PERMISSION,val)
#define Val_GSimplePermission(val) Val_GObject((GObject*)val)
#define Val_GSimplePermission_new(val) Val_GObject_new((GObject*)val)
#define GSocket_val(val) check_cast(G_SOCKET,val)
#define Val_GSocket(val) Val_GObject((GObject*)val)
#define Val_GSocket_new(val) Val_GObject_new((GObject*)val)
#define GSocketAddress_val(val) check_cast(G_SOCKET_ADDRESS,val)
#define Val_GSocketAddress(val) Val_GObject((GObject*)val)
#define Val_GSocketAddress_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSocketAddressClass' */
#define GSocketAddressEnumerator_val(val) check_cast(G_SOCKET_ADDRESS_ENUMERATOR,val)
#define Val_GSocketAddressEnumerator(val) Val_GObject((GObject*)val)
#define Val_GSocketAddressEnumerator_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSocketAddressEnumeratorClass' */
/*TODO: conversion for record 'GSocketClass' */
#define GSocketClient_val(val) check_cast(G_SOCKET_CLIENT,val)
#define Val_GSocketClient(val) Val_GObject((GObject*)val)
#define Val_GSocketClient_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSocketClientClass' */
/*TODO: conversion for record 'GSocketClientPrivate' */
/*TODO: conversion for record 'GSocketConnectableIface' */
#define GSocketConnection_val(val) check_cast(G_SOCKET_CONNECTION,val)
#define Val_GSocketConnection(val) Val_GObject((GObject*)val)
#define Val_GSocketConnection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSocketConnectionClass' */
/*TODO: conversion for record 'GSocketConnectionPrivate' */
#define GSocketControlMessage_val(val) check_cast(G_SOCKET_CONTROL_MESSAGE,val)
#define Val_GSocketControlMessage(val) Val_GObject((GObject*)val)
#define Val_GSocketControlMessage_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSocketControlMessageClass' */
/*TODO: conversion for record 'GSocketControlMessagePrivate' */
#define GSocketListener_val(val) check_cast(G_SOCKET_LISTENER,val)
#define Val_GSocketListener(val) Val_GObject((GObject*)val)
#define Val_GSocketListener_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSocketListenerClass' */
/*TODO: conversion for record 'GSocketListenerPrivate' */
/*TODO: conversion for record 'GSocketPrivate' */
#define GSocketService_val(val) check_cast(G_SOCKET_SERVICE,val)
#define Val_GSocketService(val) Val_GObject((GObject*)val)
#define Val_GSocketService_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GSocketServiceClass' */
/*TODO: conversion for record 'GSocketServicePrivate' */
/*TODO: conversion for record 'GSrvTarget' */
#define GTcpConnection_val(val) check_cast(G_TCP_CONNECTION,val)
#define Val_GTcpConnection(val) Val_GObject((GObject*)val)
#define Val_GTcpConnection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GTcpConnectionClass' */
/*TODO: conversion for record 'GTcpConnectionPrivate' */
#define GTcpWrapperConnection_val(val) check_cast(G_TCP_WRAPPER_CONNECTION,val)
#define Val_GTcpWrapperConnection(val) Val_GObject((GObject*)val)
#define Val_GTcpWrapperConnection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GTcpWrapperConnectionClass' */
/*TODO: conversion for record 'GTcpWrapperConnectionPrivate' */
#define GThemedIcon_val(val) check_cast(G_THEMED_ICON,val)
#define Val_GThemedIcon(val) Val_GObject((GObject*)val)
#define Val_GThemedIcon_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GThemedIconClass' */
#define GThreadedSocketService_val(val) check_cast(G_THREADED_SOCKET_SERVICE,val)
#define Val_GThreadedSocketService(val) Val_GObject((GObject*)val)
#define Val_GThreadedSocketService_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GThreadedSocketServiceClass' */
/*TODO: conversion for record 'GThreadedSocketServicePrivate' */
/*TODO: conversion for record 'GTlsBackendInterface' */
#define GTlsCertificate_val(val) check_cast(G_TLS_CERTIFICATE,val)
#define Val_GTlsCertificate(val) Val_GObject((GObject*)val)
#define Val_GTlsCertificate_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GTlsCertificateClass' */
/*TODO: conversion for record 'GTlsCertificatePrivate' */
/*TODO: conversion for record 'GTlsClientConnectionInterface' */
/*TODO: conversion for record 'GTlsClientContext' */
#define GTlsConnection_val(val) check_cast(G_TLS_CONNECTION,val)
#define Val_GTlsConnection(val) Val_GObject((GObject*)val)
#define Val_GTlsConnection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GTlsConnectionClass' */
/*TODO: conversion for record 'GTlsConnectionPrivate' */
/*TODO: conversion for record 'GTlsContext' */
/*TODO: conversion for record 'GTlsServerConnectionInterface' */
/*TODO: conversion for record 'GTlsServerContext' */
#define GUnixConnection_val(val) check_cast(G_UNIX_CONNECTION,val)
#define Val_GUnixConnection(val) Val_GObject((GObject*)val)
#define Val_GUnixConnection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixConnectionClass' */
/*TODO: conversion for record 'GUnixConnectionPrivate' */
#define GUnixCredentialsMessage_val(val) check_cast(G_UNIX_CREDENTIALS_MESSAGE,val)
#define Val_GUnixCredentialsMessage(val) Val_GObject((GObject*)val)
#define Val_GUnixCredentialsMessage_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixCredentialsMessageClass' */
/*TODO: conversion for record 'GUnixCredentialsMessagePrivate' */
#define GUnixFDList_val(val) check_cast(G_UNIX_F_D_LIST,val)
#define Val_GUnixFDList(val) Val_GObject((GObject*)val)
#define Val_GUnixFDList_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixFDListClass' */
/*TODO: conversion for record 'GUnixFDListPrivate' */
#define GUnixFDMessage_val(val) check_cast(G_UNIX_F_D_MESSAGE,val)
#define Val_GUnixFDMessage(val) Val_GObject((GObject*)val)
#define Val_GUnixFDMessage_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixFDMessageClass' */
/*TODO: conversion for record 'GUnixFDMessagePrivate' */
#define GUnixInputStream_val(val) check_cast(G_UNIX_INPUT_STREAM,val)
#define Val_GUnixInputStream(val) Val_GObject((GObject*)val)
#define Val_GUnixInputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixInputStreamClass' */
/*TODO: conversion for record 'GUnixInputStreamPrivate' */
/*TODO: conversion for record 'GUnixMountEntry' */
#define GUnixMountMonitor_val(val) check_cast(G_UNIX_MOUNT_MONITOR,val)
#define Val_GUnixMountMonitor(val) Val_GObject((GObject*)val)
#define Val_GUnixMountMonitor_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixMountMonitorClass' */
/*TODO: conversion for record 'GUnixMountPoint' */
#define GUnixOutputStream_val(val) check_cast(G_UNIX_OUTPUT_STREAM,val)
#define Val_GUnixOutputStream(val) Val_GObject((GObject*)val)
#define Val_GUnixOutputStream_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixOutputStreamClass' */
/*TODO: conversion for record 'GUnixOutputStreamPrivate' */
#define GUnixSocketAddress_val(val) check_cast(G_UNIX_SOCKET_ADDRESS,val)
#define Val_GUnixSocketAddress(val) Val_GObject((GObject*)val)
#define Val_GUnixSocketAddress_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GUnixSocketAddressClass' */
/*TODO: conversion for record 'GUnixSocketAddressPrivate' */
#define GVfs_val(val) check_cast(G_VFS,val)
#define Val_GVfs(val) Val_GObject((GObject*)val)
#define Val_GVfs_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GVfsClass' */
/*TODO: conversion for record 'GVolumeIface' */
#define GVolumeMonitor_val(val) check_cast(G_VOLUME_MONITOR,val)
#define Val_GVolumeMonitor(val) Val_GObject((GObject*)val)
#define Val_GVolumeMonitor_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GVolumeMonitorClass' */
#define GZlibCompressor_val(val) check_cast(G_ZLIB_COMPRESSOR,val)
#define Val_GZlibCompressor(val) Val_GObject((GObject*)val)
#define Val_GZlibCompressor_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GZlibCompressorClass' */
#define GZlibDecompressor_val(val) check_cast(G_ZLIB_DECOMPRESSOR,val)
#define Val_GZlibDecompressor(val) Val_GObject((GObject*)val)
#define Val_GZlibDecompressor_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GZlibDecompressorClass' */
#define GdkPixbuf_val(val) check_cast(GDK_PIXBUF,val)
#define Val_GdkPixbuf(val) Val_GObject((GObject*)val)
#define Val_GdkPixbuf_new(val) Val_GObject_new((GObject*)val)
#define GdkPixbufAnimation_val(val) check_cast(GDK_PIXBUF_ANIMATION,val)
#define Val_GdkPixbufAnimation(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufAnimation_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkPixbufAnimationClass' */
#define GdkPixbufAnimationIter_val(val) check_cast(GDK_PIXBUF_ANIMATION_ITER,val)
#define Val_GdkPixbufAnimationIter(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufAnimationIter_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkPixbufAnimationIterClass' */
/*TODO: conversion for record 'GdkPixbufFormat' */
#define GdkPixbufLoader_val(val) check_cast(GDK_PIXBUF_LOADER,val)
#define Val_GdkPixbufLoader(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufLoader_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkPixbufLoaderClass' */
/*TODO: conversion for record 'GdkPixbufModule' */
/*TODO: conversion for record 'GdkPixbufModulePattern' */
#define GdkPixbufSimpleAnim_val(val) check_cast(GDK_PIXBUF_SIMPLE_ANIM,val)
#define Val_GdkPixbufSimpleAnim(val) Val_GObject((GObject*)val)
#define Val_GdkPixbufSimpleAnim_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkPixbufSimpleAnimClass' */
/*TODO: conversion for record 'GdkPixdata' */
/*TODO: conversion for record 'cairo_t' */
/*TODO: conversion for record 'cairo_surface_t' */
/*TODO: conversion for record 'cairo_matrix_t' */
/*TODO: conversion for record 'cairo_pattern_t' */
/*TODO: conversion for record 'cairo_region_t' */
/*TODO: conversion for record 'cairo_font_options_t' */
/*TODO: conversion for record 'cairo_font_type_t' */
/*TODO: conversion for record 'cairo_font_face_t' */
/*TODO: conversion for record 'cairo_scaled_font_t' */
/*TODO: conversion for record 'cairo_path_t' */
/*TODO: conversion for record 'cairo_rectangle_int_t' */
/*TODO: conversion for record 'PangoAnalysis' */
/*TODO: conversion for record 'PangoAttrClass' */
/*TODO: conversion for record 'PangoAttrColor' */
/*TODO: conversion for record 'PangoAttrFloat' */
/*TODO: conversion for record 'PangoAttrFontDesc' */
/*TODO: conversion for record 'PangoAttrInt' */
/*TODO: conversion for record 'PangoAttrIterator' */
/*TODO: conversion for record 'PangoAttrLanguage' */
/*TODO: conversion for record 'PangoAttrList' */
/*TODO: conversion for record 'PangoAttrShape' */
/*TODO: conversion for record 'PangoAttrSize' */
/*TODO: conversion for record 'PangoAttrString' */
/*TODO: conversion for record 'PangoAttribute' */
/*TODO: conversion for record 'PangoColor' */
#define PangoContext_val(val) check_cast(PANGO_CONTEXT,val)
#define Val_PangoContext(val) Val_GObject((GObject*)val)
#define Val_PangoContext_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'PangoContextClass' */
/*TODO: conversion for record 'PangoCoverage' */
/*TODO: conversion for record 'PangoEngineLang' */
/*TODO: conversion for record 'PangoEngineShape' */
#define PangoFont_val(val) check_cast(PANGO_FONT,val)
#define Val_PangoFont(val) Val_GObject((GObject*)val)
#define Val_PangoFont_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'PangoFontDescription' */
#define PangoFontFace_val(val) check_cast(PANGO_FONT_FACE,val)
#define Val_PangoFontFace(val) Val_GObject((GObject*)val)
#define Val_PangoFontFace_new(val) Val_GObject_new((GObject*)val)
#define PangoFontFamily_val(val) check_cast(PANGO_FONT_FAMILY,val)
#define Val_PangoFontFamily(val) Val_GObject((GObject*)val)
#define Val_PangoFontFamily_new(val) Val_GObject_new((GObject*)val)
#define PangoFontMap_val(val) check_cast(PANGO_FONT_MAP,val)
#define Val_PangoFontMap(val) Val_GObject((GObject*)val)
#define Val_PangoFontMap_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'PangoFontMetrics' */
#define PangoFontset_val(val) check_cast(PANGO_FONTSET,val)
#define Val_PangoFontset(val) Val_GObject((GObject*)val)
#define Val_PangoFontset_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'PangoGlyphGeometry' */
/*TODO: conversion for record 'PangoGlyphInfo' */
/*TODO: conversion for record 'PangoGlyphItem' */
/*TODO: conversion for record 'PangoGlyphItemIter' */
/*TODO: conversion for record 'PangoGlyphString' */
/*TODO: conversion for record 'PangoGlyphVisAttr' */
/*TODO: conversion for record 'PangoItem' */
/*TODO: conversion for record 'PangoLanguage' */
#define PangoLayout_val(val) check_cast(PANGO_LAYOUT,val)
#define Val_PangoLayout(val) Val_GObject((GObject*)val)
#define Val_PangoLayout_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'PangoLayoutClass' */
/*TODO: conversion for record 'PangoLayoutIter' */
/*TODO: conversion for record 'PangoLayoutLine' */
/*TODO: conversion for record 'PangoLogAttr' */
/*TODO: conversion for record 'PangoMatrix' */
/*TODO: conversion for record 'PangoRectangle' */
#define PangoRenderer_val(val) check_cast(PANGO_RENDERER,val)
#define Val_PangoRenderer(val) Val_GObject((GObject*)val)
#define Val_PangoRenderer_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'PangoRendererClass' */
/*TODO: conversion for record 'PangoRendererPrivate' */
/*TODO: conversion for record 'PangoScriptIter' */
/*TODO: conversion for record 'PangoTabArray' */
/*TODO: conversion for record '_PangoScriptForLang' */
#define GdkAppLaunchContext_val(val) check_cast(GDK_APP_LAUNCH_CONTEXT,val)
#define Val_GdkAppLaunchContext(val) Val_GObject((GObject*)val)
#define Val_GdkAppLaunchContext_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkAtom' */
/*TODO: conversion for record 'GdkColor' */
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
/*TODO: conversion for record 'GdkEventAny' */
/*TODO: conversion for record 'GdkEventButton' */
/*TODO: conversion for record 'GdkEventConfigure' */
/*TODO: conversion for record 'GdkEventCrossing' */
/*TODO: conversion for record 'GdkEventDND' */
/*TODO: conversion for record 'GdkEventExpose' */
/*TODO: conversion for record 'GdkEventFocus' */
/*TODO: conversion for record 'GdkEventGrabBroken' */
/*TODO: conversion for record 'GdkEventKey' */
/*TODO: conversion for record 'GdkEventMotion' */
/*TODO: conversion for record 'GdkEventOwnerChange' */
/*TODO: conversion for record 'GdkEventProperty' */
/*TODO: conversion for record 'GdkEventProximity' */
/*TODO: conversion for record 'GdkEventScroll' */
/*TODO: conversion for record 'GdkEventSelection' */
/*TODO: conversion for record 'GdkEventSetting' */
/*TODO: conversion for record 'GdkEventVisibility' */
/*TODO: conversion for record 'GdkEventWindowState' */
/*TODO: conversion for record 'GdkGeometry' */
#define GdkKeymap_val(val) check_cast(GDK_KEYMAP,val)
#define Val_GdkKeymap(val) Val_GObject((GObject*)val)
#define Val_GdkKeymap_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkKeymapKey' */
/*TODO: conversion for record 'GdkPoint' */
/*TODO: conversion for record 'GdkRGBA' */
#define GdkScreen_val(val) check_cast(GDK_SCREEN,val)
#define Val_GdkScreen(val) Val_GObject((GObject*)val)
#define Val_GdkScreen_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkTimeCoord' */
#define GdkVisual_val(val) check_cast(GDK_VISUAL,val)
#define Val_GdkVisual(val) Val_GObject((GObject*)val)
#define Val_GdkVisual_new(val) Val_GObject_new((GObject*)val)
#define GdkWindow_val(val) check_cast(GDK_WINDOW,val)
#define Val_GdkWindow(val) Val_GObject((GObject*)val)
#define Val_GdkWindow_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GdkWindowAttr' */
/*TODO: conversion for record 'GdkWindowClass' */
/*TODO: conversion for record 'GdkWindowRedirect' */
#define GtkAboutDialog_val(val) check_cast(GTK_ABOUT_DIALOG,val)
#define Val_GtkAboutDialog(val) Val_GObject((GObject*)val)
#define Val_GtkAboutDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAboutDialogClass' */
/*TODO: conversion for record 'GtkAboutDialogPrivate' */
#define GtkAccelGroup_val(val) check_cast(GTK_ACCEL_GROUP,val)
#define Val_GtkAccelGroup(val) Val_GObject((GObject*)val)
#define Val_GtkAccelGroup_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAccelGroupClass' */
/*TODO: conversion for record 'GtkAccelGroupEntry' */
/*TODO: conversion for record 'GtkAccelGroupPrivate' */
/*TODO: conversion for record 'GtkAccelKey' */
#define GtkAccelLabel_val(val) check_cast(GTK_ACCEL_LABEL,val)
#define Val_GtkAccelLabel(val) Val_GObject((GObject*)val)
#define Val_GtkAccelLabel_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAccelLabelClass' */
/*TODO: conversion for record 'GtkAccelLabelPrivate' */
#define GtkAccelMap_val(val) check_cast(GTK_ACCEL_MAP,val)
#define Val_GtkAccelMap(val) Val_GObject((GObject*)val)
#define Val_GtkAccelMap_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAccelMapClass' */
#define GtkAccessible_val(val) check_cast(GTK_ACCESSIBLE,val)
#define Val_GtkAccessible(val) Val_GObject((GObject*)val)
#define Val_GtkAccessible_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAccessibleClass' */
/*TODO: conversion for record 'GtkAccessiblePrivate' */
#define GtkAction_val(val) check_cast(GTK_ACTION,val)
#define Val_GtkAction(val) Val_GObject((GObject*)val)
#define Val_GtkAction_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkActionClass' */
/*TODO: conversion for record 'GtkActionEntry' */
#define GtkActionGroup_val(val) check_cast(GTK_ACTION_GROUP,val)
#define Val_GtkActionGroup(val) Val_GObject((GObject*)val)
#define Val_GtkActionGroup_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkActionGroupClass' */
/*TODO: conversion for record 'GtkActionGroupPrivate' */
/*TODO: conversion for record 'GtkActionPrivate' */
/*TODO: conversion for record 'GtkActivatableIface' */
#define GtkAdjustment_val(val) check_cast(GTK_ADJUSTMENT,val)
#define Val_GtkAdjustment(val) Val_GObject((GObject*)val)
#define Val_GtkAdjustment_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAdjustmentClass' */
/*TODO: conversion for record 'GtkAdjustmentPrivate' */
#define GtkAlignment_val(val) check_cast(GTK_ALIGNMENT,val)
#define Val_GtkAlignment(val) Val_GObject((GObject*)val)
#define Val_GtkAlignment_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAlignmentClass' */
/*TODO: conversion for record 'GtkAlignmentPrivate' */
#define GtkAppChooserButton_val(val) check_cast(GTK_APP_CHOOSER_BUTTON,val)
#define Val_GtkAppChooserButton(val) Val_GObject((GObject*)val)
#define Val_GtkAppChooserButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAppChooserButtonClass' */
/*TODO: conversion for record 'GtkAppChooserButtonPrivate' */
#define GtkAppChooserDialog_val(val) check_cast(GTK_APP_CHOOSER_DIALOG,val)
#define Val_GtkAppChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkAppChooserDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAppChooserDialogClass' */
/*TODO: conversion for record 'GtkAppChooserDialogPrivate' */
#define GtkAppChooserWidget_val(val) check_cast(GTK_APP_CHOOSER_WIDGET,val)
#define Val_GtkAppChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkAppChooserWidget_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAppChooserWidgetClass' */
/*TODO: conversion for record 'GtkAppChooserWidgetPrivate' */
#define GtkApplication_val(val) check_cast(GTK_APPLICATION,val)
#define Val_GtkApplication(val) Val_GObject((GObject*)val)
#define Val_GtkApplication_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkApplicationClass' */
/*TODO: conversion for record 'GtkApplicationPrivate' */
#define GtkArrow_val(val) check_cast(GTK_ARROW,val)
#define Val_GtkArrow(val) Val_GObject((GObject*)val)
#define Val_GtkArrow_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkArrowClass' */
/*TODO: conversion for record 'GtkArrowPrivate' */
#define GtkAspectFrame_val(val) check_cast(GTK_ASPECT_FRAME,val)
#define Val_GtkAspectFrame(val) Val_GObject((GObject*)val)
#define Val_GtkAspectFrame_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAspectFrameClass' */
/*TODO: conversion for record 'GtkAspectFramePrivate' */
#define GtkAssistant_val(val) check_cast(GTK_ASSISTANT,val)
#define Val_GtkAssistant(val) Val_GObject((GObject*)val)
#define Val_GtkAssistant_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkAssistantClass' */
/*TODO: conversion for record 'GtkAssistantPrivate' */
#define GtkBin_val(val) check_cast(GTK_BIN,val)
#define Val_GtkBin(val) Val_GObject((GObject*)val)
#define Val_GtkBin_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkBinClass' */
/*TODO: conversion for record 'GtkBinPrivate' */
/*TODO: conversion for record 'GtkBindingArg' */
/*TODO: conversion for record 'GtkBindingEntry' */
/*TODO: conversion for record 'GtkBindingSet' */
/*TODO: conversion for record 'GtkBindingSignal' */
/*TODO: conversion for record 'GtkBorder' */
#define GtkBox_val(val) check_cast(GTK_BOX,val)
#define Val_GtkBox(val) Val_GObject((GObject*)val)
#define Val_GtkBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkBoxClass' */
/*TODO: conversion for record 'GtkBoxPrivate' */
/*TODO: conversion for record 'GtkBuildableIface' */
#define GtkBuilder_val(val) check_cast(GTK_BUILDER,val)
#define Val_GtkBuilder(val) Val_GObject((GObject*)val)
#define Val_GtkBuilder_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkBuilderClass' */
/*TODO: conversion for record 'GtkBuilderPrivate' */
#define GtkButton_val(val) check_cast(GTK_BUTTON,val)
#define Val_GtkButton(val) Val_GObject((GObject*)val)
#define Val_GtkButton_new(val) Val_GObject_new((GObject*)val)
#define GtkButtonBox_val(val) check_cast(GTK_BUTTON_BOX,val)
#define Val_GtkButtonBox(val) Val_GObject((GObject*)val)
#define Val_GtkButtonBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkButtonBoxClass' */
/*TODO: conversion for record 'GtkButtonBoxPrivate' */
/*TODO: conversion for record 'GtkButtonClass' */
/*TODO: conversion for record 'GtkButtonPrivate' */
#define GtkCalendar_val(val) check_cast(GTK_CALENDAR,val)
#define Val_GtkCalendar(val) Val_GObject((GObject*)val)
#define Val_GtkCalendar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCalendarClass' */
/*TODO: conversion for record 'GtkCalendarPrivate' */
#define GtkCellArea_val(val) check_cast(GTK_CELL_AREA,val)
#define Val_GtkCellArea(val) Val_GObject((GObject*)val)
#define Val_GtkCellArea_new(val) Val_GObject_new((GObject*)val)
#define GtkCellAreaBox_val(val) check_cast(GTK_CELL_AREA_BOX,val)
#define Val_GtkCellAreaBox(val) Val_GObject((GObject*)val)
#define Val_GtkCellAreaBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellAreaBoxClass' */
/*TODO: conversion for record 'GtkCellAreaBoxPrivate' */
/*TODO: conversion for record 'GtkCellAreaClass' */
#define GtkCellAreaContext_val(val) check_cast(GTK_CELL_AREA_CONTEXT,val)
#define Val_GtkCellAreaContext(val) Val_GObject((GObject*)val)
#define Val_GtkCellAreaContext_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellAreaContextClass' */
/*TODO: conversion for record 'GtkCellAreaContextPrivate' */
/*TODO: conversion for record 'GtkCellAreaPrivate' */
/*TODO: conversion for record 'GtkCellEditableIface' */
/*TODO: conversion for record 'GtkCellLayoutIface' */
#define GtkCellRenderer_val(val) check_cast(GTK_CELL_RENDERER,val)
#define Val_GtkCellRenderer(val) Val_GObject((GObject*)val)
#define Val_GtkCellRenderer_new(val) Val_GObject_new((GObject*)val)
#define GtkCellRendererAccel_val(val) check_cast(GTK_CELL_RENDERER_ACCEL,val)
#define Val_GtkCellRendererAccel(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererAccel_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererAccelClass' */
/*TODO: conversion for record 'GtkCellRendererAccelPrivate' */
/*TODO: conversion for record 'GtkCellRendererClass' */
#define GtkCellRendererCombo_val(val) check_cast(GTK_CELL_RENDERER_COMBO,val)
#define Val_GtkCellRendererCombo(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererCombo_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererComboClass' */
/*TODO: conversion for record 'GtkCellRendererComboPrivate' */
#define GtkCellRendererPixbuf_val(val) check_cast(GTK_CELL_RENDERER_PIXBUF,val)
#define Val_GtkCellRendererPixbuf(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererPixbuf_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererPixbufClass' */
/*TODO: conversion for record 'GtkCellRendererPixbufPrivate' */
/*TODO: conversion for record 'GtkCellRendererPrivate' */
#define GtkCellRendererProgress_val(val) check_cast(GTK_CELL_RENDERER_PROGRESS,val)
#define Val_GtkCellRendererProgress(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererProgress_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererProgressClass' */
/*TODO: conversion for record 'GtkCellRendererProgressPrivate' */
#define GtkCellRendererSpin_val(val) check_cast(GTK_CELL_RENDERER_SPIN,val)
#define Val_GtkCellRendererSpin(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererSpin_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererSpinClass' */
/*TODO: conversion for record 'GtkCellRendererSpinPrivate' */
#define GtkCellRendererSpinner_val(val) check_cast(GTK_CELL_RENDERER_SPINNER,val)
#define Val_GtkCellRendererSpinner(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererSpinner_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererSpinnerClass' */
/*TODO: conversion for record 'GtkCellRendererSpinnerPrivate' */
#define GtkCellRendererText_val(val) check_cast(GTK_CELL_RENDERER_TEXT,val)
#define Val_GtkCellRendererText(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererText_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererTextClass' */
/*TODO: conversion for record 'GtkCellRendererTextPrivate' */
#define GtkCellRendererToggle_val(val) check_cast(GTK_CELL_RENDERER_TOGGLE,val)
#define Val_GtkCellRendererToggle(val) Val_GObject((GObject*)val)
#define Val_GtkCellRendererToggle_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellRendererToggleClass' */
/*TODO: conversion for record 'GtkCellRendererTogglePrivate' */
#define GtkCellView_val(val) check_cast(GTK_CELL_VIEW,val)
#define Val_GtkCellView(val) Val_GObject((GObject*)val)
#define Val_GtkCellView_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCellViewClass' */
/*TODO: conversion for record 'GtkCellViewPrivate' */
#define GtkCheckButton_val(val) check_cast(GTK_CHECK_BUTTON,val)
#define Val_GtkCheckButton(val) Val_GObject((GObject*)val)
#define Val_GtkCheckButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCheckButtonClass' */
#define GtkCheckMenuItem_val(val) check_cast(GTK_CHECK_MENU_ITEM,val)
#define Val_GtkCheckMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkCheckMenuItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCheckMenuItemClass' */
/*TODO: conversion for record 'GtkCheckMenuItemPrivate' */
#define GtkClipboard_val(val) check_cast(GTK_CLIPBOARD,val)
#define Val_GtkClipboard(val) Val_GObject((GObject*)val)
#define Val_GtkClipboard_new(val) Val_GObject_new((GObject*)val)
#define GtkColorButton_val(val) check_cast(GTK_COLOR_BUTTON,val)
#define Val_GtkColorButton(val) Val_GObject((GObject*)val)
#define Val_GtkColorButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkColorButtonClass' */
/*TODO: conversion for record 'GtkColorButtonPrivate' */
#define GtkColorSelection_val(val) check_cast(GTK_COLOR_SELECTION,val)
#define Val_GtkColorSelection(val) Val_GObject((GObject*)val)
#define Val_GtkColorSelection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkColorSelectionClass' */
#define GtkColorSelectionDialog_val(val) check_cast(GTK_COLOR_SELECTION_DIALOG,val)
#define Val_GtkColorSelectionDialog(val) Val_GObject((GObject*)val)
#define Val_GtkColorSelectionDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkColorSelectionDialogClass' */
/*TODO: conversion for record 'GtkColorSelectionDialogPrivate' */
/*TODO: conversion for record 'GtkColorSelectionPrivate' */
#define GtkComboBox_val(val) check_cast(GTK_COMBO_BOX,val)
#define Val_GtkComboBox(val) Val_GObject((GObject*)val)
#define Val_GtkComboBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkComboBoxClass' */
/*TODO: conversion for record 'GtkComboBoxPrivate' */
#define GtkComboBoxText_val(val) check_cast(GTK_COMBO_BOX_TEXT,val)
#define Val_GtkComboBoxText(val) Val_GObject((GObject*)val)
#define Val_GtkComboBoxText_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkComboBoxTextClass' */
/*TODO: conversion for record 'GtkComboBoxTextPrivate' */
#define GtkContainer_val(val) check_cast(GTK_CONTAINER,val)
#define Val_GtkContainer(val) Val_GObject((GObject*)val)
#define Val_GtkContainer_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkContainerClass' */
/*TODO: conversion for record 'GtkContainerPrivate' */
#define GtkCssProvider_val(val) check_cast(GTK_CSS_PROVIDER,val)
#define Val_GtkCssProvider(val) Val_GObject((GObject*)val)
#define Val_GtkCssProvider_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkCssProviderClass' */
#define GtkDialog_val(val) check_cast(GTK_DIALOG,val)
#define Val_GtkDialog(val) Val_GObject((GObject*)val)
#define Val_GtkDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkDialogClass' */
/*TODO: conversion for record 'GtkDialogPrivate' */
#define GtkDrawingArea_val(val) check_cast(GTK_DRAWING_AREA,val)
#define Val_GtkDrawingArea(val) Val_GObject((GObject*)val)
#define Val_GtkDrawingArea_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkDrawingAreaClass' */
/*TODO: conversion for record 'GtkEditableInterface' */
#define GtkEntry_val(val) check_cast(GTK_ENTRY,val)
#define Val_GtkEntry(val) Val_GObject((GObject*)val)
#define Val_GtkEntry_new(val) Val_GObject_new((GObject*)val)
#define GtkEntryBuffer_val(val) check_cast(GTK_ENTRY_BUFFER,val)
#define Val_GtkEntryBuffer(val) Val_GObject((GObject*)val)
#define Val_GtkEntryBuffer_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkEntryBufferClass' */
/*TODO: conversion for record 'GtkEntryBufferPrivate' */
/*TODO: conversion for record 'GtkEntryClass' */
#define GtkEntryCompletion_val(val) check_cast(GTK_ENTRY_COMPLETION,val)
#define Val_GtkEntryCompletion(val) Val_GObject((GObject*)val)
#define Val_GtkEntryCompletion_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkEntryCompletionClass' */
/*TODO: conversion for record 'GtkEntryCompletionPrivate' */
/*TODO: conversion for record 'GtkEntryPrivate' */
#define GtkEventBox_val(val) check_cast(GTK_EVENT_BOX,val)
#define Val_GtkEventBox(val) Val_GObject((GObject*)val)
#define Val_GtkEventBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkEventBoxClass' */
/*TODO: conversion for record 'GtkEventBoxPrivate' */
#define GtkExpander_val(val) check_cast(GTK_EXPANDER,val)
#define Val_GtkExpander(val) Val_GObject((GObject*)val)
#define Val_GtkExpander_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkExpanderClass' */
/*TODO: conversion for record 'GtkExpanderPrivate' */
#define GtkFileChooserButton_val(val) check_cast(GTK_FILE_CHOOSER_BUTTON,val)
#define Val_GtkFileChooserButton(val) Val_GObject((GObject*)val)
#define Val_GtkFileChooserButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFileChooserButtonClass' */
/*TODO: conversion for record 'GtkFileChooserButtonPrivate' */
#define GtkFileChooserDialog_val(val) check_cast(GTK_FILE_CHOOSER_DIALOG,val)
#define Val_GtkFileChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkFileChooserDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFileChooserDialogClass' */
/*TODO: conversion for record 'GtkFileChooserDialogPrivate' */
#define GtkFileChooserWidget_val(val) check_cast(GTK_FILE_CHOOSER_WIDGET,val)
#define Val_GtkFileChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkFileChooserWidget_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFileChooserWidgetClass' */
/*TODO: conversion for record 'GtkFileChooserWidgetPrivate' */
#define GtkFileFilter_val(val) check_cast(GTK_FILE_FILTER,val)
#define Val_GtkFileFilter(val) Val_GObject((GObject*)val)
#define Val_GtkFileFilter_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFileFilterInfo' */
#define GtkFixed_val(val) check_cast(GTK_FIXED,val)
#define Val_GtkFixed(val) Val_GObject((GObject*)val)
#define Val_GtkFixed_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFixedChild' */
/*TODO: conversion for record 'GtkFixedClass' */
/*TODO: conversion for record 'GtkFixedPrivate' */
#define GtkFontButton_val(val) check_cast(GTK_FONT_BUTTON,val)
#define Val_GtkFontButton(val) Val_GObject((GObject*)val)
#define Val_GtkFontButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFontButtonClass' */
/*TODO: conversion for record 'GtkFontButtonPrivate' */
#define GtkFontSelection_val(val) check_cast(GTK_FONT_SELECTION,val)
#define Val_GtkFontSelection(val) Val_GObject((GObject*)val)
#define Val_GtkFontSelection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFontSelectionClass' */
#define GtkFontSelectionDialog_val(val) check_cast(GTK_FONT_SELECTION_DIALOG,val)
#define Val_GtkFontSelectionDialog(val) Val_GObject((GObject*)val)
#define Val_GtkFontSelectionDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFontSelectionDialogClass' */
/*TODO: conversion for record 'GtkFontSelectionDialogPrivate' */
/*TODO: conversion for record 'GtkFontSelectionPrivate' */
#define GtkFrame_val(val) check_cast(GTK_FRAME,val)
#define Val_GtkFrame(val) Val_GObject((GObject*)val)
#define Val_GtkFrame_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkFrameClass' */
/*TODO: conversion for record 'GtkFramePrivate' */
/*TODO: conversion for record 'GtkGradient' */
#define GtkGrid_val(val) check_cast(GTK_GRID,val)
#define Val_GtkGrid(val) Val_GObject((GObject*)val)
#define Val_GtkGrid_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkGridClass' */
/*TODO: conversion for record 'GtkGridPrivate' */
#define GtkHBox_val(val) check_cast(GTK_H_BOX,val)
#define Val_GtkHBox(val) Val_GObject((GObject*)val)
#define Val_GtkHBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHBoxClass' */
#define GtkHButtonBox_val(val) check_cast(GTK_H_BUTTON_BOX,val)
#define Val_GtkHButtonBox(val) Val_GObject((GObject*)val)
#define Val_GtkHButtonBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHButtonBoxClass' */
#define GtkHPaned_val(val) check_cast(GTK_H_PANED,val)
#define Val_GtkHPaned(val) Val_GObject((GObject*)val)
#define Val_GtkHPaned_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHPanedClass' */
#define GtkHSV_val(val) check_cast(GTK_HSV,val)
#define Val_GtkHSV(val) Val_GObject((GObject*)val)
#define Val_GtkHSV_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHSVClass' */
/*TODO: conversion for record 'GtkHSVPrivate' */
#define GtkHScale_val(val) check_cast(GTK_H_SCALE,val)
#define Val_GtkHScale(val) Val_GObject((GObject*)val)
#define Val_GtkHScale_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHScaleClass' */
#define GtkHScrollbar_val(val) check_cast(GTK_H_SCROLLBAR,val)
#define Val_GtkHScrollbar(val) Val_GObject((GObject*)val)
#define Val_GtkHScrollbar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHScrollbarClass' */
#define GtkHSeparator_val(val) check_cast(GTK_H_SEPARATOR,val)
#define Val_GtkHSeparator(val) Val_GObject((GObject*)val)
#define Val_GtkHSeparator_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHSeparatorClass' */
#define GtkHandleBox_val(val) check_cast(GTK_HANDLE_BOX,val)
#define Val_GtkHandleBox(val) Val_GObject((GObject*)val)
#define Val_GtkHandleBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkHandleBoxClass' */
/*TODO: conversion for record 'GtkHandleBoxPrivate' */
#define GtkIMContext_val(val) check_cast(GTK_IM_CONTEXT,val)
#define Val_GtkIMContext(val) Val_GObject((GObject*)val)
#define Val_GtkIMContext_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkIMContextClass' */
/*TODO: conversion for record 'GtkIMContextInfo' */
#define GtkIMContextSimple_val(val) check_cast(GTK_I_M_CONTEXT_SIMPLE,val)
#define Val_GtkIMContextSimple(val) Val_GObject((GObject*)val)
#define Val_GtkIMContextSimple_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkIMContextSimpleClass' */
/*TODO: conversion for record 'GtkIMContextSimplePrivate' */
#define GtkIMMulticontext_val(val) check_cast(GTK_IM_MULTICONTEXT,val)
#define Val_GtkIMMulticontext(val) Val_GObject((GObject*)val)
#define Val_GtkIMMulticontext_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkIMMulticontextClass' */
/*TODO: conversion for record 'GtkIMMulticontextPrivate' */
#define GtkIconFactory_val(val) check_cast(GTK_ICON_FACTORY,val)
#define Val_GtkIconFactory(val) Val_GObject((GObject*)val)
#define Val_GtkIconFactory_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkIconFactoryClass' */
/*TODO: conversion for record 'GtkIconFactoryPrivate' */
/*TODO: conversion for record 'GtkIconInfo' */
/*TODO: conversion for record 'GtkIconSet' */
/*TODO: conversion for record 'GtkIconSource' */
#define GtkIconTheme_val(val) check_cast(GTK_ICON_THEME,val)
#define Val_GtkIconTheme(val) Val_GObject((GObject*)val)
#define Val_GtkIconTheme_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkIconThemeClass' */
/*TODO: conversion for record 'GtkIconThemePrivate' */
#define GtkIconView_val(val) check_cast(GTK_ICON_VIEW,val)
#define Val_GtkIconView(val) Val_GObject((GObject*)val)
#define Val_GtkIconView_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkIconViewClass' */
/*TODO: conversion for record 'GtkIconViewPrivate' */
#define GtkImage_val(val) check_cast(GTK_IMAGE,val)
#define Val_GtkImage(val) Val_GObject((GObject*)val)
#define Val_GtkImage_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkImageClass' */
#define GtkImageMenuItem_val(val) check_cast(GTK_IMAGE_MENU_ITEM,val)
#define Val_GtkImageMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkImageMenuItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkImageMenuItemClass' */
/*TODO: conversion for record 'GtkImageMenuItemPrivate' */
/*TODO: conversion for record 'GtkImagePrivate' */
#define GtkInfoBar_val(val) check_cast(GTK_INFO_BAR,val)
#define Val_GtkInfoBar(val) Val_GObject((GObject*)val)
#define Val_GtkInfoBar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkInfoBarClass' */
/*TODO: conversion for record 'GtkInfoBarPrivate' */
#define GtkInvisible_val(val) check_cast(GTK_INVISIBLE,val)
#define Val_GtkInvisible(val) Val_GObject((GObject*)val)
#define Val_GtkInvisible_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkInvisibleClass' */
/*TODO: conversion for record 'GtkInvisiblePrivate' */
#define GtkLabel_val(val) check_cast(GTK_LABEL,val)
#define Val_GtkLabel(val) Val_GObject((GObject*)val)
#define Val_GtkLabel_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkLabelClass' */
/*TODO: conversion for record 'GtkLabelPrivate' */
/*TODO: conversion for record 'GtkLabelSelectionInfo' */
#define GtkLayout_val(val) check_cast(GTK_LAYOUT,val)
#define Val_GtkLayout(val) Val_GObject((GObject*)val)
#define Val_GtkLayout_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkLayoutClass' */
/*TODO: conversion for record 'GtkLayoutPrivate' */
#define GtkLinkButton_val(val) check_cast(GTK_LINK_BUTTON,val)
#define Val_GtkLinkButton(val) Val_GObject((GObject*)val)
#define Val_GtkLinkButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkLinkButtonClass' */
/*TODO: conversion for record 'GtkLinkButtonPrivate' */
#define GtkListStore_val(val) check_cast(GTK_LIST_STORE,val)
#define Val_GtkListStore(val) Val_GObject((GObject*)val)
#define Val_GtkListStore_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkListStoreClass' */
/*TODO: conversion for record 'GtkListStorePrivate' */
#define GtkMenu_val(val) check_cast(GTK_MENU,val)
#define Val_GtkMenu(val) Val_GObject((GObject*)val)
#define Val_GtkMenu_new(val) Val_GObject_new((GObject*)val)
#define GtkMenuBar_val(val) check_cast(GTK_MENU_BAR,val)
#define Val_GtkMenuBar(val) Val_GObject((GObject*)val)
#define Val_GtkMenuBar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkMenuBarClass' */
/*TODO: conversion for record 'GtkMenuBarPrivate' */
/*TODO: conversion for record 'GtkMenuClass' */
#define GtkMenuItem_val(val) check_cast(GTK_MENU_ITEM,val)
#define Val_GtkMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkMenuItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkMenuItemClass' */
/*TODO: conversion for record 'GtkMenuItemPrivate' */
/*TODO: conversion for record 'GtkMenuPrivate' */
#define GtkMenuShell_val(val) check_cast(GTK_MENU_SHELL,val)
#define Val_GtkMenuShell(val) Val_GObject((GObject*)val)
#define Val_GtkMenuShell_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkMenuShellClass' */
/*TODO: conversion for record 'GtkMenuShellPrivate' */
#define GtkMenuToolButton_val(val) check_cast(GTK_MENU_TOOL_BUTTON,val)
#define Val_GtkMenuToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkMenuToolButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkMenuToolButtonClass' */
/*TODO: conversion for record 'GtkMenuToolButtonPrivate' */
#define GtkMessageDialog_val(val) check_cast(GTK_MESSAGE_DIALOG,val)
#define Val_GtkMessageDialog(val) Val_GObject((GObject*)val)
#define Val_GtkMessageDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkMessageDialogClass' */
/*TODO: conversion for record 'GtkMessageDialogPrivate' */
#define GtkMisc_val(val) check_cast(GTK_MISC,val)
#define Val_GtkMisc(val) Val_GObject((GObject*)val)
#define Val_GtkMisc_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkMiscClass' */
/*TODO: conversion for record 'GtkMiscPrivate' */
#define GtkMountOperation_val(val) check_cast(GTK_MOUNT_OPERATION,val)
#define Val_GtkMountOperation(val) Val_GObject((GObject*)val)
#define Val_GtkMountOperation_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkMountOperationClass' */
/*TODO: conversion for record 'GtkMountOperationPrivate' */
#define GtkNotebook_val(val) check_cast(GTK_NOTEBOOK,val)
#define Val_GtkNotebook(val) Val_GObject((GObject*)val)
#define Val_GtkNotebook_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkNotebookClass' */
/*TODO: conversion for record 'GtkNotebookPrivate' */
#define GtkNumerableIcon_val(val) check_cast(GTK_NUMERABLE_ICON,val)
#define Val_GtkNumerableIcon(val) Val_GObject((GObject*)val)
#define Val_GtkNumerableIcon_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkNumerableIconClass' */
/*TODO: conversion for record 'GtkNumerableIconPrivate' */
#define GtkOffscreenWindow_val(val) check_cast(GTK_OFFSCREEN_WINDOW,val)
#define Val_GtkOffscreenWindow(val) Val_GObject((GObject*)val)
#define Val_GtkOffscreenWindow_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkOffscreenWindowClass' */
/*TODO: conversion for record 'GtkOrientableIface' */
/*TODO: conversion for record 'GtkPageRange' */
#define GtkPageSetup_val(val) check_cast(GTK_PAGE_SETUP,val)
#define Val_GtkPageSetup(val) Val_GObject((GObject*)val)
#define Val_GtkPageSetup_new(val) Val_GObject_new((GObject*)val)
#define GtkPaned_val(val) check_cast(GTK_PANED,val)
#define Val_GtkPaned(val) Val_GObject((GObject*)val)
#define Val_GtkPaned_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkPanedClass' */
/*TODO: conversion for record 'GtkPanedPrivate' */
/*TODO: conversion for record 'GtkPaperSize' */
#define GtkPlug_val(val) check_cast(GTK_PLUG,val)
#define Val_GtkPlug(val) Val_GObject((GObject*)val)
#define Val_GtkPlug_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkPlugClass' */
/*TODO: conversion for record 'GtkPlugPrivate' */
#define GtkPrintContext_val(val) check_cast(GTK_PRINT_CONTEXT,val)
#define Val_GtkPrintContext(val) Val_GObject((GObject*)val)
#define Val_GtkPrintContext_new(val) Val_GObject_new((GObject*)val)
#define GtkPrintOperation_val(val) check_cast(GTK_PRINT_OPERATION,val)
#define Val_GtkPrintOperation(val) Val_GObject((GObject*)val)
#define Val_GtkPrintOperation_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkPrintOperationClass' */
/*TODO: conversion for record 'GtkPrintOperationPreviewIface' */
/*TODO: conversion for record 'GtkPrintOperationPrivate' */
#define GtkPrintSettings_val(val) check_cast(GTK_PRINT_SETTINGS,val)
#define Val_GtkPrintSettings(val) Val_GObject((GObject*)val)
#define Val_GtkPrintSettings_new(val) Val_GObject_new((GObject*)val)
#define GtkProgressBar_val(val) check_cast(GTK_PROGRESS_BAR,val)
#define Val_GtkProgressBar(val) Val_GObject((GObject*)val)
#define Val_GtkProgressBar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkProgressBarClass' */
/*TODO: conversion for record 'GtkProgressBarPrivate' */
#define GtkRadioAction_val(val) check_cast(GTK_RADIO_ACTION,val)
#define Val_GtkRadioAction(val) Val_GObject((GObject*)val)
#define Val_GtkRadioAction_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRadioActionClass' */
/*TODO: conversion for record 'GtkRadioActionEntry' */
/*TODO: conversion for record 'GtkRadioActionPrivate' */
#define GtkRadioButton_val(val) check_cast(GTK_RADIO_BUTTON,val)
#define Val_GtkRadioButton(val) Val_GObject((GObject*)val)
#define Val_GtkRadioButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRadioButtonClass' */
/*TODO: conversion for record 'GtkRadioButtonPrivate' */
#define GtkRadioMenuItem_val(val) check_cast(GTK_RADIO_MENU_ITEM,val)
#define Val_GtkRadioMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkRadioMenuItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRadioMenuItemClass' */
/*TODO: conversion for record 'GtkRadioMenuItemPrivate' */
#define GtkRadioToolButton_val(val) check_cast(GTK_RADIO_TOOL_BUTTON,val)
#define Val_GtkRadioToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkRadioToolButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRadioToolButtonClass' */
#define GtkRange_val(val) check_cast(GTK_RANGE,val)
#define Val_GtkRange(val) Val_GObject((GObject*)val)
#define Val_GtkRange_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRangeClass' */
/*TODO: conversion for record 'GtkRangePrivate' */
/*TODO: conversion for record 'GtkRcContext' */
/*TODO: conversion for record 'GtkRcProperty' */
#define GtkRcStyle_val(val) check_cast(GTK_RC_STYLE,val)
#define Val_GtkRcStyle(val) Val_GObject((GObject*)val)
#define Val_GtkRcStyle_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRcStyleClass' */
#define GtkRecentAction_val(val) check_cast(GTK_RECENT_ACTION,val)
#define Val_GtkRecentAction(val) Val_GObject((GObject*)val)
#define Val_GtkRecentAction_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRecentActionClass' */
/*TODO: conversion for record 'GtkRecentActionPrivate' */
#define GtkRecentChooserDialog_val(val) check_cast(GTK_RECENT_CHOOSER_DIALOG,val)
#define Val_GtkRecentChooserDialog(val) Val_GObject((GObject*)val)
#define Val_GtkRecentChooserDialog_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRecentChooserDialogClass' */
/*TODO: conversion for record 'GtkRecentChooserDialogPrivate' */
/*TODO: conversion for record 'GtkRecentChooserIface' */
#define GtkRecentChooserMenu_val(val) check_cast(GTK_RECENT_CHOOSER_MENU,val)
#define Val_GtkRecentChooserMenu(val) Val_GObject((GObject*)val)
#define Val_GtkRecentChooserMenu_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRecentChooserMenuClass' */
/*TODO: conversion for record 'GtkRecentChooserMenuPrivate' */
#define GtkRecentChooserWidget_val(val) check_cast(GTK_RECENT_CHOOSER_WIDGET,val)
#define Val_GtkRecentChooserWidget(val) Val_GObject((GObject*)val)
#define Val_GtkRecentChooserWidget_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRecentChooserWidgetClass' */
/*TODO: conversion for record 'GtkRecentChooserWidgetPrivate' */
/*TODO: conversion for record 'GtkRecentData' */
#define GtkRecentFilter_val(val) check_cast(GTK_RECENT_FILTER,val)
#define Val_GtkRecentFilter(val) Val_GObject((GObject*)val)
#define Val_GtkRecentFilter_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRecentFilterInfo' */
/*TODO: conversion for record 'GtkRecentInfo' */
#define GtkRecentManager_val(val) check_cast(GTK_RECENT_MANAGER,val)
#define Val_GtkRecentManager(val) Val_GObject((GObject*)val)
#define Val_GtkRecentManager_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkRecentManagerClass' */
/*TODO: conversion for record 'GtkRecentManagerPrivate' */
/*TODO: conversion for record 'GtkRequestedSize' */
/*TODO: conversion for record 'GtkRequisition' */
#define GtkScale_val(val) check_cast(GTK_SCALE,val)
#define Val_GtkScale(val) Val_GObject((GObject*)val)
#define Val_GtkScale_new(val) Val_GObject_new((GObject*)val)
#define GtkScaleButton_val(val) check_cast(GTK_SCALE_BUTTON,val)
#define Val_GtkScaleButton(val) Val_GObject((GObject*)val)
#define Val_GtkScaleButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkScaleButtonClass' */
/*TODO: conversion for record 'GtkScaleButtonPrivate' */
/*TODO: conversion for record 'GtkScaleClass' */
/*TODO: conversion for record 'GtkScalePrivate' */
/*TODO: conversion for record 'GtkScrollableInterface' */
#define GtkScrollbar_val(val) check_cast(GTK_SCROLLBAR,val)
#define Val_GtkScrollbar(val) Val_GObject((GObject*)val)
#define Val_GtkScrollbar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkScrollbarClass' */
#define GtkScrolledWindow_val(val) check_cast(GTK_SCROLLED_WINDOW,val)
#define Val_GtkScrolledWindow(val) Val_GObject((GObject*)val)
#define Val_GtkScrolledWindow_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkScrolledWindowClass' */
/*TODO: conversion for record 'GtkScrolledWindowPrivate' */
/*TODO: conversion for record 'GtkSelectionData' */
#define GtkSeparator_val(val) check_cast(GTK_SEPARATOR,val)
#define Val_GtkSeparator(val) Val_GObject((GObject*)val)
#define Val_GtkSeparator_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSeparatorClass' */
#define GtkSeparatorMenuItem_val(val) check_cast(GTK_SEPARATOR_MENU_ITEM,val)
#define Val_GtkSeparatorMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkSeparatorMenuItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSeparatorMenuItemClass' */
/*TODO: conversion for record 'GtkSeparatorPrivate' */
#define GtkSeparatorToolItem_val(val) check_cast(GTK_SEPARATOR_TOOL_ITEM,val)
#define Val_GtkSeparatorToolItem(val) Val_GObject((GObject*)val)
#define Val_GtkSeparatorToolItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSeparatorToolItemClass' */
/*TODO: conversion for record 'GtkSeparatorToolItemPrivate' */
#define GtkSettings_val(val) check_cast(GTK_SETTINGS,val)
#define Val_GtkSettings(val) Val_GObject((GObject*)val)
#define Val_GtkSettings_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSettingsClass' */
/*TODO: conversion for record 'GtkSettingsPrivate' */
/*TODO: conversion for record 'GtkSettingsValue' */
#define GtkSizeGroup_val(val) check_cast(GTK_SIZE_GROUP,val)
#define Val_GtkSizeGroup(val) Val_GObject((GObject*)val)
#define Val_GtkSizeGroup_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSizeGroupClass' */
/*TODO: conversion for record 'GtkSizeGroupPrivate' */
#define GtkSocket_val(val) check_cast(GTK_SOCKET,val)
#define Val_GtkSocket(val) Val_GObject((GObject*)val)
#define Val_GtkSocket_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSocketClass' */
/*TODO: conversion for record 'GtkSocketPrivate' */
#define GtkSpinButton_val(val) check_cast(GTK_SPIN_BUTTON,val)
#define Val_GtkSpinButton(val) Val_GObject((GObject*)val)
#define Val_GtkSpinButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSpinButtonClass' */
/*TODO: conversion for record 'GtkSpinButtonPrivate' */
#define GtkSpinner_val(val) check_cast(GTK_SPINNER,val)
#define Val_GtkSpinner(val) Val_GObject((GObject*)val)
#define Val_GtkSpinner_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSpinnerClass' */
/*TODO: conversion for record 'GtkSpinnerPrivate' */
#define GtkStatusIcon_val(val) check_cast(GTK_STATUS_ICON,val)
#define Val_GtkStatusIcon(val) Val_GObject((GObject*)val)
#define Val_GtkStatusIcon_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkStatusIconClass' */
/*TODO: conversion for record 'GtkStatusIconPrivate' */
#define GtkStatusbar_val(val) check_cast(GTK_STATUSBAR,val)
#define Val_GtkStatusbar(val) Val_GObject((GObject*)val)
#define Val_GtkStatusbar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkStatusbarClass' */
/*TODO: conversion for record 'GtkStatusbarPrivate' */
/*TODO: conversion for record 'GtkStockItem' */
#define GtkStyle_val(val) check_cast(GTK_STYLE,val)
#define Val_GtkStyle(val) Val_GObject((GObject*)val)
#define Val_GtkStyle_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkStyleClass' */
#define GtkStyleContext_val(val) check_cast(GTK_STYLE_CONTEXT,val)
#define Val_GtkStyleContext(val) Val_GObject((GObject*)val)
#define Val_GtkStyleContext_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkStyleContextClass' */
#define GtkStyleProperties_val(val) check_cast(GTK_STYLE_PROPERTIES,val)
#define Val_GtkStyleProperties(val) Val_GObject((GObject*)val)
#define Val_GtkStyleProperties_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkStylePropertiesClass' */
/*TODO: conversion for record 'GtkStyleProviderIface' */
#define GtkSwitch_val(val) check_cast(GTK_SWITCH,val)
#define Val_GtkSwitch(val) Val_GObject((GObject*)val)
#define Val_GtkSwitch_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkSwitchClass' */
/*TODO: conversion for record 'GtkSwitchPrivate' */
/*TODO: conversion for record 'GtkSymbolicColor' */
#define GtkTable_val(val) check_cast(GTK_TABLE,val)
#define Val_GtkTable(val) Val_GObject((GObject*)val)
#define Val_GtkTable_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTableChild' */
/*TODO: conversion for record 'GtkTableClass' */
/*TODO: conversion for record 'GtkTablePrivate' */
/*TODO: conversion for record 'GtkTableRowCol' */
/*TODO: conversion for record 'GtkTargetEntry' */
/*TODO: conversion for record 'GtkTargetList' */
#define GtkTearoffMenuItem_val(val) check_cast(GTK_TEAROFF_MENU_ITEM,val)
#define Val_GtkTearoffMenuItem(val) Val_GObject((GObject*)val)
#define Val_GtkTearoffMenuItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTearoffMenuItemClass' */
/*TODO: conversion for record 'GtkTearoffMenuItemPrivate' */
/*TODO: conversion for record 'GtkTextAppearance' */
/*TODO: conversion for record 'GtkTextAttributes' */
/*TODO: conversion for record 'GtkTextBTree' */
#define GtkTextBuffer_val(val) check_cast(GTK_TEXT_BUFFER,val)
#define Val_GtkTextBuffer(val) Val_GObject((GObject*)val)
#define Val_GtkTextBuffer_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTextBufferClass' */
/*TODO: conversion for record 'GtkTextBufferPrivate' */
#define GtkTextChildAnchor_val(val) check_cast(GTK_TEXT_CHILD_ANCHOR,val)
#define Val_GtkTextChildAnchor(val) Val_GObject((GObject*)val)
#define Val_GtkTextChildAnchor_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTextChildAnchorClass' */
/*TODO: conversion for record 'GtkTextIter' */
#define GtkTextMark_val(val) check_cast(GTK_TEXT_MARK,val)
#define Val_GtkTextMark(val) Val_GObject((GObject*)val)
#define Val_GtkTextMark_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTextMarkClass' */
#define GtkTextTag_val(val) check_cast(GTK_TEXT_TAG,val)
#define Val_GtkTextTag(val) Val_GObject((GObject*)val)
#define Val_GtkTextTag_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTextTagClass' */
/*TODO: conversion for record 'GtkTextTagPrivate' */
#define GtkTextTagTable_val(val) check_cast(GTK_TEXT_TAG_TABLE,val)
#define Val_GtkTextTagTable(val) Val_GObject((GObject*)val)
#define Val_GtkTextTagTable_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTextTagTableClass' */
/*TODO: conversion for record 'GtkTextTagTablePrivate' */
#define GtkTextView_val(val) check_cast(GTK_TEXT_VIEW,val)
#define Val_GtkTextView(val) Val_GObject((GObject*)val)
#define Val_GtkTextView_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTextViewClass' */
/*TODO: conversion for record 'GtkTextViewPrivate' */
/*TODO: conversion for record 'GtkThemeEngine' */
#define GtkThemingEngine_val(val) check_cast(GTK_THEMING_ENGINE,val)
#define Val_GtkThemingEngine(val) Val_GObject((GObject*)val)
#define Val_GtkThemingEngine_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkThemingEngineClass' */
#define GtkToggleAction_val(val) check_cast(GTK_TOGGLE_ACTION,val)
#define Val_GtkToggleAction(val) Val_GObject((GObject*)val)
#define Val_GtkToggleAction_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToggleActionClass' */
/*TODO: conversion for record 'GtkToggleActionEntry' */
/*TODO: conversion for record 'GtkToggleActionPrivate' */
#define GtkToggleButton_val(val) check_cast(GTK_TOGGLE_BUTTON,val)
#define Val_GtkToggleButton(val) Val_GObject((GObject*)val)
#define Val_GtkToggleButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToggleButtonClass' */
/*TODO: conversion for record 'GtkToggleButtonPrivate' */
#define GtkToggleToolButton_val(val) check_cast(GTK_TOGGLE_TOOL_BUTTON,val)
#define Val_GtkToggleToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkToggleToolButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToggleToolButtonClass' */
/*TODO: conversion for record 'GtkToggleToolButtonPrivate' */
#define GtkToolButton_val(val) check_cast(GTK_TOOL_BUTTON,val)
#define Val_GtkToolButton(val) Val_GObject((GObject*)val)
#define Val_GtkToolButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToolButtonClass' */
/*TODO: conversion for record 'GtkToolButtonPrivate' */
#define GtkToolItem_val(val) check_cast(GTK_TOOL_ITEM,val)
#define Val_GtkToolItem(val) Val_GObject((GObject*)val)
#define Val_GtkToolItem_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToolItemClass' */
#define GtkToolItemGroup_val(val) check_cast(GTK_TOOL_ITEM_GROUP,val)
#define Val_GtkToolItemGroup(val) Val_GObject((GObject*)val)
#define Val_GtkToolItemGroup_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToolItemGroupClass' */
/*TODO: conversion for record 'GtkToolItemGroupPrivate' */
/*TODO: conversion for record 'GtkToolItemPrivate' */
#define GtkToolPalette_val(val) check_cast(GTK_TOOL_PALETTE,val)
#define Val_GtkToolPalette(val) Val_GObject((GObject*)val)
#define Val_GtkToolPalette_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToolPaletteClass' */
/*TODO: conversion for record 'GtkToolPalettePrivate' */
/*TODO: conversion for record 'GtkToolShellIface' */
#define GtkToolbar_val(val) check_cast(GTK_TOOLBAR,val)
#define Val_GtkToolbar(val) Val_GObject((GObject*)val)
#define Val_GtkToolbar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkToolbarClass' */
/*TODO: conversion for record 'GtkToolbarPrivate' */
#define GtkTooltip_val(val) check_cast(GTK_TOOLTIP,val)
#define Val_GtkTooltip(val) Val_GObject((GObject*)val)
#define Val_GtkTooltip_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTreeDragDestIface' */
/*TODO: conversion for record 'GtkTreeDragSourceIface' */
/*TODO: conversion for record 'GtkTreeIter' */
#define GtkTreeModelFilter_val(val) check_cast(GTK_TREE_MODEL_FILTER,val)
#define Val_GtkTreeModelFilter(val) Val_GObject((GObject*)val)
#define Val_GtkTreeModelFilter_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTreeModelFilterClass' */
/*TODO: conversion for record 'GtkTreeModelFilterPrivate' */
/*TODO: conversion for record 'GtkTreeModelIface' */
#define GtkTreeModelSort_val(val) check_cast(GTK_TREE_MODEL_SORT,val)
#define Val_GtkTreeModelSort(val) Val_GObject((GObject*)val)
#define Val_GtkTreeModelSort_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTreeModelSortClass' */
/*TODO: conversion for record 'GtkTreeModelSortPrivate' */
/*TODO: conversion for record 'GtkTreePath' */
/*TODO: conversion for record 'GtkTreeRowReference' */
#define GtkTreeSelection_val(val) check_cast(GTK_TREE_SELECTION,val)
#define Val_GtkTreeSelection(val) Val_GObject((GObject*)val)
#define Val_GtkTreeSelection_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTreeSelectionClass' */
/*TODO: conversion for record 'GtkTreeSelectionPrivate' */
/*TODO: conversion for record 'GtkTreeSortableIface' */
#define GtkTreeStore_val(val) check_cast(GTK_TREE_STORE,val)
#define Val_GtkTreeStore(val) Val_GObject((GObject*)val)
#define Val_GtkTreeStore_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTreeStoreClass' */
/*TODO: conversion for record 'GtkTreeStorePrivate' */
#define GtkTreeView_val(val) check_cast(GTK_TREE_VIEW,val)
#define Val_GtkTreeView(val) Val_GObject((GObject*)val)
#define Val_GtkTreeView_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTreeViewClass' */
#define GtkTreeViewColumn_val(val) check_cast(GTK_TREE_VIEW_COLUMN,val)
#define Val_GtkTreeViewColumn(val) Val_GObject((GObject*)val)
#define Val_GtkTreeViewColumn_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkTreeViewColumnClass' */
/*TODO: conversion for record 'GtkTreeViewColumnPrivate' */
/*TODO: conversion for record 'GtkTreeViewPrivate' */
#define GtkUIManager_val(val) check_cast(GTK_UI_MANAGER,val)
#define Val_GtkUIManager(val) Val_GObject((GObject*)val)
#define Val_GtkUIManager_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkUIManagerClass' */
/*TODO: conversion for record 'GtkUIManagerPrivate' */
#define GtkVBox_val(val) check_cast(GTK_V_BOX,val)
#define Val_GtkVBox(val) Val_GObject((GObject*)val)
#define Val_GtkVBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkVBoxClass' */
#define GtkVButtonBox_val(val) check_cast(GTK_V_BUTTON_BOX,val)
#define Val_GtkVButtonBox(val) Val_GObject((GObject*)val)
#define Val_GtkVButtonBox_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkVButtonBoxClass' */
#define GtkVPaned_val(val) check_cast(GTK_V_PANED,val)
#define Val_GtkVPaned(val) Val_GObject((GObject*)val)
#define Val_GtkVPaned_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkVPanedClass' */
#define GtkVScale_val(val) check_cast(GTK_V_SCALE,val)
#define Val_GtkVScale(val) Val_GObject((GObject*)val)
#define Val_GtkVScale_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkVScaleClass' */
#define GtkVScrollbar_val(val) check_cast(GTK_V_SCROLLBAR,val)
#define Val_GtkVScrollbar(val) Val_GObject((GObject*)val)
#define Val_GtkVScrollbar_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkVScrollbarClass' */
#define GtkVSeparator_val(val) check_cast(GTK_V_SEPARATOR,val)
#define Val_GtkVSeparator(val) Val_GObject((GObject*)val)
#define Val_GtkVSeparator_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkVSeparatorClass' */
#define GtkViewport_val(val) check_cast(GTK_VIEWPORT,val)
#define Val_GtkViewport(val) Val_GObject((GObject*)val)
#define Val_GtkViewport_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkViewportClass' */
/*TODO: conversion for record 'GtkViewportPrivate' */
#define GtkVolumeButton_val(val) check_cast(GTK_VOLUME_BUTTON,val)
#define Val_GtkVolumeButton(val) Val_GObject((GObject*)val)
#define Val_GtkVolumeButton_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkVolumeButtonClass' */
#define GtkWidget_val(val) check_cast(GTK_WIDGET,val)
#define Val_GtkWidget(val) Val_GObject((GObject*)val)
#define Val_GtkWidget_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkWidgetAuxInfo' */
/*TODO: conversion for record 'GtkWidgetClass' */
/*TODO: conversion for record 'GtkWidgetPath' */
/*TODO: conversion for record 'GtkWidgetPrivate' */
#define GtkWindow_val(val) check_cast(GTK_WINDOW,val)
#define Val_GtkWindow(val) Val_GObject((GObject*)val)
#define Val_GtkWindow_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkWindowClass' */
/*TODO: conversion for record 'GtkWindowGeometryInfo' */
#define GtkWindowGroup_val(val) check_cast(GTK_WINDOW_GROUP,val)
#define Val_GtkWindowGroup(val) Val_GObject((GObject*)val)
#define Val_GtkWindowGroup_new(val) Val_GObject_new((GObject*)val)
/*TODO: conversion for record 'GtkWindowGroupClass' */
/*TODO: conversion for record 'GtkWindowGroupPrivate' */
/*TODO: conversion for record 'GtkWindowPrivate' */

#include <<dummy>>
#include "../wrappers.h"
#include "../ml_gobject.h"
/* Module _RegistryClass */
/* end of _RegistryClass */
/* Module _Registry */
/* end of _Registry */
/* Module _PropertyValues */
/* end of _PropertyValues */
/* Module ValueIface */
/* end of ValueIface */
/* Module UtilClass */
/* end of UtilClass */
/* Module Util */
/* end of Util */
/* Module TextRectangle */
/* end of TextRectangle */
/* Module TextRange */
/* end of TextRange */
/* Module TextIface */
/* end of TextIface */
/* Module TableIface */
/* end of TableIface */
/* Module StreamableContentIface */
/* end of StreamableContentIface */
/* Module StateSetClass */
/* end of StateSetClass */
/* Module StateSet */
ML_2(atk_state_set_xor_sets,AtkStateSet_val, AtkStateSet_val, Val_AtkStateSet_new)
ML_2(atk_state_set_or_sets,AtkStateSet_val, AtkStateSet_val, Val_AtkStateSet_new)
ML_1(atk_state_set_is_empty,AtkStateSet_val, Val_bool)
ML_1(atk_state_set_clear_states,AtkStateSet_val, Unit)
ML_2(atk_state_set_and_sets,AtkStateSet_val, AtkStateSet_val, Val_AtkStateSet_new)
/* end of StateSet */
/* Module SocketClass */
/* end of SocketClass */
/* Module Socket */
ML_1(atk_socket_is_occupied,AtkSocket_val, Val_bool)
ML_2(atk_socket_embed,AtkSocket_val, String_val, Unit)
/* end of Socket */
/* Module SelectionIface */
/* end of SelectionIface */
/* Module RelationSetClass */
/* end of RelationSetClass */
/* Module RelationSet */
ML_2(atk_relation_set_remove,AtkRelationSet_val, AtkRelation_val, Unit)
ML_2(atk_relation_set_get_relation,AtkRelationSet_val, Int_val, Val_AtkRelation)
ML_1(atk_relation_set_get_n_relations,AtkRelationSet_val, Val_int)
ML_2(atk_relation_set_add,AtkRelationSet_val, AtkRelation_val, Unit)
/* end of RelationSet */
/* Module RelationClass */
/* end of RelationClass */
/* Module Relation */
ML_2(atk_relation_remove_target,AtkRelation_val, AtkObject_val, Val_bool)
ML_2(atk_relation_add_target,AtkRelation_val, AtkObject_val, Unit)
/* end of Relation */
/* Module Registry */
/* end of Registry */
/* Module Rectangle */
/* end of Rectangle */
/* Module PlugClass */
/* end of PlugClass */
/* Module Plug */
ML_1(atk_plug_get_id,AtkPlug_val, Val_string_new)
/* end of Plug */
/* Module ObjectFactoryClass */
/* end of ObjectFactoryClass */
/* Module ObjectFactory */
ML_1(atk_object_factory_invalidate,AtkObjectFactory_val, Unit)
ML_1(atk_object_factory_get_accessible_type,AtkObjectFactory_val, Val_int)
/* end of ObjectFactory */
/* Module ObjectClass */
/* end of ObjectClass */
/* Module Object */
ML_2(atk_object_set_parent,AtkObject_val, AtkObject_val, Unit)
ML_2(atk_object_set_name,AtkObject_val, String_val, Unit)
ML_2(atk_object_set_description,AtkObject_val, String_val, Unit)
ML_2(atk_object_remove_property_change_handler,AtkObject_val, Int_val, Unit)
ML_1(atk_object_ref_state_set,AtkObject_val, Val_AtkStateSet_new)
ML_1(atk_object_ref_relation_set,AtkObject_val, Val_AtkRelationSet_new)
ML_2(atk_object_ref_accessible_child,AtkObject_val, Int_val, Val_AtkObject_new)
ML_3(atk_object_notify_state_change,AtkObject_val, Int64_val, Bool_val, Unit)
ML_1(atk_object_get_parent,AtkObject_val, Val_AtkObject)
ML_1(atk_object_get_name,AtkObject_val, Val_string)
ML_1(atk_object_get_n_accessible_children,AtkObject_val, Val_int)
ML_1(atk_object_get_index_in_parent,AtkObject_val, Val_int)
ML_1(atk_object_get_description,AtkObject_val, Val_string)
/* end of Object */
/* Module NoOpObjectFactoryClass */
/* end of NoOpObjectFactoryClass */
/* Module NoOpObjectFactory */
/* end of NoOpObjectFactory */
/* Module NoOpObjectClass */
/* end of NoOpObjectClass */
/* Module NoOpObject */
/* end of NoOpObject */
/* Module MiscClass */
/* end of MiscClass */
/* Module Misc */
ML_1(atk_misc_threads_leave,AtkMisc_val, Unit)
ML_1(atk_misc_threads_enter,AtkMisc_val, Unit)
ML_0(atk_misc_get_instance,Val_AtkMisc)
/* end of Misc */
/* Module KeyEventStruct */
/* end of KeyEventStruct */
/* Module Implementor */
ML_1(atk_implementor_ref_accessible,AtkImplementor_val, Val_AtkObject_new)
/* end of Implementor */
/* Module ImageIface */
/* end of ImageIface */
/* Module HypertextIface */
/* end of HypertextIface */
/* Module HyperlinkImplIface */
/* end of HyperlinkImplIface */
/* Module HyperlinkClass */
/* end of HyperlinkClass */
/* Module Hyperlink */
ML_1(atk_hyperlink_is_valid,AtkHyperlink_val, Val_bool)
ML_1(atk_hyperlink_is_inline,AtkHyperlink_val, Val_bool)
ML_2(atk_hyperlink_get_uri,AtkHyperlink_val, Int_val, Val_string_new)
ML_1(atk_hyperlink_get_start_index,AtkHyperlink_val, Val_int)
ML_2(atk_hyperlink_get_object,AtkHyperlink_val, Int_val, Val_AtkObject)
ML_1(atk_hyperlink_get_n_anchors,AtkHyperlink_val, Val_int)
ML_1(atk_hyperlink_get_end_index,AtkHyperlink_val, Val_int)
/* end of Hyperlink */
/* Module GObjectAccessibleClass */
/* end of GObjectAccessibleClass */
/* Module GObjectAccessible */
/* end of GObjectAccessible */
/* Module EditableTextIface */
/* end of EditableTextIface */
/* Module DocumentIface */
/* end of DocumentIface */
/* Module ComponentIface */
/* end of ComponentIface */
/* Module Attribute */
/* end of Attribute */
/* Module ActionIface */
/* end of ActionIface */
/* Global functions */
ML_1(atk_remove_key_event_listener,Int_val, Unit)
ML_1(atk_remove_global_event_listener,Int_val, Unit)
ML_1(atk_remove_focus_tracker,Int_val, Unit)
ML_0(atk_get_version,Val_string)
ML_0(atk_get_toolkit_version,Val_string)
ML_0(atk_get_toolkit_name,Val_string)
ML_0(atk_get_root,Val_AtkObject)
ML_0(atk_get_focus_object,Val_AtkObject)
ML_1(atk_focus_tracker_notify,AtkObject_val, Unit)
/* End of global functions */

