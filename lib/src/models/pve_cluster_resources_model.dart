import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_cluster_resources_model.g.dart';

abstract class PveClusterResourcesModel
    implements
        Built<PveClusterResourcesModel, PveClusterResourcesModelBuilder> {
  static Serializer<PveClusterResourcesModel> get serializer =>
      _$pveClusterResourcesModelSerializer;

  @nullable
  double get cpu;
  @nullable
  int get disk;
  @nullable
  String get hastate;
  String get id;
  @nullable
  String get level;
  @nullable
  double get maxcpu;
  @nullable
  int get maxdisk;
  @nullable
  int get maxmem;
  @nullable
  int get mem;
  @nullable
  String get name;
  @nullable
  String get node;
  @nullable
  String get pool;
  @nullable
  String get status;
  @nullable
  bool get shared;
  @nullable
  String get storage;
  String get type;
  @nullable
  int get uptime;
  @nullable
  int get vmid;

  factory PveClusterResourcesModel(
          [void Function(PveClusterResourcesModelBuilder) updates]) =
      _$PveClusterResourcesModel;
  PveClusterResourcesModel._();

  String get displayName {
    switch (type) {
      case "node":
        return node;
      case "qemu":
        return "$vmid $name";
      case "lxc":
        return "$vmid $name";
      case "storage":
        return storage;
      case "pool":
        return pool;
      default:
        return id;
    }
  }
}

class PveClusterResourceType extends EnumClass {

  static const PveClusterResourceType vm = _$vm;
  static const PveClusterResourceType storage = _$storage;
  static const PveClusterResourceType node = _$node;
  static const PveClusterResourceType sdn = _$sdn;


  const PveClusterResourceType._(String name) : super(name);

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

  const PveClusterResourceAction._(String name) : super(name);

  static BuiltSet<PveClusterResourceAction> get values =>
      _$pveClusterResourceActionValues;
  static PveClusterResourceAction valueOf(String name) =>
      _$pveClusterResourceActionValueOf(name);
}
