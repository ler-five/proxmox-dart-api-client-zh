import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_cluster_resources_model.g.dart';

abstract class PveClusterResourcesModel
    implements
        Built<PveClusterResourcesModel, PveClusterResourcesModelBuilder> {
  static Serializer<PveClusterResourcesModel> get serializer =>
      _$pveClusterResourcesModelSerializer;

  String get id;
  String get type;

  double? get cpu;
  int? get disk;
  String? get hastate;
  String? get level;
  double? get maxcpu;
  int? get maxdisk;
  int? get maxmem;
  int? get mem;
  String? get name;
  String? get node;
  String? get pool;
  String? get status;
  bool? get shared;
  String? get storage;
  int? get uptime;
  int? get vmid;
  String? get lock;
  bool? get template;

  factory PveClusterResourcesModel(
          [void Function(PveClusterResourcesModelBuilder)? updates]) =
      _$PveClusterResourcesModel;
  PveClusterResourcesModel._();

  String get displayName {
    switch (type) {
      case 'node':
        return node!;
      case 'qemu':
        return "$vmid ${name ?? ''}";
      case 'lxc':
        return "$vmid ${name ?? ''}";
      case 'storage':
        return storage!;
      case 'pool':
        return pool!;
      default:
        return id;
    }
  }

  PveResourceStatusType getStatus() {
    if (status == 'running' || status == 'available' || status == 'online') {
      if (lock == 'suspending') {
        return PveResourceStatusType.suspending;
      }
      return PveResourceStatusType.running;
    }

    if (status == 'stopped' || status == 'offline') {
      if (lock == 'suspended') {
        return PveResourceStatusType.suspended;
      }
      return PveResourceStatusType.stopped;
    }

    if(status == 'prelaunch') return PveResourceStatusType.prelaunch;

    if (status == 'paused') return PveResourceStatusType.paused;

    return PveResourceStatusType.unknown;
  }
}

class PveClusterResourceType extends EnumClass {
  static const PveClusterResourceType vm = _$vm;
  static const PveClusterResourceType storage = _$storage;
  static const PveClusterResourceType node = _$node;
  static const PveClusterResourceType sdn = _$sdn;

  const PveClusterResourceType._(super.name);

  static BuiltSet<PveClusterResourceType> get values => _$pcrtValues;
  static PveClusterResourceType valueOf(String name) => _$pcrtValueOf(name);
}

class PveClusterResourceAction extends EnumClass {
  static const PveClusterResourceAction start = _$start;
  static const PveClusterResourceAction stop = _$stop;
  static const PveClusterResourceAction shutdown = _$shutdown;
  static const PveClusterResourceAction resume = _$resume;
  static const PveClusterResourceAction reboot = _$reboot;
  static const PveClusterResourceAction suspend = _$suspend;
  static const PveClusterResourceAction reset = _$reset;
  static const PveClusterResourceAction hibernate = _$hibernate;

  const PveClusterResourceAction._(super.name);

  static BuiltSet<PveClusterResourceAction> get values =>
      _$pveClusterResourceActionValues;
  static PveClusterResourceAction valueOf(String name) =>
      _$pveClusterResourceActionValueOf(name);
}

class PveResourceStatusType extends EnumClass {
  static const PveResourceStatusType stopped = _$stopped;
  static const PveResourceStatusType running = _$running;
  static const PveResourceStatusType paused = _$paused;
  static const PveResourceStatusType suspending = _$suspending;
  static const PveResourceStatusType suspended = _$suspended;
  static const PveResourceStatusType unknown = _$unknown;
  static const PveResourceStatusType prelaunch = _$prelaunch;

  const PveResourceStatusType._(super.name);

  static BuiltSet<PveResourceStatusType> get values => _$pqsTValues;
  static PveResourceStatusType valueOf(String name) => _$pqsTValueOf(name);

  static Serializer<PveResourceStatusType> get serializer =>
      _$pveResourceStatusTypeSerializer;
}
