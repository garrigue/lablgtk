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

#include <gtk/gtkx.h>
#include "../wrappers.h"
#include "../ml_gobject.h"
/* Module WindowPrivate */
/* end of WindowPrivate */
/* Module WindowGroupPrivate */
/* end of WindowGroupPrivate */
/* Module WindowGroupClass */
/* end of WindowGroupClass */
/* Module WindowGroup */
ML_2(gtk_window_group_remove_window,GtkWindowGroup_val, GtkWindow_val, Unit)
ML_1(gtk_window_group_list_windows,GtkWindowGroup_val, Val_GList)
ML_1(gtk_window_group_get_current_grab,GtkWindowGroup_val, Val_GtkWidget)
ML_2(gtk_window_group_get_current_device_grab,GtkWindowGroup_val, GdkDevice_val, Val_GtkWidget)
ML_2(gtk_window_group_add_window,GtkWindowGroup_val, GtkWindow_val, Unit)
/* end of WindowGroup */
/* Module WindowGeometryInfo */
/* end of WindowGeometryInfo */
/* Module WindowClass */
/* end of WindowClass */
/* Module Window */
ML_1(gtk_window_unstick,GtkWindow_val, Unit)
ML_1(gtk_window_unmaximize,GtkWindow_val, Unit)
ML_1(gtk_window_unfullscreen,GtkWindow_val, Unit)
ML_1(gtk_window_stick,GtkWindow_val, Unit)
ML_3(gtk_window_set_wmclass,GtkWindow_val, String_val, String_val, Unit)
ML_2(gtk_window_set_urgency_hint,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_transient_for,GtkWindow_val, Option_val(arg2,GtkWindow_val,NULL) Ignore, Unit)
ML_2(gtk_window_set_title,GtkWindow_val, String_val, Unit)
ML_2(gtk_window_set_startup_id,GtkWindow_val, String_val, Unit)
ML_2(gtk_window_set_skip_taskbar_hint,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_skip_pager_hint,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_screen,GtkWindow_val, GdkScreen_val, Unit)
ML_2(gtk_window_set_role,GtkWindow_val, String_val, Unit)
ML_2(gtk_window_set_resizable,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_opacity,GtkWindow_val, Double_val, Unit)
ML_2(gtk_window_set_modal,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_mnemonics_visible,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_keep_below,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_keep_above,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_icon_name,GtkWindow_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_window_set_icon_list,GtkWindow_val, GList_val, Unit)
ML_2(gtk_window_set_icon,GtkWindow_val, Option_val(arg2,GdkPixbuf_val,NULL) Ignore, Unit)
ML_2(gtk_window_set_has_user_ref_count,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_has_resize_grip,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_focus_on_map,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_focus,GtkWindow_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_window_set_destroy_with_parent,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_deletable,GtkWindow_val, Bool_val, Unit)
ML_3(gtk_window_set_default_size,GtkWindow_val, Int_val, Int_val, Unit)
ML_3(gtk_window_set_default_geometry,GtkWindow_val, Int_val, Int_val, Unit)
ML_2(gtk_window_set_default,GtkWindow_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_window_set_decorated,GtkWindow_val, Bool_val, Unit)
ML_2(gtk_window_set_application,GtkWindow_val, Option_val(arg2,GtkApplication_val,NULL) Ignore, Unit)
ML_2(gtk_window_set_accept_focus,GtkWindow_val, Bool_val, Unit)
ML_3(gtk_window_resize_to_geometry,GtkWindow_val, Int_val, Int_val, Unit)
ML_1(gtk_window_resize_grip_is_visible,GtkWindow_val, Val_bool)
ML_3(gtk_window_resize,GtkWindow_val, Int_val, Int_val, Unit)
ML_1(gtk_window_reshow_with_initial_size,GtkWindow_val, Unit)
ML_3(gtk_window_remove_mnemonic,GtkWindow_val, Int_val, GtkWidget_val, Unit)
ML_2(gtk_window_remove_accel_group,GtkWindow_val, GtkAccelGroup_val, Unit)
ML_2(gtk_window_propagate_key_event,GtkWindow_val, GdkEventKey_val, Val_bool)
ML_2(gtk_window_present_with_time,GtkWindow_val, Int32_val, Unit)
ML_1(gtk_window_present,GtkWindow_val, Unit)
ML_2(gtk_window_parse_geometry,GtkWindow_val, String_val, Val_bool)
ML_3(gtk_window_move,GtkWindow_val, Int_val, Int_val, Unit)
ML_1(gtk_window_maximize,GtkWindow_val, Unit)
ML_1(gtk_window_is_active,GtkWindow_val, Val_bool)
ML_1(gtk_window_iconify,GtkWindow_val, Unit)
ML_1(gtk_window_has_toplevel_focus,GtkWindow_val, Val_bool)
ML_1(gtk_window_has_group,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_urgency_hint,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_transient_for,GtkWindow_val, Val_GtkWindow)
ML_1(gtk_window_get_title,GtkWindow_val, Val_string)
ML_1(gtk_window_get_skip_taskbar_hint,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_skip_pager_hint,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_screen,GtkWindow_val, Val_GdkScreen)
ML_1(gtk_window_get_role,GtkWindow_val, Val_string)
ML_1(gtk_window_get_resizable,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_opacity,GtkWindow_val, Val_double)
ML_1(gtk_window_get_modal,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_mnemonics_visible,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_icon_name,GtkWindow_val, Val_string)
ML_1(gtk_window_get_icon_list,GtkWindow_val, Val_GList)
ML_1(gtk_window_get_icon,GtkWindow_val, Val_GdkPixbuf)
ML_1(gtk_window_get_has_resize_grip,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_group,GtkWindow_val, Val_GtkWindowGroup)
ML_1(gtk_window_get_focus_on_map,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_focus,GtkWindow_val, Val_GtkWidget)
ML_1(gtk_window_get_destroy_with_parent,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_deletable,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_default_widget,GtkWindow_val, Val_GtkWidget)
ML_1(gtk_window_get_decorated,GtkWindow_val, Val_bool)
ML_1(gtk_window_get_application,GtkWindow_val, Val_GtkApplication)
ML_1(gtk_window_get_accept_focus,GtkWindow_val, Val_bool)
ML_1(gtk_window_fullscreen,GtkWindow_val, Unit)
ML_1(gtk_window_deiconify,GtkWindow_val, Unit)
ML_5(gtk_window_begin_move_drag,GtkWindow_val, Int_val, Int_val, Int_val, Int32_val, Unit)
ML_3(gtk_window_add_mnemonic,GtkWindow_val, Int_val, GtkWidget_val, Unit)
ML_2(gtk_window_add_accel_group,GtkWindow_val, GtkAccelGroup_val, Unit)
ML_2(gtk_window_activate_key,GtkWindow_val, GdkEventKey_val, Val_bool)
ML_1(gtk_window_activate_focus,GtkWindow_val, Val_bool)
ML_1(gtk_window_activate_default,GtkWindow_val, Val_bool)
ML_1(gtk_window_set_default_icon_name,String_val, Unit)
ML_1(gtk_window_set_default_icon_list,GList_val, Unit)
ML_1(gtk_window_set_default_icon,GdkPixbuf_val, Unit)
ML_1(gtk_window_set_auto_startup_notification,Bool_val, Unit)
ML_0(gtk_window_list_toplevels,Val_GList)
ML_0(gtk_window_get_default_icon_name,Val_string)
ML_0(gtk_window_get_default_icon_list,Val_GList)
/* end of Window */
/* Module WidgetPrivate */
/* end of WidgetPrivate */
/* Module WidgetPath */
ML_2(gtk_widget_path_prepend_type,GtkWidgetPath_val, Int_val, Unit)
ML_1(gtk_widget_path_length,GtkWidgetPath_val, Val_int)
ML_3(gtk_widget_path_iter_set_object_type,GtkWidgetPath_val, Int_val, Int_val, Unit)
ML_3(gtk_widget_path_iter_set_name,GtkWidgetPath_val, Int_val, String_val, Unit)
ML_3(gtk_widget_path_iter_remove_region,GtkWidgetPath_val, Int_val, String_val, Unit)
ML_3(gtk_widget_path_iter_remove_class,GtkWidgetPath_val, Int_val, String_val, Unit)
ML_2(gtk_widget_path_iter_list_regions,GtkWidgetPath_val, Int_val, Val_GSList)
ML_2(gtk_widget_path_iter_list_classes,GtkWidgetPath_val, Int_val, Val_GSList)
ML_3(gtk_widget_path_iter_has_qname,GtkWidgetPath_val, Int_val, Int32_val, Val_bool)
ML_3(gtk_widget_path_iter_has_qclass,GtkWidgetPath_val, Int_val, Int32_val, Val_bool)
ML_3(gtk_widget_path_iter_has_name,GtkWidgetPath_val, Int_val, String_val, Val_bool)
ML_3(gtk_widget_path_iter_has_class,GtkWidgetPath_val, Int_val, String_val, Val_bool)
ML_2(gtk_widget_path_iter_get_object_type,GtkWidgetPath_val, Int_val, Val_int)
ML_2(gtk_widget_path_iter_get_name,GtkWidgetPath_val, Int_val, Val_string)
ML_2(gtk_widget_path_iter_clear_regions,GtkWidgetPath_val, Int_val, Unit)
ML_2(gtk_widget_path_iter_clear_classes,GtkWidgetPath_val, Int_val, Unit)
ML_3(gtk_widget_path_iter_add_class,GtkWidgetPath_val, Int_val, String_val, Unit)
ML_2(gtk_widget_path_is_type,GtkWidgetPath_val, Int_val, Val_bool)
ML_2(gtk_widget_path_has_parent,GtkWidgetPath_val, Int_val, Val_bool)
ML_1(gtk_widget_path_get_object_type,GtkWidgetPath_val, Val_int)
ML_1(gtk_widget_path_free,GtkWidgetPath_val, Unit)
ML_1(gtk_widget_path_copy,GtkWidgetPath_val, Val_GtkWidgetPath_new)
ML_2(gtk_widget_path_append_type,GtkWidgetPath_val, Int_val, Val_int)
/* end of WidgetPath */
/* Module WidgetClass */
ML_2(gtk_widget_class_install_style_property,GtkWidgetClass_val, GParamSpec_val, Unit)
ML_2(gtk_widget_class_find_style_property,GtkWidgetClass_val, String_val, Val_GParamSpec)
/* end of WidgetClass */
/* Module WidgetAuxInfo */
/* end of WidgetAuxInfo */
/* Module Widget */
ML_1(gtk_widget_unrealize,GtkWidget_val, Unit)
ML_1(gtk_widget_unparent,GtkWidget_val, Unit)
ML_1(gtk_widget_unmap,GtkWidget_val, Unit)
ML_1(gtk_widget_trigger_tooltip_query,GtkWidget_val, Unit)
ML_1(gtk_widget_thaw_child_notify,GtkWidget_val, Unit)
ML_3(gtk_widget_style_get_property,GtkWidget_val, String_val, GValue_val, Unit)
ML_1(gtk_widget_style_attach,GtkWidget_val, Unit)
ML_1(gtk_widget_show_now,GtkWidget_val, Unit)
ML_1(gtk_widget_show_all,GtkWidget_val, Unit)
ML_1(gtk_widget_show,GtkWidget_val, Unit)
ML_2(gtk_widget_shape_combine_region,GtkWidget_val, Option_val(arg2,cairo_region_t_val,NULL) Ignore, Unit)
ML_2(gtk_widget_set_window,GtkWidget_val, GdkWindow_val, Unit)
ML_2(gtk_widget_set_visual,GtkWidget_val, GdkVisual_val, Unit)
ML_2(gtk_widget_set_visible,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_vexpand_set,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_vexpand,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_tooltip_window,GtkWidget_val, Option_val(arg2,GtkWindow_val,NULL) Ignore, Unit)
ML_2(gtk_widget_set_tooltip_text,GtkWidget_val, String_val, Unit)
ML_2(gtk_widget_set_tooltip_markup,GtkWidget_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_widget_set_support_multidevice,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_style,GtkWidget_val, Option_val(arg2,GtkStyle_val,NULL) Ignore, Unit)
ML_3(gtk_widget_set_size_request,GtkWidget_val, Int_val, Int_val, Unit)
ML_2(gtk_widget_set_sensitive,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_redraw_on_allocate,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_receives_default,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_realized,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_parent_window,GtkWidget_val, GdkWindow_val, Unit)
ML_2(gtk_widget_set_parent,GtkWidget_val, GtkWidget_val, Unit)
ML_2(gtk_widget_set_no_show_all,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_name,GtkWidget_val, String_val, Unit)
ML_2(gtk_widget_set_margin_top,GtkWidget_val, Int_val, Unit)
ML_2(gtk_widget_set_margin_right,GtkWidget_val, Int_val, Unit)
ML_2(gtk_widget_set_margin_left,GtkWidget_val, Int_val, Unit)
ML_2(gtk_widget_set_margin_bottom,GtkWidget_val, Int_val, Unit)
ML_2(gtk_widget_set_mapped,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_hexpand_set,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_hexpand,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_has_window,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_has_tooltip,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_events,GtkWidget_val, Int_val, Unit)
ML_2(gtk_widget_set_double_buffered,GtkWidget_val, Bool_val, Unit)
ML_3(gtk_widget_set_device_enabled,GtkWidget_val, GdkDevice_val, Bool_val, Unit)
ML_2(gtk_widget_set_composite_name,GtkWidget_val, String_val, Unit)
ML_2(gtk_widget_set_child_visible,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_can_focus,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_can_default,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_widget_set_app_paintable,GtkWidget_val, Bool_val, Unit)
ML_3(gtk_widget_set_accel_path,GtkWidget_val, Option_val(arg2,String_val,NULL) Ignore, Option_val(arg3,GtkAccelGroup_val,NULL) Ignore, Unit)
ML_1(gtk_widget_reset_style,GtkWidget_val, Unit)
ML_1(gtk_widget_reset_rc_styles,GtkWidget_val, Unit)
ML_2(gtk_widget_reparent,GtkWidget_val, GtkWidget_val, Unit)
ML_2(gtk_widget_remove_mnemonic_label,GtkWidget_val, GtkWidget_val, Unit)
ML_2(gtk_widget_region_intersect,GtkWidget_val, cairo_region_t_val, Val_cairo_region_t_new)
ML_1(gtk_widget_realize,GtkWidget_val, Unit)
ML_1(gtk_widget_queue_resize_no_redraw,GtkWidget_val, Unit)
ML_1(gtk_widget_queue_resize,GtkWidget_val, Unit)
ML_2(gtk_widget_queue_draw_region,GtkWidget_val, cairo_region_t_val, Unit)
ML_5(gtk_widget_queue_draw_area,GtkWidget_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_1(gtk_widget_queue_draw,GtkWidget_val, Unit)
ML_1(gtk_widget_queue_compute_expand,GtkWidget_val, Unit)
ML_3(gtk_widget_override_symbolic_color,GtkWidget_val, String_val, Option_val(arg3,GdkRGBA_val,NULL) Ignore, Unit)
ML_2(gtk_widget_override_font,GtkWidget_val, PangoFontDescription_val, Unit)
ML_3(gtk_widget_override_cursor,GtkWidget_val, GdkRGBA_val, GdkRGBA_val, Unit)
ML_2(gtk_widget_modify_style,GtkWidget_val, GtkRcStyle_val, Unit)
ML_2(gtk_widget_modify_font,GtkWidget_val, Option_val(arg2,PangoFontDescription_val,NULL) Ignore, Unit)
ML_3(gtk_widget_modify_cursor,GtkWidget_val, GdkColor_val, GdkColor_val, Unit)
ML_2(gtk_widget_mnemonic_activate,GtkWidget_val, Bool_val, Val_bool)
ML_1(gtk_widget_map,GtkWidget_val, Unit)
ML_1(gtk_widget_list_mnemonic_labels,GtkWidget_val, Val_GList)
ML_1(gtk_widget_list_accel_closures,GtkWidget_val, Val_GList)
ML_1(gtk_widget_is_toplevel,GtkWidget_val, Val_bool)
ML_1(gtk_widget_is_sensitive,GtkWidget_val, Val_bool)
ML_1(gtk_widget_is_focus,GtkWidget_val, Val_bool)
ML_1(gtk_widget_is_drawable,GtkWidget_val, Val_bool)
ML_1(gtk_widget_is_composited,GtkWidget_val, Val_bool)
ML_2(gtk_widget_is_ancestor,GtkWidget_val, GtkWidget_val, Val_bool)
ML_2(gtk_widget_input_shape_combine_region,GtkWidget_val, Option_val(arg2,cairo_region_t_val,NULL) Ignore, Unit)
ML_1(gtk_widget_in_destruction,GtkWidget_val, Val_bool)
ML_1(gtk_widget_hide_on_delete,GtkWidget_val, Val_bool)
ML_1(gtk_widget_hide,GtkWidget_val, Unit)
ML_1(gtk_widget_has_screen,GtkWidget_val, Val_bool)
ML_1(gtk_widget_has_rc_style,GtkWidget_val, Val_bool)
ML_1(gtk_widget_has_grab,GtkWidget_val, Val_bool)
ML_1(gtk_widget_has_focus,GtkWidget_val, Val_bool)
ML_1(gtk_widget_has_default,GtkWidget_val, Val_bool)
ML_1(gtk_grab_remove,GtkWidget_val, Unit)
ML_1(gtk_widget_grab_focus,GtkWidget_val, Unit)
ML_1(gtk_widget_grab_default,GtkWidget_val, Unit)
ML_1(gtk_grab_add,GtkWidget_val, Unit)
ML_1(gtk_widget_get_window,GtkWidget_val, Val_GdkWindow)
ML_1(gtk_widget_get_visual,GtkWidget_val, Val_GdkVisual)
ML_1(gtk_widget_get_visible,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_vexpand_set,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_vexpand,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_toplevel,GtkWidget_val, Val_GtkWidget)
ML_1(gtk_widget_get_tooltip_window,GtkWidget_val, Val_GtkWindow)
ML_1(gtk_widget_get_tooltip_text,GtkWidget_val, Val_string_new)
ML_1(gtk_widget_get_tooltip_markup,GtkWidget_val, Val_string_new)
ML_1(gtk_widget_get_support_multidevice,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_style_context,GtkWidget_val, Val_GtkStyleContext)
ML_1(gtk_widget_get_style,GtkWidget_val, Val_GtkStyle)
ML_1(gtk_widget_get_settings,GtkWidget_val, Val_GtkSettings)
ML_1(gtk_widget_get_sensitive,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_screen,GtkWidget_val, Val_GdkScreen)
ML_1(gtk_widget_get_root_window,GtkWidget_val, Val_GdkWindow)
ML_1(gtk_widget_get_receives_default,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_realized,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_path,GtkWidget_val, Val_GtkWidgetPath)
ML_1(gtk_widget_get_parent_window,GtkWidget_val, Val_GdkWindow)
ML_1(gtk_widget_get_parent,GtkWidget_val, Val_GtkWidget)
ML_1(gtk_widget_get_pango_context,GtkWidget_val, Val_PangoContext)
ML_1(gtk_widget_get_no_show_all,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_name,GtkWidget_val, Val_string)
ML_1(gtk_widget_get_modifier_style,GtkWidget_val, Val_GtkRcStyle)
ML_1(gtk_widget_get_margin_top,GtkWidget_val, Val_int)
ML_1(gtk_widget_get_margin_right,GtkWidget_val, Val_int)
ML_1(gtk_widget_get_margin_left,GtkWidget_val, Val_int)
ML_1(gtk_widget_get_margin_bottom,GtkWidget_val, Val_int)
ML_1(gtk_widget_get_mapped,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_hexpand_set,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_hexpand,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_has_window,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_has_tooltip,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_events,GtkWidget_val, Val_int)
ML_1(gtk_widget_get_double_buffered,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_display,GtkWidget_val, Val_GdkDisplay)
ML_2(gtk_widget_get_device_enabled,GtkWidget_val, GdkDevice_val, Val_bool)
ML_1(gtk_widget_get_composite_name,GtkWidget_val, Val_string_new)
ML_1(gtk_widget_get_child_visible,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_can_focus,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_can_default,GtkWidget_val, Val_bool)
ML_1(gtk_widget_get_app_paintable,GtkWidget_val, Val_bool)
ML_2(gtk_widget_get_ancestor,GtkWidget_val, Int_val, Val_GtkWidget)
ML_1(gtk_widget_get_allocated_width,GtkWidget_val, Val_int)
ML_1(gtk_widget_get_allocated_height,GtkWidget_val, Val_int)
ML_1(gtk_widget_get_accessible,GtkWidget_val, Val_AtkObject)
ML_1(gtk_widget_freeze_child_notify,GtkWidget_val, Unit)
ML_1(gtk_widget_error_bell,GtkWidget_val, Unit)
ML_1(gtk_widget_ensure_style,GtkWidget_val, Unit)
ML_2(gtk_widget_draw,GtkWidget_val, cairo_t_val, Unit)
ML_1(gtk_drag_unhighlight,GtkWidget_val, Unit)
ML_1(gtk_drag_source_unset,GtkWidget_val, Unit)
ML_2(gtk_drag_source_set_target_list,GtkWidget_val, Option_val(arg2,GtkTargetList_val,NULL) Ignore, Unit)
ML_2(gtk_drag_source_set_icon_stock,GtkWidget_val, String_val, Unit)
ML_2(gtk_drag_source_set_icon_pixbuf,GtkWidget_val, GdkPixbuf_val, Unit)
ML_2(gtk_drag_source_set_icon_name,GtkWidget_val, String_val, Unit)
ML_1(gtk_drag_source_get_target_list,GtkWidget_val, Val_GtkTargetList)
ML_1(gtk_drag_source_add_uri_targets,GtkWidget_val, Unit)
ML_1(gtk_drag_source_add_text_targets,GtkWidget_val, Unit)
ML_1(gtk_drag_source_add_image_targets,GtkWidget_val, Unit)
ML_1(gtk_drag_highlight,GtkWidget_val, Unit)
ML_1(gtk_drag_dest_unset,GtkWidget_val, Unit)
ML_2(gtk_drag_dest_set_track_motion,GtkWidget_val, Bool_val, Unit)
ML_2(gtk_drag_dest_set_target_list,GtkWidget_val, Option_val(arg2,GtkTargetList_val,NULL) Ignore, Unit)
ML_1(gtk_drag_dest_get_track_motion,GtkWidget_val, Val_bool)
ML_1(gtk_drag_dest_get_target_list,GtkWidget_val, Val_GtkTargetList)
ML_1(gtk_drag_dest_add_uri_targets,GtkWidget_val, Unit)
ML_1(gtk_drag_dest_add_text_targets,GtkWidget_val, Unit)
ML_1(gtk_drag_dest_add_image_targets,GtkWidget_val, Unit)
ML_5(gtk_drag_check_threshold,GtkWidget_val, Int_val, Int_val, Int_val, Int_val, Val_bool)
ML_2(gtk_widget_device_is_shadowed,GtkWidget_val, GdkDevice_val, Val_bool)
ML_1(gtk_widget_destroy,GtkWidget_val, Unit)
ML_2(gtk_widget_create_pango_layout,GtkWidget_val, String_val, Val_PangoLayout_new)
ML_1(gtk_widget_create_pango_context,GtkWidget_val, Val_PangoContext_new)
ML_2(gtk_widget_child_notify,GtkWidget_val, String_val, Unit)
ML_2(gtk_widget_can_activate_accel,GtkWidget_val, Int_val, Val_bool)
ML_2(gtk_widget_add_mnemonic_label,GtkWidget_val, GtkWidget_val, Unit)
ML_2(gtk_widget_add_events,GtkWidget_val, Int_val, Unit)
ML_1(gtk_widget_activate,GtkWidget_val, Val_bool)
ML_0(gtk_widget_push_composite_child,Unit)
ML_0(gtk_widget_pop_composite_child,Unit)
ML_0(gtk_widget_get_default_style,Val_GtkStyle)
/* end of Widget */
/* Module VolumeButtonClass */
/* end of VolumeButtonClass */
/* Module VolumeButton */
/* end of VolumeButton */
/* Module ViewportPrivate */
/* end of ViewportPrivate */
/* Module ViewportClass */
/* end of ViewportClass */
/* Module Viewport */
ML_2(gtk_viewport_set_vadjustment,GtkViewport_val, Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Unit)
ML_2(gtk_viewport_set_hadjustment,GtkViewport_val, Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Unit)
ML_1(gtk_viewport_get_view_window,GtkViewport_val, Val_GdkWindow)
ML_1(gtk_viewport_get_vadjustment,GtkViewport_val, Val_GtkAdjustment)
ML_1(gtk_viewport_get_hadjustment,GtkViewport_val, Val_GtkAdjustment)
ML_1(gtk_viewport_get_bin_window,GtkViewport_val, Val_GdkWindow)
/* end of Viewport */
/* Module VSeparatorClass */
/* end of VSeparatorClass */
/* Module VSeparator */
/* end of VSeparator */
/* Module VScrollbarClass */
/* end of VScrollbarClass */
/* Module VScrollbar */
/* end of VScrollbar */
/* Module VScaleClass */
/* end of VScaleClass */
/* Module VScale */
/* end of VScale */
/* Module VPanedClass */
/* end of VPanedClass */
/* Module VPaned */
/* end of VPaned */
/* Module VButtonBoxClass */
/* end of VButtonBoxClass */
/* Module VButtonBox */
/* end of VButtonBox */
/* Module VBoxClass */
/* end of VBoxClass */
/* Module VBox */
/* end of VBox */
/* Module UIManagerPrivate */
/* end of UIManagerPrivate */
/* Module UIManagerClass */
/* end of UIManagerClass */
/* Module UIManager */
ML_2(gtk_ui_manager_set_add_tearoffs,GtkUIManager_val, Bool_val, Unit)
ML_2(gtk_ui_manager_remove_ui,GtkUIManager_val, Int_val, Unit)
ML_2(gtk_ui_manager_remove_action_group,GtkUIManager_val, GtkActionGroup_val, Unit)
ML_1(gtk_ui_manager_new_merge_id,GtkUIManager_val, Val_int)
ML_3(gtk_ui_manager_insert_action_group,GtkUIManager_val, GtkActionGroup_val, Int_val, Unit)
ML_2(gtk_ui_manager_get_widget,GtkUIManager_val, String_val, Val_GtkWidget)
ML_1(gtk_ui_manager_get_ui,GtkUIManager_val, Val_string_new)
ML_1(gtk_ui_manager_get_add_tearoffs,GtkUIManager_val, Val_bool)
ML_1(gtk_ui_manager_get_action_groups,GtkUIManager_val, Val_GList)
ML_2(gtk_ui_manager_get_action,GtkUIManager_val, String_val, Val_GtkAction)
ML_1(gtk_ui_manager_get_accel_group,GtkUIManager_val, Val_GtkAccelGroup)
ML_1(gtk_ui_manager_ensure_update,GtkUIManager_val, Unit)
/* end of UIManager */
/* Module TreeViewPrivate */
/* end of TreeViewPrivate */
/* Module TreeViewColumnPrivate */
/* end of TreeViewColumnPrivate */
/* Module TreeViewColumnClass */
/* end of TreeViewColumnClass */
/* Module TreeViewColumn */
ML_2(gtk_tree_view_column_set_widget,GtkTreeViewColumn_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_tree_view_column_set_visible,GtkTreeViewColumn_val, Bool_val, Unit)
ML_2(gtk_tree_view_column_set_title,GtkTreeViewColumn_val, String_val, Unit)
ML_2(gtk_tree_view_column_set_spacing,GtkTreeViewColumn_val, Int_val, Unit)
ML_2(gtk_tree_view_column_set_sort_indicator,GtkTreeViewColumn_val, Bool_val, Unit)
ML_2(gtk_tree_view_column_set_sort_column_id,GtkTreeViewColumn_val, Int_val, Unit)
ML_2(gtk_tree_view_column_set_resizable,GtkTreeViewColumn_val, Bool_val, Unit)
ML_2(gtk_tree_view_column_set_reorderable,GtkTreeViewColumn_val, Bool_val, Unit)
ML_2(gtk_tree_view_column_set_min_width,GtkTreeViewColumn_val, Int_val, Unit)
ML_2(gtk_tree_view_column_set_max_width,GtkTreeViewColumn_val, Int_val, Unit)
ML_2(gtk_tree_view_column_set_fixed_width,GtkTreeViewColumn_val, Int_val, Unit)
ML_2(gtk_tree_view_column_set_expand,GtkTreeViewColumn_val, Bool_val, Unit)
ML_2(gtk_tree_view_column_set_clickable,GtkTreeViewColumn_val, Bool_val, Unit)
ML_1(gtk_tree_view_column_queue_resize,GtkTreeViewColumn_val, Unit)
ML_3(gtk_tree_view_column_pack_start,GtkTreeViewColumn_val, GtkCellRenderer_val, Bool_val, Unit)
ML_3(gtk_tree_view_column_pack_end,GtkTreeViewColumn_val, GtkCellRenderer_val, Bool_val, Unit)
ML_1(gtk_tree_view_column_get_width,GtkTreeViewColumn_val, Val_int)
ML_1(gtk_tree_view_column_get_widget,GtkTreeViewColumn_val, Val_GtkWidget)
ML_1(gtk_tree_view_column_get_visible,GtkTreeViewColumn_val, Val_bool)
ML_1(gtk_tree_view_column_get_tree_view,GtkTreeViewColumn_val, Val_GtkWidget)
ML_1(gtk_tree_view_column_get_title,GtkTreeViewColumn_val, Val_string)
ML_1(gtk_tree_view_column_get_spacing,GtkTreeViewColumn_val, Val_int)
ML_1(gtk_tree_view_column_get_sort_indicator,GtkTreeViewColumn_val, Val_bool)
ML_1(gtk_tree_view_column_get_sort_column_id,GtkTreeViewColumn_val, Val_int)
ML_1(gtk_tree_view_column_get_resizable,GtkTreeViewColumn_val, Val_bool)
ML_1(gtk_tree_view_column_get_reorderable,GtkTreeViewColumn_val, Val_bool)
ML_1(gtk_tree_view_column_get_min_width,GtkTreeViewColumn_val, Val_int)
ML_1(gtk_tree_view_column_get_max_width,GtkTreeViewColumn_val, Val_int)
ML_1(gtk_tree_view_column_get_fixed_width,GtkTreeViewColumn_val, Val_int)
ML_1(gtk_tree_view_column_get_expand,GtkTreeViewColumn_val, Val_bool)
ML_1(gtk_tree_view_column_get_clickable,GtkTreeViewColumn_val, Val_bool)
ML_1(gtk_tree_view_column_get_button,GtkTreeViewColumn_val, Val_GtkWidget)
ML_2(gtk_tree_view_column_focus_cell,GtkTreeViewColumn_val, GtkCellRenderer_val, Unit)
ML_1(gtk_tree_view_column_clicked,GtkTreeViewColumn_val, Unit)
ML_2(gtk_tree_view_column_clear_attributes,GtkTreeViewColumn_val, GtkCellRenderer_val, Unit)
ML_1(gtk_tree_view_column_clear,GtkTreeViewColumn_val, Unit)
ML_1(gtk_tree_view_column_cell_is_visible,GtkTreeViewColumn_val, Val_bool)
ML_4(gtk_tree_view_column_add_attribute,GtkTreeViewColumn_val, GtkCellRenderer_val, String_val, Int_val, Unit)
/* end of TreeViewColumn */
/* Module TreeViewClass */
/* end of TreeViewClass */
/* Module TreeView */
ML_1(gtk_tree_view_unset_rows_drag_source,GtkTreeView_val, Unit)
ML_1(gtk_tree_view_unset_rows_drag_dest,GtkTreeView_val, Unit)
ML_2(gtk_tree_view_set_vadjustment,GtkTreeView_val, Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Unit)
ML_3(gtk_tree_view_set_tooltip_row,GtkTreeView_val, GtkTooltip_val, GtkTreePath_val, Unit)
ML_2(gtk_tree_view_set_tooltip_column,GtkTreeView_val, Int_val, Unit)
ML_5(gtk_tree_view_set_tooltip_cell,GtkTreeView_val, GtkTooltip_val, Option_val(arg3,GtkTreePath_val,NULL) Ignore, Option_val(arg4,GtkTreeViewColumn_val,NULL) Ignore, Option_val(arg5,GtkCellRenderer_val,NULL) Ignore, Unit)
ML_2(gtk_tree_view_set_show_expanders,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_search_entry,GtkTreeView_val, Option_val(arg2,GtkEntry_val,NULL) Ignore, Unit)
ML_2(gtk_tree_view_set_search_column,GtkTreeView_val, Int_val, Unit)
ML_2(gtk_tree_view_set_rules_hint,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_rubber_banding,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_reorderable,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_level_indentation,GtkTreeView_val, Int_val, Unit)
ML_2(gtk_tree_view_set_hover_selection,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_hover_expand,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_headers_visible,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_headers_clickable,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_hadjustment,GtkTreeView_val, Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Unit)
ML_2(gtk_tree_view_set_fixed_height_mode,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_expander_column,GtkTreeView_val, GtkTreeViewColumn_val, Unit)
ML_2(gtk_tree_view_set_enable_tree_lines,GtkTreeView_val, Bool_val, Unit)
ML_2(gtk_tree_view_set_enable_search,GtkTreeView_val, Bool_val, Unit)
ML_5(gtk_tree_view_set_cursor_on_cell,GtkTreeView_val, GtkTreePath_val, Option_val(arg3,GtkTreeViewColumn_val,NULL) Ignore, Option_val(arg4,GtkCellRenderer_val,NULL) Ignore, Bool_val, Unit)
ML_4(gtk_tree_view_set_cursor,GtkTreeView_val, GtkTreePath_val, Option_val(arg3,GtkTreeViewColumn_val,NULL) Ignore, Bool_val, Unit)
ML_3(gtk_tree_view_scroll_to_point,GtkTreeView_val, Int_val, Int_val, Unit)
ML_2(gtk_tree_view_row_expanded,GtkTreeView_val, GtkTreePath_val, Val_bool)
ML_3(gtk_tree_view_row_activated,GtkTreeView_val, GtkTreePath_val, GtkTreeViewColumn_val, Unit)
ML_2(gtk_tree_view_remove_column,GtkTreeView_val, GtkTreeViewColumn_val, Val_int)
ML_3(gtk_tree_view_move_column_after,GtkTreeView_val, GtkTreeViewColumn_val, Option_val(arg3,GtkTreeViewColumn_val,NULL) Ignore, Unit)
ML_1(gtk_tree_view_is_rubber_banding_active,GtkTreeView_val, Val_bool)
ML_3(gtk_tree_view_insert_column,GtkTreeView_val, GtkTreeViewColumn_val, Int_val, Val_int)
ML_1(gtk_tree_view_get_vadjustment,GtkTreeView_val, Val_GtkAdjustment)
ML_1(gtk_tree_view_get_tooltip_column,GtkTreeView_val, Val_int)
ML_1(gtk_tree_view_get_show_expanders,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_selection,GtkTreeView_val, Val_GtkTreeSelection)
ML_1(gtk_tree_view_get_search_entry,GtkTreeView_val, Val_GtkEntry)
ML_1(gtk_tree_view_get_search_column,GtkTreeView_val, Val_int)
ML_1(gtk_tree_view_get_rules_hint,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_rubber_banding,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_reorderable,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_level_indentation,GtkTreeView_val, Val_int)
ML_1(gtk_tree_view_get_hover_selection,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_hover_expand,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_headers_visible,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_headers_clickable,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_hadjustment,GtkTreeView_val, Val_GtkAdjustment)
ML_1(gtk_tree_view_get_fixed_height_mode,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_expander_column,GtkTreeView_val, Val_GtkTreeViewColumn)
ML_1(gtk_tree_view_get_enable_tree_lines,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_enable_search,GtkTreeView_val, Val_bool)
ML_1(gtk_tree_view_get_columns,GtkTreeView_val, Val_GList)
ML_2(gtk_tree_view_get_column,GtkTreeView_val, Int_val, Val_GtkTreeViewColumn)
ML_1(gtk_tree_view_get_bin_window,GtkTreeView_val, Val_GdkWindow)
ML_2(gtk_tree_view_expand_to_path,GtkTreeView_val, GtkTreePath_val, Unit)
ML_3(gtk_tree_view_expand_row,GtkTreeView_val, GtkTreePath_val, Bool_val, Val_bool)
ML_1(gtk_tree_view_expand_all,GtkTreeView_val, Unit)
ML_2(gtk_tree_view_create_row_drag_icon,GtkTreeView_val, GtkTreePath_val, Val_cairo_surface_t_new)
ML_1(gtk_tree_view_columns_autosize,GtkTreeView_val, Unit)
ML_2(gtk_tree_view_collapse_row,GtkTreeView_val, GtkTreePath_val, Val_bool)
ML_1(gtk_tree_view_collapse_all,GtkTreeView_val, Unit)
ML_2(gtk_tree_view_append_column,GtkTreeView_val, GtkTreeViewColumn_val, Val_int)
/* end of TreeView */
/* Module TreeStorePrivate */
/* end of TreeStorePrivate */
/* Module TreeStoreClass */
/* end of TreeStoreClass */
/* Module TreeStore */
ML_3(gtk_tree_store_swap,GtkTreeStore_val, GtkTreeIter_val, GtkTreeIter_val, Unit)
ML_4(gtk_tree_store_set_value,GtkTreeStore_val, GtkTreeIter_val, Int_val, GValue_val, Unit)
ML_2(gtk_tree_store_remove,GtkTreeStore_val, GtkTreeIter_val, Val_bool)
ML_3(gtk_tree_store_move_before,GtkTreeStore_val, GtkTreeIter_val, Option_val(arg3,GtkTreeIter_val,NULL) Ignore, Unit)
ML_3(gtk_tree_store_move_after,GtkTreeStore_val, GtkTreeIter_val, Option_val(arg3,GtkTreeIter_val,NULL) Ignore, Unit)
ML_2(gtk_tree_store_iter_is_valid,GtkTreeStore_val, GtkTreeIter_val, Val_bool)
ML_2(gtk_tree_store_iter_depth,GtkTreeStore_val, GtkTreeIter_val, Val_int)
ML_3(gtk_tree_store_is_ancestor,GtkTreeStore_val, GtkTreeIter_val, GtkTreeIter_val, Val_bool)
ML_1(gtk_tree_store_clear,GtkTreeStore_val, Unit)
/* end of TreeStore */
/* Module TreeSortableIface */
/* end of TreeSortableIface */
/* Module TreeSelectionPrivate */
/* end of TreeSelectionPrivate */
/* Module TreeSelectionClass */
/* end of TreeSelectionClass */
/* Module TreeSelection */
ML_3(gtk_tree_selection_unselect_range,GtkTreeSelection_val, GtkTreePath_val, GtkTreePath_val, Unit)
ML_2(gtk_tree_selection_unselect_path,GtkTreeSelection_val, GtkTreePath_val, Unit)
ML_2(gtk_tree_selection_unselect_iter,GtkTreeSelection_val, GtkTreeIter_val, Unit)
ML_1(gtk_tree_selection_unselect_all,GtkTreeSelection_val, Unit)
ML_3(gtk_tree_selection_select_range,GtkTreeSelection_val, GtkTreePath_val, GtkTreePath_val, Unit)
ML_2(gtk_tree_selection_select_path,GtkTreeSelection_val, GtkTreePath_val, Unit)
ML_2(gtk_tree_selection_select_iter,GtkTreeSelection_val, GtkTreeIter_val, Unit)
ML_1(gtk_tree_selection_select_all,GtkTreeSelection_val, Unit)
ML_2(gtk_tree_selection_path_is_selected,GtkTreeSelection_val, GtkTreePath_val, Val_bool)
ML_2(gtk_tree_selection_iter_is_selected,GtkTreeSelection_val, GtkTreeIter_val, Val_bool)
ML_1(gtk_tree_selection_get_tree_view,GtkTreeSelection_val, Val_GtkTreeView)
ML_1(gtk_tree_selection_count_selected_rows,GtkTreeSelection_val, Val_int)
/* end of TreeSelection */
/* Module TreeRowReference */
ML_1(gtk_tree_row_reference_valid,GtkTreeRowReference_val, Val_bool)
ML_1(gtk_tree_row_reference_get_path,GtkTreeRowReference_val, Val_GtkTreePath_new)
ML_1(gtk_tree_row_reference_free,GtkTreeRowReference_val, Unit)
ML_1(gtk_tree_row_reference_copy,GtkTreeRowReference_val, Val_GtkTreeRowReference_new)
/* end of TreeRowReference */
/* Module TreePath */
ML_1(gtk_tree_path_up,GtkTreePath_val, Val_bool)
ML_1(gtk_tree_path_to_string,GtkTreePath_val, Val_string_new)
ML_1(gtk_tree_path_prev,GtkTreePath_val, Val_bool)
ML_2(gtk_tree_path_prepend_index,GtkTreePath_val, Int_val, Unit)
ML_1(gtk_tree_path_next,GtkTreePath_val, Unit)
ML_2(gtk_tree_path_is_descendant,GtkTreePath_val, GtkTreePath_val, Val_bool)
ML_2(gtk_tree_path_is_ancestor,GtkTreePath_val, GtkTreePath_val, Val_bool)
ML_1(gtk_tree_path_get_depth,GtkTreePath_val, Val_int)
ML_1(gtk_tree_path_free,GtkTreePath_val, Unit)
ML_1(gtk_tree_path_down,GtkTreePath_val, Unit)
ML_1(gtk_tree_path_copy,GtkTreePath_val, Val_GtkTreePath_new)
ML_2(gtk_tree_path_compare,GtkTreePath_val, GtkTreePath_val, Val_int)
ML_2(gtk_tree_path_append_index,GtkTreePath_val, Int_val, Unit)
/* end of TreePath */
/* Module TreeModelSortPrivate */
/* end of TreeModelSortPrivate */
/* Module TreeModelSortClass */
/* end of TreeModelSortClass */
/* Module TreeModelSort */
ML_1(gtk_tree_model_sort_reset_default_sort_func,GtkTreeModelSort_val, Unit)
ML_2(gtk_tree_model_sort_iter_is_valid,GtkTreeModelSort_val, GtkTreeIter_val, Val_bool)
ML_2(gtk_tree_model_sort_convert_path_to_child_path,GtkTreeModelSort_val, GtkTreePath_val, Val_GtkTreePath_new)
ML_2(gtk_tree_model_sort_convert_child_path_to_path,GtkTreeModelSort_val, GtkTreePath_val, Val_GtkTreePath_new)
ML_1(gtk_tree_model_sort_clear_cache,GtkTreeModelSort_val, Unit)
/* end of TreeModelSort */
/* Module TreeModelIface */
/* end of TreeModelIface */
/* Module TreeModelFilterPrivate */
/* end of TreeModelFilterPrivate */
/* Module TreeModelFilterClass */
/* end of TreeModelFilterClass */
/* Module TreeModelFilter */
ML_2(gtk_tree_model_filter_set_visible_column,GtkTreeModelFilter_val, Int_val, Unit)
ML_1(gtk_tree_model_filter_refilter,GtkTreeModelFilter_val, Unit)
ML_2(gtk_tree_model_filter_convert_path_to_child_path,GtkTreeModelFilter_val, GtkTreePath_val, Val_GtkTreePath_new)
ML_2(gtk_tree_model_filter_convert_child_path_to_path,GtkTreeModelFilter_val, GtkTreePath_val, Val_GtkTreePath_new)
ML_1(gtk_tree_model_filter_clear_cache,GtkTreeModelFilter_val, Unit)
/* end of TreeModelFilter */
/* Module TreeIter */
ML_1(gtk_tree_iter_free,GtkTreeIter_val, Unit)
ML_1(gtk_tree_iter_copy,GtkTreeIter_val, Val_GtkTreeIter_new)
/* end of TreeIter */
/* Module TreeDragSourceIface */
/* end of TreeDragSourceIface */
/* Module TreeDragDestIface */
/* end of TreeDragDestIface */
/* Module Tooltip */
ML_2(gtk_tooltip_set_text,GtkTooltip_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_tooltip_set_markup,GtkTooltip_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_tooltip_set_icon,GtkTooltip_val, Option_val(arg2,GdkPixbuf_val,NULL) Ignore, Unit)
ML_2(gtk_tooltip_set_custom,GtkTooltip_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_1(gtk_tooltip_trigger_tooltip_query,GdkDisplay_val, Unit)
/* end of Tooltip */
/* Module ToolbarPrivate */
/* end of ToolbarPrivate */
/* Module ToolbarClass */
/* end of ToolbarClass */
/* Module Toolbar */
ML_1(gtk_toolbar_unset_style,GtkToolbar_val, Unit)
ML_1(gtk_toolbar_unset_icon_size,GtkToolbar_val, Unit)
ML_2(gtk_toolbar_set_show_arrow,GtkToolbar_val, Bool_val, Unit)
ML_3(gtk_toolbar_set_drop_highlight_item,GtkToolbar_val, Option_val(arg2,GtkToolItem_val,NULL) Ignore, Int_val, Unit)
ML_3(gtk_toolbar_insert,GtkToolbar_val, GtkToolItem_val, Int_val, Unit)
ML_1(gtk_toolbar_get_show_arrow,GtkToolbar_val, Val_bool)
ML_2(gtk_toolbar_get_nth_item,GtkToolbar_val, Int_val, Val_GtkToolItem)
ML_1(gtk_toolbar_get_n_items,GtkToolbar_val, Val_int)
ML_2(gtk_toolbar_get_item_index,GtkToolbar_val, GtkToolItem_val, Val_int)
ML_3(gtk_toolbar_get_drop_index,GtkToolbar_val, Int_val, Int_val, Val_int)
/* end of Toolbar */
/* Module ToolShellIface */
/* end of ToolShellIface */
/* Module ToolPalettePrivate */
/* end of ToolPalettePrivate */
/* Module ToolPaletteClass */
/* end of ToolPaletteClass */
/* Module ToolPalette */
ML_1(gtk_tool_palette_unset_style,GtkToolPalette_val, Unit)
ML_1(gtk_tool_palette_unset_icon_size,GtkToolPalette_val, Unit)
ML_3(gtk_tool_palette_set_group_position,GtkToolPalette_val, GtkToolItemGroup_val, Int_val, Unit)
ML_3(gtk_tool_palette_set_expand,GtkToolPalette_val, GtkToolItemGroup_val, Bool_val, Unit)
ML_3(gtk_tool_palette_set_exclusive,GtkToolPalette_val, GtkToolItemGroup_val, Bool_val, Unit)
ML_1(gtk_tool_palette_get_vadjustment,GtkToolPalette_val, Val_GtkAdjustment)
ML_1(gtk_tool_palette_get_hadjustment,GtkToolPalette_val, Val_GtkAdjustment)
ML_2(gtk_tool_palette_get_group_position,GtkToolPalette_val, GtkToolItemGroup_val, Val_int)
ML_2(gtk_tool_palette_get_expand,GtkToolPalette_val, GtkToolItemGroup_val, Val_bool)
ML_2(gtk_tool_palette_get_exclusive,GtkToolPalette_val, GtkToolItemGroup_val, Val_bool)
ML_3(gtk_tool_palette_get_drop_item,GtkToolPalette_val, Int_val, Int_val, Val_GtkToolItem)
ML_3(gtk_tool_palette_get_drop_group,GtkToolPalette_val, Int_val, Int_val, Val_GtkToolItemGroup)
ML_2(gtk_tool_palette_get_drag_item,GtkToolPalette_val, GtkSelectionData_val, Val_GtkWidget)
ML_0(gtk_tool_palette_get_drag_target_item,Val_GtkTargetEntry)
ML_0(gtk_tool_palette_get_drag_target_group,Val_GtkTargetEntry)
/* end of ToolPalette */
/* Module ToolItemPrivate */
/* end of ToolItemPrivate */
/* Module ToolItemGroupPrivate */
/* end of ToolItemGroupPrivate */
/* Module ToolItemGroupClass */
/* end of ToolItemGroupClass */
/* Module ToolItemGroup */
ML_2(gtk_tool_item_group_set_label_widget,GtkToolItemGroup_val, GtkWidget_val, Unit)
ML_2(gtk_tool_item_group_set_label,GtkToolItemGroup_val, String_val, Unit)
ML_3(gtk_tool_item_group_set_item_position,GtkToolItemGroup_val, GtkToolItem_val, Int_val, Unit)
ML_2(gtk_tool_item_group_set_collapsed,GtkToolItemGroup_val, Bool_val, Unit)
ML_3(gtk_tool_item_group_insert,GtkToolItemGroup_val, GtkToolItem_val, Int_val, Unit)
ML_2(gtk_tool_item_group_get_nth_item,GtkToolItemGroup_val, Int_val, Val_GtkToolItem)
ML_1(gtk_tool_item_group_get_n_items,GtkToolItemGroup_val, Val_int)
ML_1(gtk_tool_item_group_get_label_widget,GtkToolItemGroup_val, Val_GtkWidget)
ML_1(gtk_tool_item_group_get_label,GtkToolItemGroup_val, Val_string)
ML_2(gtk_tool_item_group_get_item_position,GtkToolItemGroup_val, GtkToolItem_val, Val_int)
ML_3(gtk_tool_item_group_get_drop_item,GtkToolItemGroup_val, Int_val, Int_val, Val_GtkToolItem)
ML_1(gtk_tool_item_group_get_collapsed,GtkToolItemGroup_val, Val_bool)
/* end of ToolItemGroup */
/* Module ToolItemClass */
/* end of ToolItemClass */
/* Module ToolItem */
ML_1(gtk_tool_item_toolbar_reconfigured,GtkToolItem_val, Unit)
ML_2(gtk_tool_item_set_visible_vertical,GtkToolItem_val, Bool_val, Unit)
ML_2(gtk_tool_item_set_visible_horizontal,GtkToolItem_val, Bool_val, Unit)
ML_2(gtk_tool_item_set_use_drag_window,GtkToolItem_val, Bool_val, Unit)
ML_2(gtk_tool_item_set_tooltip_text,GtkToolItem_val, String_val, Unit)
ML_2(gtk_tool_item_set_tooltip_markup,GtkToolItem_val, String_val, Unit)
ML_3(gtk_tool_item_set_proxy_menu_item,GtkToolItem_val, String_val, GtkWidget_val, Unit)
ML_2(gtk_tool_item_set_is_important,GtkToolItem_val, Bool_val, Unit)
ML_2(gtk_tool_item_set_homogeneous,GtkToolItem_val, Bool_val, Unit)
ML_2(gtk_tool_item_set_expand,GtkToolItem_val, Bool_val, Unit)
ML_1(gtk_tool_item_retrieve_proxy_menu_item,GtkToolItem_val, Val_GtkWidget)
ML_1(gtk_tool_item_rebuild_menu,GtkToolItem_val, Unit)
ML_1(gtk_tool_item_get_visible_vertical,GtkToolItem_val, Val_bool)
ML_1(gtk_tool_item_get_visible_horizontal,GtkToolItem_val, Val_bool)
ML_1(gtk_tool_item_get_use_drag_window,GtkToolItem_val, Val_bool)
ML_1(gtk_tool_item_get_text_size_group,GtkToolItem_val, Val_GtkSizeGroup)
ML_2(gtk_tool_item_get_proxy_menu_item,GtkToolItem_val, String_val, Val_GtkWidget)
ML_1(gtk_tool_item_get_is_important,GtkToolItem_val, Val_bool)
ML_1(gtk_tool_item_get_homogeneous,GtkToolItem_val, Val_bool)
ML_1(gtk_tool_item_get_expand,GtkToolItem_val, Val_bool)
/* end of ToolItem */
/* Module ToolButtonPrivate */
/* end of ToolButtonPrivate */
/* Module ToolButtonClass */
/* end of ToolButtonClass */
/* Module ToolButton */
ML_2(gtk_tool_button_set_use_underline,GtkToolButton_val, Bool_val, Unit)
ML_2(gtk_tool_button_set_stock_id,GtkToolButton_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_tool_button_set_label_widget,GtkToolButton_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_tool_button_set_label,GtkToolButton_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_tool_button_set_icon_widget,GtkToolButton_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_tool_button_set_icon_name,GtkToolButton_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_1(gtk_tool_button_get_use_underline,GtkToolButton_val, Val_bool)
ML_1(gtk_tool_button_get_stock_id,GtkToolButton_val, Val_string)
ML_1(gtk_tool_button_get_label_widget,GtkToolButton_val, Val_GtkWidget)
ML_1(gtk_tool_button_get_label,GtkToolButton_val, Val_string)
ML_1(gtk_tool_button_get_icon_widget,GtkToolButton_val, Val_GtkWidget)
ML_1(gtk_tool_button_get_icon_name,GtkToolButton_val, Val_string)
/* end of ToolButton */
/* Module ToggleToolButtonPrivate */
/* end of ToggleToolButtonPrivate */
/* Module ToggleToolButtonClass */
/* end of ToggleToolButtonClass */
/* Module ToggleToolButton */
ML_2(gtk_toggle_tool_button_set_active,GtkToggleToolButton_val, Bool_val, Unit)
ML_1(gtk_toggle_tool_button_get_active,GtkToggleToolButton_val, Val_bool)
/* end of ToggleToolButton */
/* Module ToggleButtonPrivate */
/* end of ToggleButtonPrivate */
/* Module ToggleButtonClass */
/* end of ToggleButtonClass */
/* Module ToggleButton */
ML_1(gtk_toggle_button_toggled,GtkToggleButton_val, Unit)
ML_2(gtk_toggle_button_set_mode,GtkToggleButton_val, Bool_val, Unit)
ML_2(gtk_toggle_button_set_inconsistent,GtkToggleButton_val, Bool_val, Unit)
ML_2(gtk_toggle_button_set_active,GtkToggleButton_val, Bool_val, Unit)
ML_1(gtk_toggle_button_get_mode,GtkToggleButton_val, Val_bool)
ML_1(gtk_toggle_button_get_inconsistent,GtkToggleButton_val, Val_bool)
ML_1(gtk_toggle_button_get_active,GtkToggleButton_val, Val_bool)
/* end of ToggleButton */
/* Module ToggleActionPrivate */
/* end of ToggleActionPrivate */
/* Module ToggleActionEntry */
/* end of ToggleActionEntry */
/* Module ToggleActionClass */
/* end of ToggleActionClass */
/* Module ToggleAction */
ML_1(gtk_toggle_action_toggled,GtkToggleAction_val, Unit)
ML_2(gtk_toggle_action_set_draw_as_radio,GtkToggleAction_val, Bool_val, Unit)
ML_2(gtk_toggle_action_set_active,GtkToggleAction_val, Bool_val, Unit)
ML_1(gtk_toggle_action_get_draw_as_radio,GtkToggleAction_val, Val_bool)
ML_1(gtk_toggle_action_get_active,GtkToggleAction_val, Val_bool)
/* end of ToggleAction */
/* Module ThemingEngineClass */
/* end of ThemingEngineClass */
/* Module ThemingEngine */
ML_2(gtk_theming_engine_has_class,GtkThemingEngine_val, String_val, Val_bool)
ML_3(gtk_theming_engine_get_style_property,GtkThemingEngine_val, String_val, GValue_val, Unit)
ML_1(gtk_theming_engine_get_screen,GtkThemingEngine_val, Val_GdkScreen)
ML_1(gtk_theming_engine_get_path,GtkThemingEngine_val, Val_GtkWidgetPath)
ML_1(gtk_theming_engine_load,String_val, Val_GtkThemingEngine)
/* end of ThemingEngine */
/* Module ThemeEngine */
/* end of ThemeEngine */
/* Module TextViewPrivate */
/* end of TextViewPrivate */
/* Module TextViewClass */
/* end of TextViewClass */
/* Module TextView */
ML_2(gtk_text_view_starts_display_line,GtkTextView_val, GtkTextIter_val, Val_bool)
ML_2(gtk_text_view_set_tabs,GtkTextView_val, PangoTabArray_val, Unit)
ML_2(gtk_text_view_set_right_margin,GtkTextView_val, Int_val, Unit)
ML_2(gtk_text_view_set_pixels_inside_wrap,GtkTextView_val, Int_val, Unit)
ML_2(gtk_text_view_set_pixels_below_lines,GtkTextView_val, Int_val, Unit)
ML_2(gtk_text_view_set_pixels_above_lines,GtkTextView_val, Int_val, Unit)
ML_2(gtk_text_view_set_overwrite,GtkTextView_val, Bool_val, Unit)
ML_2(gtk_text_view_set_left_margin,GtkTextView_val, Int_val, Unit)
ML_2(gtk_text_view_set_indent,GtkTextView_val, Int_val, Unit)
ML_2(gtk_text_view_set_editable,GtkTextView_val, Bool_val, Unit)
ML_2(gtk_text_view_set_cursor_visible,GtkTextView_val, Bool_val, Unit)
ML_2(gtk_text_view_set_buffer,GtkTextView_val, Option_val(arg2,GtkTextBuffer_val,NULL) Ignore, Unit)
ML_2(gtk_text_view_set_accepts_tab,GtkTextView_val, Bool_val, Unit)
ML_6(gtk_text_view_scroll_to_mark,GtkTextView_val, GtkTextMark_val, Double_val, Bool_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_text_view_scroll_to_mark)
ML_6(gtk_text_view_scroll_to_iter,GtkTextView_val, GtkTextIter_val, Double_val, Bool_val, Double_val, Double_val, Val_bool)
ML_bc6(ml_gtk_text_view_scroll_to_iter)
ML_2(gtk_text_view_scroll_mark_onscreen,GtkTextView_val, GtkTextMark_val, Unit)
ML_1(gtk_text_view_reset_im_context,GtkTextView_val, Unit)
ML_1(gtk_text_view_place_cursor_onscreen,GtkTextView_val, Val_bool)
ML_3(gtk_text_view_move_visually,GtkTextView_val, GtkTextIter_val, Int_val, Val_bool)
ML_2(gtk_text_view_move_mark_onscreen,GtkTextView_val, GtkTextMark_val, Val_bool)
ML_4(gtk_text_view_move_child,GtkTextView_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_2(gtk_text_view_im_context_filter_keypress,GtkTextView_val, GdkEventKey_val, Val_bool)
ML_1(gtk_text_view_get_vadjustment,GtkTextView_val, Val_GtkAdjustment)
ML_1(gtk_text_view_get_tabs,GtkTextView_val, Val_PangoTabArray_new)
ML_1(gtk_text_view_get_right_margin,GtkTextView_val, Val_int)
ML_1(gtk_text_view_get_pixels_inside_wrap,GtkTextView_val, Val_int)
ML_1(gtk_text_view_get_pixels_below_lines,GtkTextView_val, Val_int)
ML_1(gtk_text_view_get_pixels_above_lines,GtkTextView_val, Val_int)
ML_1(gtk_text_view_get_overwrite,GtkTextView_val, Val_bool)
ML_1(gtk_text_view_get_left_margin,GtkTextView_val, Val_int)
ML_1(gtk_text_view_get_indent,GtkTextView_val, Val_int)
ML_1(gtk_text_view_get_hadjustment,GtkTextView_val, Val_GtkAdjustment)
ML_1(gtk_text_view_get_editable,GtkTextView_val, Val_bool)
ML_1(gtk_text_view_get_default_attributes,GtkTextView_val, Val_GtkTextAttributes_new)
ML_1(gtk_text_view_get_cursor_visible,GtkTextView_val, Val_bool)
ML_1(gtk_text_view_get_buffer,GtkTextView_val, Val_GtkTextBuffer)
ML_1(gtk_text_view_get_accepts_tab,GtkTextView_val, Val_bool)
ML_2(gtk_text_view_forward_display_line_end,GtkTextView_val, GtkTextIter_val, Val_bool)
ML_2(gtk_text_view_forward_display_line,GtkTextView_val, GtkTextIter_val, Val_bool)
ML_2(gtk_text_view_backward_display_line_start,GtkTextView_val, GtkTextIter_val, Val_bool)
ML_2(gtk_text_view_backward_display_line,GtkTextView_val, GtkTextIter_val, Val_bool)
ML_3(gtk_text_view_add_child_at_anchor,GtkTextView_val, GtkWidget_val, GtkTextChildAnchor_val, Unit)
/* end of TextView */
/* Module TextTagTablePrivate */
/* end of TextTagTablePrivate */
/* Module TextTagTableClass */
/* end of TextTagTableClass */
/* Module TextTagTable */
ML_2(gtk_text_tag_table_remove,GtkTextTagTable_val, GtkTextTag_val, Unit)
ML_2(gtk_text_tag_table_lookup,GtkTextTagTable_val, String_val, Val_GtkTextTag)
ML_1(gtk_text_tag_table_get_size,GtkTextTagTable_val, Val_int)
ML_2(gtk_text_tag_table_add,GtkTextTagTable_val, GtkTextTag_val, Unit)
/* end of TextTagTable */
/* Module TextTagPrivate */
/* end of TextTagPrivate */
/* Module TextTagClass */
/* end of TextTagClass */
/* Module TextTag */
ML_2(gtk_text_tag_set_priority,GtkTextTag_val, Int_val, Unit)
ML_1(gtk_text_tag_get_priority,GtkTextTag_val, Val_int)
/* end of TextTag */
/* Module TextMarkClass */
/* end of TextMarkClass */
/* Module TextMark */
ML_2(gtk_text_mark_set_visible,GtkTextMark_val, Bool_val, Unit)
ML_1(gtk_text_mark_get_visible,GtkTextMark_val, Val_bool)
ML_1(gtk_text_mark_get_name,GtkTextMark_val, Val_string)
ML_1(gtk_text_mark_get_left_gravity,GtkTextMark_val, Val_bool)
ML_1(gtk_text_mark_get_deleted,GtkTextMark_val, Val_bool)
ML_1(gtk_text_mark_get_buffer,GtkTextMark_val, Val_GtkTextBuffer)
/* end of TextMark */
/* Module TextIter */
ML_2(gtk_text_iter_toggles_tag,GtkTextIter_val, Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)
ML_1(gtk_text_iter_starts_word,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_starts_sentence,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_starts_line,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_set_visible_line_offset,GtkTextIter_val, Int_val, Unit)
ML_2(gtk_text_iter_set_visible_line_index,GtkTextIter_val, Int_val, Unit)
ML_2(gtk_text_iter_set_offset,GtkTextIter_val, Int_val, Unit)
ML_2(gtk_text_iter_set_line_offset,GtkTextIter_val, Int_val, Unit)
ML_2(gtk_text_iter_set_line_index,GtkTextIter_val, Int_val, Unit)
ML_2(gtk_text_iter_set_line,GtkTextIter_val, Int_val, Unit)
ML_2(gtk_text_iter_order,GtkTextIter_val, GtkTextIter_val, Unit)
ML_1(gtk_text_iter_is_start,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_is_end,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_is_cursor_position,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_inside_word,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_inside_sentence,GtkTextIter_val, Val_bool)
ML_3(gtk_text_iter_in_range,GtkTextIter_val, GtkTextIter_val, GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_has_tag,GtkTextIter_val, GtkTextTag_val, Val_bool)
ML_2(gtk_text_iter_get_visible_text,GtkTextIter_val, GtkTextIter_val, Val_string_new)
ML_2(gtk_text_iter_get_visible_slice,GtkTextIter_val, GtkTextIter_val, Val_string_new)
ML_1(gtk_text_iter_get_visible_line_offset,GtkTextIter_val, Val_int)
ML_1(gtk_text_iter_get_visible_line_index,GtkTextIter_val, Val_int)
ML_2(gtk_text_iter_get_toggled_tags,GtkTextIter_val, Bool_val, Val_GSList)
ML_2(gtk_text_iter_get_text,GtkTextIter_val, GtkTextIter_val, Val_string_new)
ML_1(gtk_text_iter_get_tags,GtkTextIter_val, Val_GSList)
ML_2(gtk_text_iter_get_slice,GtkTextIter_val, GtkTextIter_val, Val_string_new)
ML_1(gtk_text_iter_get_pixbuf,GtkTextIter_val, Val_GdkPixbuf)
ML_1(gtk_text_iter_get_offset,GtkTextIter_val, Val_int)
ML_1(gtk_text_iter_get_marks,GtkTextIter_val, Val_GSList)
ML_1(gtk_text_iter_get_line_offset,GtkTextIter_val, Val_int)
ML_1(gtk_text_iter_get_line_index,GtkTextIter_val, Val_int)
ML_1(gtk_text_iter_get_line,GtkTextIter_val, Val_int)
ML_1(gtk_text_iter_get_language,GtkTextIter_val, Val_PangoLanguage_new)
ML_1(gtk_text_iter_get_child_anchor,GtkTextIter_val, Val_GtkTextChildAnchor)
ML_1(gtk_text_iter_get_chars_in_line,GtkTextIter_val, Val_int)
ML_1(gtk_text_iter_get_char,GtkTextIter_val, Val_int32)
ML_1(gtk_text_iter_get_bytes_in_line,GtkTextIter_val, Val_int)
ML_1(gtk_text_iter_get_buffer,GtkTextIter_val, Val_GtkTextBuffer)
ML_1(gtk_text_iter_free,GtkTextIter_val, Unit)
ML_2(gtk_text_iter_forward_word_ends,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_word_end,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_forward_visible_word_ends,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_visible_word_end,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_forward_visible_lines,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_visible_line,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_forward_visible_cursor_positions,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_visible_cursor_position,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_forward_to_tag_toggle,GtkTextIter_val, Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)
ML_1(gtk_text_iter_forward_to_line_end,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_forward_to_end,GtkTextIter_val, Unit)
ML_2(gtk_text_iter_forward_sentence_ends,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_sentence_end,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_forward_lines,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_line,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_forward_cursor_positions,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_cursor_position,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_forward_chars,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_forward_char,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_equal,GtkTextIter_val, GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_ends_word,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_ends_tag,GtkTextIter_val, Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)
ML_1(gtk_text_iter_ends_sentence,GtkTextIter_val, Val_bool)
ML_1(gtk_text_iter_ends_line,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_editable,GtkTextIter_val, Bool_val, Val_bool)
ML_1(gtk_text_iter_copy,GtkTextIter_val, Val_GtkTextIter_new)
ML_2(gtk_text_iter_compare,GtkTextIter_val, GtkTextIter_val, Val_int)
ML_2(gtk_text_iter_can_insert,GtkTextIter_val, Bool_val, Val_bool)
ML_2(gtk_text_iter_begins_tag,GtkTextIter_val, Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)
ML_2(gtk_text_iter_backward_word_starts,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_word_start,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_backward_visible_word_starts,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_visible_word_start,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_backward_visible_lines,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_visible_line,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_backward_visible_cursor_positions,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_visible_cursor_position,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_backward_to_tag_toggle,GtkTextIter_val, Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)
ML_2(gtk_text_iter_backward_sentence_starts,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_sentence_start,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_backward_lines,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_line,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_backward_cursor_positions,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_cursor_position,GtkTextIter_val, Val_bool)
ML_2(gtk_text_iter_backward_chars,GtkTextIter_val, Int_val, Val_bool)
ML_1(gtk_text_iter_backward_char,GtkTextIter_val, Val_bool)
/* end of TextIter */
/* Module TextChildAnchorClass */
/* end of TextChildAnchorClass */
/* Module TextChildAnchor */
ML_1(gtk_text_child_anchor_get_widgets,GtkTextChildAnchor_val, Val_GList)
ML_1(gtk_text_child_anchor_get_deleted,GtkTextChildAnchor_val, Val_bool)
/* end of TextChildAnchor */
/* Module TextBufferPrivate */
/* end of TextBufferPrivate */
/* Module TextBufferClass */
/* end of TextBufferClass */
/* Module TextBuffer */
ML_3(gtk_text_buffer_set_text,GtkTextBuffer_val, String_val, Int_val, Unit)
ML_2(gtk_text_buffer_set_modified,GtkTextBuffer_val, Bool_val, Unit)
ML_3(gtk_text_buffer_select_range,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_4(gtk_text_buffer_remove_tag_by_name,GtkTextBuffer_val, String_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_4(gtk_text_buffer_remove_tag,GtkTextBuffer_val, GtkTextTag_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_2(gtk_text_buffer_remove_selection_clipboard,GtkTextBuffer_val, GtkClipboard_val, Unit)
ML_3(gtk_text_buffer_remove_all_tags,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_2(gtk_text_buffer_place_cursor,GtkTextBuffer_val, GtkTextIter_val, Unit)
ML_4(gtk_text_buffer_paste_clipboard,GtkTextBuffer_val, GtkClipboard_val, Option_val(arg3,GtkTextIter_val,NULL) Ignore, Bool_val, Unit)
ML_3(gtk_text_buffer_move_mark_by_name,GtkTextBuffer_val, String_val, GtkTextIter_val, Unit)
ML_3(gtk_text_buffer_move_mark,GtkTextBuffer_val, GtkTextMark_val, GtkTextIter_val, Unit)
ML_5(gtk_text_buffer_insert_range_interactive,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, GtkTextIter_val, Bool_val, Val_bool)
ML_4(gtk_text_buffer_insert_range,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_3(gtk_text_buffer_insert_pixbuf,GtkTextBuffer_val, GtkTextIter_val, GdkPixbuf_val, Unit)
ML_4(gtk_text_buffer_insert_interactive_at_cursor,GtkTextBuffer_val, String_val, Int_val, Bool_val, Val_bool)
ML_5(gtk_text_buffer_insert_interactive,GtkTextBuffer_val, GtkTextIter_val, String_val, Int_val, Bool_val, Val_bool)
ML_3(gtk_text_buffer_insert_child_anchor,GtkTextBuffer_val, GtkTextIter_val, GtkTextChildAnchor_val, Unit)
ML_3(gtk_text_buffer_insert_at_cursor,GtkTextBuffer_val, String_val, Int_val, Unit)
ML_4(gtk_text_buffer_insert,GtkTextBuffer_val, GtkTextIter_val, String_val, Int_val, Unit)
ML_4(gtk_text_buffer_get_text,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, Bool_val, Val_string_new)
ML_1(gtk_text_buffer_get_tag_table,GtkTextBuffer_val, Val_GtkTextTagTable)
ML_4(gtk_text_buffer_get_slice,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, Bool_val, Val_string_new)
ML_1(gtk_text_buffer_get_selection_bound,GtkTextBuffer_val, Val_GtkTextMark)
ML_1(gtk_text_buffer_get_paste_target_list,GtkTextBuffer_val, Val_GtkTargetList)
ML_1(gtk_text_buffer_get_modified,GtkTextBuffer_val, Val_bool)
ML_2(gtk_text_buffer_get_mark,GtkTextBuffer_val, String_val, Val_GtkTextMark)
ML_1(gtk_text_buffer_get_line_count,GtkTextBuffer_val, Val_int)
ML_1(gtk_text_buffer_get_insert,GtkTextBuffer_val, Val_GtkTextMark)
ML_1(gtk_text_buffer_get_has_selection,GtkTextBuffer_val, Val_bool)
ML_1(gtk_text_buffer_get_copy_target_list,GtkTextBuffer_val, Val_GtkTargetList)
ML_1(gtk_text_buffer_get_char_count,GtkTextBuffer_val, Val_int)
ML_1(gtk_text_buffer_end_user_action,GtkTextBuffer_val, Unit)
ML_3(gtk_text_buffer_delete_selection,GtkTextBuffer_val, Bool_val, Bool_val, Val_bool)
ML_2(gtk_text_buffer_delete_mark_by_name,GtkTextBuffer_val, String_val, Unit)
ML_2(gtk_text_buffer_delete_mark,GtkTextBuffer_val, GtkTextMark_val, Unit)
ML_4(gtk_text_buffer_delete_interactive,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, Bool_val, Val_bool)
ML_3(gtk_text_buffer_delete,GtkTextBuffer_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_3(gtk_text_buffer_cut_clipboard,GtkTextBuffer_val, GtkClipboard_val, Bool_val, Unit)
ML_4(gtk_text_buffer_create_mark,GtkTextBuffer_val, Option_val(arg2,String_val,NULL) Ignore, GtkTextIter_val, Bool_val, Val_GtkTextMark)
ML_2(gtk_text_buffer_create_child_anchor,GtkTextBuffer_val, GtkTextIter_val, Val_GtkTextChildAnchor)
ML_2(gtk_text_buffer_copy_clipboard,GtkTextBuffer_val, GtkClipboard_val, Unit)
ML_1(gtk_text_buffer_begin_user_action,GtkTextBuffer_val, Unit)
ML_4(gtk_text_buffer_backspace,GtkTextBuffer_val, GtkTextIter_val, Bool_val, Bool_val, Val_bool)
ML_4(gtk_text_buffer_apply_tag_by_name,GtkTextBuffer_val, String_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_4(gtk_text_buffer_apply_tag,GtkTextBuffer_val, GtkTextTag_val, GtkTextIter_val, GtkTextIter_val, Unit)
ML_2(gtk_text_buffer_add_selection_clipboard,GtkTextBuffer_val, GtkClipboard_val, Unit)
ML_3(gtk_text_buffer_add_mark,GtkTextBuffer_val, GtkTextMark_val, GtkTextIter_val, Unit)
/* end of TextBuffer */
/* Module TextBTree */
/* end of TextBTree */
/* Module TextAttributes */
ML_1(gtk_text_attributes_unref,GtkTextAttributes_val, Unit)
ML_1(gtk_text_attributes_ref,GtkTextAttributes_val, Val_GtkTextAttributes_new)
ML_2(gtk_text_attributes_copy_values,GtkTextAttributes_val, GtkTextAttributes_val, Unit)
ML_1(gtk_text_attributes_copy,GtkTextAttributes_val, Val_GtkTextAttributes_new)
/* end of TextAttributes */
/* Module TextAppearance */
/* end of TextAppearance */
/* Module TearoffMenuItemPrivate */
/* end of TearoffMenuItemPrivate */
/* Module TearoffMenuItemClass */
/* end of TearoffMenuItemClass */
/* Module TearoffMenuItem */
/* end of TearoffMenuItem */
/* Module TargetList */
ML_1(gtk_target_list_unref,GtkTargetList_val, Unit)
ML_1(gtk_target_list_ref,GtkTargetList_val, Val_GtkTargetList_new)
ML_2(gtk_target_list_add_uri_targets,GtkTargetList_val, Int_val, Unit)
ML_2(gtk_target_list_add_text_targets,GtkTargetList_val, Int_val, Unit)
ML_4(gtk_target_list_add_rich_text_targets,GtkTargetList_val, Int_val, Bool_val, GtkTextBuffer_val, Unit)
ML_3(gtk_target_list_add_image_targets,GtkTargetList_val, Int_val, Bool_val, Unit)
/* end of TargetList */
/* Module TargetEntry */
ML_1(gtk_target_entry_free,GtkTargetEntry_val, Unit)
ML_1(gtk_target_entry_copy,GtkTargetEntry_val, Val_GtkTargetEntry_new)
/* end of TargetEntry */
/* Module TableRowCol */
/* end of TableRowCol */
/* Module TablePrivate */
/* end of TablePrivate */
/* Module TableClass */
/* end of TableClass */
/* Module TableChild */
/* end of TableChild */
/* Module Table */
ML_2(gtk_table_set_row_spacings,GtkTable_val, Int_val, Unit)
ML_3(gtk_table_set_row_spacing,GtkTable_val, Int_val, Int_val, Unit)
ML_2(gtk_table_set_homogeneous,GtkTable_val, Bool_val, Unit)
ML_2(gtk_table_set_col_spacings,GtkTable_val, Int_val, Unit)
ML_3(gtk_table_set_col_spacing,GtkTable_val, Int_val, Int_val, Unit)
ML_3(gtk_table_resize,GtkTable_val, Int_val, Int_val, Unit)
ML_2(gtk_table_get_row_spacing,GtkTable_val, Int_val, Val_int)
ML_1(gtk_table_get_homogeneous,GtkTable_val, Val_bool)
ML_1(gtk_table_get_default_row_spacing,GtkTable_val, Val_int)
ML_1(gtk_table_get_default_col_spacing,GtkTable_val, Val_int)
ML_2(gtk_table_get_col_spacing,GtkTable_val, Int_val, Val_int)
ML_6(gtk_table_attach_defaults,GtkTable_val, GtkWidget_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc6(ml_gtk_table_attach_defaults) /* end of Table */
/* Module SymbolicColor */
ML_1(gtk_symbolic_color_unref,GtkSymbolicColor_val, Unit)
ML_1(gtk_symbolic_color_ref,GtkSymbolicColor_val, Val_GtkSymbolicColor_new)
ML_2(gtk_symbolic_color_new_shade,GtkSymbolicColor_val, Double_val, Val_GtkSymbolicColor_new)
ML_3(gtk_symbolic_color_new_mix,GtkSymbolicColor_val, GtkSymbolicColor_val, Double_val, Val_GtkSymbolicColor_new)
ML_2(gtk_symbolic_color_new_alpha,GtkSymbolicColor_val, Double_val, Val_GtkSymbolicColor_new)
/* end of SymbolicColor */
/* Module SwitchPrivate */
/* end of SwitchPrivate */
/* Module SwitchClass */
/* end of SwitchClass */
/* Module Switch */
ML_2(gtk_switch_set_active,GtkSwitch_val, Bool_val, Unit)
ML_1(gtk_switch_get_active,GtkSwitch_val, Val_bool)
/* end of Switch */
/* Module StyleProviderIface */
/* end of StyleProviderIface */
/* Module StylePropertiesClass */
/* end of StylePropertiesClass */
/* Module StyleProperties */
ML_3(gtk_style_properties_merge,GtkStyleProperties_val, GtkStyleProperties_val, Bool_val, Unit)
ML_3(gtk_style_properties_map_color,GtkStyleProperties_val, String_val, GtkSymbolicColor_val, Unit)
ML_2(gtk_style_properties_lookup_color,GtkStyleProperties_val, String_val, Val_GtkSymbolicColor)
ML_1(gtk_style_properties_clear,GtkStyleProperties_val, Unit)
/* end of StyleProperties */
/* Module StyleContextClass */
/* end of StyleContextClass */
/* Module StyleContext */
ML_2(gtk_style_context_set_screen,GtkStyleContext_val, GdkScreen_val, Unit)
ML_2(gtk_style_context_set_path,GtkStyleContext_val, GtkWidgetPath_val, Unit)
ML_2(gtk_style_context_set_background,GtkStyleContext_val, GdkWindow_val, Unit)
ML_4(gtk_style_context_scroll_animations,GtkStyleContext_val, GdkWindow_val, Int_val, Int_val, Unit)
ML_1(gtk_style_context_save,GtkStyleContext_val, Unit)
ML_1(gtk_style_context_restore,GtkStyleContext_val, Unit)
ML_2(gtk_style_context_remove_region,GtkStyleContext_val, String_val, Unit)
ML_2(gtk_style_context_remove_class,GtkStyleContext_val, String_val, Unit)
ML_1(gtk_style_context_pop_animatable_region,GtkStyleContext_val, Unit)
ML_2(gtk_style_context_lookup_icon_set,GtkStyleContext_val, String_val, Val_GtkIconSet)
ML_1(gtk_style_context_list_regions,GtkStyleContext_val, Val_GList)
ML_1(gtk_style_context_list_classes,GtkStyleContext_val, Val_GList)
ML_1(gtk_style_context_invalidate,GtkStyleContext_val, Unit)
ML_2(gtk_style_context_has_class,GtkStyleContext_val, String_val, Val_bool)
ML_3(gtk_style_context_get_style_property,GtkStyleContext_val, String_val, GValue_val, Unit)
ML_1(gtk_style_context_get_screen,GtkStyleContext_val, Val_GdkScreen)
ML_1(gtk_style_context_get_path,GtkStyleContext_val, Val_GtkWidgetPath)
ML_2(gtk_style_context_add_class,GtkStyleContext_val, String_val, Unit)
ML_1(gtk_style_context_reset_widgets,GdkScreen_val, Unit)
/* end of StyleContext */
/* Module StyleClass */
/* end of StyleClass */
/* Module Style */
ML_2(gtk_style_lookup_icon_set,GtkStyle_val, String_val, Val_GtkIconSet)
ML_1(gtk_style_has_context,GtkStyle_val, Val_bool)
ML_4(gtk_style_get_style_property,GtkStyle_val, Int_val, String_val, GValue_val, Unit)
ML_1(gtk_style_detach,GtkStyle_val, Unit)
ML_1(gtk_style_copy,GtkStyle_val, Val_GtkStyle_new)
ML_2(gtk_style_attach,GtkStyle_val, GdkWindow_val, Val_GtkStyle)
/* end of Style */
/* Module StockItem */
ML_1(gtk_stock_item_free,GtkStockItem_val, Unit)
ML_1(gtk_stock_item_copy,GtkStockItem_val, Val_GtkStockItem)
/* end of StockItem */
/* Module StatusbarPrivate */
/* end of StatusbarPrivate */
/* Module StatusbarClass */
/* end of StatusbarClass */
/* Module Statusbar */
ML_2(gtk_statusbar_remove_all,GtkStatusbar_val, Int_val, Unit)
ML_3(gtk_statusbar_remove,GtkStatusbar_val, Int_val, Int_val, Unit)
ML_3(gtk_statusbar_push,GtkStatusbar_val, Int_val, String_val, Val_int)
ML_2(gtk_statusbar_pop,GtkStatusbar_val, Int_val, Unit)
ML_1(gtk_statusbar_get_message_area,GtkStatusbar_val, Val_GtkWidget)
ML_2(gtk_statusbar_get_context_id,GtkStatusbar_val, String_val, Val_int)
/* end of Statusbar */
/* Module StatusIconPrivate */
/* end of StatusIconPrivate */
/* Module StatusIconClass */
/* end of StatusIconClass */
/* Module StatusIcon */
ML_2(gtk_status_icon_set_visible,GtkStatusIcon_val, Bool_val, Unit)
ML_2(gtk_status_icon_set_tooltip_text,GtkStatusIcon_val, String_val, Unit)
ML_2(gtk_status_icon_set_tooltip_markup,GtkStatusIcon_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_status_icon_set_title,GtkStatusIcon_val, String_val, Unit)
ML_2(gtk_status_icon_set_screen,GtkStatusIcon_val, GdkScreen_val, Unit)
ML_2(gtk_status_icon_set_name,GtkStatusIcon_val, String_val, Unit)
ML_2(gtk_status_icon_set_has_tooltip,GtkStatusIcon_val, Bool_val, Unit)
ML_2(gtk_status_icon_set_from_stock,GtkStatusIcon_val, String_val, Unit)
ML_2(gtk_status_icon_set_from_pixbuf,GtkStatusIcon_val, Option_val(arg2,GdkPixbuf_val,NULL) Ignore, Unit)
ML_2(gtk_status_icon_set_from_icon_name,GtkStatusIcon_val, String_val, Unit)
ML_1(gtk_status_icon_is_embedded,GtkStatusIcon_val, Val_bool)
ML_1(gtk_status_icon_get_x11_window_id,GtkStatusIcon_val, Val_int32)
ML_1(gtk_status_icon_get_visible,GtkStatusIcon_val, Val_bool)
ML_1(gtk_status_icon_get_tooltip_text,GtkStatusIcon_val, Val_string_new)
ML_1(gtk_status_icon_get_tooltip_markup,GtkStatusIcon_val, Val_string_new)
ML_1(gtk_status_icon_get_title,GtkStatusIcon_val, Val_string)
ML_1(gtk_status_icon_get_stock,GtkStatusIcon_val, Val_string)
ML_1(gtk_status_icon_get_size,GtkStatusIcon_val, Val_int)
ML_1(gtk_status_icon_get_screen,GtkStatusIcon_val, Val_GdkScreen)
ML_1(gtk_status_icon_get_pixbuf,GtkStatusIcon_val, Val_GdkPixbuf)
ML_1(gtk_status_icon_get_icon_name,GtkStatusIcon_val, Val_string)
ML_1(gtk_status_icon_get_has_tooltip,GtkStatusIcon_val, Val_bool)
/* end of StatusIcon */
/* Module SpinnerPrivate */
/* end of SpinnerPrivate */
/* Module SpinnerClass */
/* end of SpinnerClass */
/* Module Spinner */
ML_1(gtk_spinner_stop,GtkSpinner_val, Unit)
ML_1(gtk_spinner_start,GtkSpinner_val, Unit)
/* end of Spinner */
/* Module SpinButtonPrivate */
/* end of SpinButtonPrivate */
/* Module SpinButtonClass */
/* end of SpinButtonClass */
/* Module SpinButton */
ML_1(gtk_spin_button_update,GtkSpinButton_val, Unit)
ML_2(gtk_spin_button_set_wrap,GtkSpinButton_val, Bool_val, Unit)
ML_2(gtk_spin_button_set_value,GtkSpinButton_val, Double_val, Unit)
ML_2(gtk_spin_button_set_snap_to_ticks,GtkSpinButton_val, Bool_val, Unit)
ML_3(gtk_spin_button_set_range,GtkSpinButton_val, Double_val, Double_val, Unit)
ML_2(gtk_spin_button_set_numeric,GtkSpinButton_val, Bool_val, Unit)
ML_3(gtk_spin_button_set_increments,GtkSpinButton_val, Double_val, Double_val, Unit)
ML_2(gtk_spin_button_set_digits,GtkSpinButton_val, Int_val, Unit)
ML_2(gtk_spin_button_set_adjustment,GtkSpinButton_val, GtkAdjustment_val, Unit)
ML_1(gtk_spin_button_get_wrap,GtkSpinButton_val, Val_bool)
ML_1(gtk_spin_button_get_value_as_int,GtkSpinButton_val, Val_int)
ML_1(gtk_spin_button_get_value,GtkSpinButton_val, Val_double)
ML_1(gtk_spin_button_get_snap_to_ticks,GtkSpinButton_val, Val_bool)
ML_1(gtk_spin_button_get_numeric,GtkSpinButton_val, Val_bool)
ML_1(gtk_spin_button_get_digits,GtkSpinButton_val, Val_int)
ML_1(gtk_spin_button_get_adjustment,GtkSpinButton_val, Val_GtkAdjustment)
ML_4(gtk_spin_button_configure,GtkSpinButton_val, Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Double_val, Int_val, Unit)
/* end of SpinButton */
/* Module SocketPrivate */
/* end of SocketPrivate */
/* Module SocketClass */
/* end of SocketClass */
/* Module Socket */
ML_1(gtk_socket_get_plug_window,GtkSocket_val, Val_GdkWindow)
/* end of Socket */
/* Module SizeGroupPrivate */
/* end of SizeGroupPrivate */
/* Module SizeGroupClass */
/* end of SizeGroupClass */
/* Module SizeGroup */
ML_2(gtk_size_group_set_ignore_hidden,GtkSizeGroup_val, Bool_val, Unit)
ML_2(gtk_size_group_remove_widget,GtkSizeGroup_val, GtkWidget_val, Unit)
ML_1(gtk_size_group_get_widgets,GtkSizeGroup_val, Val_GSList)
ML_1(gtk_size_group_get_ignore_hidden,GtkSizeGroup_val, Val_bool)
ML_2(gtk_size_group_add_widget,GtkSizeGroup_val, GtkWidget_val, Unit)
/* end of SizeGroup */
/* Module SettingsValue */
/* end of SettingsValue */
/* Module SettingsPrivate */
/* end of SettingsPrivate */
/* Module SettingsClass */
/* end of SettingsClass */
/* Module Settings */
ML_4(gtk_settings_set_string_property,GtkSettings_val, String_val, String_val, String_val, Unit)
ML_3(gtk_settings_set_property_value,GtkSettings_val, String_val, GtkSettingsValue_val, Unit)
ML_4(gtk_settings_set_long_property,GtkSettings_val, String_val, Double_val, String_val, Unit)
ML_4(gtk_settings_set_double_property,GtkSettings_val, String_val, Double_val, String_val, Unit)
ML_1(gtk_settings_install_property,GParamSpec_val, Unit)
ML_1(gtk_settings_get_for_screen,GdkScreen_val, Val_GtkSettings)
ML_0(gtk_settings_get_default,Val_GtkSettings)
/* end of Settings */
/* Module SeparatorToolItemPrivate */
/* end of SeparatorToolItemPrivate */
/* Module SeparatorToolItemClass */
/* end of SeparatorToolItemClass */
/* Module SeparatorToolItem */
ML_2(gtk_separator_tool_item_set_draw,GtkSeparatorToolItem_val, Bool_val, Unit)
ML_1(gtk_separator_tool_item_get_draw,GtkSeparatorToolItem_val, Val_bool)
/* end of SeparatorToolItem */
/* Module SeparatorPrivate */
/* end of SeparatorPrivate */
/* Module SeparatorMenuItemClass */
/* end of SeparatorMenuItemClass */
/* Module SeparatorMenuItem */
/* end of SeparatorMenuItem */
/* Module SeparatorClass */
/* end of SeparatorClass */
/* Module Separator */
/* end of Separator */
/* Module SelectionData */
ML_1(gtk_selection_data_targets_include_uri,GtkSelectionData_val, Val_bool)
ML_1(gtk_selection_data_targets_include_text,GtkSelectionData_val, Val_bool)
ML_2(gtk_selection_data_targets_include_rich_text,GtkSelectionData_val, GtkTextBuffer_val, Val_bool)
ML_2(gtk_selection_data_targets_include_image,GtkSelectionData_val, Bool_val, Val_bool)
ML_3(gtk_selection_data_set_text,GtkSelectionData_val, String_val, Int_val, Val_bool)
ML_2(gtk_selection_data_set_pixbuf,GtkSelectionData_val, GdkPixbuf_val, Val_bool)
ML_1(gtk_selection_data_get_pixbuf,GtkSelectionData_val, Val_GdkPixbuf_new)
ML_1(gtk_selection_data_get_length,GtkSelectionData_val, Val_int)
ML_1(gtk_selection_data_get_format,GtkSelectionData_val, Val_int)
ML_1(gtk_selection_data_get_display,GtkSelectionData_val, Val_GdkDisplay)
ML_1(gtk_selection_data_get_data,GtkSelectionData_val, Val_string)
ML_1(gtk_selection_data_free,GtkSelectionData_val, Unit)
ML_1(gtk_selection_data_copy,GtkSelectionData_val, Val_GtkSelectionData_new)
/* end of SelectionData */
/* Module ScrolledWindowPrivate */
/* end of ScrolledWindowPrivate */
/* Module ScrolledWindowClass */
/* end of ScrolledWindowClass */
/* Module ScrolledWindow */
ML_1(gtk_scrolled_window_unset_placement,GtkScrolledWindow_val, Unit)
ML_2(gtk_scrolled_window_set_vadjustment,GtkScrolledWindow_val, GtkAdjustment_val, Unit)
ML_2(gtk_scrolled_window_set_min_content_width,GtkScrolledWindow_val, Int_val, Unit)
ML_2(gtk_scrolled_window_set_min_content_height,GtkScrolledWindow_val, Int_val, Unit)
ML_2(gtk_scrolled_window_set_hadjustment,GtkScrolledWindow_val, GtkAdjustment_val, Unit)
ML_1(gtk_scrolled_window_get_vscrollbar,GtkScrolledWindow_val, Val_GtkWidget)
ML_1(gtk_scrolled_window_get_vadjustment,GtkScrolledWindow_val, Val_GtkAdjustment)
ML_1(gtk_scrolled_window_get_min_content_width,GtkScrolledWindow_val, Val_int)
ML_1(gtk_scrolled_window_get_min_content_height,GtkScrolledWindow_val, Val_int)
ML_1(gtk_scrolled_window_get_hscrollbar,GtkScrolledWindow_val, Val_GtkWidget)
ML_1(gtk_scrolled_window_get_hadjustment,GtkScrolledWindow_val, Val_GtkAdjustment)
ML_2(gtk_scrolled_window_add_with_viewport,GtkScrolledWindow_val, GtkWidget_val, Unit)
/* end of ScrolledWindow */
/* Module ScrollbarClass */
/* end of ScrollbarClass */
/* Module Scrollbar */
/* end of Scrollbar */
/* Module ScrollableInterface */
/* end of ScrollableInterface */
/* Module ScalePrivate */
/* end of ScalePrivate */
/* Module ScaleClass */
/* end of ScaleClass */
/* Module ScaleButtonPrivate */
/* end of ScaleButtonPrivate */
/* Module ScaleButtonClass */
/* end of ScaleButtonClass */
/* Module ScaleButton */
ML_2(gtk_scale_button_set_value,GtkScaleButton_val, Double_val, Unit)
ML_2(gtk_scale_button_set_adjustment,GtkScaleButton_val, GtkAdjustment_val, Unit)
ML_1(gtk_scale_button_get_value,GtkScaleButton_val, Val_double)
ML_1(gtk_scale_button_get_popup,GtkScaleButton_val, Val_GtkWidget)
ML_1(gtk_scale_button_get_plus_button,GtkScaleButton_val, Val_GtkWidget)
ML_1(gtk_scale_button_get_minus_button,GtkScaleButton_val, Val_GtkWidget)
ML_1(gtk_scale_button_get_adjustment,GtkScaleButton_val, Val_GtkAdjustment)
/* end of ScaleButton */
/* Module Scale */
ML_2(gtk_scale_set_draw_value,GtkScale_val, Bool_val, Unit)
ML_2(gtk_scale_set_digits,GtkScale_val, Int_val, Unit)
ML_1(gtk_scale_get_layout,GtkScale_val, Val_PangoLayout)
ML_1(gtk_scale_get_draw_value,GtkScale_val, Val_bool)
ML_1(gtk_scale_get_digits,GtkScale_val, Val_int)
ML_1(gtk_scale_clear_marks,GtkScale_val, Unit)
/* end of Scale */
/* Module Requisition */
ML_1(gtk_requisition_free,GtkRequisition_val, Unit)
ML_1(gtk_requisition_copy,GtkRequisition_val, Val_GtkRequisition_new)
/* end of Requisition */
/* Module RequestedSize */
/* end of RequestedSize */
/* Module RecentManagerPrivate */
/* end of RecentManagerPrivate */
/* Module RecentManagerClass */
/* end of RecentManagerClass */
/* Module RecentManager */
ML_2(gtk_recent_manager_has_item,GtkRecentManager_val, String_val, Val_bool)
ML_1(gtk_recent_manager_get_items,GtkRecentManager_val, Val_GList_new)
ML_2(gtk_recent_manager_add_item,GtkRecentManager_val, String_val, Val_bool)
ML_3(gtk_recent_manager_add_full,GtkRecentManager_val, String_val, GtkRecentData_val, Val_bool)
ML_0(gtk_recent_manager_get_default,Val_GtkRecentManager)
/* end of RecentManager */
/* Module RecentInfo */
ML_1(gtk_recent_info_unref,GtkRecentInfo_val, Unit)
ML_1(gtk_recent_info_ref,GtkRecentInfo_val, Val_GtkRecentInfo_new)
ML_2(gtk_recent_info_match,GtkRecentInfo_val, GtkRecentInfo_val, Val_bool)
ML_1(gtk_recent_info_last_application,GtkRecentInfo_val, Val_string_new)
ML_1(gtk_recent_info_is_local,GtkRecentInfo_val, Val_bool)
ML_2(gtk_recent_info_has_group,GtkRecentInfo_val, String_val, Val_bool)
ML_2(gtk_recent_info_has_application,GtkRecentInfo_val, String_val, Val_bool)
ML_1(gtk_recent_info_get_uri_display,GtkRecentInfo_val, Val_string_new)
ML_1(gtk_recent_info_get_uri,GtkRecentInfo_val, Val_string)
ML_1(gtk_recent_info_get_short_name,GtkRecentInfo_val, Val_string_new)
ML_1(gtk_recent_info_get_private_hint,GtkRecentInfo_val, Val_bool)
ML_1(gtk_recent_info_get_mime_type,GtkRecentInfo_val, Val_string)
ML_2(gtk_recent_info_get_icon,GtkRecentInfo_val, Int_val, Val_GdkPixbuf_new)
ML_1(gtk_recent_info_get_display_name,GtkRecentInfo_val, Val_string)
ML_1(gtk_recent_info_get_description,GtkRecentInfo_val, Val_string)
ML_1(gtk_recent_info_get_age,GtkRecentInfo_val, Val_int)
ML_1(gtk_recent_info_exists,GtkRecentInfo_val, Val_bool)
/* end of RecentInfo */
/* Module RecentFilterInfo */
/* end of RecentFilterInfo */
/* Module RecentFilter */
ML_2(gtk_recent_filter_set_name,GtkRecentFilter_val, String_val, Unit)
ML_1(gtk_recent_filter_get_name,GtkRecentFilter_val, Val_string)
ML_2(gtk_recent_filter_filter,GtkRecentFilter_val, GtkRecentFilterInfo_val, Val_bool)
ML_1(gtk_recent_filter_add_pixbuf_formats,GtkRecentFilter_val, Unit)
ML_2(gtk_recent_filter_add_pattern,GtkRecentFilter_val, String_val, Unit)
ML_2(gtk_recent_filter_add_mime_type,GtkRecentFilter_val, String_val, Unit)
ML_2(gtk_recent_filter_add_group,GtkRecentFilter_val, String_val, Unit)
ML_2(gtk_recent_filter_add_application,GtkRecentFilter_val, String_val, Unit)
ML_2(gtk_recent_filter_add_age,GtkRecentFilter_val, Int_val, Unit)
/* end of RecentFilter */
/* Module RecentData */
/* end of RecentData */
/* Module RecentChooserWidgetPrivate */
/* end of RecentChooserWidgetPrivate */
/* Module RecentChooserWidgetClass */
/* end of RecentChooserWidgetClass */
/* Module RecentChooserWidget */
/* end of RecentChooserWidget */
/* Module RecentChooserMenuPrivate */
/* end of RecentChooserMenuPrivate */
/* Module RecentChooserMenuClass */
/* end of RecentChooserMenuClass */
/* Module RecentChooserMenu */
ML_2(gtk_recent_chooser_menu_set_show_numbers,GtkRecentChooserMenu_val, Bool_val, Unit)
ML_1(gtk_recent_chooser_menu_get_show_numbers,GtkRecentChooserMenu_val, Val_bool)
/* end of RecentChooserMenu */
/* Module RecentChooserIface */
/* end of RecentChooserIface */
/* Module RecentChooserDialogPrivate */
/* end of RecentChooserDialogPrivate */
/* Module RecentChooserDialogClass */
/* end of RecentChooserDialogClass */
/* Module RecentChooserDialog */
/* end of RecentChooserDialog */
/* Module RecentActionPrivate */
/* end of RecentActionPrivate */
/* Module RecentActionClass */
/* end of RecentActionClass */
/* Module RecentAction */
ML_2(gtk_recent_action_set_show_numbers,GtkRecentAction_val, Bool_val, Unit)
ML_1(gtk_recent_action_get_show_numbers,GtkRecentAction_val, Val_bool)
/* end of RecentAction */
/* Module RcStyleClass */
/* end of RcStyleClass */
/* Module RcStyle */
ML_1(gtk_rc_style_copy,GtkRcStyle_val, Val_GtkRcStyle_new)
/* end of RcStyle */
/* Module RcProperty */
/* end of RcProperty */
/* Module RcContext */
/* end of RcContext */
/* Module RangePrivate */
/* end of RangePrivate */
/* Module RangeClass */
/* end of RangeClass */
/* Module Range */
ML_2(gtk_range_set_value,GtkRange_val, Double_val, Unit)
ML_2(gtk_range_set_slider_size_fixed,GtkRange_val, Bool_val, Unit)
ML_2(gtk_range_set_show_fill_level,GtkRange_val, Bool_val, Unit)
ML_2(gtk_range_set_round_digits,GtkRange_val, Int_val, Unit)
ML_2(gtk_range_set_restrict_to_fill_level,GtkRange_val, Bool_val, Unit)
ML_3(gtk_range_set_range,GtkRange_val, Double_val, Double_val, Unit)
ML_2(gtk_range_set_min_slider_size,GtkRange_val, Int_val, Unit)
ML_2(gtk_range_set_inverted,GtkRange_val, Bool_val, Unit)
ML_3(gtk_range_set_increments,GtkRange_val, Double_val, Double_val, Unit)
ML_2(gtk_range_set_flippable,GtkRange_val, Bool_val, Unit)
ML_2(gtk_range_set_fill_level,GtkRange_val, Double_val, Unit)
ML_2(gtk_range_set_adjustment,GtkRange_val, GtkAdjustment_val, Unit)
ML_1(gtk_range_get_value,GtkRange_val, Val_double)
ML_1(gtk_range_get_slider_size_fixed,GtkRange_val, Val_bool)
ML_1(gtk_range_get_show_fill_level,GtkRange_val, Val_bool)
ML_1(gtk_range_get_round_digits,GtkRange_val, Val_int)
ML_1(gtk_range_get_restrict_to_fill_level,GtkRange_val, Val_bool)
ML_1(gtk_range_get_min_slider_size,GtkRange_val, Val_int)
ML_1(gtk_range_get_inverted,GtkRange_val, Val_bool)
ML_1(gtk_range_get_flippable,GtkRange_val, Val_bool)
ML_1(gtk_range_get_fill_level,GtkRange_val, Val_double)
ML_1(gtk_range_get_event_window,GtkRange_val, Val_GdkWindow)
ML_1(gtk_range_get_adjustment,GtkRange_val, Val_GtkAdjustment)
/* end of Range */
/* Module RadioToolButtonClass */
/* end of RadioToolButtonClass */
/* Module RadioToolButton */
ML_2(gtk_radio_tool_button_set_group,GtkRadioToolButton_val, GSList_val, Unit)
ML_2(gtk_radio_tool_button_new_with_stock_from_widget,GtkRadioToolButton_val, String_val, Val_GtkToolItem)
ML_1(gtk_radio_tool_button_new_from_widget,GtkRadioToolButton_val, Val_GtkToolItem)
ML_1(gtk_radio_tool_button_get_group,GtkRadioToolButton_val, Val_GSList)
/* end of RadioToolButton */
/* Module RadioMenuItemPrivate */
/* end of RadioMenuItemPrivate */
/* Module RadioMenuItemClass */
/* end of RadioMenuItemClass */
/* Module RadioMenuItem */
ML_2(gtk_radio_menu_item_set_group,GtkRadioMenuItem_val, GSList_val, Unit)
ML_2(gtk_radio_menu_item_new_with_mnemonic_from_widget,GtkRadioMenuItem_val, String_val, Val_GtkWidget)
ML_2(gtk_radio_menu_item_new_with_label_from_widget,GtkRadioMenuItem_val, String_val, Val_GtkWidget)
ML_1(gtk_radio_menu_item_new_from_widget,GtkRadioMenuItem_val, Val_GtkWidget)
ML_1(gtk_radio_menu_item_get_group,GtkRadioMenuItem_val, Val_GSList)
/* end of RadioMenuItem */
/* Module RadioButtonPrivate */
/* end of RadioButtonPrivate */
/* Module RadioButtonClass */
/* end of RadioButtonClass */
/* Module RadioButton */
ML_2(gtk_radio_button_set_group,GtkRadioButton_val, GSList_val, Unit)
ML_1(gtk_radio_button_new_from_widget,GtkRadioButton_val, Val_GtkWidget)
ML_2(gtk_radio_button_join_group,GtkRadioButton_val, Option_val(arg2,GtkRadioButton_val,NULL) Ignore, Unit)
ML_1(gtk_radio_button_get_group,GtkRadioButton_val, Val_GSList)
/* end of RadioButton */
/* Module RadioActionPrivate */
/* end of RadioActionPrivate */
/* Module RadioActionEntry */
/* end of RadioActionEntry */
/* Module RadioActionClass */
/* end of RadioActionClass */
/* Module RadioAction */
ML_2(gtk_radio_action_set_group,GtkRadioAction_val, GSList_val, Unit)
ML_2(gtk_radio_action_set_current_value,GtkRadioAction_val, Int_val, Unit)
ML_2(gtk_radio_action_join_group,GtkRadioAction_val, Option_val(arg2,GtkRadioAction_val,NULL) Ignore, Unit)
ML_1(gtk_radio_action_get_group,GtkRadioAction_val, Val_GSList)
ML_1(gtk_radio_action_get_current_value,GtkRadioAction_val, Val_int)
/* end of RadioAction */
/* Module ProgressBarPrivate */
/* end of ProgressBarPrivate */
/* Module ProgressBarClass */
/* end of ProgressBarClass */
/* Module ProgressBar */
ML_2(gtk_progress_bar_set_text,GtkProgressBar_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_progress_bar_set_show_text,GtkProgressBar_val, Bool_val, Unit)
ML_2(gtk_progress_bar_set_pulse_step,GtkProgressBar_val, Double_val, Unit)
ML_2(gtk_progress_bar_set_inverted,GtkProgressBar_val, Bool_val, Unit)
ML_2(gtk_progress_bar_set_fraction,GtkProgressBar_val, Double_val, Unit)
ML_1(gtk_progress_bar_pulse,GtkProgressBar_val, Unit)
ML_1(gtk_progress_bar_get_text,GtkProgressBar_val, Val_string)
ML_1(gtk_progress_bar_get_show_text,GtkProgressBar_val, Val_bool)
ML_1(gtk_progress_bar_get_pulse_step,GtkProgressBar_val, Val_double)
ML_1(gtk_progress_bar_get_inverted,GtkProgressBar_val, Val_bool)
ML_1(gtk_progress_bar_get_fraction,GtkProgressBar_val, Val_double)
/* end of ProgressBar */
/* Module PrintSettings */
ML_2(gtk_print_settings_unset,GtkPrintSettings_val, String_val, Unit)
ML_3(gtk_print_settings_to_key_file,GtkPrintSettings_val, GKeyFile_val, String_val, Unit)
ML_2(gtk_print_settings_set_use_color,GtkPrintSettings_val, Bool_val, Unit)
ML_2(gtk_print_settings_set_scale,GtkPrintSettings_val, Double_val, Unit)
ML_2(gtk_print_settings_set_reverse,GtkPrintSettings_val, Bool_val, Unit)
ML_3(gtk_print_settings_set_resolution_xy,GtkPrintSettings_val, Int_val, Int_val, Unit)
ML_2(gtk_print_settings_set_resolution,GtkPrintSettings_val, Int_val, Unit)
ML_2(gtk_print_settings_set_printer_lpi,GtkPrintSettings_val, Double_val, Unit)
ML_2(gtk_print_settings_set_printer,GtkPrintSettings_val, String_val, Unit)
ML_2(gtk_print_settings_set_paper_size,GtkPrintSettings_val, GtkPaperSize_val, Unit)
ML_2(gtk_print_settings_set_output_bin,GtkPrintSettings_val, String_val, Unit)
ML_2(gtk_print_settings_set_number_up,GtkPrintSettings_val, Int_val, Unit)
ML_2(gtk_print_settings_set_n_copies,GtkPrintSettings_val, Int_val, Unit)
ML_2(gtk_print_settings_set_media_type,GtkPrintSettings_val, String_val, Unit)
ML_3(gtk_print_settings_set_int,GtkPrintSettings_val, String_val, Int_val, Unit)
ML_2(gtk_print_settings_set_finishings,GtkPrintSettings_val, String_val, Unit)
ML_3(gtk_print_settings_set_double,GtkPrintSettings_val, String_val, Double_val, Unit)
ML_2(gtk_print_settings_set_dither,GtkPrintSettings_val, String_val, Unit)
ML_2(gtk_print_settings_set_default_source,GtkPrintSettings_val, String_val, Unit)
ML_2(gtk_print_settings_set_collate,GtkPrintSettings_val, Bool_val, Unit)
ML_3(gtk_print_settings_set_bool,GtkPrintSettings_val, String_val, Bool_val, Unit)
ML_3(gtk_print_settings_set,GtkPrintSettings_val, String_val, Option_val(arg3,String_val,NULL) Ignore, Unit)
ML_2(gtk_print_settings_has_key,GtkPrintSettings_val, String_val, Val_bool)
ML_1(gtk_print_settings_get_use_color,GtkPrintSettings_val, Val_bool)
ML_1(gtk_print_settings_get_scale,GtkPrintSettings_val, Val_double)
ML_1(gtk_print_settings_get_reverse,GtkPrintSettings_val, Val_bool)
ML_1(gtk_print_settings_get_resolution_y,GtkPrintSettings_val, Val_int)
ML_1(gtk_print_settings_get_resolution_x,GtkPrintSettings_val, Val_int)
ML_1(gtk_print_settings_get_resolution,GtkPrintSettings_val, Val_int)
ML_1(gtk_print_settings_get_printer_lpi,GtkPrintSettings_val, Val_double)
ML_1(gtk_print_settings_get_printer,GtkPrintSettings_val, Val_string)
ML_1(gtk_print_settings_get_paper_size,GtkPrintSettings_val, Val_GtkPaperSize_new)
ML_1(gtk_print_settings_get_output_bin,GtkPrintSettings_val, Val_string)
ML_1(gtk_print_settings_get_number_up,GtkPrintSettings_val, Val_int)
ML_1(gtk_print_settings_get_n_copies,GtkPrintSettings_val, Val_int)
ML_1(gtk_print_settings_get_media_type,GtkPrintSettings_val, Val_string)
ML_3(gtk_print_settings_get_int_with_default,GtkPrintSettings_val, String_val, Int_val, Val_int)
ML_2(gtk_print_settings_get_int,GtkPrintSettings_val, String_val, Val_int)
ML_1(gtk_print_settings_get_finishings,GtkPrintSettings_val, Val_string)
ML_3(gtk_print_settings_get_double_with_default,GtkPrintSettings_val, String_val, Double_val, Val_double)
ML_2(gtk_print_settings_get_double,GtkPrintSettings_val, String_val, Val_double)
ML_1(gtk_print_settings_get_dither,GtkPrintSettings_val, Val_string)
ML_1(gtk_print_settings_get_default_source,GtkPrintSettings_val, Val_string)
ML_1(gtk_print_settings_get_collate,GtkPrintSettings_val, Val_bool)
ML_2(gtk_print_settings_get_bool,GtkPrintSettings_val, String_val, Val_bool)
ML_2(gtk_print_settings_get,GtkPrintSettings_val, String_val, Val_string)
ML_1(gtk_print_settings_copy,GtkPrintSettings_val, Val_GtkPrintSettings_new)
/* end of PrintSettings */
/* Module PrintOperationPrivate */
/* end of PrintOperationPrivate */
/* Module PrintOperationPreviewIface */
/* end of PrintOperationPreviewIface */
/* Module PrintOperationClass */
/* end of PrintOperationClass */
/* Module PrintOperation */
ML_2(gtk_print_operation_set_use_full_page,GtkPrintOperation_val, Bool_val, Unit)
ML_2(gtk_print_operation_set_track_print_status,GtkPrintOperation_val, Bool_val, Unit)
ML_2(gtk_print_operation_set_support_selection,GtkPrintOperation_val, Bool_val, Unit)
ML_2(gtk_print_operation_set_show_progress,GtkPrintOperation_val, Bool_val, Unit)
ML_2(gtk_print_operation_set_print_settings,GtkPrintOperation_val, Option_val(arg2,GtkPrintSettings_val,NULL) Ignore, Unit)
ML_2(gtk_print_operation_set_n_pages,GtkPrintOperation_val, Int_val, Unit)
ML_2(gtk_print_operation_set_job_name,GtkPrintOperation_val, String_val, Unit)
ML_2(gtk_print_operation_set_has_selection,GtkPrintOperation_val, Bool_val, Unit)
ML_2(gtk_print_operation_set_embed_page_setup,GtkPrintOperation_val, Bool_val, Unit)
ML_1(gtk_print_operation_set_defer_drawing,GtkPrintOperation_val, Unit)
ML_2(gtk_print_operation_set_default_page_setup,GtkPrintOperation_val, Option_val(arg2,GtkPageSetup_val,NULL) Ignore, Unit)
ML_2(gtk_print_operation_set_custom_tab_label,GtkPrintOperation_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_print_operation_set_current_page,GtkPrintOperation_val, Int_val, Unit)
ML_2(gtk_print_operation_set_allow_async,GtkPrintOperation_val, Bool_val, Unit)
ML_1(gtk_print_operation_is_finished,GtkPrintOperation_val, Val_bool)
ML_1(gtk_print_operation_get_support_selection,GtkPrintOperation_val, Val_bool)
ML_1(gtk_print_operation_get_status_string,GtkPrintOperation_val, Val_string)
ML_1(gtk_print_operation_get_print_settings,GtkPrintOperation_val, Val_GtkPrintSettings)
ML_1(gtk_print_operation_get_n_pages_to_print,GtkPrintOperation_val, Val_int)
ML_1(gtk_print_operation_get_has_selection,GtkPrintOperation_val, Val_bool)
ML_1(gtk_print_operation_get_embed_page_setup,GtkPrintOperation_val, Val_bool)
ML_1(gtk_print_operation_get_default_page_setup,GtkPrintOperation_val, Val_GtkPageSetup)
ML_1(gtk_print_operation_draw_page_finish,GtkPrintOperation_val, Unit)
ML_1(gtk_print_operation_cancel,GtkPrintOperation_val, Unit)
/* end of PrintOperation */
/* Module PrintContext */
ML_4(gtk_print_context_set_cairo_context,GtkPrintContext_val, cairo_t_val, Double_val, Double_val, Unit)
ML_1(gtk_print_context_get_width,GtkPrintContext_val, Val_double)
ML_1(gtk_print_context_get_pango_fontmap,GtkPrintContext_val, Val_PangoFontMap)
ML_1(gtk_print_context_get_page_setup,GtkPrintContext_val, Val_GtkPageSetup)
ML_1(gtk_print_context_get_height,GtkPrintContext_val, Val_double)
ML_1(gtk_print_context_get_dpi_y,GtkPrintContext_val, Val_double)
ML_1(gtk_print_context_get_dpi_x,GtkPrintContext_val, Val_double)
ML_1(gtk_print_context_get_cairo_context,GtkPrintContext_val, Val_cairo_t)
ML_1(gtk_print_context_create_pango_layout,GtkPrintContext_val, Val_PangoLayout_new)
ML_1(gtk_print_context_create_pango_context,GtkPrintContext_val, Val_PangoContext_new)
/* end of PrintContext */
/* Module PlugPrivate */
/* end of PlugPrivate */
/* Module PlugClass */
/* end of PlugClass */
/* Module Plug */
ML_1(gtk_plug_get_socket_window,GtkPlug_val, Val_GdkWindow)
ML_1(gtk_plug_get_embedded,GtkPlug_val, Val_bool)
/* end of Plug */
/* Module PaperSize */
ML_3(gtk_paper_size_to_key_file,GtkPaperSize_val, GKeyFile_val, String_val, Unit)
ML_2(gtk_paper_size_is_equal,GtkPaperSize_val, GtkPaperSize_val, Val_bool)
ML_1(gtk_paper_size_is_custom,GtkPaperSize_val, Val_bool)
ML_1(gtk_paper_size_get_ppd_name,GtkPaperSize_val, Val_string)
ML_1(gtk_paper_size_get_name,GtkPaperSize_val, Val_string)
ML_1(gtk_paper_size_get_display_name,GtkPaperSize_val, Val_string)
ML_1(gtk_paper_size_free,GtkPaperSize_val, Unit)
ML_1(gtk_paper_size_copy,GtkPaperSize_val, Val_GtkPaperSize_new)
/* end of PaperSize */
/* Module PanedPrivate */
/* end of PanedPrivate */
/* Module PanedClass */
/* end of PanedClass */
/* Module Paned */
ML_2(gtk_paned_set_position,GtkPaned_val, Int_val, Unit)
ML_4(gtk_paned_pack2,GtkPaned_val, GtkWidget_val, Bool_val, Bool_val, Unit)
ML_4(gtk_paned_pack1,GtkPaned_val, GtkWidget_val, Bool_val, Bool_val, Unit)
ML_1(gtk_paned_get_position,GtkPaned_val, Val_int)
ML_1(gtk_paned_get_handle_window,GtkPaned_val, Val_GdkWindow)
ML_1(gtk_paned_get_child2,GtkPaned_val, Val_GtkWidget)
ML_1(gtk_paned_get_child1,GtkPaned_val, Val_GtkWidget)
ML_2(gtk_paned_add2,GtkPaned_val, GtkWidget_val, Unit)
ML_2(gtk_paned_add1,GtkPaned_val, GtkWidget_val, Unit)
/* end of Paned */
/* Module PageSetup */
ML_3(gtk_page_setup_to_key_file,GtkPageSetup_val, GKeyFile_val, String_val, Unit)
ML_2(gtk_page_setup_set_paper_size_and_default_margins,GtkPageSetup_val, GtkPaperSize_val, Unit)
ML_2(gtk_page_setup_set_paper_size,GtkPageSetup_val, GtkPaperSize_val, Unit)
ML_1(gtk_page_setup_get_paper_size,GtkPageSetup_val, Val_GtkPaperSize_new)
ML_1(gtk_page_setup_copy,GtkPageSetup_val, Val_GtkPageSetup_new)
/* end of PageSetup */
/* Module PageRange */
/* end of PageRange */
/* Module OrientableIface */
/* end of OrientableIface */
/* Module OffscreenWindowClass */
/* end of OffscreenWindowClass */
/* Module OffscreenWindow */
ML_1(gtk_offscreen_window_get_surface,GtkOffscreenWindow_val, Val_cairo_surface_t)
ML_1(gtk_offscreen_window_get_pixbuf,GtkOffscreenWindow_val, Val_GdkPixbuf_new)
/* end of OffscreenWindow */
/* Module NumerableIconPrivate */
/* end of NumerableIconPrivate */
/* Module NumerableIconClass */
/* end of NumerableIconClass */
/* Module NumerableIcon */
ML_2(gtk_numerable_icon_set_style_context,GtkNumerableIcon_val, GtkStyleContext_val, Unit)
ML_2(gtk_numerable_icon_set_label,GtkNumerableIcon_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_numerable_icon_set_count,GtkNumerableIcon_val, Int_val, Unit)
ML_2(gtk_numerable_icon_set_background_icon_name,GtkNumerableIcon_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_1(gtk_numerable_icon_get_style_context,GtkNumerableIcon_val, Val_GtkStyleContext)
ML_1(gtk_numerable_icon_get_label,GtkNumerableIcon_val, Val_string)
ML_1(gtk_numerable_icon_get_count,GtkNumerableIcon_val, Val_int)
ML_1(gtk_numerable_icon_get_background_icon_name,GtkNumerableIcon_val, Val_string)
/* end of NumerableIcon */
/* Module NotebookPrivate */
/* end of NotebookPrivate */
/* Module NotebookClass */
/* end of NotebookClass */
/* Module Notebook */
ML_3(gtk_notebook_set_tab_reorderable,GtkNotebook_val, GtkWidget_val, Bool_val, Unit)
ML_3(gtk_notebook_set_tab_label_text,GtkNotebook_val, GtkWidget_val, String_val, Unit)
ML_3(gtk_notebook_set_tab_label,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Unit)
ML_3(gtk_notebook_set_tab_detachable,GtkNotebook_val, GtkWidget_val, Bool_val, Unit)
ML_2(gtk_notebook_set_show_tabs,GtkNotebook_val, Bool_val, Unit)
ML_2(gtk_notebook_set_show_border,GtkNotebook_val, Bool_val, Unit)
ML_2(gtk_notebook_set_scrollable,GtkNotebook_val, Bool_val, Unit)
ML_3(gtk_notebook_set_menu_label_text,GtkNotebook_val, GtkWidget_val, String_val, Unit)
ML_3(gtk_notebook_set_menu_label,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_notebook_set_group_name,GtkNotebook_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_notebook_set_current_page,GtkNotebook_val, Int_val, Unit)
ML_3(gtk_notebook_reorder_child,GtkNotebook_val, GtkWidget_val, Int_val, Unit)
ML_2(gtk_notebook_remove_page,GtkNotebook_val, Int_val, Unit)
ML_1(gtk_notebook_prev_page,GtkNotebook_val, Unit)
ML_4(gtk_notebook_prepend_page_menu,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Option_val(arg4,GtkWidget_val,NULL) Ignore, Val_int)
ML_3(gtk_notebook_prepend_page,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Val_int)
ML_1(gtk_notebook_popup_enable,GtkNotebook_val, Unit)
ML_1(gtk_notebook_popup_disable,GtkNotebook_val, Unit)
ML_2(gtk_notebook_page_num,GtkNotebook_val, GtkWidget_val, Val_int)
ML_1(gtk_notebook_next_page,GtkNotebook_val, Unit)
ML_5(gtk_notebook_insert_page_menu,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Option_val(arg4,GtkWidget_val,NULL) Ignore, Int_val, Val_int)
ML_4(gtk_notebook_insert_page,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Int_val, Val_int)
ML_1(gtk_notebook_get_tab_vborder,GtkNotebook_val, Val_int)
ML_2(gtk_notebook_get_tab_reorderable,GtkNotebook_val, GtkWidget_val, Val_bool)
ML_2(gtk_notebook_get_tab_label_text,GtkNotebook_val, GtkWidget_val, Val_string)
ML_2(gtk_notebook_get_tab_label,GtkNotebook_val, GtkWidget_val, Val_GtkWidget)
ML_1(gtk_notebook_get_tab_hborder,GtkNotebook_val, Val_int)
ML_2(gtk_notebook_get_tab_detachable,GtkNotebook_val, GtkWidget_val, Val_bool)
ML_1(gtk_notebook_get_show_tabs,GtkNotebook_val, Val_bool)
ML_1(gtk_notebook_get_show_border,GtkNotebook_val, Val_bool)
ML_1(gtk_notebook_get_scrollable,GtkNotebook_val, Val_bool)
ML_2(gtk_notebook_get_nth_page,GtkNotebook_val, Int_val, Val_GtkWidget)
ML_1(gtk_notebook_get_n_pages,GtkNotebook_val, Val_int)
ML_2(gtk_notebook_get_menu_label_text,GtkNotebook_val, GtkWidget_val, Val_string)
ML_2(gtk_notebook_get_menu_label,GtkNotebook_val, GtkWidget_val, Val_GtkWidget)
ML_1(gtk_notebook_get_group_name,GtkNotebook_val, Val_string)
ML_1(gtk_notebook_get_current_page,GtkNotebook_val, Val_int)
ML_4(gtk_notebook_append_page_menu,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Option_val(arg4,GtkWidget_val,NULL) Ignore, Val_int)
ML_3(gtk_notebook_append_page,GtkNotebook_val, GtkWidget_val, Option_val(arg3,GtkWidget_val,NULL) Ignore, Val_int)
/* end of Notebook */
/* Module MountOperationPrivate */
/* end of MountOperationPrivate */
/* Module MountOperationClass */
/* end of MountOperationClass */
/* Module MountOperation */
ML_2(gtk_mount_operation_set_screen,GtkMountOperation_val, GdkScreen_val, Unit)
ML_2(gtk_mount_operation_set_parent,GtkMountOperation_val, Option_val(arg2,GtkWindow_val,NULL) Ignore, Unit)
ML_1(gtk_mount_operation_is_showing,GtkMountOperation_val, Val_bool)
ML_1(gtk_mount_operation_get_screen,GtkMountOperation_val, Val_GdkScreen)
ML_1(gtk_mount_operation_get_parent,GtkMountOperation_val, Val_GtkWindow)
/* end of MountOperation */
/* Module MiscPrivate */
/* end of MiscPrivate */
/* Module MiscClass */
/* end of MiscClass */
/* Module Misc */
ML_3(gtk_misc_set_padding,GtkMisc_val, Int_val, Int_val, Unit)
/* end of Misc */
/* Module MessageDialogPrivate */
/* end of MessageDialogPrivate */
/* Module MessageDialogClass */
/* end of MessageDialogClass */
/* Module MessageDialog */
ML_2(gtk_message_dialog_set_markup,GtkMessageDialog_val, String_val, Unit)
ML_2(gtk_message_dialog_set_image,GtkMessageDialog_val, GtkWidget_val, Unit)
ML_1(gtk_message_dialog_get_message_area,GtkMessageDialog_val, Val_GtkWidget)
ML_1(gtk_message_dialog_get_image,GtkMessageDialog_val, Val_GtkWidget)
/* end of MessageDialog */
/* Module MenuToolButtonPrivate */
/* end of MenuToolButtonPrivate */
/* Module MenuToolButtonClass */
/* end of MenuToolButtonClass */
/* Module MenuToolButton */
ML_2(gtk_menu_tool_button_set_menu,GtkMenuToolButton_val, GtkWidget_val, Unit)
ML_2(gtk_menu_tool_button_set_arrow_tooltip_text,GtkMenuToolButton_val, String_val, Unit)
ML_2(gtk_menu_tool_button_set_arrow_tooltip_markup,GtkMenuToolButton_val, String_val, Unit)
ML_1(gtk_menu_tool_button_get_menu,GtkMenuToolButton_val, Val_GtkWidget)
/* end of MenuToolButton */
/* Module MenuShellPrivate */
/* end of MenuShellPrivate */
/* Module MenuShellClass */
/* end of MenuShellClass */
/* Module MenuShell */
ML_2(gtk_menu_shell_set_take_focus,GtkMenuShell_val, Bool_val, Unit)
ML_2(gtk_menu_shell_select_item,GtkMenuShell_val, GtkWidget_val, Unit)
ML_2(gtk_menu_shell_select_first,GtkMenuShell_val, Bool_val, Unit)
ML_2(gtk_menu_shell_prepend,GtkMenuShell_val, GtkWidget_val, Unit)
ML_3(gtk_menu_shell_insert,GtkMenuShell_val, GtkWidget_val, Int_val, Unit)
ML_1(gtk_menu_shell_get_take_focus,GtkMenuShell_val, Val_bool)
ML_1(gtk_menu_shell_get_selected_item,GtkMenuShell_val, Val_GtkWidget)
ML_1(gtk_menu_shell_get_parent_shell,GtkMenuShell_val, Val_GtkWidget)
ML_1(gtk_menu_shell_deselect,GtkMenuShell_val, Unit)
ML_1(gtk_menu_shell_deactivate,GtkMenuShell_val, Unit)
ML_1(gtk_menu_shell_cancel,GtkMenuShell_val, Unit)
ML_2(gtk_menu_shell_append,GtkMenuShell_val, GtkWidget_val, Unit)
ML_3(gtk_menu_shell_activate_item,GtkMenuShell_val, GtkWidget_val, Bool_val, Unit)
/* end of MenuShell */
/* Module MenuPrivate */
/* end of MenuPrivate */
/* Module MenuItemPrivate */
/* end of MenuItemPrivate */
/* Module MenuItemClass */
/* end of MenuItemClass */
/* Module MenuItem */
ML_2(gtk_menu_item_toggle_size_allocate,GtkMenuItem_val, Int_val, Unit)
ML_2(gtk_menu_item_set_use_underline,GtkMenuItem_val, Bool_val, Unit)
ML_2(gtk_menu_item_set_submenu,GtkMenuItem_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_menu_item_set_right_justified,GtkMenuItem_val, Bool_val, Unit)
ML_2(gtk_menu_item_set_reserve_indicator,GtkMenuItem_val, Bool_val, Unit)
ML_2(gtk_menu_item_set_label,GtkMenuItem_val, String_val, Unit)
ML_2(gtk_menu_item_set_accel_path,GtkMenuItem_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_1(gtk_menu_item_select,GtkMenuItem_val, Unit)
ML_1(gtk_menu_item_get_use_underline,GtkMenuItem_val, Val_bool)
ML_1(gtk_menu_item_get_submenu,GtkMenuItem_val, Val_GtkWidget)
ML_1(gtk_menu_item_get_right_justified,GtkMenuItem_val, Val_bool)
ML_1(gtk_menu_item_get_reserve_indicator,GtkMenuItem_val, Val_bool)
ML_1(gtk_menu_item_get_label,GtkMenuItem_val, Val_string)
ML_1(gtk_menu_item_get_accel_path,GtkMenuItem_val, Val_string)
ML_1(gtk_menu_item_deselect,GtkMenuItem_val, Unit)
ML_1(gtk_menu_item_activate,GtkMenuItem_val, Unit)
/* end of MenuItem */
/* Module MenuClass */
/* end of MenuClass */
/* Module MenuBarPrivate */
/* end of MenuBarPrivate */
/* Module MenuBarClass */
/* end of MenuBarClass */
/* Module MenuBar */
/* end of MenuBar */
/* Module Menu */
ML_2(gtk_menu_set_title,GtkMenu_val, String_val, Unit)
ML_2(gtk_menu_set_tearoff_state,GtkMenu_val, Bool_val, Unit)
ML_2(gtk_menu_set_screen,GtkMenu_val, Option_val(arg2,GdkScreen_val,NULL) Ignore, Unit)
ML_2(gtk_menu_set_reserve_toggle_size,GtkMenu_val, Bool_val, Unit)
ML_2(gtk_menu_set_monitor,GtkMenu_val, Int_val, Unit)
ML_2(gtk_menu_set_active,GtkMenu_val, Int_val, Unit)
ML_2(gtk_menu_set_accel_path,GtkMenu_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_menu_set_accel_group,GtkMenu_val, Option_val(arg2,GtkAccelGroup_val,NULL) Ignore, Unit)
ML_1(gtk_menu_reposition,GtkMenu_val, Unit)
ML_3(gtk_menu_reorder_child,GtkMenu_val, GtkWidget_val, Int_val, Unit)
ML_1(gtk_menu_popdown,GtkMenu_val, Unit)
ML_1(gtk_menu_get_title,GtkMenu_val, Val_string)
ML_1(gtk_menu_get_tearoff_state,GtkMenu_val, Val_bool)
ML_1(gtk_menu_get_reserve_toggle_size,GtkMenu_val, Val_bool)
ML_1(gtk_menu_get_monitor,GtkMenu_val, Val_int)
ML_1(gtk_menu_get_attach_widget,GtkMenu_val, Val_GtkWidget)
ML_1(gtk_menu_get_active,GtkMenu_val, Val_GtkWidget)
ML_1(gtk_menu_get_accel_path,GtkMenu_val, Val_string)
ML_1(gtk_menu_get_accel_group,GtkMenu_val, Val_GtkAccelGroup)
ML_1(gtk_menu_detach,GtkMenu_val, Unit)
ML_6(gtk_menu_attach,GtkMenu_val, GtkWidget_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc6(ml_gtk_menu_attach)
ML_1(gtk_menu_get_for_attach_widget,GtkWidget_val, Val_GList)
/* end of Menu */
/* Module ListStorePrivate */
/* end of ListStorePrivate */
/* Module ListStoreClass */
/* end of ListStoreClass */
/* Module ListStore */
ML_3(gtk_list_store_swap,GtkListStore_val, GtkTreeIter_val, GtkTreeIter_val, Unit)
ML_4(gtk_list_store_set_value,GtkListStore_val, GtkTreeIter_val, Int_val, GValue_val, Unit)
ML_2(gtk_list_store_remove,GtkListStore_val, GtkTreeIter_val, Val_bool)
ML_3(gtk_list_store_move_before,GtkListStore_val, GtkTreeIter_val, Option_val(arg3,GtkTreeIter_val,NULL) Ignore, Unit)
ML_3(gtk_list_store_move_after,GtkListStore_val, GtkTreeIter_val, Option_val(arg3,GtkTreeIter_val,NULL) Ignore, Unit)
ML_2(gtk_list_store_iter_is_valid,GtkListStore_val, GtkTreeIter_val, Val_bool)
ML_1(gtk_list_store_clear,GtkListStore_val, Unit)
/* end of ListStore */
/* Module LinkButtonPrivate */
/* end of LinkButtonPrivate */
/* Module LinkButtonClass */
/* end of LinkButtonClass */
/* Module LinkButton */
ML_2(gtk_link_button_set_visited,GtkLinkButton_val, Bool_val, Unit)
ML_2(gtk_link_button_set_uri,GtkLinkButton_val, String_val, Unit)
ML_1(gtk_link_button_get_visited,GtkLinkButton_val, Val_bool)
ML_1(gtk_link_button_get_uri,GtkLinkButton_val, Val_string)
/* end of LinkButton */
/* Module LayoutPrivate */
/* end of LayoutPrivate */
/* Module LayoutClass */
/* end of LayoutClass */
/* Module Layout */
ML_2(gtk_layout_set_vadjustment,GtkLayout_val, Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Unit)
ML_3(gtk_layout_set_size,GtkLayout_val, Int_val, Int_val, Unit)
ML_2(gtk_layout_set_hadjustment,GtkLayout_val, Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Unit)
ML_4(gtk_layout_put,GtkLayout_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_4(gtk_layout_move,GtkLayout_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_1(gtk_layout_get_vadjustment,GtkLayout_val, Val_GtkAdjustment)
ML_1(gtk_layout_get_hadjustment,GtkLayout_val, Val_GtkAdjustment)
ML_1(gtk_layout_get_bin_window,GtkLayout_val, Val_GdkWindow)
/* end of Layout */
/* Module LabelSelectionInfo */
/* end of LabelSelectionInfo */
/* Module LabelPrivate */
/* end of LabelPrivate */
/* Module LabelClass */
/* end of LabelClass */
/* Module Label */
ML_2(gtk_label_set_width_chars,GtkLabel_val, Int_val, Unit)
ML_2(gtk_label_set_use_underline,GtkLabel_val, Bool_val, Unit)
ML_2(gtk_label_set_use_markup,GtkLabel_val, Bool_val, Unit)
ML_2(gtk_label_set_track_visited_links,GtkLabel_val, Bool_val, Unit)
ML_2(gtk_label_set_text_with_mnemonic,GtkLabel_val, String_val, Unit)
ML_2(gtk_label_set_text,GtkLabel_val, String_val, Unit)
ML_2(gtk_label_set_single_line_mode,GtkLabel_val, Bool_val, Unit)
ML_2(gtk_label_set_selectable,GtkLabel_val, Bool_val, Unit)
ML_2(gtk_label_set_pattern,GtkLabel_val, String_val, Unit)
ML_2(gtk_label_set_mnemonic_widget,GtkLabel_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_label_set_max_width_chars,GtkLabel_val, Int_val, Unit)
ML_2(gtk_label_set_markup_with_mnemonic,GtkLabel_val, String_val, Unit)
ML_2(gtk_label_set_markup,GtkLabel_val, String_val, Unit)
ML_2(gtk_label_set_line_wrap,GtkLabel_val, Bool_val, Unit)
ML_2(gtk_label_set_label,GtkLabel_val, String_val, Unit)
ML_2(gtk_label_set_attributes,GtkLabel_val, PangoAttrList_val, Unit)
ML_2(gtk_label_set_angle,GtkLabel_val, Double_val, Unit)
ML_3(gtk_label_select_region,GtkLabel_val, Int_val, Int_val, Unit)
ML_1(gtk_label_get_width_chars,GtkLabel_val, Val_int)
ML_1(gtk_label_get_use_underline,GtkLabel_val, Val_bool)
ML_1(gtk_label_get_use_markup,GtkLabel_val, Val_bool)
ML_1(gtk_label_get_track_visited_links,GtkLabel_val, Val_bool)
ML_1(gtk_label_get_text,GtkLabel_val, Val_string)
ML_1(gtk_label_get_single_line_mode,GtkLabel_val, Val_bool)
ML_1(gtk_label_get_selectable,GtkLabel_val, Val_bool)
ML_1(gtk_label_get_mnemonic_widget,GtkLabel_val, Val_GtkWidget)
ML_1(gtk_label_get_mnemonic_keyval,GtkLabel_val, Val_int)
ML_1(gtk_label_get_max_width_chars,GtkLabel_val, Val_int)
ML_1(gtk_label_get_line_wrap,GtkLabel_val, Val_bool)
ML_1(gtk_label_get_layout,GtkLabel_val, Val_PangoLayout)
ML_1(gtk_label_get_label,GtkLabel_val, Val_string)
ML_1(gtk_label_get_current_uri,GtkLabel_val, Val_string)
ML_1(gtk_label_get_attributes,GtkLabel_val, Val_PangoAttrList)
ML_1(gtk_label_get_angle,GtkLabel_val, Val_double)
/* end of Label */
/* Module InvisiblePrivate */
/* end of InvisiblePrivate */
/* Module InvisibleClass */
/* end of InvisibleClass */
/* Module Invisible */
ML_2(gtk_invisible_set_screen,GtkInvisible_val, GdkScreen_val, Unit)
ML_1(gtk_invisible_get_screen,GtkInvisible_val, Val_GdkScreen)
/* end of Invisible */
/* Module InfoBarPrivate */
/* end of InfoBarPrivate */
/* Module InfoBarClass */
/* end of InfoBarClass */
/* Module InfoBar */
ML_3(gtk_info_bar_set_response_sensitive,GtkInfoBar_val, Int_val, Bool_val, Unit)
ML_2(gtk_info_bar_set_default_response,GtkInfoBar_val, Int_val, Unit)
ML_2(gtk_info_bar_response,GtkInfoBar_val, Int_val, Unit)
ML_1(gtk_info_bar_get_content_area,GtkInfoBar_val, Val_GtkWidget)
ML_1(gtk_info_bar_get_action_area,GtkInfoBar_val, Val_GtkWidget)
ML_3(gtk_info_bar_add_button,GtkInfoBar_val, String_val, Int_val, Val_GtkWidget)
ML_3(gtk_info_bar_add_action_widget,GtkInfoBar_val, GtkWidget_val, Int_val, Unit)
/* end of InfoBar */
/* Module ImagePrivate */
/* end of ImagePrivate */
/* Module ImageMenuItemPrivate */
/* end of ImageMenuItemPrivate */
/* Module ImageMenuItemClass */
/* end of ImageMenuItemClass */
/* Module ImageMenuItem */
ML_2(gtk_image_menu_item_set_use_stock,GtkImageMenuItem_val, Bool_val, Unit)
ML_2(gtk_image_menu_item_set_image,GtkImageMenuItem_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_image_menu_item_set_always_show_image,GtkImageMenuItem_val, Bool_val, Unit)
ML_2(gtk_image_menu_item_set_accel_group,GtkImageMenuItem_val, GtkAccelGroup_val, Unit)
ML_1(gtk_image_menu_item_get_use_stock,GtkImageMenuItem_val, Val_bool)
ML_1(gtk_image_menu_item_get_image,GtkImageMenuItem_val, Val_GtkWidget)
ML_1(gtk_image_menu_item_get_always_show_image,GtkImageMenuItem_val, Val_bool)
/* end of ImageMenuItem */
/* Module ImageClass */
/* end of ImageClass */
/* Module Image */
ML_2(gtk_image_set_pixel_size,GtkImage_val, Int_val, Unit)
ML_2(gtk_image_set_from_pixbuf,GtkImage_val, Option_val(arg2,GdkPixbuf_val,NULL) Ignore, Unit)
ML_2(gtk_image_set_from_animation,GtkImage_val, GdkPixbufAnimation_val, Unit)
ML_1(gtk_image_get_pixel_size,GtkImage_val, Val_int)
ML_1(gtk_image_get_pixbuf,GtkImage_val, Val_GdkPixbuf)
ML_1(gtk_image_get_animation,GtkImage_val, Val_GdkPixbufAnimation)
ML_1(gtk_image_clear,GtkImage_val, Unit)
/* end of Image */
/* Module IconViewPrivate */
/* end of IconViewPrivate */
/* Module IconViewClass */
/* end of IconViewClass */
/* Module IconView */
ML_1(gtk_icon_view_unset_model_drag_source,GtkIconView_val, Unit)
ML_1(gtk_icon_view_unset_model_drag_dest,GtkIconView_val, Unit)
ML_2(gtk_icon_view_unselect_path,GtkIconView_val, GtkTreePath_val, Unit)
ML_1(gtk_icon_view_unselect_all,GtkIconView_val, Unit)
ML_3(gtk_icon_view_set_tooltip_item,GtkIconView_val, GtkTooltip_val, GtkTreePath_val, Unit)
ML_2(gtk_icon_view_set_tooltip_column,GtkIconView_val, Int_val, Unit)
ML_4(gtk_icon_view_set_tooltip_cell,GtkIconView_val, GtkTooltip_val, GtkTreePath_val, Option_val(arg4,GtkCellRenderer_val,NULL) Ignore, Unit)
ML_2(gtk_icon_view_set_text_column,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_spacing,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_row_spacing,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_reorderable,GtkIconView_val, Bool_val, Unit)
ML_2(gtk_icon_view_set_pixbuf_column,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_markup_column,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_margin,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_item_width,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_item_padding,GtkIconView_val, Int_val, Unit)
ML_4(gtk_icon_view_set_cursor,GtkIconView_val, GtkTreePath_val, Option_val(arg3,GtkCellRenderer_val,NULL) Ignore, Bool_val, Unit)
ML_2(gtk_icon_view_set_columns,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_set_column_spacing,GtkIconView_val, Int_val, Unit)
ML_2(gtk_icon_view_select_path,GtkIconView_val, GtkTreePath_val, Unit)
ML_1(gtk_icon_view_select_all,GtkIconView_val, Unit)
ML_2(gtk_icon_view_path_is_selected,GtkIconView_val, GtkTreePath_val, Val_bool)
ML_2(gtk_icon_view_item_activated,GtkIconView_val, GtkTreePath_val, Unit)
ML_1(gtk_icon_view_get_tooltip_column,GtkIconView_val, Val_int)
ML_1(gtk_icon_view_get_text_column,GtkIconView_val, Val_int)
ML_1(gtk_icon_view_get_spacing,GtkIconView_val, Val_int)
ML_1(gtk_icon_view_get_selected_items,GtkIconView_val, Val_GList_new)
ML_1(gtk_icon_view_get_row_spacing,GtkIconView_val, Val_int)
ML_1(gtk_icon_view_get_reorderable,GtkIconView_val, Val_bool)
ML_1(gtk_icon_view_get_pixbuf_column,GtkIconView_val, Val_int)
ML_3(gtk_icon_view_get_path_at_pos,GtkIconView_val, Int_val, Int_val, Val_GtkTreePath_new)
ML_1(gtk_icon_view_get_markup_column,GtkIconView_val, Val_int)
ML_1(gtk_icon_view_get_margin,GtkIconView_val, Val_int)
ML_1(gtk_icon_view_get_item_width,GtkIconView_val, Val_int)
ML_2(gtk_icon_view_get_item_row,GtkIconView_val, GtkTreePath_val, Val_int)
ML_1(gtk_icon_view_get_item_padding,GtkIconView_val, Val_int)
ML_2(gtk_icon_view_get_item_column,GtkIconView_val, GtkTreePath_val, Val_int)
ML_1(gtk_icon_view_get_columns,GtkIconView_val, Val_int)
ML_1(gtk_icon_view_get_column_spacing,GtkIconView_val, Val_int)
ML_2(gtk_icon_view_create_drag_icon,GtkIconView_val, GtkTreePath_val, Val_cairo_surface_t_new)
/* end of IconView */
/* Module IconThemePrivate */
/* end of IconThemePrivate */
/* Module IconThemeClass */
/* end of IconThemeClass */
/* Module IconTheme */
ML_2(gtk_icon_theme_set_screen,GtkIconTheme_val, GdkScreen_val, Unit)
ML_2(gtk_icon_theme_set_custom_theme,GtkIconTheme_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_1(gtk_icon_theme_rescan_if_needed,GtkIconTheme_val, Val_bool)
ML_2(gtk_icon_theme_list_icons,GtkIconTheme_val, Option_val(arg2,String_val,NULL) Ignore, Val_GList_new)
ML_1(gtk_icon_theme_list_contexts,GtkIconTheme_val, Val_GList_new)
ML_2(gtk_icon_theme_has_icon,GtkIconTheme_val, String_val, Val_bool)
ML_1(gtk_icon_theme_get_example_icon_name,GtkIconTheme_val, Val_string_new)
ML_1(gtk_icon_theme_get_for_screen,GdkScreen_val, Val_GtkIconTheme)
ML_0(gtk_icon_theme_get_default,Val_GtkIconTheme)
ML_3(gtk_icon_theme_add_builtin_icon,String_val, Int_val, GdkPixbuf_val, Unit)
/* end of IconTheme */
/* Module IconSource */
ML_2(gtk_icon_source_set_state_wildcarded,GtkIconSource_val, Bool_val, Unit)
ML_2(gtk_icon_source_set_size_wildcarded,GtkIconSource_val, Bool_val, Unit)
ML_2(gtk_icon_source_set_pixbuf,GtkIconSource_val, GdkPixbuf_val, Unit)
ML_2(gtk_icon_source_set_icon_name,GtkIconSource_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_icon_source_set_direction_wildcarded,GtkIconSource_val, Bool_val, Unit)
ML_1(gtk_icon_source_get_state_wildcarded,GtkIconSource_val, Val_bool)
ML_1(gtk_icon_source_get_size_wildcarded,GtkIconSource_val, Val_bool)
ML_1(gtk_icon_source_get_pixbuf,GtkIconSource_val, Val_GdkPixbuf)
ML_1(gtk_icon_source_get_icon_name,GtkIconSource_val, Val_string)
ML_1(gtk_icon_source_get_direction_wildcarded,GtkIconSource_val, Val_bool)
ML_1(gtk_icon_source_free,GtkIconSource_val, Unit)
ML_1(gtk_icon_source_copy,GtkIconSource_val, Val_GtkIconSource_new)
/* end of IconSource */
/* Module IconSet */
ML_1(gtk_icon_set_unref,GtkIconSet_val, Unit)
ML_1(gtk_icon_set_ref,GtkIconSet_val, Val_GtkIconSet_new)
ML_1(gtk_icon_set_copy,GtkIconSet_val, Val_GtkIconSet_new)
ML_2(gtk_icon_set_add_source,GtkIconSet_val, GtkIconSource_val, Unit)
/* end of IconSet */
/* Module IconInfo */
ML_2(gtk_icon_info_set_raw_coordinates,GtkIconInfo_val, Bool_val, Unit)
ML_1(gtk_icon_info_get_display_name,GtkIconInfo_val, Val_string)
ML_1(gtk_icon_info_get_builtin_pixbuf,GtkIconInfo_val, Val_GdkPixbuf)
ML_1(gtk_icon_info_get_base_size,GtkIconInfo_val, Val_int)
ML_1(gtk_icon_info_free,GtkIconInfo_val, Unit)
ML_1(gtk_icon_info_copy,GtkIconInfo_val, Val_GtkIconInfo_new)
/* end of IconInfo */
/* Module IconFactoryPrivate */
/* end of IconFactoryPrivate */
/* Module IconFactoryClass */
/* end of IconFactoryClass */
/* Module IconFactory */
ML_1(gtk_icon_factory_remove_default,GtkIconFactory_val, Unit)
ML_2(gtk_icon_factory_lookup,GtkIconFactory_val, String_val, Val_GtkIconSet)
ML_1(gtk_icon_factory_add_default,GtkIconFactory_val, Unit)
ML_3(gtk_icon_factory_add,GtkIconFactory_val, String_val, GtkIconSet_val, Unit)
ML_1(gtk_icon_factory_lookup_default,String_val, Val_GtkIconSet)
/* end of IconFactory */
/* Module IMMulticontextPrivate */
/* end of IMMulticontextPrivate */
/* Module IMMulticontextClass */
/* end of IMMulticontextClass */
/* Module IMMulticontext */
ML_2(gtk_im_multicontext_set_context_id,GtkIMMulticontext_val, String_val, Unit)
ML_1(gtk_im_multicontext_get_context_id,GtkIMMulticontext_val, Val_string)
ML_2(gtk_im_multicontext_append_menuitems,GtkIMMulticontext_val, GtkMenuShell_val, Unit)
/* end of IMMulticontext */
/* Module IMContextSimplePrivate */
/* end of IMContextSimplePrivate */
/* Module IMContextSimpleClass */
/* end of IMContextSimpleClass */
/* Module IMContextSimple */
/* end of IMContextSimple */
/* Module IMContextInfo */
/* end of IMContextInfo */
/* Module IMContextClass */
/* end of IMContextClass */
/* Module IMContext */
ML_2(gtk_im_context_set_use_preedit,GtkIMContext_val, Bool_val, Unit)
ML_4(gtk_im_context_set_surrounding,GtkIMContext_val, String_val, Int_val, Int_val, Unit)
ML_2(gtk_im_context_set_client_window,GtkIMContext_val, Option_val(arg2,GdkWindow_val,NULL) Ignore, Unit)
ML_1(gtk_im_context_reset,GtkIMContext_val, Unit)
ML_1(gtk_im_context_focus_out,GtkIMContext_val, Unit)
ML_1(gtk_im_context_focus_in,GtkIMContext_val, Unit)
ML_2(gtk_im_context_filter_keypress,GtkIMContext_val, GdkEventKey_val, Val_bool)
ML_3(gtk_im_context_delete_surrounding,GtkIMContext_val, Int_val, Int_val, Val_bool)
/* end of IMContext */
/* Module HandleBoxPrivate */
/* end of HandleBoxPrivate */
/* Module HandleBoxClass */
/* end of HandleBoxClass */
/* Module HandleBox */
ML_1(gtk_handle_box_get_child_detached,GtkHandleBox_val, Val_bool)
/* end of HandleBox */
/* Module HSeparatorClass */
/* end of HSeparatorClass */
/* Module HSeparator */
/* end of HSeparator */
/* Module HScrollbarClass */
/* end of HScrollbarClass */
/* Module HScrollbar */
/* end of HScrollbar */
/* Module HScaleClass */
/* end of HScaleClass */
/* Module HScale */
/* end of HScale */
/* Module HSVPrivate */
/* end of HSVPrivate */
/* Module HSVClass */
/* end of HSVClass */
/* Module HSV */
ML_3(gtk_hsv_set_metrics,GtkHSV_val, Int_val, Int_val, Unit)
ML_4(gtk_hsv_set_color,GtkHSV_val, Double_val, Double_val, Double_val, Unit)
ML_1(gtk_hsv_is_adjusting,GtkHSV_val, Val_bool)
/* end of HSV */
/* Module HPanedClass */
/* end of HPanedClass */
/* Module HPaned */
/* end of HPaned */
/* Module HButtonBoxClass */
/* end of HButtonBoxClass */
/* Module HButtonBox */
/* end of HButtonBox */
/* Module HBoxClass */
/* end of HBoxClass */
/* Module HBox */
/* end of HBox */
/* Module GridPrivate */
/* end of GridPrivate */
/* Module GridClass */
/* end of GridClass */
/* Module Grid */
ML_2(gtk_grid_set_row_spacing,GtkGrid_val, Int_val, Unit)
ML_2(gtk_grid_set_row_homogeneous,GtkGrid_val, Bool_val, Unit)
ML_2(gtk_grid_set_column_spacing,GtkGrid_val, Int_val, Unit)
ML_2(gtk_grid_set_column_homogeneous,GtkGrid_val, Bool_val, Unit)
ML_1(gtk_grid_get_row_spacing,GtkGrid_val, Val_int)
ML_1(gtk_grid_get_row_homogeneous,GtkGrid_val, Val_bool)
ML_1(gtk_grid_get_column_spacing,GtkGrid_val, Val_int)
ML_1(gtk_grid_get_column_homogeneous,GtkGrid_val, Val_bool)
ML_6(gtk_grid_attach,GtkGrid_val, GtkWidget_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc6(ml_gtk_grid_attach) /* end of Grid */
/* Module Gradient */
ML_1(gtk_gradient_unref,GtkGradient_val, Unit)
ML_1(gtk_gradient_ref,GtkGradient_val, Val_GtkGradient_new)
ML_3(gtk_gradient_add_color_stop,GtkGradient_val, Double_val, GtkSymbolicColor_val, Unit)
/* end of Gradient */
/* Module FramePrivate */
/* end of FramePrivate */
/* Module FrameClass */
/* end of FrameClass */
/* Module Frame */
ML_2(gtk_frame_set_label_widget,GtkFrame_val, GtkWidget_val, Unit)
ML_2(gtk_frame_set_label,GtkFrame_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_1(gtk_frame_get_label_widget,GtkFrame_val, Val_GtkWidget)
ML_1(gtk_frame_get_label,GtkFrame_val, Val_string)
/* end of Frame */
/* Module FontSelectionPrivate */
/* end of FontSelectionPrivate */
/* Module FontSelectionDialogPrivate */
/* end of FontSelectionDialogPrivate */
/* Module FontSelectionDialogClass */
/* end of FontSelectionDialogClass */
/* Module FontSelectionDialog */
ML_2(gtk_font_selection_dialog_set_preview_text,GtkFontSelectionDialog_val, String_val, Unit)
ML_2(gtk_font_selection_dialog_set_font_name,GtkFontSelectionDialog_val, String_val, Val_bool)
ML_1(gtk_font_selection_dialog_get_preview_text,GtkFontSelectionDialog_val, Val_string)
ML_1(gtk_font_selection_dialog_get_ok_button,GtkFontSelectionDialog_val, Val_GtkWidget)
ML_1(gtk_font_selection_dialog_get_font_selection,GtkFontSelectionDialog_val, Val_GtkWidget)
ML_1(gtk_font_selection_dialog_get_font_name,GtkFontSelectionDialog_val, Val_string_new)
ML_1(gtk_font_selection_dialog_get_cancel_button,GtkFontSelectionDialog_val, Val_GtkWidget)
/* end of FontSelectionDialog */
/* Module FontSelectionClass */
/* end of FontSelectionClass */
/* Module FontSelection */
ML_2(gtk_font_selection_set_preview_text,GtkFontSelection_val, String_val, Unit)
ML_2(gtk_font_selection_set_font_name,GtkFontSelection_val, String_val, Val_bool)
ML_1(gtk_font_selection_get_size_list,GtkFontSelection_val, Val_GtkWidget)
ML_1(gtk_font_selection_get_size_entry,GtkFontSelection_val, Val_GtkWidget)
ML_1(gtk_font_selection_get_size,GtkFontSelection_val, Val_int)
ML_1(gtk_font_selection_get_preview_text,GtkFontSelection_val, Val_string)
ML_1(gtk_font_selection_get_preview_entry,GtkFontSelection_val, Val_GtkWidget)
ML_1(gtk_font_selection_get_font_name,GtkFontSelection_val, Val_string_new)
ML_1(gtk_font_selection_get_family_list,GtkFontSelection_val, Val_GtkWidget)
ML_1(gtk_font_selection_get_family,GtkFontSelection_val, Val_PangoFontFamily)
ML_1(gtk_font_selection_get_face_list,GtkFontSelection_val, Val_GtkWidget)
ML_1(gtk_font_selection_get_face,GtkFontSelection_val, Val_PangoFontFace)
/* end of FontSelection */
/* Module FontButtonPrivate */
/* end of FontButtonPrivate */
/* Module FontButtonClass */
/* end of FontButtonClass */
/* Module FontButton */
ML_2(gtk_font_button_set_use_size,GtkFontButton_val, Bool_val, Unit)
ML_2(gtk_font_button_set_use_font,GtkFontButton_val, Bool_val, Unit)
ML_2(gtk_font_button_set_title,GtkFontButton_val, String_val, Unit)
ML_2(gtk_font_button_set_show_style,GtkFontButton_val, Bool_val, Unit)
ML_2(gtk_font_button_set_show_size,GtkFontButton_val, Bool_val, Unit)
ML_2(gtk_font_button_set_font_name,GtkFontButton_val, String_val, Val_bool)
ML_1(gtk_font_button_get_use_size,GtkFontButton_val, Val_bool)
ML_1(gtk_font_button_get_use_font,GtkFontButton_val, Val_bool)
ML_1(gtk_font_button_get_title,GtkFontButton_val, Val_string)
ML_1(gtk_font_button_get_show_style,GtkFontButton_val, Val_bool)
ML_1(gtk_font_button_get_show_size,GtkFontButton_val, Val_bool)
ML_1(gtk_font_button_get_font_name,GtkFontButton_val, Val_string)
/* end of FontButton */
/* Module FixedPrivate */
/* end of FixedPrivate */
/* Module FixedClass */
/* end of FixedClass */
/* Module FixedChild */
/* end of FixedChild */
/* Module Fixed */
ML_4(gtk_fixed_put,GtkFixed_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_4(gtk_fixed_move,GtkFixed_val, GtkWidget_val, Int_val, Int_val, Unit)
/* end of Fixed */
/* Module FileFilterInfo */
/* end of FileFilterInfo */
/* Module FileFilter */
ML_2(gtk_file_filter_set_name,GtkFileFilter_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_1(gtk_file_filter_get_name,GtkFileFilter_val, Val_string)
ML_2(gtk_file_filter_filter,GtkFileFilter_val, GtkFileFilterInfo_val, Val_bool)
ML_1(gtk_file_filter_add_pixbuf_formats,GtkFileFilter_val, Unit)
ML_2(gtk_file_filter_add_pattern,GtkFileFilter_val, String_val, Unit)
ML_2(gtk_file_filter_add_mime_type,GtkFileFilter_val, String_val, Unit)
/* end of FileFilter */
/* Module FileChooserWidgetPrivate */
/* end of FileChooserWidgetPrivate */
/* Module FileChooserWidgetClass */
/* end of FileChooserWidgetClass */
/* Module FileChooserWidget */
/* end of FileChooserWidget */
/* Module FileChooserDialogPrivate */
/* end of FileChooserDialogPrivate */
/* Module FileChooserDialogClass */
/* end of FileChooserDialogClass */
/* Module FileChooserDialog */
/* end of FileChooserDialog */
/* Module FileChooserButtonPrivate */
/* end of FileChooserButtonPrivate */
/* Module FileChooserButtonClass */
/* end of FileChooserButtonClass */
/* Module FileChooserButton */
ML_2(gtk_file_chooser_button_set_width_chars,GtkFileChooserButton_val, Int_val, Unit)
ML_2(gtk_file_chooser_button_set_title,GtkFileChooserButton_val, String_val, Unit)
ML_2(gtk_file_chooser_button_set_focus_on_click,GtkFileChooserButton_val, Bool_val, Unit)
ML_1(gtk_file_chooser_button_get_width_chars,GtkFileChooserButton_val, Val_int)
ML_1(gtk_file_chooser_button_get_title,GtkFileChooserButton_val, Val_string)
ML_1(gtk_file_chooser_button_get_focus_on_click,GtkFileChooserButton_val, Val_bool)
/* end of FileChooserButton */
/* Module ExpanderPrivate */
/* end of ExpanderPrivate */
/* Module ExpanderClass */
/* end of ExpanderClass */
/* Module Expander */
ML_2(gtk_expander_set_use_underline,GtkExpander_val, Bool_val, Unit)
ML_2(gtk_expander_set_use_markup,GtkExpander_val, Bool_val, Unit)
ML_2(gtk_expander_set_spacing,GtkExpander_val, Int_val, Unit)
ML_2(gtk_expander_set_label_widget,GtkExpander_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_expander_set_label_fill,GtkExpander_val, Bool_val, Unit)
ML_2(gtk_expander_set_label,GtkExpander_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_expander_set_expanded,GtkExpander_val, Bool_val, Unit)
ML_1(gtk_expander_get_use_underline,GtkExpander_val, Val_bool)
ML_1(gtk_expander_get_use_markup,GtkExpander_val, Val_bool)
ML_1(gtk_expander_get_spacing,GtkExpander_val, Val_int)
ML_1(gtk_expander_get_label_widget,GtkExpander_val, Val_GtkWidget)
ML_1(gtk_expander_get_label_fill,GtkExpander_val, Val_bool)
ML_1(gtk_expander_get_label,GtkExpander_val, Val_string)
ML_1(gtk_expander_get_expanded,GtkExpander_val, Val_bool)
/* end of Expander */
/* Module EventBoxPrivate */
/* end of EventBoxPrivate */
/* Module EventBoxClass */
/* end of EventBoxClass */
/* Module EventBox */
ML_2(gtk_event_box_set_visible_window,GtkEventBox_val, Bool_val, Unit)
ML_2(gtk_event_box_set_above_child,GtkEventBox_val, Bool_val, Unit)
ML_1(gtk_event_box_get_visible_window,GtkEventBox_val, Val_bool)
ML_1(gtk_event_box_get_above_child,GtkEventBox_val, Val_bool)
/* end of EventBox */
/* Module EntryPrivate */
/* end of EntryPrivate */
/* Module EntryCompletionPrivate */
/* end of EntryCompletionPrivate */
/* Module EntryCompletionClass */
/* end of EntryCompletionClass */
/* Module EntryCompletion */
ML_2(gtk_entry_completion_set_text_column,GtkEntryCompletion_val, Int_val, Unit)
ML_2(gtk_entry_completion_set_popup_single_match,GtkEntryCompletion_val, Bool_val, Unit)
ML_2(gtk_entry_completion_set_popup_set_width,GtkEntryCompletion_val, Bool_val, Unit)
ML_2(gtk_entry_completion_set_popup_completion,GtkEntryCompletion_val, Bool_val, Unit)
ML_2(gtk_entry_completion_set_minimum_key_length,GtkEntryCompletion_val, Int_val, Unit)
ML_2(gtk_entry_completion_set_inline_selection,GtkEntryCompletion_val, Bool_val, Unit)
ML_2(gtk_entry_completion_set_inline_completion,GtkEntryCompletion_val, Bool_val, Unit)
ML_1(gtk_entry_completion_insert_prefix,GtkEntryCompletion_val, Unit)
ML_3(gtk_entry_completion_insert_action_text,GtkEntryCompletion_val, Int_val, String_val, Unit)
ML_3(gtk_entry_completion_insert_action_markup,GtkEntryCompletion_val, Int_val, String_val, Unit)
ML_1(gtk_entry_completion_get_text_column,GtkEntryCompletion_val, Val_int)
ML_1(gtk_entry_completion_get_popup_single_match,GtkEntryCompletion_val, Val_bool)
ML_1(gtk_entry_completion_get_popup_set_width,GtkEntryCompletion_val, Val_bool)
ML_1(gtk_entry_completion_get_popup_completion,GtkEntryCompletion_val, Val_bool)
ML_1(gtk_entry_completion_get_minimum_key_length,GtkEntryCompletion_val, Val_int)
ML_1(gtk_entry_completion_get_inline_selection,GtkEntryCompletion_val, Val_bool)
ML_1(gtk_entry_completion_get_inline_completion,GtkEntryCompletion_val, Val_bool)
ML_1(gtk_entry_completion_get_entry,GtkEntryCompletion_val, Val_GtkWidget)
ML_1(gtk_entry_completion_get_completion_prefix,GtkEntryCompletion_val, Val_string)
ML_2(gtk_entry_completion_delete_action,GtkEntryCompletion_val, Int_val, Unit)
ML_1(gtk_entry_completion_complete,GtkEntryCompletion_val, Unit)
/* end of EntryCompletion */
/* Module EntryClass */
/* end of EntryClass */
/* Module EntryBufferPrivate */
/* end of EntryBufferPrivate */
/* Module EntryBufferClass */
/* end of EntryBufferClass */
/* Module EntryBuffer */
ML_3(gtk_entry_buffer_set_text,GtkEntryBuffer_val, String_val, Int_val, Unit)
ML_2(gtk_entry_buffer_set_max_length,GtkEntryBuffer_val, Int_val, Unit)
ML_4(gtk_entry_buffer_insert_text,GtkEntryBuffer_val, Int_val, String_val, Int_val, Val_int)
ML_1(gtk_entry_buffer_get_text,GtkEntryBuffer_val, Val_string)
ML_1(gtk_entry_buffer_get_max_length,GtkEntryBuffer_val, Val_int)
ML_1(gtk_entry_buffer_get_length,GtkEntryBuffer_val, Val_int)
ML_1(gtk_entry_buffer_get_bytes,GtkEntryBuffer_val, Val_int)
ML_4(gtk_entry_buffer_emit_inserted_text,GtkEntryBuffer_val, Int_val, String_val, Int_val, Unit)
ML_3(gtk_entry_buffer_emit_deleted_text,GtkEntryBuffer_val, Int_val, Int_val, Unit)
ML_3(gtk_entry_buffer_delete_text,GtkEntryBuffer_val, Int_val, Int_val, Val_int)
/* end of EntryBuffer */
/* Module Entry */
ML_1(gtk_entry_unset_invisible_char,GtkEntry_val, Unit)
ML_2(gtk_entry_text_index_to_layout_index,GtkEntry_val, Int_val, Val_int)
ML_2(gtk_entry_set_width_chars,GtkEntry_val, Int_val, Unit)
ML_2(gtk_entry_set_visibility,GtkEntry_val, Bool_val, Unit)
ML_2(gtk_entry_set_text,GtkEntry_val, String_val, Unit)
ML_2(gtk_entry_set_progress_pulse_step,GtkEntry_val, Double_val, Unit)
ML_2(gtk_entry_set_progress_fraction,GtkEntry_val, Double_val, Unit)
ML_2(gtk_entry_set_overwrite_mode,GtkEntry_val, Bool_val, Unit)
ML_2(gtk_entry_set_max_length,GtkEntry_val, Int_val, Unit)
ML_2(gtk_entry_set_invisible_char,GtkEntry_val, Int32_val, Unit)
ML_2(gtk_entry_set_inner_border,GtkEntry_val, Option_val(arg2,GtkBorder_val,NULL) Ignore, Unit)
ML_2(gtk_entry_set_has_frame,GtkEntry_val, Bool_val, Unit)
ML_2(gtk_entry_set_cursor_hadjustment,GtkEntry_val, GtkAdjustment_val, Unit)
ML_2(gtk_entry_set_completion,GtkEntry_val, Option_val(arg2,GtkEntryCompletion_val,NULL) Ignore, Unit)
ML_2(gtk_entry_set_buffer,GtkEntry_val, GtkEntryBuffer_val, Unit)
ML_2(gtk_entry_set_activates_default,GtkEntry_val, Bool_val, Unit)
ML_1(gtk_entry_reset_im_context,GtkEntry_val, Unit)
ML_1(gtk_entry_progress_pulse,GtkEntry_val, Unit)
ML_2(gtk_entry_layout_index_to_text_index,GtkEntry_val, Int_val, Val_int)
ML_2(gtk_entry_im_context_filter_keypress,GtkEntry_val, GdkEventKey_val, Val_bool)
ML_1(gtk_entry_get_width_chars,GtkEntry_val, Val_int)
ML_1(gtk_entry_get_visibility,GtkEntry_val, Val_bool)
ML_1(gtk_entry_get_text_length,GtkEntry_val, Val_int)
ML_1(gtk_entry_get_text,GtkEntry_val, Val_string)
ML_1(gtk_entry_get_progress_pulse_step,GtkEntry_val, Val_double)
ML_1(gtk_entry_get_progress_fraction,GtkEntry_val, Val_double)
ML_1(gtk_entry_get_overwrite_mode,GtkEntry_val, Val_bool)
ML_1(gtk_entry_get_max_length,GtkEntry_val, Val_int)
ML_1(gtk_entry_get_layout,GtkEntry_val, Val_PangoLayout)
ML_1(gtk_entry_get_invisible_char,GtkEntry_val, Val_int32)
ML_1(gtk_entry_get_inner_border,GtkEntry_val, Val_GtkBorder)
ML_3(gtk_entry_get_icon_at_pos,GtkEntry_val, Int_val, Int_val, Val_int)
ML_1(gtk_entry_get_has_frame,GtkEntry_val, Val_bool)
ML_1(gtk_entry_get_cursor_hadjustment,GtkEntry_val, Val_GtkAdjustment)
ML_1(gtk_entry_get_current_icon_drag_source,GtkEntry_val, Val_int)
ML_1(gtk_entry_get_completion,GtkEntry_val, Val_GtkEntryCompletion)
ML_1(gtk_entry_get_buffer,GtkEntry_val, Val_GtkEntryBuffer)
ML_1(gtk_entry_get_activates_default,GtkEntry_val, Val_bool)
/* end of Entry */
/* Module EditableInterface */
/* end of EditableInterface */
/* Module DrawingAreaClass */
/* end of DrawingAreaClass */
/* Module DrawingArea */
/* end of DrawingArea */
/* Module DialogPrivate */
/* end of DialogPrivate */
/* Module DialogClass */
/* end of DialogClass */
/* Module Dialog */
ML_3(gtk_dialog_set_response_sensitive,GtkDialog_val, Int_val, Bool_val, Unit)
ML_2(gtk_dialog_set_default_response,GtkDialog_val, Int_val, Unit)
ML_1(gtk_dialog_run,GtkDialog_val, Val_int)
ML_2(gtk_dialog_response,GtkDialog_val, Int_val, Unit)
ML_2(gtk_dialog_get_widget_for_response,GtkDialog_val, Int_val, Val_GtkWidget)
ML_2(gtk_dialog_get_response_for_widget,GtkDialog_val, GtkWidget_val, Val_int)
ML_1(gtk_dialog_get_content_area,GtkDialog_val, Val_GtkWidget)
ML_1(gtk_dialog_get_action_area,GtkDialog_val, Val_GtkWidget)
ML_3(gtk_dialog_add_button,GtkDialog_val, String_val, Int_val, Val_GtkWidget)
ML_3(gtk_dialog_add_action_widget,GtkDialog_val, GtkWidget_val, Int_val, Unit)
/* end of Dialog */
/* Module CssProviderClass */
/* end of CssProviderClass */
/* Module CssProvider */
ML_2(gtk_css_provider_get_named,String_val, Option_val(arg2,String_val,NULL) Ignore, Val_GtkCssProvider)
ML_0(gtk_css_provider_get_default,Val_GtkCssProvider)
/* end of CssProvider */
/* Module ContainerPrivate */
/* end of ContainerPrivate */
/* Module ContainerClass */
ML_3(gtk_container_class_install_child_property,GtkContainerClass_val, Int_val, GParamSpec_val, Unit)
ML_1(gtk_container_class_handle_border_width,GtkContainerClass_val, Unit)
ML_2(gtk_container_class_find_child_property,GtkContainerClass_val, String_val, Val_GParamSpec)
/* end of ContainerClass */
/* Module Container */
ML_1(gtk_container_unset_focus_chain,GtkContainer_val, Unit)
ML_2(gtk_container_set_reallocate_redraws,GtkContainer_val, Bool_val, Unit)
ML_2(gtk_container_set_focus_vadjustment,GtkContainer_val, GtkAdjustment_val, Unit)
ML_2(gtk_container_set_focus_hadjustment,GtkContainer_val, GtkAdjustment_val, Unit)
ML_2(gtk_container_set_focus_child,GtkContainer_val, Option_val(arg2,GtkWidget_val,NULL) Ignore, Unit)
ML_2(gtk_container_set_focus_chain,GtkContainer_val, GList_val, Unit)
ML_2(gtk_container_set_border_width,GtkContainer_val, Int_val, Unit)
ML_1(gtk_container_resize_children,GtkContainer_val, Unit)
ML_2(gtk_container_remove,GtkContainer_val, GtkWidget_val, Unit)
ML_3(gtk_container_propagate_draw,GtkContainer_val, GtkWidget_val, cairo_t_val, Unit)
ML_2(gtk_container_get_path_for_child,GtkContainer_val, GtkWidget_val, Val_GtkWidgetPath_new)
ML_1(gtk_container_get_focus_vadjustment,GtkContainer_val, Val_GtkAdjustment)
ML_1(gtk_container_get_focus_hadjustment,GtkContainer_val, Val_GtkAdjustment)
ML_1(gtk_container_get_focus_child,GtkContainer_val, Val_GtkWidget)
ML_1(gtk_container_get_children,GtkContainer_val, Val_GList)
ML_1(gtk_container_get_border_width,GtkContainer_val, Val_int)
ML_1(gtk_container_child_type,GtkContainer_val, Val_int)
ML_4(gtk_container_child_set_property,GtkContainer_val, GtkWidget_val, String_val, GValue_val, Unit)
ML_4(gtk_container_child_get_property,GtkContainer_val, GtkWidget_val, String_val, GValue_val, Unit)
ML_1(gtk_container_check_resize,GtkContainer_val, Unit)
ML_2(gtk_container_add,GtkContainer_val, GtkWidget_val, Unit)
/* end of Container */
/* Module ComboBoxTextPrivate */
/* end of ComboBoxTextPrivate */
/* Module ComboBoxTextClass */
/* end of ComboBoxTextClass */
/* Module ComboBoxText */
ML_1(gtk_combo_box_text_remove_all,GtkComboBoxText_val, Unit)
ML_2(gtk_combo_box_text_remove,GtkComboBoxText_val, Int_val, Unit)
ML_2(gtk_combo_box_text_prepend_text,GtkComboBoxText_val, String_val, Unit)
ML_3(gtk_combo_box_text_prepend,GtkComboBoxText_val, Option_val(arg2,String_val,NULL) Ignore, String_val, Unit)
ML_3(gtk_combo_box_text_insert_text,GtkComboBoxText_val, Int_val, String_val, Unit)
ML_4(gtk_combo_box_text_insert,GtkComboBoxText_val, Int_val, Option_val(arg3,String_val,NULL) Ignore, String_val, Unit)
ML_1(gtk_combo_box_text_get_active_text,GtkComboBoxText_val, Val_string_new)
ML_2(gtk_combo_box_text_append_text,GtkComboBoxText_val, String_val, Unit)
ML_3(gtk_combo_box_text_append,GtkComboBoxText_val, Option_val(arg2,String_val,NULL) Ignore, String_val, Unit)
/* end of ComboBoxText */
/* Module ComboBoxPrivate */
/* end of ComboBoxPrivate */
/* Module ComboBoxClass */
/* end of ComboBoxClass */
/* Module ComboBox */
ML_2(gtk_combo_box_set_wrap_width,GtkComboBox_val, Int_val, Unit)
ML_2(gtk_combo_box_set_title,GtkComboBox_val, String_val, Unit)
ML_2(gtk_combo_box_set_row_span_column,GtkComboBox_val, Int_val, Unit)
ML_2(gtk_combo_box_set_popup_fixed_width,GtkComboBox_val, Bool_val, Unit)
ML_2(gtk_combo_box_set_id_column,GtkComboBox_val, Int_val, Unit)
ML_2(gtk_combo_box_set_focus_on_click,GtkComboBox_val, Bool_val, Unit)
ML_2(gtk_combo_box_set_entry_text_column,GtkComboBox_val, Int_val, Unit)
ML_2(gtk_combo_box_set_column_span_column,GtkComboBox_val, Int_val, Unit)
ML_2(gtk_combo_box_set_add_tearoffs,GtkComboBox_val, Bool_val, Unit)
ML_2(gtk_combo_box_set_active_iter,GtkComboBox_val, Option_val(arg2,GtkTreeIter_val,NULL) Ignore, Unit)
ML_2(gtk_combo_box_set_active_id,GtkComboBox_val, String_val, Unit)
ML_2(gtk_combo_box_set_active,GtkComboBox_val, Int_val, Unit)
ML_2(gtk_combo_box_popup_for_device,GtkComboBox_val, GdkDevice_val, Unit)
ML_1(gtk_combo_box_popup,GtkComboBox_val, Unit)
ML_1(gtk_combo_box_popdown,GtkComboBox_val, Unit)
ML_1(gtk_combo_box_get_wrap_width,GtkComboBox_val, Val_int)
ML_1(gtk_combo_box_get_title,GtkComboBox_val, Val_string)
ML_1(gtk_combo_box_get_row_span_column,GtkComboBox_val, Val_int)
ML_1(gtk_combo_box_get_popup_fixed_width,GtkComboBox_val, Val_bool)
ML_1(gtk_combo_box_get_popup_accessible,GtkComboBox_val, Val_AtkObject)
ML_1(gtk_combo_box_get_id_column,GtkComboBox_val, Val_int)
ML_1(gtk_combo_box_get_has_entry,GtkComboBox_val, Val_bool)
ML_1(gtk_combo_box_get_focus_on_click,GtkComboBox_val, Val_bool)
ML_1(gtk_combo_box_get_entry_text_column,GtkComboBox_val, Val_int)
ML_1(gtk_combo_box_get_column_span_column,GtkComboBox_val, Val_int)
ML_1(gtk_combo_box_get_add_tearoffs,GtkComboBox_val, Val_bool)
ML_1(gtk_combo_box_get_active_id,GtkComboBox_val, Val_string)
ML_1(gtk_combo_box_get_active,GtkComboBox_val, Val_int)
/* end of ComboBox */
/* Module ColorSelectionPrivate */
/* end of ColorSelectionPrivate */
/* Module ColorSelectionDialogPrivate */
/* end of ColorSelectionDialogPrivate */
/* Module ColorSelectionDialogClass */
/* end of ColorSelectionDialogClass */
/* Module ColorSelectionDialog */
ML_1(gtk_color_selection_dialog_get_color_selection,GtkColorSelectionDialog_val, Val_GtkWidget)
/* end of ColorSelectionDialog */
/* Module ColorSelectionClass */
/* end of ColorSelectionClass */
/* Module ColorSelection */
ML_2(gtk_color_selection_set_previous_rgba,GtkColorSelection_val, GdkRGBA_val, Unit)
ML_2(gtk_color_selection_set_previous_color,GtkColorSelection_val, GdkColor_val, Unit)
ML_2(gtk_color_selection_set_previous_alpha,GtkColorSelection_val, Int_val, Unit)
ML_2(gtk_color_selection_set_has_palette,GtkColorSelection_val, Bool_val, Unit)
ML_2(gtk_color_selection_set_has_opacity_control,GtkColorSelection_val, Bool_val, Unit)
ML_2(gtk_color_selection_set_current_rgba,GtkColorSelection_val, GdkRGBA_val, Unit)
ML_2(gtk_color_selection_set_current_color,GtkColorSelection_val, GdkColor_val, Unit)
ML_2(gtk_color_selection_set_current_alpha,GtkColorSelection_val, Int_val, Unit)
ML_1(gtk_color_selection_is_adjusting,GtkColorSelection_val, Val_bool)
ML_1(gtk_color_selection_get_previous_alpha,GtkColorSelection_val, Val_int)
ML_1(gtk_color_selection_get_has_palette,GtkColorSelection_val, Val_bool)
ML_1(gtk_color_selection_get_has_opacity_control,GtkColorSelection_val, Val_bool)
ML_1(gtk_color_selection_get_current_alpha,GtkColorSelection_val, Val_int)
/* end of ColorSelection */
/* Module ColorButtonPrivate */
/* end of ColorButtonPrivate */
/* Module ColorButtonClass */
/* end of ColorButtonClass */
/* Module ColorButton */
ML_2(gtk_color_button_set_use_alpha,GtkColorButton_val, Bool_val, Unit)
ML_2(gtk_color_button_set_title,GtkColorButton_val, String_val, Unit)
ML_2(gtk_color_button_set_rgba,GtkColorButton_val, GdkRGBA_val, Unit)
ML_2(gtk_color_button_set_color,GtkColorButton_val, GdkColor_val, Unit)
ML_2(gtk_color_button_set_alpha,GtkColorButton_val, Int_val, Unit)
ML_1(gtk_color_button_get_use_alpha,GtkColorButton_val, Val_bool)
ML_1(gtk_color_button_get_title,GtkColorButton_val, Val_string)
ML_1(gtk_color_button_get_alpha,GtkColorButton_val, Val_int)
/* end of ColorButton */
/* Module Clipboard */
ML_1(gtk_clipboard_wait_is_uris_available,GtkClipboard_val, Val_bool)
ML_1(gtk_clipboard_wait_is_text_available,GtkClipboard_val, Val_bool)
ML_2(gtk_clipboard_wait_is_rich_text_available,GtkClipboard_val, GtkTextBuffer_val, Val_bool)
ML_1(gtk_clipboard_wait_is_image_available,GtkClipboard_val, Val_bool)
ML_1(gtk_clipboard_wait_for_text,GtkClipboard_val, Val_string_new)
ML_1(gtk_clipboard_wait_for_image,GtkClipboard_val, Val_GdkPixbuf_new)
ML_1(gtk_clipboard_store,GtkClipboard_val, Unit)
ML_3(gtk_clipboard_set_text,GtkClipboard_val, String_val, Int_val, Unit)
ML_2(gtk_clipboard_set_image,GtkClipboard_val, GdkPixbuf_val, Unit)
ML_1(gtk_clipboard_get_display,GtkClipboard_val, Val_GdkDisplay)
ML_1(gtk_clipboard_clear,GtkClipboard_val, Unit)
/* end of Clipboard */
/* Module CheckMenuItemPrivate */
/* end of CheckMenuItemPrivate */
/* Module CheckMenuItemClass */
/* end of CheckMenuItemClass */
/* Module CheckMenuItem */
ML_1(gtk_check_menu_item_toggled,GtkCheckMenuItem_val, Unit)
ML_2(gtk_check_menu_item_set_inconsistent,GtkCheckMenuItem_val, Bool_val, Unit)
ML_2(gtk_check_menu_item_set_draw_as_radio,GtkCheckMenuItem_val, Bool_val, Unit)
ML_2(gtk_check_menu_item_set_active,GtkCheckMenuItem_val, Bool_val, Unit)
ML_1(gtk_check_menu_item_get_inconsistent,GtkCheckMenuItem_val, Val_bool)
ML_1(gtk_check_menu_item_get_draw_as_radio,GtkCheckMenuItem_val, Val_bool)
ML_1(gtk_check_menu_item_get_active,GtkCheckMenuItem_val, Val_bool)
/* end of CheckMenuItem */
/* Module CheckButtonClass */
/* end of CheckButtonClass */
/* Module CheckButton */
/* end of CheckButton */
/* Module CellViewPrivate */
/* end of CellViewPrivate */
/* Module CellViewClass */
/* end of CellViewClass */
/* Module CellView */
ML_2(gtk_cell_view_set_fit_model,GtkCellView_val, Bool_val, Unit)
ML_2(gtk_cell_view_set_draw_sensitive,GtkCellView_val, Bool_val, Unit)
ML_2(gtk_cell_view_set_displayed_row,GtkCellView_val, Option_val(arg2,GtkTreePath_val,NULL) Ignore, Unit)
ML_2(gtk_cell_view_set_background_rgba,GtkCellView_val, GdkRGBA_val, Unit)
ML_2(gtk_cell_view_set_background_color,GtkCellView_val, GdkColor_val, Unit)
ML_1(gtk_cell_view_get_fit_model,GtkCellView_val, Val_bool)
ML_1(gtk_cell_view_get_draw_sensitive,GtkCellView_val, Val_bool)
ML_1(gtk_cell_view_get_displayed_row,GtkCellView_val, Val_GtkTreePath_new)
/* end of CellView */
/* Module CellRendererTogglePrivate */
/* end of CellRendererTogglePrivate */
/* Module CellRendererToggleClass */
/* end of CellRendererToggleClass */
/* Module CellRendererToggle */
ML_2(gtk_cell_renderer_toggle_set_radio,GtkCellRendererToggle_val, Bool_val, Unit)
ML_2(gtk_cell_renderer_toggle_set_active,GtkCellRendererToggle_val, Bool_val, Unit)
ML_2(gtk_cell_renderer_toggle_set_activatable,GtkCellRendererToggle_val, Bool_val, Unit)
ML_1(gtk_cell_renderer_toggle_get_radio,GtkCellRendererToggle_val, Val_bool)
ML_1(gtk_cell_renderer_toggle_get_active,GtkCellRendererToggle_val, Val_bool)
ML_1(gtk_cell_renderer_toggle_get_activatable,GtkCellRendererToggle_val, Val_bool)
/* end of CellRendererToggle */
/* Module CellRendererTextPrivate */
/* end of CellRendererTextPrivate */
/* Module CellRendererTextClass */
/* end of CellRendererTextClass */
/* Module CellRendererText */
ML_2(gtk_cell_renderer_text_set_fixed_height_from_font,GtkCellRendererText_val, Int_val, Unit)
/* end of CellRendererText */
/* Module CellRendererSpinnerPrivate */
/* end of CellRendererSpinnerPrivate */
/* Module CellRendererSpinnerClass */
/* end of CellRendererSpinnerClass */
/* Module CellRendererSpinner */
/* end of CellRendererSpinner */
/* Module CellRendererSpinPrivate */
/* end of CellRendererSpinPrivate */
/* Module CellRendererSpinClass */
/* end of CellRendererSpinClass */
/* Module CellRendererSpin */
/* end of CellRendererSpin */
/* Module CellRendererProgressPrivate */
/* end of CellRendererProgressPrivate */
/* Module CellRendererProgressClass */
/* end of CellRendererProgressClass */
/* Module CellRendererProgress */
/* end of CellRendererProgress */
/* Module CellRendererPrivate */
/* end of CellRendererPrivate */
/* Module CellRendererPixbufPrivate */
/* end of CellRendererPixbufPrivate */
/* Module CellRendererPixbufClass */
/* end of CellRendererPixbufClass */
/* Module CellRendererPixbuf */
/* end of CellRendererPixbuf */
/* Module CellRendererComboPrivate */
/* end of CellRendererComboPrivate */
/* Module CellRendererComboClass */
/* end of CellRendererComboClass */
/* Module CellRendererCombo */
/* end of CellRendererCombo */
/* Module CellRendererClass */
/* end of CellRendererClass */
/* Module CellRendererAccelPrivate */
/* end of CellRendererAccelPrivate */
/* Module CellRendererAccelClass */
/* end of CellRendererAccelClass */
/* Module CellRendererAccel */
/* end of CellRendererAccel */
/* Module CellRenderer */
ML_2(gtk_cell_renderer_stop_editing,GtkCellRenderer_val, Bool_val, Unit)
ML_2(gtk_cell_renderer_set_visible,GtkCellRenderer_val, Bool_val, Unit)
ML_2(gtk_cell_renderer_set_sensitive,GtkCellRenderer_val, Bool_val, Unit)
ML_3(gtk_cell_renderer_set_padding,GtkCellRenderer_val, Int_val, Int_val, Unit)
ML_3(gtk_cell_renderer_set_fixed_size,GtkCellRenderer_val, Int_val, Int_val, Unit)
ML_1(gtk_cell_renderer_is_activatable,GtkCellRenderer_val, Val_bool)
ML_1(gtk_cell_renderer_get_visible,GtkCellRenderer_val, Val_bool)
ML_1(gtk_cell_renderer_get_sensitive,GtkCellRenderer_val, Val_bool)
/* end of CellRenderer */
/* Module CellLayoutIface */
/* end of CellLayoutIface */
/* Module CellEditableIface */
/* end of CellEditableIface */
/* Module CellAreaPrivate */
/* end of CellAreaPrivate */
/* Module CellAreaContextPrivate */
/* end of CellAreaContextPrivate */
/* Module CellAreaContextClass */
/* end of CellAreaContextClass */
/* Module CellAreaContext */
ML_1(gtk_cell_area_context_reset,GtkCellAreaContext_val, Unit)
ML_3(gtk_cell_area_context_push_preferred_width,GtkCellAreaContext_val, Int_val, Int_val, Unit)
ML_3(gtk_cell_area_context_push_preferred_height,GtkCellAreaContext_val, Int_val, Int_val, Unit)
ML_1(gtk_cell_area_context_get_area,GtkCellAreaContext_val, Val_GtkCellArea)
ML_3(gtk_cell_area_context_allocate,GtkCellAreaContext_val, Int_val, Int_val, Unit)
/* end of CellAreaContext */
/* Module CellAreaClass */
ML_3(gtk_cell_area_class_install_cell_property,GtkCellAreaClass_val, Int_val, GParamSpec_val, Unit)
ML_2(gtk_cell_area_class_find_cell_property,GtkCellAreaClass_val, String_val, Val_GParamSpec)
/* end of CellAreaClass */
/* Module CellAreaBoxPrivate */
/* end of CellAreaBoxPrivate */
/* Module CellAreaBoxClass */
/* end of CellAreaBoxClass */
/* Module CellAreaBox */
ML_2(gtk_cell_area_box_set_spacing,GtkCellAreaBox_val, Int_val, Unit)
ML_5(gtk_cell_area_box_pack_start,GtkCellAreaBox_val, GtkCellRenderer_val, Bool_val, Bool_val, Bool_val, Unit)
ML_5(gtk_cell_area_box_pack_end,GtkCellAreaBox_val, GtkCellRenderer_val, Bool_val, Bool_val, Bool_val, Unit)
ML_1(gtk_cell_area_box_get_spacing,GtkCellAreaBox_val, Val_int)
/* end of CellAreaBox */
/* Module CellArea */
ML_2(gtk_cell_area_stop_editing,GtkCellArea_val, Bool_val, Unit)
ML_2(gtk_cell_area_set_focus_cell,GtkCellArea_val, GtkCellRenderer_val, Unit)
ML_3(gtk_cell_area_remove_focus_sibling,GtkCellArea_val, GtkCellRenderer_val, GtkCellRenderer_val, Unit)
ML_2(gtk_cell_area_remove,GtkCellArea_val, GtkCellRenderer_val, Unit)
ML_3(gtk_cell_area_is_focus_sibling,GtkCellArea_val, GtkCellRenderer_val, GtkCellRenderer_val, Val_bool)
ML_1(gtk_cell_area_is_activatable,GtkCellArea_val, Val_bool)
ML_2(gtk_cell_area_has_renderer,GtkCellArea_val, GtkCellRenderer_val, Val_bool)
ML_2(gtk_cell_area_get_focus_siblings,GtkCellArea_val, GtkCellRenderer_val, Val_GList)
ML_2(gtk_cell_area_get_focus_from_sibling,GtkCellArea_val, GtkCellRenderer_val, Val_GtkCellRenderer)
ML_1(gtk_cell_area_get_focus_cell,GtkCellArea_val, Val_GtkCellRenderer)
ML_1(gtk_cell_area_get_edited_cell,GtkCellArea_val, Val_GtkCellRenderer)
ML_1(gtk_cell_area_get_current_path_string,GtkCellArea_val, Val_string)
ML_1(gtk_cell_area_create_context,GtkCellArea_val, Val_GtkCellAreaContext_new)
ML_2(gtk_cell_area_copy_context,GtkCellArea_val, GtkCellAreaContext_val, Val_GtkCellAreaContext_new)
ML_4(gtk_cell_area_cell_set_property,GtkCellArea_val, GtkCellRenderer_val, String_val, GValue_val, Unit)
ML_4(gtk_cell_area_cell_get_property,GtkCellArea_val, GtkCellRenderer_val, String_val, GValue_val, Unit)
ML_3(gtk_cell_area_attribute_disconnect,GtkCellArea_val, GtkCellRenderer_val, String_val, Unit)
ML_4(gtk_cell_area_attribute_connect,GtkCellArea_val, GtkCellRenderer_val, String_val, Int_val, Unit)
ML_3(gtk_cell_area_add_focus_sibling,GtkCellArea_val, GtkCellRenderer_val, GtkCellRenderer_val, Unit)
ML_2(gtk_cell_area_add,GtkCellArea_val, GtkCellRenderer_val, Unit)
/* end of CellArea */
/* Module CalendarPrivate */
/* end of CalendarPrivate */
/* Module CalendarClass */
/* end of CalendarClass */
/* Module Calendar */
ML_2(gtk_calendar_unmark_day,GtkCalendar_val, Int_val, Unit)
ML_2(gtk_calendar_set_detail_width_chars,GtkCalendar_val, Int_val, Unit)
ML_2(gtk_calendar_set_detail_height_rows,GtkCalendar_val, Int_val, Unit)
ML_3(gtk_calendar_select_month,GtkCalendar_val, Int_val, Int_val, Unit)
ML_2(gtk_calendar_select_day,GtkCalendar_val, Int_val, Unit)
ML_2(gtk_calendar_mark_day,GtkCalendar_val, Int_val, Unit)
ML_1(gtk_calendar_get_detail_width_chars,GtkCalendar_val, Val_int)
ML_1(gtk_calendar_get_detail_height_rows,GtkCalendar_val, Val_int)
ML_2(gtk_calendar_get_day_is_marked,GtkCalendar_val, Int_val, Val_bool)
ML_1(gtk_calendar_clear_marks,GtkCalendar_val, Unit)
/* end of Calendar */
/* Module ButtonPrivate */
/* end of ButtonPrivate */
/* Module ButtonClass */
/* end of ButtonClass */
/* Module ButtonBoxPrivate */
/* end of ButtonBoxPrivate */
/* Module ButtonBoxClass */
/* end of ButtonBoxClass */
/* Module ButtonBox */
ML_3(gtk_button_box_set_child_secondary,GtkButtonBox_val, GtkWidget_val, Bool_val, Unit)
ML_2(gtk_button_box_get_child_secondary,GtkButtonBox_val, GtkWidget_val, Val_bool)
/* end of ButtonBox */
/* Module Button */
ML_2(gtk_button_set_use_underline,GtkButton_val, Bool_val, Unit)
ML_2(gtk_button_set_use_stock,GtkButton_val, Bool_val, Unit)
ML_2(gtk_button_set_label,GtkButton_val, String_val, Unit)
ML_2(gtk_button_set_image,GtkButton_val, GtkWidget_val, Unit)
ML_2(gtk_button_set_focus_on_click,GtkButton_val, Bool_val, Unit)
ML_1(gtk_button_released,GtkButton_val, Unit)
ML_1(gtk_button_pressed,GtkButton_val, Unit)
ML_1(gtk_button_leave,GtkButton_val, Unit)
ML_1(gtk_button_get_use_underline,GtkButton_val, Val_bool)
ML_1(gtk_button_get_use_stock,GtkButton_val, Val_bool)
ML_1(gtk_button_get_label,GtkButton_val, Val_string)
ML_1(gtk_button_get_image,GtkButton_val, Val_GtkWidget)
ML_1(gtk_button_get_focus_on_click,GtkButton_val, Val_bool)
ML_1(gtk_button_get_event_window,GtkButton_val, Val_GdkWindow)
ML_1(gtk_button_enter,GtkButton_val, Unit)
ML_1(gtk_button_clicked,GtkButton_val, Unit)
/* end of Button */
/* Module BuilderPrivate */
/* end of BuilderPrivate */
/* Module BuilderClass */
/* end of BuilderClass */
/* Module Builder */
ML_2(gtk_builder_set_translation_domain,GtkBuilder_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_builder_get_type_from_name,GtkBuilder_val, String_val, Val_int)
ML_1(gtk_builder_get_translation_domain,GtkBuilder_val, Val_string)
ML_1(gtk_builder_get_objects,GtkBuilder_val, Val_GSList)
/* end of Builder */
/* Module BuildableIface */
/* end of BuildableIface */
/* Module BoxPrivate */
/* end of BoxPrivate */
/* Module BoxClass */
/* end of BoxClass */
/* Module Box */
ML_2(gtk_box_set_spacing,GtkBox_val, Int_val, Unit)
ML_2(gtk_box_set_homogeneous,GtkBox_val, Bool_val, Unit)
ML_3(gtk_box_reorder_child,GtkBox_val, GtkWidget_val, Int_val, Unit)
ML_5(gtk_box_pack_start,GtkBox_val, GtkWidget_val, Bool_val, Bool_val, Int_val, Unit)
ML_5(gtk_box_pack_end,GtkBox_val, GtkWidget_val, Bool_val, Bool_val, Int_val, Unit)
ML_1(gtk_box_get_spacing,GtkBox_val, Val_int)
ML_1(gtk_box_get_homogeneous,GtkBox_val, Val_bool)
/* end of Box */
/* Module Border */
ML_1(gtk_border_free,GtkBorder_val, Unit)
ML_1(gtk_border_copy,GtkBorder_val, Val_GtkBorder_new)
/* end of Border */
/* Module BindingSignal */
/* end of BindingSignal */
/* Module BindingSet */
/* end of BindingSet */
/* Module BindingEntry */
/* end of BindingEntry */
/* Module BindingArg */
/* end of BindingArg */
/* Module BinPrivate */
/* end of BinPrivate */
/* Module BinClass */
/* end of BinClass */
/* Module Bin */
ML_1(gtk_bin_get_child,GtkBin_val, Val_GtkWidget)
/* end of Bin */
/* Module AssistantPrivate */
/* end of AssistantPrivate */
/* Module AssistantClass */
/* end of AssistantClass */
/* Module Assistant */
ML_1(gtk_assistant_update_buttons_state,GtkAssistant_val, Unit)
ML_3(gtk_assistant_set_page_title,GtkAssistant_val, GtkWidget_val, String_val, Unit)
ML_3(gtk_assistant_set_page_side_image,GtkAssistant_val, GtkWidget_val, Option_val(arg3,GdkPixbuf_val,NULL) Ignore, Unit)
ML_3(gtk_assistant_set_page_header_image,GtkAssistant_val, GtkWidget_val, Option_val(arg3,GdkPixbuf_val,NULL) Ignore, Unit)
ML_3(gtk_assistant_set_page_complete,GtkAssistant_val, GtkWidget_val, Bool_val, Unit)
ML_2(gtk_assistant_set_current_page,GtkAssistant_val, Int_val, Unit)
ML_2(gtk_assistant_remove_action_widget,GtkAssistant_val, GtkWidget_val, Unit)
ML_1(gtk_assistant_previous_page,GtkAssistant_val, Unit)
ML_2(gtk_assistant_prepend_page,GtkAssistant_val, GtkWidget_val, Val_int)
ML_1(gtk_assistant_next_page,GtkAssistant_val, Unit)
ML_3(gtk_assistant_insert_page,GtkAssistant_val, GtkWidget_val, Int_val, Val_int)
ML_2(gtk_assistant_get_page_title,GtkAssistant_val, GtkWidget_val, Val_string)
ML_2(gtk_assistant_get_page_side_image,GtkAssistant_val, GtkWidget_val, Val_GdkPixbuf)
ML_2(gtk_assistant_get_page_header_image,GtkAssistant_val, GtkWidget_val, Val_GdkPixbuf)
ML_2(gtk_assistant_get_page_complete,GtkAssistant_val, GtkWidget_val, Val_bool)
ML_2(gtk_assistant_get_nth_page,GtkAssistant_val, Int_val, Val_GtkWidget)
ML_1(gtk_assistant_get_n_pages,GtkAssistant_val, Val_int)
ML_1(gtk_assistant_get_current_page,GtkAssistant_val, Val_int)
ML_1(gtk_assistant_commit,GtkAssistant_val, Unit)
ML_2(gtk_assistant_append_page,GtkAssistant_val, GtkWidget_val, Val_int)
ML_2(gtk_assistant_add_action_widget,GtkAssistant_val, GtkWidget_val, Unit)
/* end of Assistant */
/* Module AspectFramePrivate */
/* end of AspectFramePrivate */
/* Module AspectFrameClass */
/* end of AspectFrameClass */
/* Module AspectFrame */
/* end of AspectFrame */
/* Module ArrowPrivate */
/* end of ArrowPrivate */
/* Module ArrowClass */
/* end of ArrowClass */
/* Module Arrow */
/* end of Arrow */
/* Module ApplicationPrivate */
/* end of ApplicationPrivate */
/* Module ApplicationClass */
/* end of ApplicationClass */
/* Module Application */
ML_2(gtk_application_remove_window,GtkApplication_val, GtkWindow_val, Unit)
ML_1(gtk_application_get_windows,GtkApplication_val, Val_GList)
ML_2(gtk_application_add_window,GtkApplication_val, GtkWindow_val, Unit)
/* end of Application */
/* Module AppChooserWidgetPrivate */
/* end of AppChooserWidgetPrivate */
/* Module AppChooserWidgetClass */
/* end of AppChooserWidgetClass */
/* Module AppChooserWidget */
ML_2(gtk_app_chooser_widget_set_show_recommended,GtkAppChooserWidget_val, Bool_val, Unit)
ML_2(gtk_app_chooser_widget_set_show_other,GtkAppChooserWidget_val, Bool_val, Unit)
ML_2(gtk_app_chooser_widget_set_show_fallback,GtkAppChooserWidget_val, Bool_val, Unit)
ML_2(gtk_app_chooser_widget_set_show_default,GtkAppChooserWidget_val, Bool_val, Unit)
ML_2(gtk_app_chooser_widget_set_show_all,GtkAppChooserWidget_val, Bool_val, Unit)
ML_2(gtk_app_chooser_widget_set_default_text,GtkAppChooserWidget_val, String_val, Unit)
ML_1(gtk_app_chooser_widget_get_show_recommended,GtkAppChooserWidget_val, Val_bool)
ML_1(gtk_app_chooser_widget_get_show_other,GtkAppChooserWidget_val, Val_bool)
ML_1(gtk_app_chooser_widget_get_show_fallback,GtkAppChooserWidget_val, Val_bool)
ML_1(gtk_app_chooser_widget_get_show_default,GtkAppChooserWidget_val, Val_bool)
ML_1(gtk_app_chooser_widget_get_show_all,GtkAppChooserWidget_val, Val_bool)
ML_1(gtk_app_chooser_widget_get_default_text,GtkAppChooserWidget_val, Val_string)
/* end of AppChooserWidget */
/* Module AppChooserDialogPrivate */
/* end of AppChooserDialogPrivate */
/* Module AppChooserDialogClass */
/* end of AppChooserDialogClass */
/* Module AppChooserDialog */
ML_2(gtk_app_chooser_dialog_set_heading,GtkAppChooserDialog_val, String_val, Unit)
ML_1(gtk_app_chooser_dialog_get_widget,GtkAppChooserDialog_val, Val_GtkWidget)
ML_1(gtk_app_chooser_dialog_get_heading,GtkAppChooserDialog_val, Val_string)
/* end of AppChooserDialog */
/* Module AppChooserButtonPrivate */
/* end of AppChooserButtonPrivate */
/* Module AppChooserButtonClass */
/* end of AppChooserButtonClass */
/* Module AppChooserButton */
ML_2(gtk_app_chooser_button_set_show_dialog_item,GtkAppChooserButton_val, Bool_val, Unit)
ML_2(gtk_app_chooser_button_set_heading,GtkAppChooserButton_val, String_val, Unit)
ML_2(gtk_app_chooser_button_set_active_custom_item,GtkAppChooserButton_val, String_val, Unit)
ML_1(gtk_app_chooser_button_get_show_dialog_item,GtkAppChooserButton_val, Val_bool)
ML_1(gtk_app_chooser_button_get_heading,GtkAppChooserButton_val, Val_string)
ML_1(gtk_app_chooser_button_append_separator,GtkAppChooserButton_val, Unit)
/* end of AppChooserButton */
/* Module AlignmentPrivate */
/* end of AlignmentPrivate */
/* Module AlignmentClass */
/* end of AlignmentClass */
/* Module Alignment */
ML_5(gtk_alignment_set_padding,GtkAlignment_val, Int_val, Int_val, Int_val, Int_val, Unit)
/* end of Alignment */
/* Module AdjustmentPrivate */
/* end of AdjustmentPrivate */
/* Module AdjustmentClass */
/* end of AdjustmentClass */
/* Module Adjustment */
ML_1(gtk_adjustment_value_changed,GtkAdjustment_val, Unit)
ML_2(gtk_adjustment_set_value,GtkAdjustment_val, Double_val, Unit)
ML_2(gtk_adjustment_set_upper,GtkAdjustment_val, Double_val, Unit)
ML_2(gtk_adjustment_set_step_increment,GtkAdjustment_val, Double_val, Unit)
ML_2(gtk_adjustment_set_page_size,GtkAdjustment_val, Double_val, Unit)
ML_2(gtk_adjustment_set_page_increment,GtkAdjustment_val, Double_val, Unit)
ML_2(gtk_adjustment_set_lower,GtkAdjustment_val, Double_val, Unit)
ML_1(gtk_adjustment_get_value,GtkAdjustment_val, Val_double)
ML_1(gtk_adjustment_get_upper,GtkAdjustment_val, Val_double)
ML_1(gtk_adjustment_get_step_increment,GtkAdjustment_val, Val_double)
ML_1(gtk_adjustment_get_page_size,GtkAdjustment_val, Val_double)
ML_1(gtk_adjustment_get_page_increment,GtkAdjustment_val, Val_double)
ML_1(gtk_adjustment_get_lower,GtkAdjustment_val, Val_double)
ML_7(gtk_adjustment_configure,GtkAdjustment_val, Double_val, Double_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc7(ml_gtk_adjustment_configure)
ML_3(gtk_adjustment_clamp_page,GtkAdjustment_val, Double_val, Double_val, Unit)
ML_1(gtk_adjustment_changed,GtkAdjustment_val, Unit)
/* end of Adjustment */
/* Module ActivatableIface */
/* end of ActivatableIface */
/* Module ActionPrivate */
/* end of ActionPrivate */
/* Module ActionGroupPrivate */
/* end of ActionGroupPrivate */
/* Module ActionGroupClass */
/* end of ActionGroupClass */
/* Module ActionGroup */
ML_2(gtk_action_group_translate_string,GtkActionGroup_val, String_val, Val_string)
ML_2(gtk_action_group_set_visible,GtkActionGroup_val, Bool_val, Unit)
ML_2(gtk_action_group_set_translation_domain,GtkActionGroup_val, String_val, Unit)
ML_2(gtk_action_group_set_sensitive,GtkActionGroup_val, Bool_val, Unit)
ML_2(gtk_action_group_remove_action,GtkActionGroup_val, GtkAction_val, Unit)
ML_1(gtk_action_group_list_actions,GtkActionGroup_val, Val_GList)
ML_1(gtk_action_group_get_visible,GtkActionGroup_val, Val_bool)
ML_1(gtk_action_group_get_sensitive,GtkActionGroup_val, Val_bool)
ML_1(gtk_action_group_get_name,GtkActionGroup_val, Val_string)
ML_2(gtk_action_group_get_action,GtkActionGroup_val, String_val, Val_GtkAction)
ML_3(gtk_action_group_add_action_with_accel,GtkActionGroup_val, GtkAction_val, Option_val(arg3,String_val,NULL) Ignore, Unit)
ML_2(gtk_action_group_add_action,GtkActionGroup_val, GtkAction_val, Unit)
/* end of ActionGroup */
/* Module ActionEntry */
/* end of ActionEntry */
/* Module ActionClass */
/* end of ActionClass */
/* Module Action */
ML_1(gtk_action_unblock_activate,GtkAction_val, Unit)
ML_2(gtk_action_set_visible_vertical,GtkAction_val, Bool_val, Unit)
ML_2(gtk_action_set_visible_horizontal,GtkAction_val, Bool_val, Unit)
ML_2(gtk_action_set_visible,GtkAction_val, Bool_val, Unit)
ML_2(gtk_action_set_tooltip,GtkAction_val, String_val, Unit)
ML_2(gtk_action_set_stock_id,GtkAction_val, String_val, Unit)
ML_2(gtk_action_set_short_label,GtkAction_val, String_val, Unit)
ML_2(gtk_action_set_sensitive,GtkAction_val, Bool_val, Unit)
ML_2(gtk_action_set_label,GtkAction_val, String_val, Unit)
ML_2(gtk_action_set_is_important,GtkAction_val, Bool_val, Unit)
ML_2(gtk_action_set_icon_name,GtkAction_val, String_val, Unit)
ML_2(gtk_action_set_always_show_image,GtkAction_val, Bool_val, Unit)
ML_2(gtk_action_set_accel_path,GtkAction_val, String_val, Unit)
ML_2(gtk_action_set_accel_group,GtkAction_val, Option_val(arg2,GtkAccelGroup_val,NULL) Ignore, Unit)
ML_1(gtk_action_is_visible,GtkAction_val, Val_bool)
ML_1(gtk_action_is_sensitive,GtkAction_val, Val_bool)
ML_1(gtk_action_get_visible_vertical,GtkAction_val, Val_bool)
ML_1(gtk_action_get_visible_horizontal,GtkAction_val, Val_bool)
ML_1(gtk_action_get_visible,GtkAction_val, Val_bool)
ML_1(gtk_action_get_tooltip,GtkAction_val, Val_string)
ML_1(gtk_action_get_stock_id,GtkAction_val, Val_string)
ML_1(gtk_action_get_short_label,GtkAction_val, Val_string)
ML_1(gtk_action_get_sensitive,GtkAction_val, Val_bool)
ML_1(gtk_action_get_proxies,GtkAction_val, Val_GSList)
ML_1(gtk_action_get_name,GtkAction_val, Val_string)
ML_1(gtk_action_get_label,GtkAction_val, Val_string)
ML_1(gtk_action_get_is_important,GtkAction_val, Val_bool)
ML_1(gtk_action_get_icon_name,GtkAction_val, Val_string)
ML_1(gtk_action_get_always_show_image,GtkAction_val, Val_bool)
ML_1(gtk_action_get_accel_path,GtkAction_val, Val_string)
ML_1(gtk_action_get_accel_closure,GtkAction_val, Val_GClosure)
ML_1(gtk_action_disconnect_accelerator,GtkAction_val, Unit)
ML_1(gtk_action_create_tool_item,GtkAction_val, Val_GtkWidget)
ML_1(gtk_action_create_menu_item,GtkAction_val, Val_GtkWidget)
ML_1(gtk_action_create_menu,GtkAction_val, Val_GtkWidget)
ML_1(gtk_action_connect_accelerator,GtkAction_val, Unit)
ML_1(gtk_action_block_activate,GtkAction_val, Unit)
ML_1(gtk_action_activate,GtkAction_val, Unit)
/* end of Action */
/* Module AccessiblePrivate */
/* end of AccessiblePrivate */
/* Module AccessibleClass */
/* end of AccessibleClass */
/* Module Accessible */
ML_2(gtk_accessible_set_widget,GtkAccessible_val, GtkWidget_val, Unit)
ML_1(gtk_accessible_get_widget,GtkAccessible_val, Val_GtkWidget)
ML_1(gtk_accessible_connect_widget_destroyed,GtkAccessible_val, Unit)
/* end of Accessible */
/* Module AccelMapClass */
/* end of AccelMapClass */
/* Module AccelMap */
ML_1(gtk_accel_map_unlock_path,String_val, Unit)
ML_1(gtk_accel_map_save_fd,Int_val, Unit)
ML_1(gtk_accel_map_lock_path,String_val, Unit)
ML_1(gtk_accel_map_load_scanner,GScanner_val, Unit)
ML_1(gtk_accel_map_load_fd,Int_val, Unit)
ML_0(gtk_accel_map_get,Val_GtkAccelMap)
ML_1(gtk_accel_map_add_filter,String_val, Unit)
/* end of AccelMap */
/* Module AccelLabelPrivate */
/* end of AccelLabelPrivate */
/* Module AccelLabelClass */
/* end of AccelLabelClass */
/* Module AccelLabel */
ML_2(gtk_accel_label_set_accel_widget,GtkAccelLabel_val, GtkWidget_val, Unit)
ML_2(gtk_accel_label_set_accel_closure,GtkAccelLabel_val, GClosure_val, Unit)
ML_1(gtk_accel_label_refetch,GtkAccelLabel_val, Val_bool)
ML_1(gtk_accel_label_get_accel_width,GtkAccelLabel_val, Val_int)
ML_1(gtk_accel_label_get_accel_widget,GtkAccelLabel_val, Val_GtkWidget)
/* end of AccelLabel */
/* Module AccelKey */
/* end of AccelKey */
/* Module AccelGroupPrivate */
/* end of AccelGroupPrivate */
/* Module AccelGroupEntry */
/* end of AccelGroupEntry */
/* Module AccelGroupClass */
/* end of AccelGroupClass */
/* Module AccelGroup */
ML_1(gtk_accel_group_unlock,GtkAccelGroup_val, Unit)
ML_1(gtk_accel_group_lock,GtkAccelGroup_val, Unit)
ML_1(gtk_accel_group_get_is_locked,GtkAccelGroup_val, Val_bool)
ML_2(gtk_accel_group_disconnect,GtkAccelGroup_val, Option_val(arg2,GClosure_val,NULL) Ignore, Val_bool)
ML_3(gtk_accel_group_connect_by_path,GtkAccelGroup_val, String_val, GClosure_val, Unit)
ML_1(gtk_accel_group_from_accel_closure,GClosure_val, Val_GtkAccelGroup)
/* end of AccelGroup */
/* Module AboutDialogPrivate */
/* end of AboutDialogPrivate */
/* Module AboutDialogClass */
/* end of AboutDialogClass */
/* Module AboutDialog */
ML_2(gtk_about_dialog_set_wrap_license,GtkAboutDialog_val, Bool_val, Unit)
ML_2(gtk_about_dialog_set_website_label,GtkAboutDialog_val, String_val, Unit)
ML_2(gtk_about_dialog_set_website,GtkAboutDialog_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_about_dialog_set_version,GtkAboutDialog_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_about_dialog_set_translator_credits,GtkAboutDialog_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_about_dialog_set_program_name,GtkAboutDialog_val, String_val, Unit)
ML_2(gtk_about_dialog_set_logo_icon_name,GtkAboutDialog_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_about_dialog_set_logo,GtkAboutDialog_val, Option_val(arg2,GdkPixbuf_val,NULL) Ignore, Unit)
ML_2(gtk_about_dialog_set_license,GtkAboutDialog_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_2(gtk_about_dialog_set_copyright,GtkAboutDialog_val, String_val, Unit)
ML_2(gtk_about_dialog_set_comments,GtkAboutDialog_val, Option_val(arg2,String_val,NULL) Ignore, Unit)
ML_1(gtk_about_dialog_get_wrap_license,GtkAboutDialog_val, Val_bool)
ML_1(gtk_about_dialog_get_website_label,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_website,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_version,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_translator_credits,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_program_name,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_logo_icon_name,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_logo,GtkAboutDialog_val, Val_GdkPixbuf)
ML_1(gtk_about_dialog_get_license,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_copyright,GtkAboutDialog_val, Val_string)
ML_1(gtk_about_dialog_get_comments,GtkAboutDialog_val, Val_string)
/* end of AboutDialog */
/* Global functions */
ML_0(gtk_true,Val_bool)
ML_2(gtk_test_text_set,GtkWidget_val, String_val, Unit)
ML_1(gtk_test_text_get,GtkWidget_val, Val_string_new)
ML_3(gtk_test_spin_button_click,GtkSpinButton_val, Int_val, Bool_val, Val_bool)
ML_2(gtk_test_slider_set_perc,GtkWidget_val, Double_val, Unit)
ML_1(gtk_test_slider_get_value,GtkWidget_val, Val_double)
ML_0(gtk_test_register_all_types,Unit)
ML_3(gtk_test_find_widget,GtkWidget_val, String_val, Int_val, Val_GtkWidget)
ML_2(gtk_test_find_sibling,GtkWidget_val, Int_val, Val_GtkWidget)
ML_2(gtk_test_find_label,GtkWidget_val, String_val, Val_GtkWidget)
ML_2(gtk_test_create_simple_window,String_val, String_val, Val_GtkWidget)
ML_0(gtk_stock_list_ids,Val_GSList_new)
ML_1(gtk_set_debug_flags,Int_val, Unit)
ML_1(gtk_selection_remove_all,GtkWidget_val, Unit)
ML_6(gtk_render_option,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_option)
ML_6(gtk_render_line,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_line)
ML_5(gtk_render_layout,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, PangoLayout_val, Unit)
ML_6(gtk_render_handle,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_handle)
ML_6(gtk_render_frame,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_frame)
ML_6(gtk_render_focus,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_focus)
ML_6(gtk_render_expander,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_expander)
ML_6(gtk_render_check,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_check)
ML_6(gtk_render_background,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_background)
ML_6(gtk_render_arrow,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_arrow)
ML_6(gtk_render_activity,GtkStyleContext_val, cairo_t_val, Double_val, Double_val, Double_val, Double_val, Unit)
ML_bc6(ml_gtk_render_activity)
ML_0(gtk_recent_manager_error_quark,Val_int32)
ML_0(gtk_recent_chooser_error_quark,Val_int32)
ML_0(gtk_rc_scanner_new,Val_GScanner)
ML_1(gtk_rc_reset_styles,GtkSettings_val, Unit)
ML_2(gtk_rc_reparse_all_for_settings,GtkSettings_val, Bool_val, Val_bool)
ML_0(gtk_rc_reparse_all,Val_bool)
ML_3(gtk_rc_property_parse_requisition,GParamSpec_val, GString_val, GValue_val, Val_bool)
ML_3(gtk_rc_property_parse_flags,GParamSpec_val, GString_val, GValue_val, Val_bool)
ML_3(gtk_rc_property_parse_enum,GParamSpec_val, GString_val, GValue_val, Val_bool)
ML_3(gtk_rc_property_parse_color,GParamSpec_val, GString_val, GValue_val, Val_bool)
ML_3(gtk_rc_property_parse_border,GParamSpec_val, GString_val, GValue_val, Val_bool)
ML_1(gtk_rc_parse_string,String_val, Unit)
ML_1(gtk_rc_parse,String_val, Unit)
ML_0(gtk_rc_get_theme_dir,Val_string_new)
ML_4(gtk_rc_get_style_by_paths,GtkSettings_val, Option_val(arg2,String_val,NULL) Ignore, Option_val(arg3,String_val,NULL) Ignore, Int_val, Val_GtkStyle)
ML_1(gtk_rc_get_style,GtkWidget_val, Val_GtkStyle)
ML_3(gtk_print_run_page_setup_dialog,Option_val(arg1,GtkWindow_val,NULL) Ignore, Option_val(arg2,GtkPageSetup_val,NULL) Ignore, GtkPrintSettings_val, Val_GtkPageSetup_new)
ML_0(gtk_print_error_quark,Val_int32)
ML_1(gtk_paper_size_get_paper_sizes,Bool_val, Val_GList_new)
ML_0(gtk_paper_size_get_default,Val_string)
ML_0(gtk_main_quit,Unit)
ML_0(gtk_main_level,Val_int)
ML_1(gtk_main_iteration_do,Bool_val, Val_bool)
ML_0(gtk_main_iteration,Val_bool)
ML_0(gtk_main,Unit)
ML_1(gtk_key_snooper_remove,Int_val, Unit)
ML_0(gtk_icon_theme_error_quark,Val_int32)
ML_0(gtk_grab_get_current,Val_GtkWidget)
ML_1(gtk_get_option_group,Bool_val, Val_GOptionGroup)
ML_0(gtk_get_minor_version,Val_int)
ML_0(gtk_get_micro_version,Val_int)
ML_0(gtk_get_major_version,Val_int)
ML_0(gtk_get_interface_age,Val_int)
ML_0(gtk_get_default_language,Val_PangoLanguage_new)
ML_0(gtk_get_debug_flags,Val_int)
ML_0(gtk_get_current_event_time,Val_int32)
ML_0(gtk_get_current_event_device,Val_GdkDevice)
ML_0(gtk_get_binary_age,Val_int)
ML_0(gtk_file_chooser_error_quark,Val_int32)
ML_0(gtk_false,Val_bool)
ML_0(gtk_events_pending,Val_bool)
ML_4(gtk_drag_set_icon_widget,GdkDragContext_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_2(gtk_drag_set_icon_surface,GdkDragContext_val, cairo_surface_t_val, Unit)
ML_4(gtk_drag_set_icon_stock,GdkDragContext_val, String_val, Int_val, Int_val, Unit)
ML_4(gtk_drag_set_icon_pixbuf,GdkDragContext_val, GdkPixbuf_val, Int_val, Int_val, Unit)
ML_4(gtk_drag_set_icon_name,GdkDragContext_val, String_val, Int_val, Int_val, Unit)
ML_1(gtk_drag_set_icon_default,GdkDragContext_val, Unit)
ML_1(gtk_drag_get_source_widget,GdkDragContext_val, Val_GtkWidget)
ML_4(gtk_drag_finish,GdkDragContext_val, Bool_val, Bool_val, Int32_val, Unit)
ML_3(gtk_distribute_natural_allocation,Int_val, Int_val, GtkRequestedSize_val, Val_int)
ML_0(gtk_disable_setlocale,Unit)
ML_2(gtk_device_grab_remove,GtkWidget_val, GdkDevice_val, Unit)
ML_3(gtk_device_grab_add,GtkWidget_val, GdkDevice_val, Bool_val, Unit)
ML_0(gtk_css_provider_error_quark,Val_int32)
ML_3(gtk_check_version,Int_val, Int_val, Int_val, Val_string)
ML_3(gtk_cairo_transform_to_window,cairo_t_val, GtkWidget_val, GdkWindow_val, Unit)
ML_2(gtk_cairo_should_draw_window,cairo_t_val, GdkWindow_val, Val_bool)
ML_0(gtk_builder_error_quark,Val_int32)
ML_1(gtk_binding_set_new,String_val, Val_GtkBindingSet_new)
ML_1(gtk_binding_set_find,String_val, Val_GtkBindingSet)
ML_1(gtk_alternative_dialog_button_order,Option_val(arg1,GdkScreen_val,NULL) Ignore, Val_bool)
/* End of global functions */

