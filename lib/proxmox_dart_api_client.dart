/// Support for doing something awesome.
///
/// More dartdocs go here.
library proxmox_dart_api_client;

export 'src/client.dart';
export 'src/authenticate.dart';
export 'src/credentials.dart';
export 'src/proxmox_api_exception.dart';

export 'src/utils.dart'
    if (dart.library.html) 'src/utils_web.dart'
    if (dart.library.io) 'src/utils_native.dart';