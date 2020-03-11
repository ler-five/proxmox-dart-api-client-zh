import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:proxmox_dart_api_client/src/models/pve_ha_manger_service_status_model.dart';

part 'pve_nodes_qemu_status_model.g.dart';

abstract class PveQemuStatusModel
    implements Built<PveQemuStatusModel, PveQemuStatusModelBuilder> {
  static Serializer<PveQemuStatusModel> get serializer =>
      _$pveQemuStatusModelSerializer;

  PveHAMangerServiceStatusModel get ha;
  PveQemuStatusType get status;
  @nullable
  bool get agent;
  @nullable
  String get name;
  @nullable
  String get pid;
  @nullable
  Duration get uptime;
  @nullable
  double get cpus;
  @nullable
  double get diskread;
  @nullable
  double get diskwrite;
  @nullable
  double get netin;
  @nullable
  double get netout;
  @nullable
  double get mem;
  @nullable
  int get maxmem;
  @nullable
  int get maxdisk;
  @nullable
  int get maxcpu;
  @nullable
  int get disk;

  PveQemuStatusModel._();
  factory PveQemuStatusModel(
          [void Function(PveQemuStatusModelBuilder) updates]) =
      _$PveQemuStatusModel;
}

class PveQemuStatusType extends EnumClass {
  static const PveQemuStatusType stopped = _$stopped;
  static const PveQemuStatusType running = _$running;

  const PveQemuStatusType._(String name) : super(name);

  static BuiltSet<PveQemuStatusType> get values => _$pqsTValues;
  static PveQemuStatusType valueOf(String name) => _$pqsTValueOf(name);

  static Serializer<PveQemuStatusType> get serializer =>
      _$pveQemuStatusTypeSerializer;
}
