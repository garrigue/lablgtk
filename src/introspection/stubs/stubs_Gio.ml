type -'a obj

module ZlibDecompressor = struct
  external get_file_info: [>`gzlibdecompressor] obj -> [<`gfileinfo] obj = "ml_g_zlib_decompressor_get_file_info"
  end
module ZlibCompressor = struct
  external set_file_info: [>`gzlibcompressor] obj -> [>`gfileinfo] obj option -> unit = "ml_g_zlib_compressor_set_file_info"
  external get_file_info: [>`gzlibcompressor] obj -> [<`gfileinfo] obj = "ml_g_zlib_compressor_get_file_info"
  end
module VolumeMonitor = struct
  external get_volumes: [>`gvolumemonitor] obj -> [<`glist] obj = "ml_g_volume_monitor_get_volumes"
  external get_mounts: [>`gvolumemonitor] obj -> [<`glist] obj = "ml_g_volume_monitor_get_mounts"
  external get_connected_drives: [>`gvolumemonitor] obj -> [<`glist] obj = "ml_g_volume_monitor_get_connected_drives"
  external get: unit -> [<`gvolumemonitor] obj = "ml_g_volume_monitor_get"
  end
module Vfs = struct
  external is_active: [>`gvfs] obj -> bool = "ml_g_vfs_is_active"
  external get_local: unit -> [<`gvfs] obj = "ml_g_vfs_get_local"
  external get_default: unit -> [<`gvfs] obj = "ml_g_vfs_get_default"
  end
module UnixSocketAddress = struct
  external get_path_len: [>`gunixsocketaddress] obj -> int = "ml_g_unix_socket_address_get_path_len"
  external get_path: [>`gunixsocketaddress] obj -> string = "ml_g_unix_socket_address_get_path"
  external get_is_abstract: [>`gunixsocketaddress] obj -> bool = "ml_g_unix_socket_address_get_is_abstract"
  external abstract_names_supported: unit -> bool = "ml_g_unix_socket_address_abstract_names_supported"
  end
module UnixOutputStream = struct
  external set_close_fd: [>`gunixoutputstream] obj -> bool -> unit = "ml_g_unix_output_stream_set_close_fd"
  external get_fd: [>`gunixoutputstream] obj -> int = "ml_g_unix_output_stream_get_fd"
  external get_close_fd: [>`gunixoutputstream] obj -> bool = "ml_g_unix_output_stream_get_close_fd"
  end
module UnixMountPoint = struct
  external is_user_mountable: [>`gunixmountpoint] obj -> bool = "ml_g_unix_mount_point_is_user_mountable"
  external is_readonly: [>`gunixmountpoint] obj -> bool = "ml_g_unix_mount_point_is_readonly"
  external is_loopback: [>`gunixmountpoint] obj -> bool = "ml_g_unix_mount_point_is_loopback"
  external guess_name: [>`gunixmountpoint] obj -> string = "ml_g_unix_mount_point_guess_name"
  external guess_can_eject: [>`gunixmountpoint] obj -> bool = "ml_g_unix_mount_point_guess_can_eject"
  external get_options: [>`gunixmountpoint] obj -> string = "ml_g_unix_mount_point_get_options"
  external get_mount_path: [>`gunixmountpoint] obj -> string = "ml_g_unix_mount_point_get_mount_path"
  external get_fs_type: [>`gunixmountpoint] obj -> string = "ml_g_unix_mount_point_get_fs_type"
  external get_device_path: [>`gunixmountpoint] obj -> string = "ml_g_unix_mount_point_get_device_path"
  external free: [>`gunixmountpoint] obj -> unit = "ml_g_unix_mount_point_free"
  external compare: [>`gunixmountpoint] obj -> [>`gunixmountpoint] obj -> int = "ml_g_unix_mount_point_compare"
  end
module UnixMountMonitor = struct
  external set_rate_limit: [>`gunixmountmonitor] obj -> int -> unit = "ml_g_unix_mount_monitor_set_rate_limit"
  end
module UnixInputStream = struct
  external set_close_fd: [>`gunixinputstream] obj -> bool -> unit = "ml_g_unix_input_stream_set_close_fd"
  external get_fd: [>`gunixinputstream] obj -> int = "ml_g_unix_input_stream_get_fd"
  external get_close_fd: [>`gunixinputstream] obj -> bool = "ml_g_unix_input_stream_get_close_fd"
  end
module UnixFDMessage = struct
  external get_fd_list: [>`gunixfdmessage] obj -> [<`gunixfdlist] obj = "ml_g_unix_fd_message_get_fd_list"
  end
module UnixFDList = struct
  external get_length: [>`gunixfdlist] obj -> int = "ml_g_unix_fd_list_get_length"
  end
module UnixCredentialsMessage = struct
  external get_credentials: [>`gunixcredentialsmessage] obj -> [<`gcredentials] obj = "ml_g_unix_credentials_message_get_credentials"
  external is_supported: unit -> bool = "ml_g_unix_credentials_message_is_supported"
  end
module UnixConnection = struct
  end
module TlsPassword = struct
  external set_warning: [>`gtlspassword] obj -> string -> unit = "ml_g_tls_password_set_warning"
  external set_value: [>`gtlspassword] obj -> string -> int -> unit = "ml_g_tls_password_set_value"
  external set_description: [>`gtlspassword] obj -> string -> unit = "ml_g_tls_password_set_description"
  external get_warning: [>`gtlspassword] obj -> string = "ml_g_tls_password_get_warning"
  external get_description: [>`gtlspassword] obj -> string = "ml_g_tls_password_get_description"
  end
module TlsInteraction = struct
  end
module TlsDatabase = struct
  external create_certificate_handle: [>`gtlsdatabase] obj -> [>`gtlscertificate] obj -> string = "ml_g_tls_database_create_certificate_handle"
  end
module TlsConnection = struct
  external set_require_close_notify: [>`gtlsconnection] obj -> bool -> unit = "ml_g_tls_connection_set_require_close_notify"
  external set_interaction: [>`gtlsconnection] obj -> [>`gtlsinteraction] obj option -> unit = "ml_g_tls_connection_set_interaction"
  external set_database: [>`gtlsconnection] obj -> [>`gtlsdatabase] obj -> unit = "ml_g_tls_connection_set_database"
  external set_certificate: [>`gtlsconnection] obj -> [>`gtlscertificate] obj -> unit = "ml_g_tls_connection_set_certificate"
  external get_require_close_notify: [>`gtlsconnection] obj -> bool = "ml_g_tls_connection_get_require_close_notify"
  external get_peer_certificate: [>`gtlsconnection] obj -> [<`gtlscertificate] obj = "ml_g_tls_connection_get_peer_certificate"
  external get_interaction: [>`gtlsconnection] obj -> [<`gtlsinteraction] obj = "ml_g_tls_connection_get_interaction"
  external get_database: [>`gtlsconnection] obj -> [<`gtlsdatabase] obj = "ml_g_tls_connection_get_database"
  external get_certificate: [>`gtlsconnection] obj -> [<`gtlscertificate] obj = "ml_g_tls_connection_get_certificate"
  end
module TlsCertificate = struct
  external get_issuer: [>`gtlscertificate] obj -> [<`gtlscertificate] obj = "ml_g_tls_certificate_get_issuer"
  end
module ThemedIcon = struct
  external prepend_name: [>`gthemedicon] obj -> string -> unit = "ml_g_themed_icon_prepend_name"
  external append_name: [>`gthemedicon] obj -> string -> unit = "ml_g_themed_icon_append_name"
  end
module TcpWrapperConnection = struct
  external get_base_io_stream: [>`gtcpwrapperconnection] obj -> [<`giostream] obj = "ml_g_tcp_wrapper_connection_get_base_io_stream"
  end
module TcpConnection = struct
  external set_graceful_disconnect: [>`gtcpconnection] obj -> bool -> unit = "ml_g_tcp_connection_set_graceful_disconnect"
  external get_graceful_disconnect: [>`gtcpconnection] obj -> bool = "ml_g_tcp_connection_get_graceful_disconnect"
  end
module StaticResource = struct
  external init: [>`gstaticresource] obj -> unit = "ml_g_static_resource_init"
  external get_resource: [>`gstaticresource] obj -> [<`gresource] obj = "ml_g_static_resource_get_resource"
  external fini: [>`gstaticresource] obj -> unit = "ml_g_static_resource_fini"
  end
module SrvTarget = struct
  external get_weight: [>`gsrvtarget] obj -> int = "ml_g_srv_target_get_weight"
  external get_priority: [>`gsrvtarget] obj -> int = "ml_g_srv_target_get_priority"
  external get_port: [>`gsrvtarget] obj -> int = "ml_g_srv_target_get_port"
  external get_hostname: [>`gsrvtarget] obj -> string = "ml_g_srv_target_get_hostname"
  external free: [>`gsrvtarget] obj -> unit = "ml_g_srv_target_free"
  external copy: [>`gsrvtarget] obj -> [<`gsrvtarget] obj = "ml_g_srv_target_copy"
  external list_sort: [>`glist] obj -> [<`glist] obj = "ml_g_srv_target_list_sort"
  end
module SocketService = struct
  external stop: [>`gsocketservice] obj -> unit = "ml_g_socket_service_stop"
  external start: [>`gsocketservice] obj -> unit = "ml_g_socket_service_start"
  external is_active: [>`gsocketservice] obj -> bool = "ml_g_socket_service_is_active"
  end
module SocketListener = struct
  external set_backlog: [>`gsocketlistener] obj -> int -> unit = "ml_g_socket_listener_set_backlog"
  external close: [>`gsocketlistener] obj -> unit = "ml_g_socket_listener_close"
  end
module SocketControlMessage = struct
  external get_size: [>`gsocketcontrolmessage] obj -> int = "ml_g_socket_control_message_get_size"
  external get_msg_type: [>`gsocketcontrolmessage] obj -> int = "ml_g_socket_control_message_get_msg_type"
  external get_level: [>`gsocketcontrolmessage] obj -> int = "ml_g_socket_control_message_get_level"
  end
module SocketConnection = struct
  external is_connected: [>`gsocketconnection] obj -> bool = "ml_g_socket_connection_is_connected"
  external get_socket: [>`gsocketconnection] obj -> [<`gsocket] obj = "ml_g_socket_connection_get_socket"
  end
module SocketClient = struct
  external set_tls: [>`gsocketclient] obj -> bool -> unit = "ml_g_socket_client_set_tls"
  external set_timeout: [>`gsocketclient] obj -> int -> unit = "ml_g_socket_client_set_timeout"
  external set_local_address: [>`gsocketclient] obj -> [>`gsocketaddress] obj -> unit = "ml_g_socket_client_set_local_address"
  external set_enable_proxy: [>`gsocketclient] obj -> bool -> unit = "ml_g_socket_client_set_enable_proxy"
  external get_tls: [>`gsocketclient] obj -> bool = "ml_g_socket_client_get_tls"
  external get_timeout: [>`gsocketclient] obj -> int = "ml_g_socket_client_get_timeout"
  external get_local_address: [>`gsocketclient] obj -> [<`gsocketaddress] obj = "ml_g_socket_client_get_local_address"
  external get_enable_proxy: [>`gsocketclient] obj -> bool = "ml_g_socket_client_get_enable_proxy"
  external add_application_proxy: [>`gsocketclient] obj -> string -> unit = "ml_g_socket_client_add_application_proxy"
  end
module SocketAddressEnumerator = struct
  end
module SocketAddress = struct
  external get_native_size: [>`gsocketaddress] obj -> int = "ml_g_socket_address_get_native_size"
  end
module Socket = struct
  external speaks_ipv4: [>`gsocket] obj -> bool = "ml_g_socket_speaks_ipv4"
  external set_ttl: [>`gsocket] obj -> int -> unit = "ml_g_socket_set_ttl"
  external set_timeout: [>`gsocket] obj -> int -> unit = "ml_g_socket_set_timeout"
  external set_multicast_ttl: [>`gsocket] obj -> int -> unit = "ml_g_socket_set_multicast_ttl"
  external set_multicast_loopback: [>`gsocket] obj -> bool -> unit = "ml_g_socket_set_multicast_loopback"
  external set_listen_backlog: [>`gsocket] obj -> int -> unit = "ml_g_socket_set_listen_backlog"
  external set_keepalive: [>`gsocket] obj -> bool -> unit = "ml_g_socket_set_keepalive"
  external set_broadcast: [>`gsocket] obj -> bool -> unit = "ml_g_socket_set_broadcast"
  external set_blocking: [>`gsocket] obj -> bool -> unit = "ml_g_socket_set_blocking"
  external is_connected: [>`gsocket] obj -> bool = "ml_g_socket_is_connected"
  external is_closed: [>`gsocket] obj -> bool = "ml_g_socket_is_closed"
  external get_ttl: [>`gsocket] obj -> int = "ml_g_socket_get_ttl"
  external get_timeout: [>`gsocket] obj -> int = "ml_g_socket_get_timeout"
  external get_multicast_ttl: [>`gsocket] obj -> int = "ml_g_socket_get_multicast_ttl"
  external get_multicast_loopback: [>`gsocket] obj -> bool = "ml_g_socket_get_multicast_loopback"
  external get_listen_backlog: [>`gsocket] obj -> int = "ml_g_socket_get_listen_backlog"
  external get_keepalive: [>`gsocket] obj -> bool = "ml_g_socket_get_keepalive"
  external get_fd: [>`gsocket] obj -> int = "ml_g_socket_get_fd"
  external get_broadcast: [>`gsocket] obj -> bool = "ml_g_socket_get_broadcast"
  external get_blocking: [>`gsocket] obj -> bool = "ml_g_socket_get_blocking"
  external get_available_bytes: [>`gsocket] obj -> int = "ml_g_socket_get_available_bytes"
  external connection_factory_create_connection: [>`gsocket] obj -> [<`gsocketconnection] obj = "ml_g_socket_connection_factory_create_connection"
  end
module SimpleAsyncResult = struct
  external take_error: [>`gsimpleasyncresult] obj -> [>`gerror] obj -> unit = "ml_g_simple_async_result_take_error"
  external set_op_res_gssize: [>`gsimpleasyncresult] obj -> int -> unit = "ml_g_simple_async_result_set_op_res_gssize"
  external set_op_res_gboolean: [>`gsimpleasyncresult] obj -> bool -> unit = "ml_g_simple_async_result_set_op_res_gboolean"
  external set_handle_cancellation: [>`gsimpleasyncresult] obj -> bool -> unit = "ml_g_simple_async_result_set_handle_cancellation"
  external set_from_error: [>`gsimpleasyncresult] obj -> [>`gerror] obj -> unit = "ml_g_simple_async_result_set_from_error"
  external set_check_cancellable: [>`gsimpleasyncresult] obj -> [>`gcancellable] obj option -> unit = "ml_g_simple_async_result_set_check_cancellable"
  external get_op_res_gssize: [>`gsimpleasyncresult] obj -> int = "ml_g_simple_async_result_get_op_res_gssize"
  external get_op_res_gboolean: [>`gsimpleasyncresult] obj -> bool = "ml_g_simple_async_result_get_op_res_gboolean"
  external complete_in_idle: [>`gsimpleasyncresult] obj -> unit = "ml_g_simple_async_result_complete_in_idle"
  external complete: [>`gsimpleasyncresult] obj -> unit = "ml_g_simple_async_result_complete"
  end
module SimpleActionGroup = struct
  external remove: [>`gsimpleactiongroup] obj -> string -> unit = "ml_g_simple_action_group_remove"
  end
module SimpleAction = struct
  external set_state: [>`gsimpleaction] obj -> [>`gvariant] obj -> unit = "ml_g_simple_action_set_state"
  external set_enabled: [>`gsimpleaction] obj -> bool -> unit = "ml_g_simple_action_set_enabled"
  end
module SettingsSchemaSource = struct
  external unref: [>`gsettingsschemasource] obj -> unit = "ml_g_settings_schema_source_unref"
  external ref_: [>`gsettingsschemasource] obj -> [<`gsettingsschemasource] obj = "ml_g_settings_schema_source_ref"
  external lookup: [>`gsettingsschemasource] obj -> string -> bool -> [<`gsettingsschema] obj = "ml_g_settings_schema_source_lookup"
  external get_default: unit -> [<`gsettingsschemasource] obj = "ml_g_settings_schema_source_get_default"
  end
module SettingsSchema = struct
  external unref: [>`gsettingsschema] obj -> unit = "ml_g_settings_schema_unref"
  external ref_: [>`gsettingsschema] obj -> [<`gsettingsschema] obj = "ml_g_settings_schema_ref"
  external get_path: [>`gsettingsschema] obj -> string = "ml_g_settings_schema_get_path"
  external get_id: [>`gsettingsschema] obj -> string = "ml_g_settings_schema_get_id"
  end
module Settings = struct
  external set_value: [>`gsettings] obj -> string -> [>`gvariant] obj -> bool = "ml_g_settings_set_value"
  external set_uint: [>`gsettings] obj -> string -> int -> bool = "ml_g_settings_set_uint"
  external set_string: [>`gsettings] obj -> string -> string -> bool = "ml_g_settings_set_string"
  external set_int: [>`gsettings] obj -> string -> int -> bool = "ml_g_settings_set_int"
  external set_flags: [>`gsettings] obj -> string -> int -> bool = "ml_g_settings_set_flags"
  external set_enum: [>`gsettings] obj -> string -> int -> bool = "ml_g_settings_set_enum"
  external set_double: [>`gsettings] obj -> string -> float -> bool = "ml_g_settings_set_double"
  external set_boolean: [>`gsettings] obj -> string -> bool -> bool = "ml_g_settings_set_boolean"
  external revert: [>`gsettings] obj -> unit = "ml_g_settings_revert"
  external reset: [>`gsettings] obj -> string -> unit = "ml_g_settings_reset"
  external range_check: [>`gsettings] obj -> string -> [>`gvariant] obj -> bool = "ml_g_settings_range_check"
  external is_writable: [>`gsettings] obj -> string -> bool = "ml_g_settings_is_writable"
  external get_value: [>`gsettings] obj -> string -> [<`gvariant] obj = "ml_g_settings_get_value"
  external get_uint: [>`gsettings] obj -> string -> int = "ml_g_settings_get_uint"
  external get_string: [>`gsettings] obj -> string -> string = "ml_g_settings_get_string"
  external get_range: [>`gsettings] obj -> string -> [<`gvariant] obj = "ml_g_settings_get_range"
  external get_int: [>`gsettings] obj -> string -> int = "ml_g_settings_get_int"
  external get_has_unapplied: [>`gsettings] obj -> bool = "ml_g_settings_get_has_unapplied"
  external get_flags: [>`gsettings] obj -> string -> int = "ml_g_settings_get_flags"
  external get_enum: [>`gsettings] obj -> string -> int = "ml_g_settings_get_enum"
  external get_double: [>`gsettings] obj -> string -> float = "ml_g_settings_get_double"
  external get_child: [>`gsettings] obj -> string -> [<`gsettings] obj = "ml_g_settings_get_child"
  external get_boolean: [>`gsettings] obj -> string -> bool = "ml_g_settings_get_boolean"
  external delay: [>`gsettings] obj -> unit = "ml_g_settings_delay"
  external apply: [>`gsettings] obj -> unit = "ml_g_settings_apply"
  external sync: unit -> unit = "ml_g_settings_sync"
  end
module Resource = struct
  external unref: [>`gresource] obj -> unit = "ml_g_resource_unref"
  external ref_: [>`gresource] obj -> [<`gresource] obj = "ml_g_resource_ref"
  external _unregister: [>`gresource] obj -> unit = "ml_g_resources_unregister"
  external _register: [>`gresource] obj -> unit = "ml_g_resources_register"
  end
module Resolver = struct
  external set_default: [>`gresolver] obj -> unit = "ml_g_resolver_set_default"
  external get_default: unit -> [<`gresolver] obj = "ml_g_resolver_get_default"
  external free_targets: [>`glist] obj -> unit = "ml_g_resolver_free_targets"
  external free_addresses: [>`glist] obj -> unit = "ml_g_resolver_free_addresses"
  end
module ProxyAddress = struct
  external get_username: [>`gproxyaddress] obj -> string = "ml_g_proxy_address_get_username"
  external get_protocol: [>`gproxyaddress] obj -> string = "ml_g_proxy_address_get_protocol"
  external get_password: [>`gproxyaddress] obj -> string = "ml_g_proxy_address_get_password"
  external get_destination_port: [>`gproxyaddress] obj -> int = "ml_g_proxy_address_get_destination_port"
  external get_destination_hostname: [>`gproxyaddress] obj -> string = "ml_g_proxy_address_get_destination_hostname"
  end
module Permission = struct
  external impl_update: [>`gpermission] obj -> bool -> bool -> bool -> unit = "ml_g_permission_impl_update"
  external get_can_release: [>`gpermission] obj -> bool = "ml_g_permission_get_can_release"
  external get_can_acquire: [>`gpermission] obj -> bool = "ml_g_permission_get_can_acquire"
  external get_allowed: [>`gpermission] obj -> bool = "ml_g_permission_get_allowed"
  end
module OutputStream = struct
  external is_closing: [>`goutputstream] obj -> bool = "ml_g_output_stream_is_closing"
  external is_closed: [>`goutputstream] obj -> bool = "ml_g_output_stream_is_closed"
  external has_pending: [>`goutputstream] obj -> bool = "ml_g_output_stream_has_pending"
  external clear_pending: [>`goutputstream] obj -> unit = "ml_g_output_stream_clear_pending"
  end
module NetworkService = struct
  external set_scheme: [>`gnetworkservice] obj -> string -> unit = "ml_g_network_service_set_scheme"
  external get_service: [>`gnetworkservice] obj -> string = "ml_g_network_service_get_service"
  external get_scheme: [>`gnetworkservice] obj -> string = "ml_g_network_service_get_scheme"
  external get_protocol: [>`gnetworkservice] obj -> string = "ml_g_network_service_get_protocol"
  external get_domain: [>`gnetworkservice] obj -> string = "ml_g_network_service_get_domain"
  end
module NetworkAddress = struct
  external get_scheme: [>`gnetworkaddress] obj -> string = "ml_g_network_address_get_scheme"
  external get_port: [>`gnetworkaddress] obj -> int = "ml_g_network_address_get_port"
  external get_hostname: [>`gnetworkaddress] obj -> string = "ml_g_network_address_get_hostname"
  end
module MountOperation = struct
  external set_username: [>`gmountoperation] obj -> string -> unit = "ml_g_mount_operation_set_username"
  external set_password: [>`gmountoperation] obj -> string -> unit = "ml_g_mount_operation_set_password"
  external set_domain: [>`gmountoperation] obj -> string -> unit = "ml_g_mount_operation_set_domain"
  external set_choice: [>`gmountoperation] obj -> int -> unit = "ml_g_mount_operation_set_choice"
  external set_anonymous: [>`gmountoperation] obj -> bool -> unit = "ml_g_mount_operation_set_anonymous"
  external get_username: [>`gmountoperation] obj -> string = "ml_g_mount_operation_get_username"
  external get_password: [>`gmountoperation] obj -> string = "ml_g_mount_operation_get_password"
  external get_domain: [>`gmountoperation] obj -> string = "ml_g_mount_operation_get_domain"
  external get_choice: [>`gmountoperation] obj -> int = "ml_g_mount_operation_get_choice"
  external get_anonymous: [>`gmountoperation] obj -> bool = "ml_g_mount_operation_get_anonymous"
  end
module MenuModel = struct
  external iterate_item_links: [>`gmenumodel] obj -> int -> [<`gmenulinkiter] obj = "ml_g_menu_model_iterate_item_links"
  external iterate_item_attributes: [>`gmenumodel] obj -> int -> [<`gmenuattributeiter] obj = "ml_g_menu_model_iterate_item_attributes"
  external items_changed: [>`gmenumodel] obj -> int -> int -> int -> unit = "ml_g_menu_model_items_changed"
  external is_mutable: [>`gmenumodel] obj -> bool = "ml_g_menu_model_is_mutable"
  external get_n_items: [>`gmenumodel] obj -> int = "ml_g_menu_model_get_n_items"
  external get_item_link: [>`gmenumodel] obj -> int -> string -> [<`gmenumodel] obj = "ml_g_menu_model_get_item_link"
  external get_item_attribute_value: [>`gmenumodel] obj -> int -> string -> [>`gvarianttype] obj option -> [<`gvariant] obj = "ml_g_menu_model_get_item_attribute_value"
  end
module MenuLinkIter = struct
  external next: [>`gmenulinkiter] obj -> bool = "ml_g_menu_link_iter_next"
  external get_value: [>`gmenulinkiter] obj -> [<`gmenumodel] obj = "ml_g_menu_link_iter_get_value"
  external get_name: [>`gmenulinkiter] obj -> string = "ml_g_menu_link_iter_get_name"
  end
module MenuItem = struct
  external set_submenu: [>`gmenuitem] obj -> [>`gmenumodel] obj option -> unit = "ml_g_menu_item_set_submenu"
  external set_section: [>`gmenuitem] obj -> [>`gmenumodel] obj option -> unit = "ml_g_menu_item_set_section"
  external set_link: [>`gmenuitem] obj -> string -> [>`gmenumodel] obj option -> unit = "ml_g_menu_item_set_link"
  external set_label: [>`gmenuitem] obj -> string option -> unit = "ml_g_menu_item_set_label"
  external set_detailed_action: [>`gmenuitem] obj -> string -> unit = "ml_g_menu_item_set_detailed_action"
  external set_attribute_value: [>`gmenuitem] obj -> string -> [>`gvariant] obj option -> unit = "ml_g_menu_item_set_attribute_value"
  external set_action_and_target_value: [>`gmenuitem] obj -> string option -> [>`gvariant] obj option -> unit = "ml_g_menu_item_set_action_and_target_value"
  end
module MenuAttributeIter = struct
  external next: [>`gmenuattributeiter] obj -> bool = "ml_g_menu_attribute_iter_next"
  external get_value: [>`gmenuattributeiter] obj -> [<`gvariant] obj = "ml_g_menu_attribute_iter_get_value"
  external get_name: [>`gmenuattributeiter] obj -> string = "ml_g_menu_attribute_iter_get_name"
  end
module Menu = struct
  external remove: [>`gmenu] obj -> int -> unit = "ml_g_menu_remove"
  external prepend_submenu: [>`gmenu] obj -> string option -> [>`gmenumodel] obj -> unit = "ml_g_menu_prepend_submenu"
  external prepend_section: [>`gmenu] obj -> string option -> [>`gmenumodel] obj -> unit = "ml_g_menu_prepend_section"
  external prepend_item: [>`gmenu] obj -> [>`gmenuitem] obj -> unit = "ml_g_menu_prepend_item"
  external prepend: [>`gmenu] obj -> string option -> string option -> unit = "ml_g_menu_prepend"
  external insert_submenu: [>`gmenu] obj -> int -> string option -> [>`gmenumodel] obj -> unit = "ml_g_menu_insert_submenu"
  external insert_section: [>`gmenu] obj -> int -> string option -> [>`gmenumodel] obj -> unit = "ml_g_menu_insert_section"
  external insert_item: [>`gmenu] obj -> int -> [>`gmenuitem] obj -> unit = "ml_g_menu_insert_item"
  external insert: [>`gmenu] obj -> int -> string option -> string option -> unit = "ml_g_menu_insert"
  external freeze: [>`gmenu] obj -> unit = "ml_g_menu_freeze"
  external append_submenu: [>`gmenu] obj -> string option -> [>`gmenumodel] obj -> unit = "ml_g_menu_append_submenu"
  external append_section: [>`gmenu] obj -> string option -> [>`gmenumodel] obj -> unit = "ml_g_menu_append_section"
  external append_item: [>`gmenu] obj -> [>`gmenuitem] obj -> unit = "ml_g_menu_append_item"
  external append: [>`gmenu] obj -> string option -> string option -> unit = "ml_g_menu_append"
  end
module MemoryOutputStream = struct
  external get_size: [>`gmemoryoutputstream] obj -> int = "ml_g_memory_output_stream_get_size"
  external get_data_size: [>`gmemoryoutputstream] obj -> int = "ml_g_memory_output_stream_get_data_size"
  end
module MemoryInputStream = struct
  end
module InputStream = struct
  external is_closed: [>`ginputstream] obj -> bool = "ml_g_input_stream_is_closed"
  external has_pending: [>`ginputstream] obj -> bool = "ml_g_input_stream_has_pending"
  external clear_pending: [>`ginputstream] obj -> unit = "ml_g_input_stream_clear_pending"
  end
module InetSocketAddress = struct
  external get_scope_id: [>`ginetsocketaddress] obj -> int32 = "ml_g_inet_socket_address_get_scope_id"
  external get_port: [>`ginetsocketaddress] obj -> int = "ml_g_inet_socket_address_get_port"
  external get_flowinfo: [>`ginetsocketaddress] obj -> int32 = "ml_g_inet_socket_address_get_flowinfo"
  external get_address: [>`ginetsocketaddress] obj -> [<`ginetaddress] obj = "ml_g_inet_socket_address_get_address"
  end
module InetAddressMask = struct
  external to_string: [>`ginetaddressmask] obj -> string = "ml_g_inet_address_mask_to_string"
  external matches: [>`ginetaddressmask] obj -> [>`ginetaddress] obj -> bool = "ml_g_inet_address_mask_matches"
  external get_length: [>`ginetaddressmask] obj -> int = "ml_g_inet_address_mask_get_length"
  external get_address: [>`ginetaddressmask] obj -> [<`ginetaddress] obj = "ml_g_inet_address_mask_get_address"
  external equal: [>`ginetaddressmask] obj -> [>`ginetaddressmask] obj -> bool = "ml_g_inet_address_mask_equal"
  end
module InetAddress = struct
  external to_string: [>`ginetaddress] obj -> string = "ml_g_inet_address_to_string"
  external get_native_size: [>`ginetaddress] obj -> int = "ml_g_inet_address_get_native_size"
  external get_is_site_local: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_site_local"
  external get_is_multicast: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_multicast"
  external get_is_mc_site_local: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_mc_site_local"
  external get_is_mc_org_local: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_mc_org_local"
  external get_is_mc_node_local: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_mc_node_local"
  external get_is_mc_link_local: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_mc_link_local"
  external get_is_mc_global: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_mc_global"
  external get_is_loopback: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_loopback"
  external get_is_link_local: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_link_local"
  external get_is_any: [>`ginetaddress] obj -> bool = "ml_g_inet_address_get_is_any"
  external equal: [>`ginetaddress] obj -> [>`ginetaddress] obj -> bool = "ml_g_inet_address_equal"
  end
module IOStream = struct
  external is_closed: [>`giostream] obj -> bool = "ml_g_io_stream_is_closed"
  external has_pending: [>`giostream] obj -> bool = "ml_g_io_stream_has_pending"
  external get_output_stream: [>`giostream] obj -> [<`goutputstream] obj = "ml_g_io_stream_get_output_stream"
  external get_input_stream: [>`giostream] obj -> [<`ginputstream] obj = "ml_g_io_stream_get_input_stream"
  external clear_pending: [>`giostream] obj -> unit = "ml_g_io_stream_clear_pending"
  end
module IOSchedulerJob = struct
  end
module IOModuleScope = struct
  external free: [>`giomodulescope] obj -> unit = "ml_g_io_module_scope_free"
  external block: [>`giomodulescope] obj -> string -> unit = "ml_g_io_module_scope_block"
  end
module IOModule = struct
  external unload: [>`giomodule] obj -> unit = "ml_g_io_module_unload"
  external load: [>`giomodule] obj -> unit = "ml_g_io_module_load"
  end
module IOExtensionPoint = struct
  external set_required_type: [>`gioextensionpoint] obj -> int -> unit = "ml_g_io_extension_point_set_required_type"
  external get_required_type: [>`gioextensionpoint] obj -> int = "ml_g_io_extension_point_get_required_type"
  external get_extensions: [>`gioextensionpoint] obj -> [<`glist] obj = "ml_g_io_extension_point_get_extensions"
  external get_extension_by_name: [>`gioextensionpoint] obj -> string -> [<`gioextension] obj = "ml_g_io_extension_point_get_extension_by_name"
  external register: string -> [<`gioextensionpoint] obj = "ml_g_io_extension_point_register"
  external lookup: string -> [<`gioextensionpoint] obj = "ml_g_io_extension_point_lookup"
  external implement: string -> int -> string -> int -> [<`gioextension] obj = "ml_g_io_extension_point_implement"
  end
module IOExtension = struct
  external ref_class: [>`gioextension] obj -> [<`gtypeclass] obj = "ml_g_io_extension_ref_class"
  external get_type: [>`gioextension] obj -> int = "ml_g_io_extension_get_type"
  external get_priority: [>`gioextension] obj -> int = "ml_g_io_extension_get_priority"
  external get_name: [>`gioextension] obj -> string = "ml_g_io_extension_get_name"
  end
module FilterOutputStream = struct
  external set_close_base_stream: [>`gfilteroutputstream] obj -> bool -> unit = "ml_g_filter_output_stream_set_close_base_stream"
  external get_close_base_stream: [>`gfilteroutputstream] obj -> bool = "ml_g_filter_output_stream_get_close_base_stream"
  external get_base_stream: [>`gfilteroutputstream] obj -> [<`goutputstream] obj = "ml_g_filter_output_stream_get_base_stream"
  end
module FilterInputStream = struct
  external set_close_base_stream: [>`gfilterinputstream] obj -> bool -> unit = "ml_g_filter_input_stream_set_close_base_stream"
  external get_close_base_stream: [>`gfilterinputstream] obj -> bool = "ml_g_filter_input_stream_get_close_base_stream"
  external get_base_stream: [>`gfilterinputstream] obj -> [<`ginputstream] obj = "ml_g_filter_input_stream_get_base_stream"
  end
module FilenameCompleter = struct
  external set_dirs_only: [>`gfilenamecompleter] obj -> bool -> unit = "ml_g_filename_completer_set_dirs_only"
  external get_completion_suffix: [>`gfilenamecompleter] obj -> string -> string = "ml_g_filename_completer_get_completion_suffix"
  end
module FileOutputStream = struct
  external get_etag: [>`gfileoutputstream] obj -> string = "ml_g_file_output_stream_get_etag"
  end
module FileMonitor = struct
  external set_rate_limit: [>`gfilemonitor] obj -> int -> unit = "ml_g_file_monitor_set_rate_limit"
  external is_cancelled: [>`gfilemonitor] obj -> bool = "ml_g_file_monitor_is_cancelled"
  external cancel: [>`gfilemonitor] obj -> bool = "ml_g_file_monitor_cancel"
  end
module FileInputStream = struct
  end
module FileInfo = struct
  external unset_attribute_mask: [>`gfileinfo] obj -> unit = "ml_g_file_info_unset_attribute_mask"
  external set_symlink_target: [>`gfileinfo] obj -> string -> unit = "ml_g_file_info_set_symlink_target"
  external set_sort_order: [>`gfileinfo] obj -> int32 -> unit = "ml_g_file_info_set_sort_order"
  external set_name: [>`gfileinfo] obj -> string -> unit = "ml_g_file_info_set_name"
  external set_modification_time: [>`gfileinfo] obj -> [>`gtimeval] obj -> unit = "ml_g_file_info_set_modification_time"
  external set_is_symlink: [>`gfileinfo] obj -> bool -> unit = "ml_g_file_info_set_is_symlink"
  external set_is_hidden: [>`gfileinfo] obj -> bool -> unit = "ml_g_file_info_set_is_hidden"
  external set_edit_name: [>`gfileinfo] obj -> string -> unit = "ml_g_file_info_set_edit_name"
  external set_display_name: [>`gfileinfo] obj -> string -> unit = "ml_g_file_info_set_display_name"
  external set_content_type: [>`gfileinfo] obj -> string -> unit = "ml_g_file_info_set_content_type"
  external set_attribute_uint64: [>`gfileinfo] obj -> string -> int64 -> unit = "ml_g_file_info_set_attribute_uint64"
  external set_attribute_uint32: [>`gfileinfo] obj -> string -> int32 -> unit = "ml_g_file_info_set_attribute_uint32"
  external set_attribute_string: [>`gfileinfo] obj -> string -> string -> unit = "ml_g_file_info_set_attribute_string"
  external set_attribute_object: [>`gfileinfo] obj -> string -> [>`gobject] obj -> unit = "ml_g_file_info_set_attribute_object"
  external set_attribute_mask: [>`gfileinfo] obj -> [>`gfileattributematcher] obj -> unit = "ml_g_file_info_set_attribute_mask"
  external set_attribute_int64: [>`gfileinfo] obj -> string -> int64 -> unit = "ml_g_file_info_set_attribute_int64"
  external set_attribute_int32: [>`gfileinfo] obj -> string -> int32 -> unit = "ml_g_file_info_set_attribute_int32"
  external set_attribute_byte_string: [>`gfileinfo] obj -> string -> string -> unit = "ml_g_file_info_set_attribute_byte_string"
  external set_attribute_boolean: [>`gfileinfo] obj -> string -> bool -> unit = "ml_g_file_info_set_attribute_boolean"
  external remove_attribute: [>`gfileinfo] obj -> string -> unit = "ml_g_file_info_remove_attribute"
  external has_namespace: [>`gfileinfo] obj -> string -> bool = "ml_g_file_info_has_namespace"
  external has_attribute: [>`gfileinfo] obj -> string -> bool = "ml_g_file_info_has_attribute"
  external get_symlink_target: [>`gfileinfo] obj -> string = "ml_g_file_info_get_symlink_target"
  external get_sort_order: [>`gfileinfo] obj -> int32 = "ml_g_file_info_get_sort_order"
  external get_name: [>`gfileinfo] obj -> string = "ml_g_file_info_get_name"
  external get_is_symlink: [>`gfileinfo] obj -> bool = "ml_g_file_info_get_is_symlink"
  external get_is_hidden: [>`gfileinfo] obj -> bool = "ml_g_file_info_get_is_hidden"
  external get_is_backup: [>`gfileinfo] obj -> bool = "ml_g_file_info_get_is_backup"
  external get_etag: [>`gfileinfo] obj -> string = "ml_g_file_info_get_etag"
  external get_edit_name: [>`gfileinfo] obj -> string = "ml_g_file_info_get_edit_name"
  external get_display_name: [>`gfileinfo] obj -> string = "ml_g_file_info_get_display_name"
  external get_content_type: [>`gfileinfo] obj -> string = "ml_g_file_info_get_content_type"
  external get_attribute_uint64: [>`gfileinfo] obj -> string -> int64 = "ml_g_file_info_get_attribute_uint64"
  external get_attribute_uint32: [>`gfileinfo] obj -> string -> int32 = "ml_g_file_info_get_attribute_uint32"
  external get_attribute_string: [>`gfileinfo] obj -> string -> string = "ml_g_file_info_get_attribute_string"
  external get_attribute_object: [>`gfileinfo] obj -> string -> [<`gobject] obj = "ml_g_file_info_get_attribute_object"
  external get_attribute_int64: [>`gfileinfo] obj -> string -> int64 = "ml_g_file_info_get_attribute_int64"
  external get_attribute_int32: [>`gfileinfo] obj -> string -> int32 = "ml_g_file_info_get_attribute_int32"
  external get_attribute_byte_string: [>`gfileinfo] obj -> string -> string = "ml_g_file_info_get_attribute_byte_string"
  external get_attribute_boolean: [>`gfileinfo] obj -> string -> bool = "ml_g_file_info_get_attribute_boolean"
  external get_attribute_as_string: [>`gfileinfo] obj -> string -> string = "ml_g_file_info_get_attribute_as_string"
  external dup: [>`gfileinfo] obj -> [<`gfileinfo] obj = "ml_g_file_info_dup"
  external copy_into: [>`gfileinfo] obj -> [>`gfileinfo] obj -> unit = "ml_g_file_info_copy_into"
  external clear_status: [>`gfileinfo] obj -> unit = "ml_g_file_info_clear_status"
  end
module FileIcon = struct
  end
module FileIOStream = struct
  external get_etag: [>`gfileiostream] obj -> string = "ml_g_file_io_stream_get_etag"
  end
module FileEnumerator = struct
  external set_pending: [>`gfileenumerator] obj -> bool -> unit = "ml_g_file_enumerator_set_pending"
  external is_closed: [>`gfileenumerator] obj -> bool = "ml_g_file_enumerator_is_closed"
  external has_pending: [>`gfileenumerator] obj -> bool = "ml_g_file_enumerator_has_pending"
  end
module FileAttributeMatcher = struct
  external unref: [>`gfileattributematcher] obj -> unit = "ml_g_file_attribute_matcher_unref"
  external to_string: [>`gfileattributematcher] obj -> string = "ml_g_file_attribute_matcher_to_string"
  external subtract: [>`gfileattributematcher] obj -> [>`gfileattributematcher] obj -> [<`gfileattributematcher] obj = "ml_g_file_attribute_matcher_subtract"
  external ref_: [>`gfileattributematcher] obj -> [<`gfileattributematcher] obj = "ml_g_file_attribute_matcher_ref"
  external matches_only: [>`gfileattributematcher] obj -> string -> bool = "ml_g_file_attribute_matcher_matches_only"
  external matches: [>`gfileattributematcher] obj -> string -> bool = "ml_g_file_attribute_matcher_matches"
  external enumerate_next: [>`gfileattributematcher] obj -> string = "ml_g_file_attribute_matcher_enumerate_next"
  external enumerate_namespace: [>`gfileattributematcher] obj -> string -> bool = "ml_g_file_attribute_matcher_enumerate_namespace"
  end
module FileAttributeInfoList = struct
  external unref: [>`gfileattributeinfolist] obj -> unit = "ml_g_file_attribute_info_list_unref"
  external ref_: [>`gfileattributeinfolist] obj -> [<`gfileattributeinfolist] obj = "ml_g_file_attribute_info_list_ref"
  external lookup: [>`gfileattributeinfolist] obj -> string -> [<`gfileattributeinfo] obj = "ml_g_file_attribute_info_list_lookup"
  external dup: [>`gfileattributeinfolist] obj -> [<`gfileattributeinfolist] obj = "ml_g_file_attribute_info_list_dup"
  end
module EmblemedIcon = struct
  external get_emblems: [>`gemblemedicon] obj -> [<`glist] obj = "ml_g_emblemed_icon_get_emblems"
  external clear_emblems: [>`gemblemedicon] obj -> unit = "ml_g_emblemed_icon_clear_emblems"
  external add_emblem: [>`gemblemedicon] obj -> [>`gemblem] obj -> unit = "ml_g_emblemed_icon_add_emblem"
  end
module Emblem = struct
  end
module DesktopAppInfo = struct
  external get_show_in: [>`gdesktopappinfo] obj -> string -> bool = "ml_g_desktop_app_info_get_show_in"
  external get_nodisplay: [>`gdesktopappinfo] obj -> bool = "ml_g_desktop_app_info_get_nodisplay"
  external get_is_hidden: [>`gdesktopappinfo] obj -> bool = "ml_g_desktop_app_info_get_is_hidden"
  external get_generic_name: [>`gdesktopappinfo] obj -> string = "ml_g_desktop_app_info_get_generic_name"
  external get_filename: [>`gdesktopappinfo] obj -> string = "ml_g_desktop_app_info_get_filename"
  external get_categories: [>`gdesktopappinfo] obj -> string = "ml_g_desktop_app_info_get_categories"
  external set_desktop_env: string -> unit = "ml_g_desktop_app_info_set_desktop_env"
  end
module DataOutputStream = struct
  end
module DataInputStream = struct
  end
module DBusSignalInfo = struct
  external unref: [>`gdbussignalinfo] obj -> unit = "ml_g_dbus_signal_info_unref"
  external ref_: [>`gdbussignalinfo] obj -> [<`gdbussignalinfo] obj = "ml_g_dbus_signal_info_ref"
  end
module DBusServer = struct
  external stop: [>`gdbusserver] obj -> unit = "ml_g_dbus_server_stop"
  external start: [>`gdbusserver] obj -> unit = "ml_g_dbus_server_start"
  external is_active: [>`gdbusserver] obj -> bool = "ml_g_dbus_server_is_active"
  external get_guid: [>`gdbusserver] obj -> string = "ml_g_dbus_server_get_guid"
  external get_client_address: [>`gdbusserver] obj -> string = "ml_g_dbus_server_get_client_address"
  end
module DBusProxy = struct
  external set_interface_info: [>`gdbusproxy] obj -> [>`gdbusinterfaceinfo] obj option -> unit = "ml_g_dbus_proxy_set_interface_info"
  external set_default_timeout: [>`gdbusproxy] obj -> int -> unit = "ml_g_dbus_proxy_set_default_timeout"
  external set_cached_property: [>`gdbusproxy] obj -> string -> [>`gvariant] obj option -> unit = "ml_g_dbus_proxy_set_cached_property"
  external get_object_path: [>`gdbusproxy] obj -> string = "ml_g_dbus_proxy_get_object_path"
  external get_name_owner: [>`gdbusproxy] obj -> string = "ml_g_dbus_proxy_get_name_owner"
  external get_name: [>`gdbusproxy] obj -> string = "ml_g_dbus_proxy_get_name"
  external get_interface_name: [>`gdbusproxy] obj -> string = "ml_g_dbus_proxy_get_interface_name"
  external get_interface_info: [>`gdbusproxy] obj -> [<`gdbusinterfaceinfo] obj = "ml_g_dbus_proxy_get_interface_info"
  external get_default_timeout: [>`gdbusproxy] obj -> int = "ml_g_dbus_proxy_get_default_timeout"
  external get_connection: [>`gdbusproxy] obj -> [<`gdbusconnection] obj = "ml_g_dbus_proxy_get_connection"
  external get_cached_property: [>`gdbusproxy] obj -> string -> [<`gvariant] obj = "ml_g_dbus_proxy_get_cached_property"
  end
module DBusPropertyInfo = struct
  external unref: [>`gdbuspropertyinfo] obj -> unit = "ml_g_dbus_property_info_unref"
  external ref_: [>`gdbuspropertyinfo] obj -> [<`gdbuspropertyinfo] obj = "ml_g_dbus_property_info_ref"
  end
module DBusObjectSkeleton = struct
  external set_object_path: [>`gdbusobjectskeleton] obj -> string -> unit = "ml_g_dbus_object_skeleton_set_object_path"
  external remove_interface_by_name: [>`gdbusobjectskeleton] obj -> string -> unit = "ml_g_dbus_object_skeleton_remove_interface_by_name"
  external remove_interface: [>`gdbusobjectskeleton] obj -> [>`gdbusinterfaceskeleton] obj -> unit = "ml_g_dbus_object_skeleton_remove_interface"
  external flush: [>`gdbusobjectskeleton] obj -> unit = "ml_g_dbus_object_skeleton_flush"
  external add_interface: [>`gdbusobjectskeleton] obj -> [>`gdbusinterfaceskeleton] obj -> unit = "ml_g_dbus_object_skeleton_add_interface"
  end
module DBusObjectProxy = struct
  external get_connection: [>`gdbusobjectproxy] obj -> [<`gdbusconnection] obj = "ml_g_dbus_object_proxy_get_connection"
  end
module DBusObjectManagerServer = struct
  external unexport: [>`gdbusobjectmanagerserver] obj -> string -> bool = "ml_g_dbus_object_manager_server_unexport"
  external set_connection: [>`gdbusobjectmanagerserver] obj -> [>`gdbusconnection] obj option -> unit = "ml_g_dbus_object_manager_server_set_connection"
  external get_connection: [>`gdbusobjectmanagerserver] obj -> [<`gdbusconnection] obj = "ml_g_dbus_object_manager_server_get_connection"
  external export_uniquely: [>`gdbusobjectmanagerserver] obj -> [>`gdbusobjectskeleton] obj -> unit = "ml_g_dbus_object_manager_server_export_uniquely"
  external export: [>`gdbusobjectmanagerserver] obj -> [>`gdbusobjectskeleton] obj -> unit = "ml_g_dbus_object_manager_server_export"
  end
module DBusObjectManagerClient = struct
  external get_name_owner: [>`gdbusobjectmanagerclient] obj -> string = "ml_g_dbus_object_manager_client_get_name_owner"
  external get_name: [>`gdbusobjectmanagerclient] obj -> string = "ml_g_dbus_object_manager_client_get_name"
  external get_connection: [>`gdbusobjectmanagerclient] obj -> [<`gdbusconnection] obj = "ml_g_dbus_object_manager_client_get_connection"
  end
module DBusNodeInfo = struct
  external unref: [>`gdbusnodeinfo] obj -> unit = "ml_g_dbus_node_info_unref"
  external ref_: [>`gdbusnodeinfo] obj -> [<`gdbusnodeinfo] obj = "ml_g_dbus_node_info_ref"
  external lookup_interface: [>`gdbusnodeinfo] obj -> string -> [<`gdbusinterfaceinfo] obj = "ml_g_dbus_node_info_lookup_interface"
  end
module DBusMethodInvocation = struct
  external return_value_with_unix_fd_list: [>`gdbusmethodinvocation] obj -> [>`gvariant] obj option -> [>`gunixfdlist] obj option -> unit = "ml_g_dbus_method_invocation_return_value_with_unix_fd_list"
  external return_value: [>`gdbusmethodinvocation] obj -> [>`gvariant] obj option -> unit = "ml_g_dbus_method_invocation_return_value"
  external return_gerror: [>`gdbusmethodinvocation] obj -> [>`gerror] obj -> unit = "ml_g_dbus_method_invocation_return_gerror"
  external return_error_literal: [>`gdbusmethodinvocation] obj -> int32 -> int -> string -> unit = "ml_g_dbus_method_invocation_return_error_literal"
  external return_dbus_error: [>`gdbusmethodinvocation] obj -> string -> string -> unit = "ml_g_dbus_method_invocation_return_dbus_error"
  external get_sender: [>`gdbusmethodinvocation] obj -> string = "ml_g_dbus_method_invocation_get_sender"
  external get_parameters: [>`gdbusmethodinvocation] obj -> [<`gvariant] obj = "ml_g_dbus_method_invocation_get_parameters"
  external get_object_path: [>`gdbusmethodinvocation] obj -> string = "ml_g_dbus_method_invocation_get_object_path"
  external get_method_name: [>`gdbusmethodinvocation] obj -> string = "ml_g_dbus_method_invocation_get_method_name"
  external get_method_info: [>`gdbusmethodinvocation] obj -> [<`gdbusmethodinfo] obj = "ml_g_dbus_method_invocation_get_method_info"
  external get_message: [>`gdbusmethodinvocation] obj -> [<`gdbusmessage] obj = "ml_g_dbus_method_invocation_get_message"
  external get_interface_name: [>`gdbusmethodinvocation] obj -> string = "ml_g_dbus_method_invocation_get_interface_name"
  external get_connection: [>`gdbusmethodinvocation] obj -> [<`gdbusconnection] obj = "ml_g_dbus_method_invocation_get_connection"
  end
module DBusMethodInfo = struct
  external unref: [>`gdbusmethodinfo] obj -> unit = "ml_g_dbus_method_info_unref"
  external ref_: [>`gdbusmethodinfo] obj -> [<`gdbusmethodinfo] obj = "ml_g_dbus_method_info_ref"
  end
module DBusMessage = struct
  external set_unix_fd_list: [>`gdbusmessage] obj -> [>`gunixfdlist] obj option -> unit = "ml_g_dbus_message_set_unix_fd_list"
  external set_signature: [>`gdbusmessage] obj -> string -> unit = "ml_g_dbus_message_set_signature"
  external set_serial: [>`gdbusmessage] obj -> int32 -> unit = "ml_g_dbus_message_set_serial"
  external set_sender: [>`gdbusmessage] obj -> string -> unit = "ml_g_dbus_message_set_sender"
  external set_reply_serial: [>`gdbusmessage] obj -> int32 -> unit = "ml_g_dbus_message_set_reply_serial"
  external set_path: [>`gdbusmessage] obj -> string -> unit = "ml_g_dbus_message_set_path"
  external set_num_unix_fds: [>`gdbusmessage] obj -> int32 -> unit = "ml_g_dbus_message_set_num_unix_fds"
  external set_member: [>`gdbusmessage] obj -> string -> unit = "ml_g_dbus_message_set_member"
  external set_interface: [>`gdbusmessage] obj -> string -> unit = "ml_g_dbus_message_set_interface"
  external set_error_name: [>`gdbusmessage] obj -> string -> unit = "ml_g_dbus_message_set_error_name"
  external set_destination: [>`gdbusmessage] obj -> string -> unit = "ml_g_dbus_message_set_destination"
  external set_body: [>`gdbusmessage] obj -> [>`gvariant] obj -> unit = "ml_g_dbus_message_set_body"
  external print: [>`gdbusmessage] obj -> int -> string = "ml_g_dbus_message_print"
  external new_method_reply: [>`gdbusmessage] obj -> [<`gdbusmessage] obj = "ml_g_dbus_message_new_method_reply"
  external new_method_error_literal: [>`gdbusmessage] obj -> string -> string -> [<`gdbusmessage] obj = "ml_g_dbus_message_new_method_error_literal"
  external lock: [>`gdbusmessage] obj -> unit = "ml_g_dbus_message_lock"
  external get_unix_fd_list: [>`gdbusmessage] obj -> [<`gunixfdlist] obj = "ml_g_dbus_message_get_unix_fd_list"
  external get_signature: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_signature"
  external get_serial: [>`gdbusmessage] obj -> int32 = "ml_g_dbus_message_get_serial"
  external get_sender: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_sender"
  external get_reply_serial: [>`gdbusmessage] obj -> int32 = "ml_g_dbus_message_get_reply_serial"
  external get_path: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_path"
  external get_num_unix_fds: [>`gdbusmessage] obj -> int32 = "ml_g_dbus_message_get_num_unix_fds"
  external get_member: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_member"
  external get_locked: [>`gdbusmessage] obj -> bool = "ml_g_dbus_message_get_locked"
  external get_interface: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_interface"
  external get_error_name: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_error_name"
  external get_destination: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_destination"
  external get_body: [>`gdbusmessage] obj -> [<`gvariant] obj = "ml_g_dbus_message_get_body"
  external get_arg0: [>`gdbusmessage] obj -> string = "ml_g_dbus_message_get_arg0"
  end
module DBusMenuModel = struct
  external get: [>`gdbusconnection] obj -> string -> string -> [<`gdbusmenumodel] obj = "ml_g_dbus_menu_model_get"
  end
module DBusInterfaceSkeleton = struct
  external unexport_from_connection: [>`gdbusinterfaceskeleton] obj -> [>`gdbusconnection] obj -> unit = "ml_g_dbus_interface_skeleton_unexport_from_connection"
  external unexport: [>`gdbusinterfaceskeleton] obj -> unit = "ml_g_dbus_interface_skeleton_unexport"
  external has_connection: [>`gdbusinterfaceskeleton] obj -> [>`gdbusconnection] obj -> bool = "ml_g_dbus_interface_skeleton_has_connection"
  external get_vtable: [>`gdbusinterfaceskeleton] obj -> [<`gdbusinterfacevtable] obj = "ml_g_dbus_interface_skeleton_get_vtable"
  external get_properties: [>`gdbusinterfaceskeleton] obj -> [<`gvariant] obj = "ml_g_dbus_interface_skeleton_get_properties"
  external get_object_path: [>`gdbusinterfaceskeleton] obj -> string = "ml_g_dbus_interface_skeleton_get_object_path"
  external get_info: [>`gdbusinterfaceskeleton] obj -> [<`gdbusinterfaceinfo] obj = "ml_g_dbus_interface_skeleton_get_info"
  external get_connections: [>`gdbusinterfaceskeleton] obj -> [<`glist] obj = "ml_g_dbus_interface_skeleton_get_connections"
  external get_connection: [>`gdbusinterfaceskeleton] obj -> [<`gdbusconnection] obj = "ml_g_dbus_interface_skeleton_get_connection"
  external flush: [>`gdbusinterfaceskeleton] obj -> unit = "ml_g_dbus_interface_skeleton_flush"
  end
module DBusInterfaceInfo = struct
  external unref: [>`gdbusinterfaceinfo] obj -> unit = "ml_g_dbus_interface_info_unref"
  external ref_: [>`gdbusinterfaceinfo] obj -> [<`gdbusinterfaceinfo] obj = "ml_g_dbus_interface_info_ref"
  external lookup_signal: [>`gdbusinterfaceinfo] obj -> string -> [<`gdbussignalinfo] obj = "ml_g_dbus_interface_info_lookup_signal"
  external lookup_property: [>`gdbusinterfaceinfo] obj -> string -> [<`gdbuspropertyinfo] obj = "ml_g_dbus_interface_info_lookup_property"
  external lookup_method: [>`gdbusinterfaceinfo] obj -> string -> [<`gdbusmethodinfo] obj = "ml_g_dbus_interface_info_lookup_method"
  external cache_release: [>`gdbusinterfaceinfo] obj -> unit = "ml_g_dbus_interface_info_cache_release"
  external cache_build: [>`gdbusinterfaceinfo] obj -> unit = "ml_g_dbus_interface_info_cache_build"
  end
module DBusConnection = struct
  external unregister_subtree: [>`gdbusconnection] obj -> int -> bool = "ml_g_dbus_connection_unregister_subtree"
  external unregister_object: [>`gdbusconnection] obj -> int -> bool = "ml_g_dbus_connection_unregister_object"
  external unexport_menu_model: [>`gdbusconnection] obj -> int -> unit = "ml_g_dbus_connection_unexport_menu_model"
  external unexport_action_group: [>`gdbusconnection] obj -> int -> unit = "ml_g_dbus_connection_unexport_action_group"
  external start_message_processing: [>`gdbusconnection] obj -> unit = "ml_g_dbus_connection_start_message_processing"
  external signal_unsubscribe: [>`gdbusconnection] obj -> int -> unit = "ml_g_dbus_connection_signal_unsubscribe"
  external set_exit_on_close: [>`gdbusconnection] obj -> bool -> unit = "ml_g_dbus_connection_set_exit_on_close"
  external remove_filter: [>`gdbusconnection] obj -> int -> unit = "ml_g_dbus_connection_remove_filter"
  external is_closed: [>`gdbusconnection] obj -> bool = "ml_g_dbus_connection_is_closed"
  external get_unique_name: [>`gdbusconnection] obj -> string = "ml_g_dbus_connection_get_unique_name"
  external get_stream: [>`gdbusconnection] obj -> [<`giostream] obj = "ml_g_dbus_connection_get_stream"
  external get_peer_credentials: [>`gdbusconnection] obj -> [<`gcredentials] obj = "ml_g_dbus_connection_get_peer_credentials"
  external get_guid: [>`gdbusconnection] obj -> string = "ml_g_dbus_connection_get_guid"
  external get_exit_on_close: [>`gdbusconnection] obj -> bool = "ml_g_dbus_connection_get_exit_on_close"
  end
module DBusAuthObserver = struct
  external authorize_authenticated_peer: [>`gdbusauthobserver] obj -> [>`giostream] obj -> [>`gcredentials] obj -> bool = "ml_g_dbus_auth_observer_authorize_authenticated_peer"
  end
module DBusArgInfo = struct
  external unref: [>`gdbusarginfo] obj -> unit = "ml_g_dbus_arg_info_unref"
  external ref_: [>`gdbusarginfo] obj -> [<`gdbusarginfo] obj = "ml_g_dbus_arg_info_ref"
  end
module DBusAnnotationInfo = struct
  external unref: [>`gdbusannotationinfo] obj -> unit = "ml_g_dbus_annotation_info_unref"
  external ref_: [>`gdbusannotationinfo] obj -> [<`gdbusannotationinfo] obj = "ml_g_dbus_annotation_info_ref"
  end
module DBusActionGroup = struct
  external get: [>`gdbusconnection] obj -> string -> string -> [<`gdbusactiongroup] obj = "ml_g_dbus_action_group_get"
  end
module Credentials = struct
  external to_string: [>`gcredentials] obj -> string = "ml_g_credentials_to_string"
  end
module ConverterOutputStream = struct
  end
module ConverterInputStream = struct
  end
module CharsetConverter = struct
  external set_use_fallback: [>`gcharsetconverter] obj -> bool -> unit = "ml_g_charset_converter_set_use_fallback"
  external get_use_fallback: [>`gcharsetconverter] obj -> bool = "ml_g_charset_converter_get_use_fallback"
  external get_num_fallbacks: [>`gcharsetconverter] obj -> int = "ml_g_charset_converter_get_num_fallbacks"
  end
module Cancellable = struct
  external source_new: [>`gcancellable] obj -> [<`gsource] obj = "ml_g_cancellable_source_new"
  external reset: [>`gcancellable] obj -> unit = "ml_g_cancellable_reset"
  external release_fd: [>`gcancellable] obj -> unit = "ml_g_cancellable_release_fd"
  external push_current: [>`gcancellable] obj -> unit = "ml_g_cancellable_push_current"
  external pop_current: [>`gcancellable] obj -> unit = "ml_g_cancellable_pop_current"
  external make_pollfd: [>`gcancellable] obj -> [>`gpollfd] obj -> bool = "ml_g_cancellable_make_pollfd"
  external is_cancelled: [>`gcancellable] obj -> bool = "ml_g_cancellable_is_cancelled"
  external get_fd: [>`gcancellable] obj -> int = "ml_g_cancellable_get_fd"
  external disconnect: [>`gcancellable] obj -> float -> unit = "ml_g_cancellable_disconnect"
  external cancel: [>`gcancellable] obj -> unit = "ml_g_cancellable_cancel"
  external get_current: unit -> [<`gcancellable] obj = "ml_g_cancellable_get_current"
  end
module BufferedOutputStream = struct
  external set_buffer_size: [>`gbufferedoutputstream] obj -> int -> unit = "ml_g_buffered_output_stream_set_buffer_size"
  external set_auto_grow: [>`gbufferedoutputstream] obj -> bool -> unit = "ml_g_buffered_output_stream_set_auto_grow"
  external get_buffer_size: [>`gbufferedoutputstream] obj -> int = "ml_g_buffered_output_stream_get_buffer_size"
  external get_auto_grow: [>`gbufferedoutputstream] obj -> bool = "ml_g_buffered_output_stream_get_auto_grow"
  end
module BufferedInputStream = struct
  external set_buffer_size: [>`gbufferedinputstream] obj -> int -> unit = "ml_g_buffered_input_stream_set_buffer_size"
  external get_buffer_size: [>`gbufferedinputstream] obj -> int = "ml_g_buffered_input_stream_get_buffer_size"
  external get_available: [>`gbufferedinputstream] obj -> int = "ml_g_buffered_input_stream_get_available"
  end
module ApplicationCommandLine = struct
  external set_exit_status: [>`gapplicationcommandline] obj -> int -> unit = "ml_g_application_command_line_set_exit_status"
  external getenv: [>`gapplicationcommandline] obj -> string -> string = "ml_g_application_command_line_getenv"
  external get_platform_data: [>`gapplicationcommandline] obj -> [<`gvariant] obj = "ml_g_application_command_line_get_platform_data"
  external get_is_remote: [>`gapplicationcommandline] obj -> bool = "ml_g_application_command_line_get_is_remote"
  external get_exit_status: [>`gapplicationcommandline] obj -> int = "ml_g_application_command_line_get_exit_status"
  external get_cwd: [>`gapplicationcommandline] obj -> string = "ml_g_application_command_line_get_cwd"
  end
module Application = struct
  external set_inactivity_timeout: [>`gapplication] obj -> int -> unit = "ml_g_application_set_inactivity_timeout"
  external set_default: [>`gapplication] obj -> unit = "ml_g_application_set_default"
  external set_application_id: [>`gapplication] obj -> string -> unit = "ml_g_application_set_application_id"
  external release: [>`gapplication] obj -> unit = "ml_g_application_release"
  external quit: [>`gapplication] obj -> unit = "ml_g_application_quit"
  external hold: [>`gapplication] obj -> unit = "ml_g_application_hold"
  external get_is_remote: [>`gapplication] obj -> bool = "ml_g_application_get_is_remote"
  external get_is_registered: [>`gapplication] obj -> bool = "ml_g_application_get_is_registered"
  external get_inactivity_timeout: [>`gapplication] obj -> int = "ml_g_application_get_inactivity_timeout"
  external get_application_id: [>`gapplication] obj -> string = "ml_g_application_get_application_id"
  external activate: [>`gapplication] obj -> unit = "ml_g_application_activate"
  external id_is_valid: string -> bool = "ml_g_application_id_is_valid"
  external get_default: unit -> [<`gapplication] obj = "ml_g_application_get_default"
  end
module AppLaunchContext = struct
  external unsetenv: [>`gapplaunchcontext] obj -> string -> unit = "ml_g_app_launch_context_unsetenv"
  external setenv: [>`gapplaunchcontext] obj -> string -> string -> unit = "ml_g_app_launch_context_setenv"
  external launch_failed: [>`gapplaunchcontext] obj -> string -> unit = "ml_g_app_launch_context_launch_failed"
  end
(* Global functions *)
external unix_mounts_changed_since: int64 -> bool = "ml_g_unix_mounts_changed_since"
external unix_mount_points_changed_since: int64 -> bool = "ml_g_unix_mount_points_changed_since"
external unix_mount_is_system_internal: [>`gunixmountentry] obj -> bool = "ml_g_unix_mount_is_system_internal"
external unix_mount_is_readonly: [>`gunixmountentry] obj -> bool = "ml_g_unix_mount_is_readonly"
external unix_mount_guess_should_display: [>`gunixmountentry] obj -> bool = "ml_g_unix_mount_guess_should_display"
external unix_mount_guess_name: [>`gunixmountentry] obj -> string = "ml_g_unix_mount_guess_name"
external unix_mount_guess_can_eject: [>`gunixmountentry] obj -> bool = "ml_g_unix_mount_guess_can_eject"
external unix_mount_get_mount_path: [>`gunixmountentry] obj -> string = "ml_g_unix_mount_get_mount_path"
external unix_mount_get_fs_type: [>`gunixmountentry] obj -> string = "ml_g_unix_mount_get_fs_type"
external unix_mount_get_device_path: [>`gunixmountentry] obj -> string = "ml_g_unix_mount_get_device_path"
external unix_mount_free: [>`gunixmountentry] obj -> unit = "ml_g_unix_mount_free"
external unix_mount_compare: [>`gunixmountentry] obj -> [>`gunixmountentry] obj -> int = "ml_g_unix_mount_compare"
external unix_is_mount_path_system_internal: string -> bool = "ml_g_unix_is_mount_path_system_internal"
external pollable_source_new: [>`gobject] obj -> [<`gsource] obj = "ml_g_pollable_source_new"
external io_scheduler_cancel_all_jobs: unit -> unit = "ml_g_io_scheduler_cancel_all_jobs"
external io_modules_scan_all_in_directory_with_scope: string -> [>`giomodulescope] obj -> unit = "ml_g_io_modules_scan_all_in_directory_with_scope"
external io_modules_scan_all_in_directory: string -> unit = "ml_g_io_modules_scan_all_in_directory"
external io_modules_load_all_in_directory_with_scope: string -> [>`giomodulescope] obj -> [<`glist] obj = "ml_g_io_modules_load_all_in_directory_with_scope"
external io_modules_load_all_in_directory: string -> [<`glist] obj = "ml_g_io_modules_load_all_in_directory"
external io_error_quark: unit -> int32 = "ml_g_io_error_quark"
external dbus_is_unique_name: string -> bool = "ml_g_dbus_is_unique_name"
external dbus_is_name: string -> bool = "ml_g_dbus_is_name"
external dbus_is_member_name: string -> bool = "ml_g_dbus_is_member_name"
external dbus_is_interface_name: string -> bool = "ml_g_dbus_is_interface_name"
external dbus_is_guid: string -> bool = "ml_g_dbus_is_guid"
external dbus_is_address: string -> bool = "ml_g_dbus_is_address"
external dbus_gvariant_to_gvalue: [>`gvariant] obj -> [>`gvalue] obj -> unit = "ml_g_dbus_gvariant_to_gvalue"
external dbus_gvalue_to_gvariant: [>`gvalue] obj -> [>`gvarianttype] obj -> [<`gvariant] obj = "ml_g_dbus_gvalue_to_gvariant"
external dbus_generate_guid: unit -> string = "ml_g_dbus_generate_guid"
external content_types_get_registered: unit -> [<`glist] obj = "ml_g_content_types_get_registered"
external content_type_is_unknown: string -> bool = "ml_g_content_type_is_unknown"
external content_type_is_a: string -> string -> bool = "ml_g_content_type_is_a"
external content_type_get_mime_type: string -> string = "ml_g_content_type_get_mime_type"
external content_type_get_description: string -> string = "ml_g_content_type_get_description"
external content_type_from_mime_type: string -> string = "ml_g_content_type_from_mime_type"
external content_type_equals: string -> string -> bool = "ml_g_content_type_equals"
external content_type_can_be_executable: string -> bool = "ml_g_content_type_can_be_executable"
external bus_unwatch_name: int -> unit = "ml_g_bus_unwatch_name"
external bus_unown_name: int -> unit = "ml_g_bus_unown_name"
(* End of global functions *)

