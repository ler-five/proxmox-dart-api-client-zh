import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:proxmox_dart_api_client/src/utils.dart';

part 'pve_nodes_lxc_config_model.g.dart';

abstract class PveNodesLxcConfigModel
    implements Built<PveNodesLxcConfigModel, PveNodesLxcConfigModelBuilder> {
  // Fields
  String get digest;

  @nullable
  LxcProcessorArch get arch;
  @nullable
  LxcConsoleMode get cmode;
  @nullable
  bool get console;
  @nullable
  int get cores;
  @nullable
  int get cpuunits;
  @nullable
  String get description;
  @nullable
  JsonObject get features;
  @nullable
  String get hostname;
  @nullable
  LxcLockType get lock;
  @nullable
  BuiltList<String> get lxc;
  @nullable
  int get memory;
  BuiltList<String> get mp;
  @nullable
  String get nameserver;
  BuiltList<String> get net;
  @nullable
  bool get onboot;
  @nullable
  LxcOsType get ostype;
  @nullable
  bool get protection;
  @nullable
  JsonObject get rootfs;
  @nullable
  String get searchdomain;
  @nullable
  String get startup;
  @nullable
  int get swap;
  @nullable
  String get tags;
  @nullable
  bool get template;
  @nullable
  int get tty;
  @nullable
  bool get unprivileged;
  BuiltList<String> get unused;

  @nullable
  Map<String, dynamic> get pending;

  dynamic getPending(String field) {
    if (pending == null || pending.isEmpty) {
      throw StateError('No pending values available');
    }
    if (pending[field] != null && pending[field]['pending'] != null) {
      return pending[field]['pending'];
    }
    return null;
  }

  PveNodesLxcConfigModel._();

  factory PveNodesLxcConfigModel(
          [void Function(PveNodesLxcConfigModelBuilder) updates]) =
      _$PveNodesLxcConfigModel;

  static Serializer<PveNodesLxcConfigModel> get serializer =>
      _$pveNodesLxcConfigModelSerializer;
  PveNodesLxcConfigModel postProcessEnumeratedJsonFields(dynamic object) {
    final map = object as Map<String, dynamic>;

    List<String> mp = matchEnumJsonFields('mp', 256, map);
    List<String> net = matchEnumJsonFields('net', 10, map);
    List<String> unused = matchEnumJsonFields('unused', 256, map);

    return rebuild(
        (b) => b..mp.replace(mp)..unused.replace(unused)..net.replace(net));
  }
}

@BuiltValueEnum(wireName: 'arch')
class LxcProcessorArch extends EnumClass {
  static const LxcProcessorArch amd64 = _$amd64;
  static const LxcProcessorArch i386 = _$i386;
  static const LxcProcessorArch arm64 = _$arm64;
  static const LxcProcessorArch armhf = _$armhf;

  @BuiltValueEnumConst(fallback: true)
  static const LxcProcessorArch undefined = _$pundefined;

  const LxcProcessorArch._(String name) : super(name);

  static BuiltSet<LxcProcessorArch> get values => _$paValues;
  static LxcProcessorArch valueOf(String name) => _$paValueOf(name);
  static Serializer<LxcProcessorArch> get serializer =>
      _$lxcProcessorArchSerializer;
}

@BuiltValueEnum(wireName: 'cmode')
class LxcConsoleMode extends EnumClass {
  static const LxcConsoleMode shell = _$shell;
  static const LxcConsoleMode console = _$console;
  static const LxcConsoleMode tty = _$tty;

  @BuiltValueEnumConst(fallback: true)
  static const LxcConsoleMode undefined = _$cundefined;

  const LxcConsoleMode._(String name) : super(name);

  static BuiltSet<LxcConsoleMode> get values => _$cvalues;
  static LxcConsoleMode valueOf(String name) => _$cvalueOf(name);
  static Serializer<LxcConsoleMode> get serializer =>
      _$lxcConsoleModeSerializer;
}

@BuiltValueEnum(wireName: 'lock')
class LxcLockType extends EnumClass {
  static const LxcLockType backup = _$backup;
  static const LxcLockType destroyed = _$destroyed;
  static const LxcLockType fstrim = _$fstrim;
  static const LxcLockType disk = _$disk;
  static const LxcLockType mounted = _$mounted;
  static const LxcLockType create = _$create;
  static const LxcLockType migrate = _$migrate;
  static const LxcLockType rollback = _$rollback;
  static const LxcLockType snapshot = _$snapshot;
  @BuiltValueEnumConst(wireName: 'snapshot-delete')
  static const LxcLockType snapshotDelete = _$snapshotDelete;

  @BuiltValueEnumConst(fallback: true)
  static const LxcLockType undefined = _$lundefined;

  const LxcLockType._(String name) : super(name);

  static BuiltSet<LxcLockType> get values => _$lvalues;
  static LxcLockType valueOf(String name) => _$lvalueOf(name);
  static Serializer<LxcLockType> get serializer => _$lxcLockTypeSerializer;
}

@BuiltValueEnum(wireName: 'ostype')
class LxcOsType extends EnumClass {
  static const LxcOsType debian = _$yes;
  static const LxcOsType ubuntu = _$ubuntu;
  static const LxcOsType centos = _$centos;
  static const LxcOsType fedora = _$fedora;
  static const LxcOsType opensuse = _$opensuse;
  static const LxcOsType archlinux = _$archlinux;
  static const LxcOsType alpine = _$alpine;
  static const LxcOsType gentoo = _$gentoo;

  @BuiltValueEnumConst(fallback: true)
  static const LxcOsType unmanaged = _$unmanaged;

  const LxcOsType._(String name) : super(name);

  static BuiltSet<LxcOsType> get values => _$ovalues;
  static LxcOsType valueOf(String name) => _$ovalueOf(name);
  static Serializer<LxcOsType> get serializer => _$lxcOsTypeSerializer;
}
