import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:proxmox_dart_api_client/src/models/pve_cluster_resources_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_ha_manger_service_status_model.dart';

part 'pve_nodes_lxc_status_model.g.dart';

abstract class PveNodesLxcStatusModel
    implements Built<PveNodesLxcStatusModel, PveNodesLxcStatusModelBuilder> {
  // Fields
  PveHAMangerServiceStatusModel get ha;
  LxcStatusType get status;
  String get vmid;
  @nullable
  num get cpus;
  @nullable
  String get lock;
  @nullable
  int get integer;
  @nullable
  int get maxmem;
  @nullable
  int get maxswap;
  @nullable
  String get name;
  @nullable
  String get tags;
  @nullable
  Duration get uptime;
  @nullable
  bool get template;

  PveNodesLxcStatusModel._();

  factory PveNodesLxcStatusModel(
          [void Function(PveNodesLxcStatusModelBuilder) updates]) =
      _$PveNodesLxcStatusModel;

  static Serializer<PveNodesLxcStatusModel> get serializer =>
      _$pveNodesLxcStatusModelSerializer;

  PveResourceStatusType getLxcStatus() {
    if (status == LxcStatusType.running) {
      if (lock == 'suspending') {
        return PveResourceStatusType.suspending;
      }
      if (lock == 'suspended') {
        return PveResourceStatusType.suspended;
      }
      return PveResourceStatusType.running;
    }

    if (status == LxcStatusType.stopped) {
      if (lock == 'suspended') {
        return PveResourceStatusType.suspended;
      }
      return PveResourceStatusType.stopped;
    }
    return PveResourceStatusType.unkown;
  }
}

class LxcStatusType extends EnumClass {
  static const LxcStatusType stopped = _$stopped;
  static const LxcStatusType running = _$running;

  @BuiltValueEnumConst(fallback: true)
  static const LxcStatusType undefined = _$undefined;

  const LxcStatusType._(String name) : super(name);

  static BuiltSet<LxcStatusType> get values => _$values;
  static LxcStatusType valueOf(String name) => _$valueOf(name);
  static Serializer<LxcStatusType> get serializer => _$lxcStatusTypeSerializer;
}
