import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:proxmox_dart_api_client/proxmox_dart_api_client.dart';
import 'package:proxmox_dart_api_client/src/models/pve_ha_manger_service_status_model.dart';

part 'pve_nodes_qemu_status_model.g.dart';

abstract class PveQemuStatusModel
    implements Built<PveQemuStatusModel, PveQemuStatusModelBuilder> {
  static Serializer<PveQemuStatusModel> get serializer =>
      _$pveQemuStatusModelSerializer;

  PveHAMangerServiceStatusModel? get ha;
  String? get status;
  bool? get agent;
  String? get name;
  String? get pid;
  Duration? get uptime;
  double? get cpus;
  double? get diskread;
  double? get diskwrite;
  double? get netin;
  double? get netout;
  double? get mem;
  int? get maxmem;
  int? get maxdisk;
  int? get maxcpu;
  int? get disk;
  String? get qmpstatus;
  String? get lock;
  bool? get template;
  bool? get spice;

  PveQemuStatusModel._();
  factory PveQemuStatusModel(
          [void Function(PveQemuStatusModelBuilder)? updates]) =
      _$PveQemuStatusModel;

  PveResourceStatusType getQemuStatus() {
    if (status == 'running') {
      switch (qmpstatus) {
        case 'running':
          return PveResourceStatusType.running;
          break;
        case 'paused':
          return PveResourceStatusType.paused;
          break;
        default:
          if (lock == 'suspending') {
            return PveResourceStatusType.suspending;
          }
          if (lock == 'suspended') {
            return PveResourceStatusType.suspended;
          }
          return PveResourceStatusType.running;
      }
    }

    if (status == 'stopped') {
      if (lock == 'suspended') {
        return PveResourceStatusType.suspended;
      }
      return PveResourceStatusType.stopped;
    }
    return PveResourceStatusType.unkown;
  }
}
