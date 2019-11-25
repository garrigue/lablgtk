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

#include <gio/gio.h>
#include "../wrappers.h"
#include "../ml_gobject.h"
/* Module ZlibDecompressorClass */
/* end of ZlibDecompressorClass */
/* Module ZlibDecompressor */
ML_1(g_zlib_decompressor_get_file_info,GZlibDecompressor_val, Val_GFileInfo)
/* end of ZlibDecompressor */
/* Module ZlibCompressorClass */
/* end of ZlibCompressorClass */
/* Module ZlibCompressor */
ML_2(g_zlib_compressor_set_file_info,GZlibCompressor_val, Option_val(arg2,GFileInfo_val,NULL) Ignore, Unit)
ML_1(g_zlib_compressor_get_file_info,GZlibCompressor_val, Val_GFileInfo)
/* end of ZlibCompressor */
/* Module VolumeMonitorClass */
/* end of VolumeMonitorClass */
/* Module VolumeMonitor */
ML_1(g_volume_monitor_get_volumes,GVolumeMonitor_val, Val_GList_new)
ML_1(g_volume_monitor_get_mounts,GVolumeMonitor_val, Val_GList_new)
ML_1(g_volume_monitor_get_connected_drives,GVolumeMonitor_val, Val_GList_new)
ML_0(g_volume_monitor_get,Val_GVolumeMonitor_new)
/* end of VolumeMonitor */
/* Module VolumeIface */
/* end of VolumeIface */
/* Module VfsClass */
/* end of VfsClass */
/* Module Vfs */
ML_1(g_vfs_is_active,GVfs_val, Val_bool)
ML_0(g_vfs_get_local,Val_GVfs)
ML_0(g_vfs_get_default,Val_GVfs)
/* end of Vfs */
/* Module UnixSocketAddressPrivate */
/* end of UnixSocketAddressPrivate */
/* Module UnixSocketAddressClass */
/* end of UnixSocketAddressClass */
/* Module UnixSocketAddress */
ML_1(g_unix_socket_address_get_path_len,GUnixSocketAddress_val, Val_int)
ML_1(g_unix_socket_address_get_path,GUnixSocketAddress_val, Val_string)
ML_1(g_unix_socket_address_get_is_abstract,GUnixSocketAddress_val, Val_bool)
ML_0(g_unix_socket_address_abstract_names_supported,Val_bool)
/* end of UnixSocketAddress */
/* Module UnixOutputStreamPrivate */
/* end of UnixOutputStreamPrivate */
/* Module UnixOutputStreamClass */
/* end of UnixOutputStreamClass */
/* Module UnixOutputStream */
ML_2(g_unix_output_stream_set_close_fd,GUnixOutputStream_val, Bool_val, Unit)
ML_1(g_unix_output_stream_get_fd,GUnixOutputStream_val, Val_int)
ML_1(g_unix_output_stream_get_close_fd,GUnixOutputStream_val, Val_bool)
/* end of UnixOutputStream */
/* Module UnixMountPoint */
ML_1(g_unix_mount_point_is_user_mountable,GUnixMountPoint_val, Val_bool)
ML_1(g_unix_mount_point_is_readonly,GUnixMountPoint_val, Val_bool)
ML_1(g_unix_mount_point_is_loopback,GUnixMountPoint_val, Val_bool)
ML_1(g_unix_mount_point_guess_name,GUnixMountPoint_val, Val_string_new)
ML_1(g_unix_mount_point_guess_can_eject,GUnixMountPoint_val, Val_bool)
ML_1(g_unix_mount_point_get_mount_path,GUnixMountPoint_val, Val_string)
ML_1(g_unix_mount_point_get_fs_type,GUnixMountPoint_val, Val_string)
ML_1(g_unix_mount_point_get_device_path,GUnixMountPoint_val, Val_string)
ML_1(g_unix_mount_point_free,GUnixMountPoint_val, Unit)
ML_2(g_unix_mount_point_compare,GUnixMountPoint_val, GUnixMountPoint_val, Val_int)
/* end of UnixMountPoint */
/* Module UnixMountMonitorClass */
/* end of UnixMountMonitorClass */
/* Module UnixMountMonitor */
ML_2(g_unix_mount_monitor_set_rate_limit,GUnixMountMonitor_val, Int_val, Unit)
/* end of UnixMountMonitor */
/* Module UnixMountEntry */
/* end of UnixMountEntry */
/* Module UnixInputStreamPrivate */
/* end of UnixInputStreamPrivate */
/* Module UnixInputStreamClass */
/* end of UnixInputStreamClass */
/* Module UnixInputStream */
ML_2(g_unix_input_stream_set_close_fd,GUnixInputStream_val, Bool_val, Unit)
ML_1(g_unix_input_stream_get_fd,GUnixInputStream_val, Val_int)
ML_1(g_unix_input_stream_get_close_fd,GUnixInputStream_val, Val_bool)
/* end of UnixInputStream */
/* Module UnixFDMessagePrivate */
/* end of UnixFDMessagePrivate */
/* Module UnixFDMessageClass */
/* end of UnixFDMessageClass */
/* Module UnixFDMessage */
ML_1(g_unix_fd_message_get_fd_list,GUnixFDMessage_val, Val_GUnixFDList)
/* end of UnixFDMessage */
/* Module UnixFDListPrivate */
/* end of UnixFDListPrivate */
/* Module UnixFDListClass */
/* end of UnixFDListClass */
/* Module UnixFDList */
ML_1(g_unix_fd_list_get_length,GUnixFDList_val, Val_int)
/* end of UnixFDList */
/* Module UnixCredentialsMessagePrivate */
/* end of UnixCredentialsMessagePrivate */
/* Module UnixCredentialsMessageClass */
/* end of UnixCredentialsMessageClass */
/* Module UnixCredentialsMessage */
ML_1(g_unix_credentials_message_get_credentials,GUnixCredentialsMessage_val, Val_GCredentials)
ML_0(g_unix_credentials_message_is_supported,Val_bool)
/* end of UnixCredentialsMessage */
/* Module UnixConnectionPrivate */
/* end of UnixConnectionPrivate */
/* Module UnixConnectionClass */
/* end of UnixConnectionClass */
/* Module UnixConnection */
/* end of UnixConnection */
/* Module TlsServerContext */
/* end of TlsServerContext */
/* Module TlsServerConnectionInterface */
/* end of TlsServerConnectionInterface */
/* Module TlsContext */
/* end of TlsContext */
/* Module TlsConnectionPrivate */
/* end of TlsConnectionPrivate */
/* Module TlsConnectionClass */
/* end of TlsConnectionClass */
/* Module TlsConnection */
ML_2(g_tls_connection_set_use_system_certdb,GTlsConnection_val, Bool_val, Unit)
ML_2(g_tls_connection_set_require_close_notify,GTlsConnection_val, Bool_val, Unit)
ML_2(g_tls_connection_set_certificate,GTlsConnection_val, GTlsCertificate_val, Unit)
ML_1(g_tls_connection_get_use_system_certdb,GTlsConnection_val, Val_bool)
ML_1(g_tls_connection_get_require_close_notify,GTlsConnection_val, Val_bool)
ML_1(g_tls_connection_get_peer_certificate,GTlsConnection_val, Val_GTlsCertificate)
ML_1(g_tls_connection_get_certificate,GTlsConnection_val, Val_GTlsCertificate)
/* end of TlsConnection */
/* Module TlsClientContext */
/* end of TlsClientContext */
/* Module TlsClientConnectionInterface */
/* end of TlsClientConnectionInterface */
/* Module TlsCertificatePrivate */
/* end of TlsCertificatePrivate */
/* Module TlsCertificateClass */
/* end of TlsCertificateClass */
/* Module TlsCertificate */
ML_1(g_tls_certificate_get_issuer,GTlsCertificate_val, Val_GTlsCertificate)
/* end of TlsCertificate */
/* Module TlsBackendInterface */
/* end of TlsBackendInterface */
/* Module ThreadedSocketServicePrivate */
/* end of ThreadedSocketServicePrivate */
/* Module ThreadedSocketServiceClass */
/* end of ThreadedSocketServiceClass */
/* Module ThreadedSocketService */
/* end of ThreadedSocketService */
/* Module ThemedIconClass */
/* end of ThemedIconClass */
/* Module ThemedIcon */
ML_2(g_themed_icon_prepend_name,GThemedIcon_val, String_val, Unit)
ML_2(g_themed_icon_append_name,GThemedIcon_val, String_val, Unit)
/* end of ThemedIcon */
/* Module TcpWrapperConnectionPrivate */
/* end of TcpWrapperConnectionPrivate */
/* Module TcpWrapperConnectionClass */
/* end of TcpWrapperConnectionClass */
/* Module TcpWrapperConnection */
ML_1(g_tcp_wrapper_connection_get_base_io_stream,GTcpWrapperConnection_val, Val_GIOStream)
/* end of TcpWrapperConnection */
/* Module TcpConnectionPrivate */
/* end of TcpConnectionPrivate */
/* Module TcpConnectionClass */
/* end of TcpConnectionClass */
/* Module TcpConnection */
ML_2(g_tcp_connection_set_graceful_disconnect,GTcpConnection_val, Bool_val, Unit)
ML_1(g_tcp_connection_get_graceful_disconnect,GTcpConnection_val, Val_bool)
/* end of TcpConnection */
/* Module SrvTarget */
ML_1(g_srv_target_get_weight,GSrvTarget_val, Val_int)
ML_1(g_srv_target_get_priority,GSrvTarget_val, Val_int)
ML_1(g_srv_target_get_port,GSrvTarget_val, Val_int)
ML_1(g_srv_target_get_hostname,GSrvTarget_val, Val_string)
ML_1(g_srv_target_free,GSrvTarget_val, Unit)
ML_1(g_srv_target_copy,GSrvTarget_val, Val_GSrvTarget_new)
/* end of SrvTarget */
/* Module SocketServicePrivate */
/* end of SocketServicePrivate */
/* Module SocketServiceClass */
/* end of SocketServiceClass */
/* Module SocketService */
ML_1(g_socket_service_stop,GSocketService_val, Unit)
ML_1(g_socket_service_start,GSocketService_val, Unit)
ML_1(g_socket_service_is_active,GSocketService_val, Val_bool)
/* end of SocketService */
/* Module SocketPrivate */
/* end of SocketPrivate */
/* Module SocketListenerPrivate */
/* end of SocketListenerPrivate */
/* Module SocketListenerClass */
/* end of SocketListenerClass */
/* Module SocketListener */
ML_2(g_socket_listener_set_backlog,GSocketListener_val, Int_val, Unit)
ML_1(g_socket_listener_close,GSocketListener_val, Unit)
/* end of SocketListener */
/* Module SocketControlMessagePrivate */
/* end of SocketControlMessagePrivate */
/* Module SocketControlMessageClass */
/* end of SocketControlMessageClass */
/* Module SocketControlMessage */
ML_1(g_socket_control_message_get_size,GSocketControlMessage_val, Val_int)
ML_1(g_socket_control_message_get_msg_type,GSocketControlMessage_val, Val_int)
ML_1(g_socket_control_message_get_level,GSocketControlMessage_val, Val_int)
/* end of SocketControlMessage */
/* Module SocketConnectionPrivate */
/* end of SocketConnectionPrivate */
/* Module SocketConnectionClass */
/* end of SocketConnectionClass */
/* Module SocketConnection */
ML_1(g_socket_connection_get_socket,GSocketConnection_val, Val_GSocket)
/* end of SocketConnection */
/* Module SocketConnectableIface */
/* end of SocketConnectableIface */
/* Module SocketClientPrivate */
/* end of SocketClientPrivate */
/* Module SocketClientClass */
/* end of SocketClientClass */
/* Module SocketClient */
ML_2(g_socket_client_set_tls,GSocketClient_val, Bool_val, Unit)
ML_2(g_socket_client_set_timeout,GSocketClient_val, Int_val, Unit)
ML_2(g_socket_client_set_local_address,GSocketClient_val, GSocketAddress_val, Unit)
ML_2(g_socket_client_set_enable_proxy,GSocketClient_val, Bool_val, Unit)
ML_1(g_socket_client_get_tls,GSocketClient_val, Val_bool)
ML_1(g_socket_client_get_timeout,GSocketClient_val, Val_int)
ML_1(g_socket_client_get_local_address,GSocketClient_val, Val_GSocketAddress)
ML_1(g_socket_client_get_enable_proxy,GSocketClient_val, Val_bool)
ML_2(g_socket_client_add_application_proxy,GSocketClient_val, String_val, Unit)
/* end of SocketClient */
/* Module SocketClass */
/* end of SocketClass */
/* Module SocketAddressEnumeratorClass */
/* end of SocketAddressEnumeratorClass */
/* Module SocketAddressEnumerator */
/* end of SocketAddressEnumerator */
/* Module SocketAddressClass */
/* end of SocketAddressClass */
/* Module SocketAddress */
ML_1(g_socket_address_get_native_size,GSocketAddress_val, Val_int)
/* end of SocketAddress */
/* Module Socket */
ML_1(g_socket_speaks_ipv4,GSocket_val, Val_bool)
ML_2(g_socket_set_timeout,GSocket_val, Int_val, Unit)
ML_2(g_socket_set_listen_backlog,GSocket_val, Int_val, Unit)
ML_2(g_socket_set_keepalive,GSocket_val, Bool_val, Unit)
ML_2(g_socket_set_blocking,GSocket_val, Bool_val, Unit)
ML_1(g_socket_is_connected,GSocket_val, Val_bool)
ML_1(g_socket_is_closed,GSocket_val, Val_bool)
ML_1(g_socket_get_timeout,GSocket_val, Val_int)
ML_1(g_socket_get_listen_backlog,GSocket_val, Val_int)
ML_1(g_socket_get_keepalive,GSocket_val, Val_bool)
ML_1(g_socket_get_fd,GSocket_val, Val_int)
ML_1(g_socket_get_blocking,GSocket_val, Val_bool)
ML_1(g_socket_connection_factory_create_connection,GSocket_val, Val_GSocketConnection_new)
/* end of Socket */
/* Module SimplePermission */
/* end of SimplePermission */
/* Module SimpleAsyncResultClass */
/* end of SimpleAsyncResultClass */
/* Module SimpleAsyncResult */
ML_2(g_simple_async_result_take_error,GSimpleAsyncResult_val, GError_val, Unit)
ML_2(g_simple_async_result_set_op_res_gssize,GSimpleAsyncResult_val, Int_val, Unit)
ML_2(g_simple_async_result_set_op_res_gboolean,GSimpleAsyncResult_val, Bool_val, Unit)
ML_2(g_simple_async_result_set_handle_cancellation,GSimpleAsyncResult_val, Bool_val, Unit)
ML_2(g_simple_async_result_set_from_error,GSimpleAsyncResult_val, GError_val, Unit)
ML_1(g_simple_async_result_get_op_res_gssize,GSimpleAsyncResult_val, Val_int)
ML_1(g_simple_async_result_get_op_res_gboolean,GSimpleAsyncResult_val, Val_bool)
ML_1(g_simple_async_result_complete_in_idle,GSimpleAsyncResult_val, Unit)
ML_1(g_simple_async_result_complete,GSimpleAsyncResult_val, Unit)
/* end of SimpleAsyncResult */
/* Module SimpleActionPrivate */
/* end of SimpleActionPrivate */
/* Module SimpleActionGroupPrivate */
/* end of SimpleActionGroupPrivate */
/* Module SimpleActionGroupClass */
/* end of SimpleActionGroupClass */
/* Module SimpleActionGroup */
ML_2(g_simple_action_group_remove,GSimpleActionGroup_val, String_val, Unit)
/* end of SimpleActionGroup */
/* Module SimpleActionClass */
/* end of SimpleActionClass */
/* Module SimpleAction */
ML_2(g_simple_action_set_enabled,GSimpleAction_val, Bool_val, Unit)
/* end of SimpleAction */
/* Module SettingsPrivate */
/* end of SettingsPrivate */
/* Module SettingsClass */
/* end of SettingsClass */
/* Module SettingsBackend */
/* end of SettingsBackend */
/* Module Settings */
ML_3(g_settings_set_value,GSettings_val, String_val, GVariant_val, Val_bool)
ML_3(g_settings_set_string,GSettings_val, String_val, String_val, Val_bool)
ML_3(g_settings_set_int,GSettings_val, String_val, Int_val, Val_bool)
ML_3(g_settings_set_flags,GSettings_val, String_val, Int_val, Val_bool)
ML_3(g_settings_set_enum,GSettings_val, String_val, Int_val, Val_bool)
ML_3(g_settings_set_double,GSettings_val, String_val, Double_val, Val_bool)
ML_3(g_settings_set_boolean,GSettings_val, String_val, Bool_val, Val_bool)
ML_1(g_settings_revert,GSettings_val, Unit)
ML_2(g_settings_reset,GSettings_val, String_val, Unit)
ML_3(g_settings_range_check,GSettings_val, String_val, GVariant_val, Val_bool)
ML_2(g_settings_is_writable,GSettings_val, String_val, Val_bool)
ML_2(g_settings_get_value,GSettings_val, String_val, Val_GVariant_new)
ML_2(g_settings_get_string,GSettings_val, String_val, Val_string_new)
ML_2(g_settings_get_range,GSettings_val, String_val, Val_GVariant_new)
ML_2(g_settings_get_int,GSettings_val, String_val, Val_int)
ML_1(g_settings_get_has_unapplied,GSettings_val, Val_bool)
ML_2(g_settings_get_flags,GSettings_val, String_val, Val_int)
ML_2(g_settings_get_enum,GSettings_val, String_val, Val_int)
ML_2(g_settings_get_double,GSettings_val, String_val, Val_double)
ML_2(g_settings_get_child,GSettings_val, String_val, Val_GSettings_new)
ML_2(g_settings_get_boolean,GSettings_val, String_val, Val_bool)
ML_1(g_settings_delay,GSettings_val, Unit)
ML_1(g_settings_apply,GSettings_val, Unit)
ML_0(g_settings_sync,Unit)
/* end of Settings */
/* Module SeekableIface */
/* end of SeekableIface */
/* Module ResolverPrivate */
/* end of ResolverPrivate */
/* Module ResolverClass */
/* end of ResolverClass */
/* Module Resolver */
ML_1(g_resolver_set_default,GResolver_val, Unit)
ML_0(g_resolver_get_default,Val_GResolver_new)
ML_1(g_resolver_free_targets,GList_val, Unit)
ML_1(g_resolver_free_addresses,GList_val, Unit)
/* end of Resolver */
/* Module ProxyResolverInterface */
/* end of ProxyResolverInterface */
/* Module ProxyInterface */
/* end of ProxyInterface */
/* Module ProxyAddressPrivate */
/* end of ProxyAddressPrivate */
/* Module ProxyAddressEnumeratorPrivate */
/* end of ProxyAddressEnumeratorPrivate */
/* Module ProxyAddressEnumeratorClass */
/* end of ProxyAddressEnumeratorClass */
/* Module ProxyAddressEnumerator */
/* end of ProxyAddressEnumerator */
/* Module ProxyAddressClass */
/* end of ProxyAddressClass */
/* Module ProxyAddress */
ML_1(g_proxy_address_get_username,GProxyAddress_val, Val_string)
ML_1(g_proxy_address_get_protocol,GProxyAddress_val, Val_string)
ML_1(g_proxy_address_get_password,GProxyAddress_val, Val_string)
ML_1(g_proxy_address_get_destination_port,GProxyAddress_val, Val_int)
ML_1(g_proxy_address_get_destination_hostname,GProxyAddress_val, Val_string)
/* end of ProxyAddress */
/* Module PollableOutputStreamInterface */
/* end of PollableOutputStreamInterface */
/* Module PollableInputStreamInterface */
/* end of PollableInputStreamInterface */
/* Module PermissionPrivate */
/* end of PermissionPrivate */
/* Module PermissionClass */
/* end of PermissionClass */
/* Module Permission */
ML_4(g_permission_impl_update,GPermission_val, Bool_val, Bool_val, Bool_val, Unit)
ML_1(g_permission_get_can_release,GPermission_val, Val_bool)
ML_1(g_permission_get_can_acquire,GPermission_val, Val_bool)
ML_1(g_permission_get_allowed,GPermission_val, Val_bool)
/* end of Permission */
/* Module OutputVector */
/* end of OutputVector */
/* Module OutputStreamPrivate */
/* end of OutputStreamPrivate */
/* Module OutputStreamClass */
/* end of OutputStreamClass */
/* Module OutputStream */
ML_1(g_output_stream_is_closing,GOutputStream_val, Val_bool)
ML_1(g_output_stream_is_closed,GOutputStream_val, Val_bool)
ML_1(g_output_stream_has_pending,GOutputStream_val, Val_bool)
ML_1(g_output_stream_clear_pending,GOutputStream_val, Unit)
/* end of OutputStream */
/* Module NetworkServicePrivate */
/* end of NetworkServicePrivate */
/* Module NetworkServiceClass */
/* end of NetworkServiceClass */
/* Module NetworkService */
ML_2(g_network_service_set_scheme,GNetworkService_val, String_val, Unit)
ML_1(g_network_service_get_service,GNetworkService_val, Val_string)
ML_1(g_network_service_get_scheme,GNetworkService_val, Val_string)
ML_1(g_network_service_get_protocol,GNetworkService_val, Val_string)
ML_1(g_network_service_get_domain,GNetworkService_val, Val_string)
/* end of NetworkService */
/* Module NetworkAddressPrivate */
/* end of NetworkAddressPrivate */
/* Module NetworkAddressClass */
/* end of NetworkAddressClass */
/* Module NetworkAddress */
ML_1(g_network_address_get_scheme,GNetworkAddress_val, Val_string)
ML_1(g_network_address_get_port,GNetworkAddress_val, Val_int)
ML_1(g_network_address_get_hostname,GNetworkAddress_val, Val_string)
/* end of NetworkAddress */
/* Module NativeVolumeMonitorClass */
/* end of NativeVolumeMonitorClass */
/* Module NativeVolumeMonitor */
/* end of NativeVolumeMonitor */
/* Module MountOperationPrivate */
/* end of MountOperationPrivate */
/* Module MountOperationClass */
/* end of MountOperationClass */
/* Module MountOperation */
ML_2(g_mount_operation_set_username,GMountOperation_val, String_val, Unit)
ML_2(g_mount_operation_set_password,GMountOperation_val, String_val, Unit)
ML_2(g_mount_operation_set_domain,GMountOperation_val, String_val, Unit)
ML_2(g_mount_operation_set_choice,GMountOperation_val, Int_val, Unit)
ML_2(g_mount_operation_set_anonymous,GMountOperation_val, Bool_val, Unit)
ML_1(g_mount_operation_get_username,GMountOperation_val, Val_string)
ML_1(g_mount_operation_get_password,GMountOperation_val, Val_string)
ML_1(g_mount_operation_get_domain,GMountOperation_val, Val_string)
ML_1(g_mount_operation_get_choice,GMountOperation_val, Val_int)
ML_1(g_mount_operation_get_anonymous,GMountOperation_val, Val_bool)
/* end of MountOperation */
/* Module MountIface */
/* end of MountIface */
/* Module MemoryOutputStreamPrivate */
/* end of MemoryOutputStreamPrivate */
/* Module MemoryOutputStreamClass */
/* end of MemoryOutputStreamClass */
/* Module MemoryOutputStream */
ML_1(g_memory_output_stream_get_size,GMemoryOutputStream_val, Val_int)
ML_1(g_memory_output_stream_get_data_size,GMemoryOutputStream_val, Val_int)
/* end of MemoryOutputStream */
/* Module MemoryInputStreamPrivate */
/* end of MemoryInputStreamPrivate */
/* Module MemoryInputStreamClass */
/* end of MemoryInputStreamClass */
/* Module MemoryInputStream */
/* end of MemoryInputStream */
/* Module LoadableIconIface */
/* end of LoadableIconIface */
/* Module InputVector */
/* end of InputVector */
/* Module InputStreamPrivate */
/* end of InputStreamPrivate */
/* Module InputStreamClass */
/* end of InputStreamClass */
/* Module InputStream */
ML_1(g_input_stream_is_closed,GInputStream_val, Val_bool)
ML_1(g_input_stream_has_pending,GInputStream_val, Val_bool)
ML_1(g_input_stream_clear_pending,GInputStream_val, Unit)
/* end of InputStream */
/* Module InitableIface */
/* end of InitableIface */
/* Module InetSocketAddressPrivate */
/* end of InetSocketAddressPrivate */
/* Module InetSocketAddressClass */
/* end of InetSocketAddressClass */
/* Module InetSocketAddress */
ML_1(g_inet_socket_address_get_port,GInetSocketAddress_val, Val_int)
ML_1(g_inet_socket_address_get_address,GInetSocketAddress_val, Val_GInetAddress)
/* end of InetSocketAddress */
/* Module InetAddressPrivate */
/* end of InetAddressPrivate */
/* Module InetAddressClass */
/* end of InetAddressClass */
/* Module InetAddress */
ML_1(g_inet_address_to_string,GInetAddress_val, Val_string_new)
ML_1(g_inet_address_get_native_size,GInetAddress_val, Val_int)
ML_1(g_inet_address_get_is_site_local,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_multicast,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_mc_site_local,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_mc_org_local,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_mc_node_local,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_mc_link_local,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_mc_global,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_loopback,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_link_local,GInetAddress_val, Val_bool)
ML_1(g_inet_address_get_is_any,GInetAddress_val, Val_bool)
/* end of InetAddress */
/* Module IconIface */
/* end of IconIface */
/* Module IOStreamPrivate */
/* end of IOStreamPrivate */
/* Module IOStreamClass */
/* end of IOStreamClass */
/* Module IOStreamAdapter */
/* end of IOStreamAdapter */
/* Module IOStream */
ML_1(g_io_stream_is_closed,GIOStream_val, Val_bool)
ML_1(g_io_stream_has_pending,GIOStream_val, Val_bool)
ML_1(g_io_stream_get_output_stream,GIOStream_val, Val_GOutputStream)
ML_1(g_io_stream_get_input_stream,GIOStream_val, Val_GInputStream)
ML_1(g_io_stream_clear_pending,GIOStream_val, Unit)
/* end of IOStream */
/* Module IOSchedulerJob */
/* end of IOSchedulerJob */
/* Module IOModuleClass */
/* end of IOModuleClass */
/* Module IOModule */
ML_1(g_io_module_unload,GIOModule_val, Unit)
ML_1(g_io_module_load,GIOModule_val, Unit)
/* end of IOModule */
/* Module IOExtensionPoint */
ML_2(g_io_extension_point_set_required_type,GIOExtensionPoint_val, Int_val, Unit)
ML_1(g_io_extension_point_get_required_type,GIOExtensionPoint_val, Val_int)
ML_1(g_io_extension_point_get_extensions,GIOExtensionPoint_val, Val_GList)
ML_2(g_io_extension_point_get_extension_by_name,GIOExtensionPoint_val, String_val, Val_GIOExtension)
/* end of IOExtensionPoint */
/* Module IOExtension */
ML_1(g_io_extension_ref_class,GIOExtension_val, Val_GTypeClass_new)
ML_1(g_io_extension_get_priority,GIOExtension_val, Val_int)
ML_1(g_io_extension_get_name,GIOExtension_val, Val_string)
/* end of IOExtension */
/* Module FilterOutputStreamClass */
/* end of FilterOutputStreamClass */
/* Module FilterOutputStream */
ML_2(g_filter_output_stream_set_close_base_stream,GFilterOutputStream_val, Bool_val, Unit)
ML_1(g_filter_output_stream_get_close_base_stream,GFilterOutputStream_val, Val_bool)
ML_1(g_filter_output_stream_get_base_stream,GFilterOutputStream_val, Val_GOutputStream)
/* end of FilterOutputStream */
/* Module FilterInputStreamClass */
/* end of FilterInputStreamClass */
/* Module FilterInputStream */
ML_2(g_filter_input_stream_set_close_base_stream,GFilterInputStream_val, Bool_val, Unit)
ML_1(g_filter_input_stream_get_close_base_stream,GFilterInputStream_val, Val_bool)
ML_1(g_filter_input_stream_get_base_stream,GFilterInputStream_val, Val_GInputStream)
/* end of FilterInputStream */
/* Module FilenameCompleterClass */
/* end of FilenameCompleterClass */
/* Module FilenameCompleter */
ML_2(g_filename_completer_set_dirs_only,GFilenameCompleter_val, Bool_val, Unit)
ML_2(g_filename_completer_get_completion_suffix,GFilenameCompleter_val, String_val, Val_string_new)
/* end of FilenameCompleter */
/* Module FileOutputStreamPrivate */
/* end of FileOutputStreamPrivate */
/* Module FileOutputStreamClass */
/* end of FileOutputStreamClass */
/* Module FileOutputStream */
ML_1(g_file_output_stream_get_etag,GFileOutputStream_val, Val_string_new)
/* end of FileOutputStream */
/* Module FileMonitorPrivate */
/* end of FileMonitorPrivate */
/* Module FileMonitorClass */
/* end of FileMonitorClass */
/* Module FileMonitor */
ML_2(g_file_monitor_set_rate_limit,GFileMonitor_val, Int_val, Unit)
ML_1(g_file_monitor_is_cancelled,GFileMonitor_val, Val_bool)
ML_1(g_file_monitor_cancel,GFileMonitor_val, Val_bool)
/* end of FileMonitor */
/* Module FileInputStreamPrivate */
/* end of FileInputStreamPrivate */
/* Module FileInputStreamClass */
/* end of FileInputStreamClass */
/* Module FileInputStream */
/* end of FileInputStream */
/* Module FileInfoClass */
/* end of FileInfoClass */
/* Module FileInfo */
ML_1(g_file_info_unset_attribute_mask,GFileInfo_val, Unit)
ML_2(g_file_info_set_symlink_target,GFileInfo_val, String_val, Unit)
ML_2(g_file_info_set_sort_order,GFileInfo_val, Int32_val, Unit)
ML_2(g_file_info_set_name,GFileInfo_val, String_val, Unit)
ML_2(g_file_info_set_modification_time,GFileInfo_val, GTimeVal_val, Unit)
ML_2(g_file_info_set_is_symlink,GFileInfo_val, Bool_val, Unit)
ML_2(g_file_info_set_is_hidden,GFileInfo_val, Bool_val, Unit)
ML_2(g_file_info_set_edit_name,GFileInfo_val, String_val, Unit)
ML_2(g_file_info_set_display_name,GFileInfo_val, String_val, Unit)
ML_2(g_file_info_set_content_type,GFileInfo_val, String_val, Unit)
ML_3(g_file_info_set_attribute_uint64,GFileInfo_val, String_val, Int64_val, Unit)
ML_3(g_file_info_set_attribute_uint32,GFileInfo_val, String_val, Int32_val, Unit)
ML_3(g_file_info_set_attribute_string,GFileInfo_val, String_val, String_val, Unit)
ML_2(g_file_info_set_attribute_mask,GFileInfo_val, GFileAttributeMatcher_val, Unit)
ML_3(g_file_info_set_attribute_int64,GFileInfo_val, String_val, Int64_val, Unit)
ML_3(g_file_info_set_attribute_int32,GFileInfo_val, String_val, Int32_val, Unit)
ML_3(g_file_info_set_attribute_byte_string,GFileInfo_val, String_val, String_val, Unit)
ML_3(g_file_info_set_attribute_boolean,GFileInfo_val, String_val, Bool_val, Unit)
ML_2(g_file_info_remove_attribute,GFileInfo_val, String_val, Unit)
ML_2(g_file_info_has_namespace,GFileInfo_val, String_val, Val_bool)
ML_2(g_file_info_has_attribute,GFileInfo_val, String_val, Val_bool)
ML_1(g_file_info_get_symlink_target,GFileInfo_val, Val_string)
ML_1(g_file_info_get_sort_order,GFileInfo_val, Val_int32)
ML_1(g_file_info_get_name,GFileInfo_val, Val_string)
ML_2(g_file_info_get_modification_time,GFileInfo_val, GTimeVal_val, Unit)
ML_1(g_file_info_get_is_symlink,GFileInfo_val, Val_bool)
ML_1(g_file_info_get_is_hidden,GFileInfo_val, Val_bool)
ML_1(g_file_info_get_is_backup,GFileInfo_val, Val_bool)
ML_1(g_file_info_get_etag,GFileInfo_val, Val_string)
ML_1(g_file_info_get_edit_name,GFileInfo_val, Val_string)
ML_1(g_file_info_get_display_name,GFileInfo_val, Val_string)
ML_1(g_file_info_get_content_type,GFileInfo_val, Val_string)
ML_2(g_file_info_get_attribute_uint64,GFileInfo_val, String_val, Val_int64)
ML_2(g_file_info_get_attribute_uint32,GFileInfo_val, String_val, Val_int32)
ML_2(g_file_info_get_attribute_string,GFileInfo_val, String_val, Val_string)
ML_2(g_file_info_get_attribute_int64,GFileInfo_val, String_val, Val_int64)
ML_2(g_file_info_get_attribute_int32,GFileInfo_val, String_val, Val_int32)
ML_2(g_file_info_get_attribute_byte_string,GFileInfo_val, String_val, Val_string)
ML_2(g_file_info_get_attribute_boolean,GFileInfo_val, String_val, Val_bool)
ML_2(g_file_info_get_attribute_as_string,GFileInfo_val, String_val, Val_string_new)
ML_1(g_file_info_dup,GFileInfo_val, Val_GFileInfo_new)
ML_2(g_file_info_copy_into,GFileInfo_val, GFileInfo_val, Unit)
ML_1(g_file_info_clear_status,GFileInfo_val, Unit)
/* end of FileInfo */
/* Module FileIface */
/* end of FileIface */
/* Module FileIconClass */
/* end of FileIconClass */
/* Module FileIcon */
/* end of FileIcon */
/* Module FileIOStreamPrivate */
/* end of FileIOStreamPrivate */
/* Module FileIOStreamClass */
/* end of FileIOStreamClass */
/* Module FileIOStream */
ML_1(g_file_io_stream_get_etag,GFileIOStream_val, Val_string_new)
/* end of FileIOStream */
/* Module FileEnumeratorPrivate */
/* end of FileEnumeratorPrivate */
/* Module FileEnumeratorClass */
/* end of FileEnumeratorClass */
/* Module FileEnumerator */
ML_2(g_file_enumerator_set_pending,GFileEnumerator_val, Bool_val, Unit)
ML_1(g_file_enumerator_is_closed,GFileEnumerator_val, Val_bool)
ML_1(g_file_enumerator_has_pending,GFileEnumerator_val, Val_bool)
/* end of FileEnumerator */
/* Module FileDescriptorBasedIface */
/* end of FileDescriptorBasedIface */
/* Module FileAttributeMatcher */
ML_1(g_file_attribute_matcher_unref,GFileAttributeMatcher_val, Unit)
ML_1(g_file_attribute_matcher_ref,GFileAttributeMatcher_val, Val_GFileAttributeMatcher_new)
ML_2(g_file_attribute_matcher_matches_only,GFileAttributeMatcher_val, String_val, Val_bool)
ML_2(g_file_attribute_matcher_matches,GFileAttributeMatcher_val, String_val, Val_bool)
ML_1(g_file_attribute_matcher_enumerate_next,GFileAttributeMatcher_val, Val_string)
ML_2(g_file_attribute_matcher_enumerate_namespace,GFileAttributeMatcher_val, String_val, Val_bool)
/* end of FileAttributeMatcher */
/* Module FileAttributeInfoList */
ML_1(g_file_attribute_info_list_unref,GFileAttributeInfoList_val, Unit)
ML_1(g_file_attribute_info_list_ref,GFileAttributeInfoList_val, Val_GFileAttributeInfoList_new)
ML_2(g_file_attribute_info_list_lookup,GFileAttributeInfoList_val, String_val, Val_GFileAttributeInfo)
ML_1(g_file_attribute_info_list_dup,GFileAttributeInfoList_val, Val_GFileAttributeInfoList_new)
/* end of FileAttributeInfoList */
/* Module FileAttributeInfo */
/* end of FileAttributeInfo */
/* Module EmblemedIconPrivate */
/* end of EmblemedIconPrivate */
/* Module EmblemedIconClass */
/* end of EmblemedIconClass */
/* Module EmblemedIcon */
ML_1(g_emblemed_icon_get_emblems,GEmblemedIcon_val, Val_GList)
ML_1(g_emblemed_icon_clear_emblems,GEmblemedIcon_val, Unit)
ML_2(g_emblemed_icon_add_emblem,GEmblemedIcon_val, GEmblem_val, Unit)
/* end of EmblemedIcon */
/* Module EmblemClass */
/* end of EmblemClass */
/* Module Emblem */
/* end of Emblem */
/* Module DriveIface */
/* end of DriveIface */
/* Module DesktopAppInfoLookupIface */
/* end of DesktopAppInfoLookupIface */
/* Module DesktopAppInfoLaunchHandlerIface */
/* end of DesktopAppInfoLaunchHandlerIface */
/* Module DesktopAppInfoClass */
/* end of DesktopAppInfoClass */
/* Module DesktopAppInfo */
ML_1(g_desktop_app_info_get_is_hidden,GDesktopAppInfo_val, Val_bool)
ML_1(g_desktop_app_info_get_filename,GDesktopAppInfo_val, Val_string)
ML_1(g_desktop_app_info_set_desktop_env,String_val, Unit)
/* end of DesktopAppInfo */
/* Module DataOutputStreamPrivate */
/* end of DataOutputStreamPrivate */
/* Module DataOutputStreamClass */
/* end of DataOutputStreamClass */
/* Module DataOutputStream */
/* end of DataOutputStream */
/* Module DataInputStreamPrivate */
/* end of DataInputStreamPrivate */
/* Module DataInputStreamClass */
/* end of DataInputStreamClass */
/* Module DataInputStream */
/* end of DataInputStream */
/* Module DBusSubtreeVTable */
/* end of DBusSubtreeVTable */
/* Module DBusSignalInfo */
ML_1(g_dbus_signal_info_unref,GDBusSignalInfo_val, Unit)
ML_1(g_dbus_signal_info_ref,GDBusSignalInfo_val, Val_GDBusSignalInfo_new)
/* end of DBusSignalInfo */
/* Module DBusServer */
ML_1(g_dbus_server_stop,GDBusServer_val, Unit)
ML_1(g_dbus_server_start,GDBusServer_val, Unit)
ML_1(g_dbus_server_is_active,GDBusServer_val, Val_bool)
ML_1(g_dbus_server_get_guid,GDBusServer_val, Val_string)
ML_1(g_dbus_server_get_client_address,GDBusServer_val, Val_string)
/* end of DBusServer */
/* Module DBusProxyPrivate */
/* end of DBusProxyPrivate */
/* Module DBusProxyClass */
/* end of DBusProxyClass */
/* Module DBusProxy */
ML_2(g_dbus_proxy_set_interface_info,GDBusProxy_val, GDBusInterfaceInfo_val, Unit)
ML_2(g_dbus_proxy_set_default_timeout,GDBusProxy_val, Int_val, Unit)
ML_3(g_dbus_proxy_set_cached_property,GDBusProxy_val, String_val, GVariant_val, Unit)
ML_1(g_dbus_proxy_get_object_path,GDBusProxy_val, Val_string)
ML_1(g_dbus_proxy_get_name_owner,GDBusProxy_val, Val_string_new)
ML_1(g_dbus_proxy_get_name,GDBusProxy_val, Val_string)
ML_1(g_dbus_proxy_get_interface_name,GDBusProxy_val, Val_string)
ML_1(g_dbus_proxy_get_interface_info,GDBusProxy_val, Val_GDBusInterfaceInfo_new)
ML_1(g_dbus_proxy_get_default_timeout,GDBusProxy_val, Val_int)
ML_1(g_dbus_proxy_get_connection,GDBusProxy_val, Val_GDBusConnection)
ML_2(g_dbus_proxy_get_cached_property,GDBusProxy_val, String_val, Val_GVariant_new)
/* end of DBusProxy */
/* Module DBusPropertyInfo */
ML_1(g_dbus_property_info_unref,GDBusPropertyInfo_val, Unit)
ML_1(g_dbus_property_info_ref,GDBusPropertyInfo_val, Val_GDBusPropertyInfo_new)
/* end of DBusPropertyInfo */
/* Module DBusNodeInfo */
ML_1(g_dbus_node_info_unref,GDBusNodeInfo_val, Unit)
ML_1(g_dbus_node_info_ref,GDBusNodeInfo_val, Val_GDBusNodeInfo_new)
ML_2(g_dbus_node_info_lookup_interface,GDBusNodeInfo_val, String_val, Val_GDBusInterfaceInfo_new)
ML_3(g_dbus_node_info_generate_xml,GDBusNodeInfo_val, Int_val, GString_val, Unit)
/* end of DBusNodeInfo */
/* Module DBusMethodInvocation */
ML_2(g_dbus_method_invocation_return_value,GDBusMethodInvocation_val, GVariant_val, Unit)
ML_2(g_dbus_method_invocation_return_gerror,GDBusMethodInvocation_val, GError_val, Unit)
ML_4(g_dbus_method_invocation_return_error_literal,GDBusMethodInvocation_val, Int32_val, Int_val, String_val, Unit)
ML_3(g_dbus_method_invocation_return_dbus_error,GDBusMethodInvocation_val, String_val, String_val, Unit)
ML_1(g_dbus_method_invocation_get_sender,GDBusMethodInvocation_val, Val_string)
ML_1(g_dbus_method_invocation_get_parameters,GDBusMethodInvocation_val, Val_GVariant_new)
ML_1(g_dbus_method_invocation_get_object_path,GDBusMethodInvocation_val, Val_string)
ML_1(g_dbus_method_invocation_get_method_name,GDBusMethodInvocation_val, Val_string)
ML_1(g_dbus_method_invocation_get_method_info,GDBusMethodInvocation_val, Val_GDBusMethodInfo)
ML_1(g_dbus_method_invocation_get_message,GDBusMethodInvocation_val, Val_GDBusMessage)
ML_1(g_dbus_method_invocation_get_interface_name,GDBusMethodInvocation_val, Val_string)
ML_1(g_dbus_method_invocation_get_connection,GDBusMethodInvocation_val, Val_GDBusConnection)
/* end of DBusMethodInvocation */
/* Module DBusMethodInfo */
ML_1(g_dbus_method_info_unref,GDBusMethodInfo_val, Unit)
ML_1(g_dbus_method_info_ref,GDBusMethodInfo_val, Val_GDBusMethodInfo_new)
/* end of DBusMethodInfo */
/* Module DBusMessage */
ML_2(g_dbus_message_set_unix_fd_list,GDBusMessage_val, Option_val(arg2,GUnixFDList_val,NULL) Ignore, Unit)
ML_2(g_dbus_message_set_signature,GDBusMessage_val, String_val, Unit)
ML_2(g_dbus_message_set_serial,GDBusMessage_val, Int32_val, Unit)
ML_2(g_dbus_message_set_sender,GDBusMessage_val, String_val, Unit)
ML_2(g_dbus_message_set_reply_serial,GDBusMessage_val, Int32_val, Unit)
ML_2(g_dbus_message_set_path,GDBusMessage_val, String_val, Unit)
ML_2(g_dbus_message_set_num_unix_fds,GDBusMessage_val, Int32_val, Unit)
ML_2(g_dbus_message_set_member,GDBusMessage_val, String_val, Unit)
ML_2(g_dbus_message_set_interface,GDBusMessage_val, String_val, Unit)
ML_2(g_dbus_message_set_error_name,GDBusMessage_val, String_val, Unit)
ML_2(g_dbus_message_set_destination,GDBusMessage_val, String_val, Unit)
ML_2(g_dbus_message_set_body,GDBusMessage_val, GVariant_val, Unit)
ML_2(g_dbus_message_print,GDBusMessage_val, Int_val, Val_string_new)
ML_1(g_dbus_message_new_method_reply,GDBusMessage_val, Val_GDBusMessage_new)
ML_3(g_dbus_message_new_method_error_literal,GDBusMessage_val, String_val, String_val, Val_GDBusMessage_new)
ML_1(g_dbus_message_lock,GDBusMessage_val, Unit)
ML_1(g_dbus_message_get_unix_fd_list,GDBusMessage_val, Val_GUnixFDList)
ML_1(g_dbus_message_get_signature,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_serial,GDBusMessage_val, Val_int32)
ML_1(g_dbus_message_get_sender,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_reply_serial,GDBusMessage_val, Val_int32)
ML_1(g_dbus_message_get_path,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_num_unix_fds,GDBusMessage_val, Val_int32)
ML_1(g_dbus_message_get_member,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_locked,GDBusMessage_val, Val_bool)
ML_1(g_dbus_message_get_interface,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_header_fields,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_error_name,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_destination,GDBusMessage_val, Val_string)
ML_1(g_dbus_message_get_body,GDBusMessage_val, Val_GVariant_new)
ML_1(g_dbus_message_get_arg0,GDBusMessage_val, Val_string)
/* end of DBusMessage */
/* Module DBusInterfaceVTable */
/* end of DBusInterfaceVTable */
/* Module DBusInterfaceInfo */
ML_1(g_dbus_interface_info_unref,GDBusInterfaceInfo_val, Unit)
ML_1(g_dbus_interface_info_ref,GDBusInterfaceInfo_val, Val_GDBusInterfaceInfo_new)
ML_2(g_dbus_interface_info_lookup_signal,GDBusInterfaceInfo_val, String_val, Val_GDBusSignalInfo_new)
ML_2(g_dbus_interface_info_lookup_property,GDBusInterfaceInfo_val, String_val, Val_GDBusPropertyInfo_new)
ML_2(g_dbus_interface_info_lookup_method,GDBusInterfaceInfo_val, String_val, Val_GDBusMethodInfo_new)
ML_3(g_dbus_interface_info_generate_xml,GDBusInterfaceInfo_val, Int_val, GString_val, Unit)
/* end of DBusInterfaceInfo */
/* Module DBusErrorEntry */
/* end of DBusErrorEntry */
/* Module DBusConnection */
ML_2(g_dbus_connection_unregister_subtree,GDBusConnection_val, Int_val, Val_bool)
ML_2(g_dbus_connection_unregister_object,GDBusConnection_val, Int_val, Val_bool)
ML_1(g_dbus_connection_start_message_processing,GDBusConnection_val, Unit)
ML_2(g_dbus_connection_signal_unsubscribe,GDBusConnection_val, Int_val, Unit)
ML_2(g_dbus_connection_set_exit_on_close,GDBusConnection_val, Bool_val, Unit)
ML_2(g_dbus_connection_remove_filter,GDBusConnection_val, Int_val, Unit)
ML_1(g_dbus_connection_is_closed,GDBusConnection_val, Val_bool)
ML_1(g_dbus_connection_get_unique_name,GDBusConnection_val, Val_string)
ML_1(g_dbus_connection_get_stream,GDBusConnection_val, Val_GIOStream)
ML_1(g_dbus_connection_get_peer_credentials,GDBusConnection_val, Val_GCredentials)
ML_1(g_dbus_connection_get_guid,GDBusConnection_val, Val_string)
ML_1(g_dbus_connection_get_exit_on_close,GDBusConnection_val, Val_bool)
/* end of DBusConnection */
/* Module DBusAuthObserver */
ML_3(g_dbus_auth_observer_authorize_authenticated_peer,GDBusAuthObserver_val, GIOStream_val, GCredentials_val, Val_bool)
/* end of DBusAuthObserver */
/* Module DBusArgInfo */
ML_1(g_dbus_arg_info_unref,GDBusArgInfo_val, Unit)
ML_1(g_dbus_arg_info_ref,GDBusArgInfo_val, Val_GDBusArgInfo_new)
/* end of DBusArgInfo */
/* Module DBusAnnotationInfo */
ML_1(g_dbus_annotation_info_unref,GDBusAnnotationInfo_val, Unit)
ML_1(g_dbus_annotation_info_ref,GDBusAnnotationInfo_val, Val_GDBusAnnotationInfo_new)
/* end of DBusAnnotationInfo */
/* Module CredentialsClass */
/* end of CredentialsClass */
/* Module Credentials */
ML_1(g_credentials_to_string,GCredentials_val, Val_string_new)
/* end of Credentials */
/* Module ConverterOutputStreamPrivate */
/* end of ConverterOutputStreamPrivate */
/* Module ConverterOutputStreamClass */
/* end of ConverterOutputStreamClass */
/* Module ConverterOutputStream */
/* end of ConverterOutputStream */
/* Module ConverterInputStreamPrivate */
/* end of ConverterInputStreamPrivate */
/* Module ConverterInputStreamClass */
/* end of ConverterInputStreamClass */
/* Module ConverterInputStream */
/* end of ConverterInputStream */
/* Module ConverterIface */
/* end of ConverterIface */
/* Module CharsetConverterClass */
/* end of CharsetConverterClass */
/* Module CharsetConverter */
ML_2(g_charset_converter_set_use_fallback,GCharsetConverter_val, Bool_val, Unit)
ML_1(g_charset_converter_get_use_fallback,GCharsetConverter_val, Val_bool)
ML_1(g_charset_converter_get_num_fallbacks,GCharsetConverter_val, Val_int)
/* end of CharsetConverter */
/* Module CancellablePrivate */
/* end of CancellablePrivate */
/* Module CancellableClass */
/* end of CancellableClass */
/* Module Cancellable */
ML_1(g_cancellable_source_new,GCancellable_val, Val_GSource_new)
ML_1(g_cancellable_reset,GCancellable_val, Unit)
ML_1(g_cancellable_release_fd,GCancellable_val, Unit)
ML_1(g_cancellable_push_current,GCancellable_val, Unit)
ML_1(g_cancellable_pop_current,GCancellable_val, Unit)
ML_2(g_cancellable_make_pollfd,GCancellable_val, GPollFD_val, Val_bool)
ML_1(g_cancellable_is_cancelled,GCancellable_val, Val_bool)
ML_1(g_cancellable_get_fd,GCancellable_val, Val_int)
ML_2(g_cancellable_disconnect,GCancellable_val, Double_val, Unit)
ML_1(g_cancellable_cancel,GCancellable_val, Unit)
ML_0(g_cancellable_get_current,Val_GCancellable)
/* end of Cancellable */
/* Module BufferedOutputStreamPrivate */
/* end of BufferedOutputStreamPrivate */
/* Module BufferedOutputStreamClass */
/* end of BufferedOutputStreamClass */
/* Module BufferedOutputStream */
ML_2(g_buffered_output_stream_set_buffer_size,GBufferedOutputStream_val, Int_val, Unit)
ML_2(g_buffered_output_stream_set_auto_grow,GBufferedOutputStream_val, Bool_val, Unit)
ML_1(g_buffered_output_stream_get_buffer_size,GBufferedOutputStream_val, Val_int)
ML_1(g_buffered_output_stream_get_auto_grow,GBufferedOutputStream_val, Val_bool)
/* end of BufferedOutputStream */
/* Module BufferedInputStreamPrivate */
/* end of BufferedInputStreamPrivate */
/* Module BufferedInputStreamClass */
/* end of BufferedInputStreamClass */
/* Module BufferedInputStream */
ML_2(g_buffered_input_stream_set_buffer_size,GBufferedInputStream_val, Int_val, Unit)
ML_1(g_buffered_input_stream_get_buffer_size,GBufferedInputStream_val, Val_int)
ML_1(g_buffered_input_stream_get_available,GBufferedInputStream_val, Val_int)
/* end of BufferedInputStream */
/* Module AsyncResultIface */
/* end of AsyncResultIface */
/* Module AsyncInitableIface */
/* end of AsyncInitableIface */
/* Module ApplicationPrivate */
/* end of ApplicationPrivate */
/* Module ApplicationCommandLinePrivate */
/* end of ApplicationCommandLinePrivate */
/* Module ApplicationCommandLineClass */
/* end of ApplicationCommandLineClass */
/* Module ApplicationCommandLine */
ML_2(g_application_command_line_set_exit_status,GApplicationCommandLine_val, Int_val, Unit)
ML_2(g_application_command_line_getenv,GApplicationCommandLine_val, String_val, Val_string)
ML_1(g_application_command_line_get_platform_data,GApplicationCommandLine_val, Val_GVariant_new)
ML_1(g_application_command_line_get_is_remote,GApplicationCommandLine_val, Val_bool)
ML_1(g_application_command_line_get_exit_status,GApplicationCommandLine_val, Val_int)
ML_1(g_application_command_line_get_cwd,GApplicationCommandLine_val, Val_string)
/* end of ApplicationCommandLine */
/* Module ApplicationClass */
/* end of ApplicationClass */
/* Module Application */
ML_2(g_application_set_inactivity_timeout,GApplication_val, Int_val, Unit)
ML_2(g_application_set_application_id,GApplication_val, String_val, Unit)
ML_1(g_application_release,GApplication_val, Unit)
ML_1(g_application_hold,GApplication_val, Unit)
ML_1(g_application_get_is_remote,GApplication_val, Val_bool)
ML_1(g_application_get_is_registered,GApplication_val, Val_bool)
ML_1(g_application_get_inactivity_timeout,GApplication_val, Val_int)
ML_1(g_application_get_application_id,GApplication_val, Val_string)
ML_1(g_application_activate,GApplication_val, Unit)
ML_1(g_application_id_is_valid,String_val, Val_bool)
/* end of Application */
/* Module AppLaunchContextPrivate */
/* end of AppLaunchContextPrivate */
/* Module AppLaunchContextClass */
/* end of AppLaunchContextClass */
/* Module AppLaunchContext */
ML_2(g_app_launch_context_launch_failed,GAppLaunchContext_val, String_val, Unit)
/* end of AppLaunchContext */
/* Module AppInfoIface */
/* end of AppInfoIface */
/* Module ActionInterface */
/* end of ActionInterface */
/* Module ActionGroupInterface */
/* end of ActionGroupInterface */
/* Global functions */
ML_1(g_unix_mounts_changed_since,Int64_val, Val_bool)
ML_1(g_unix_mount_points_changed_since,Int64_val, Val_bool)
ML_1(g_unix_mount_is_system_internal,GUnixMountEntry_val, Val_bool)
ML_1(g_unix_mount_is_readonly,GUnixMountEntry_val, Val_bool)
ML_1(g_unix_mount_guess_should_display,GUnixMountEntry_val, Val_bool)
ML_1(g_unix_mount_guess_name,GUnixMountEntry_val, Val_string_new)
ML_1(g_unix_mount_guess_can_eject,GUnixMountEntry_val, Val_bool)
ML_1(g_unix_mount_get_mount_path,GUnixMountEntry_val, Val_string)
ML_1(g_unix_mount_get_fs_type,GUnixMountEntry_val, Val_string)
ML_1(g_unix_mount_get_device_path,GUnixMountEntry_val, Val_string)
ML_1(g_unix_mount_free,GUnixMountEntry_val, Unit)
ML_2(g_unix_mount_compare,GUnixMountEntry_val, GUnixMountEntry_val, Val_int)
ML_1(g_unix_is_mount_path_system_internal,String_val, Val_bool)
ML_0(g_tls_error_quark,Val_int32)
ML_1(g_srv_target_list_sort,GList_val, Val_GList_new)
ML_0(g_resolver_error_quark,Val_int32)
ML_0(g_io_scheduler_cancel_all_jobs,Unit)
ML_1(g_io_modules_scan_all_in_directory,String_val, Unit)
ML_1(g_io_modules_load_all_in_directory,String_val, Val_GList_new)
ML_1(g_io_extension_point_register,String_val, Val_GIOExtensionPoint)
ML_1(g_io_extension_point_lookup,String_val, Val_GIOExtensionPoint)
ML_4(g_io_extension_point_implement,String_val, Int_val, String_val, Int_val, Val_GIOExtension)
ML_1(g_io_extension_get_type,GIOExtension_val, Val_int)
ML_0(g_io_error_quark,Val_int32)
ML_1(g_dbus_is_unique_name,String_val, Val_bool)
ML_1(g_dbus_is_name,String_val, Val_bool)
ML_1(g_dbus_is_member_name,String_val, Val_bool)
ML_1(g_dbus_is_interface_name,String_val, Val_bool)
ML_1(g_dbus_is_guid,String_val, Val_bool)
ML_1(g_dbus_is_address,String_val, Val_bool)
ML_0(g_dbus_generate_guid,Val_string_new)
ML_3(g_dbus_error_unregister_error,Int32_val, Int_val, String_val, Val_bool)
ML_1(g_dbus_error_strip_remote_error,GError_val, Val_bool)
ML_3(g_dbus_error_register_error,Int32_val, Int_val, String_val, Val_bool)
ML_0(g_dbus_error_quark,Val_int32)
ML_2(g_dbus_error_new_for_dbus_error,String_val, String_val, Val_GError)
ML_1(g_dbus_error_is_remote_error,GError_val, Val_bool)
ML_1(g_dbus_error_get_remote_error,GError_val, Val_string_new)
ML_1(g_dbus_error_encode_gerror,GError_val, Val_string_new)
ML_0(g_content_types_get_registered,Val_GList_new)
ML_1(g_content_type_is_unknown,String_val, Val_bool)
ML_2(g_content_type_is_a,String_val, String_val, Val_bool)
ML_1(g_content_type_get_mime_type,String_val, Val_string_new)
ML_1(g_content_type_get_description,String_val, Val_string_new)
ML_1(g_content_type_from_mime_type,String_val, Val_string_new)
ML_2(g_content_type_equals,String_val, String_val, Val_bool)
ML_1(g_content_type_can_be_executable,String_val, Val_bool)
ML_1(g_bus_unwatch_name,Int_val, Unit)
ML_1(g_bus_unown_name,Int_val, Unit)
ML_1(g_app_info_reset_type_associations,String_val, Unit)
ML_1(g_app_info_get_recommended_for_type,String_val, Val_GList_new)
ML_1(g_app_info_get_fallback_for_type,String_val, Val_GList_new)
ML_1(g_app_info_get_all_for_type,String_val, Val_GList_new)
ML_0(g_app_info_get_all,Val_GList_new)
/* End of global functions */

