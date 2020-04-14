import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_node_status_model.g.dart';

abstract class PveNodeStatusModel
    implements Built<PveNodeStatusModel, PveNodeStatusModelBuilder> {
  // Fields
  PveNodeKSM get ksm;
  PveNodeRootFs get rootfs;
  bool get idle;
  BuiltList<String> get loadavg;
  PveNodeMemory get memory;
  String get pveversion;
  int get uptime;
  PveNodeCpuInfo get cpuinfo;
  PveNodeSwap get swap;
  double get cpu;
  String get kversion;
  double get wait;

  PveNodeStatusModel._();

  factory PveNodeStatusModel(
          [void Function(PveNodeStatusModelBuilder) updates]) =
      _$PveNodeStatusModel;

  static Serializer<PveNodeStatusModel> get serializer =>
      _$pveNodeStatusModelSerializer;
}

abstract class PveNodeKSM implements Built<PveNodeKSM, PveNodeKSMBuilder> {
  // Fields
  bool get shared;

  PveNodeKSM._();

  factory PveNodeKSM([void Function(PveNodeKSMBuilder) updates]) = _$PveNodeKSM;

  static Serializer<PveNodeKSM> get serializer => _$pveNodeKSMSerializer;
}

abstract class PveNodeRootFs
    implements Built<PveNodeRootFs, PveNodeRootFsBuilder> {
  // Fields
  int get avail;
  int get total;
  int get free;
  int get used;

  PveNodeRootFs._();

  factory PveNodeRootFs([void Function(PveNodeRootFsBuilder) updates]) =
      _$PveNodeRootFs;

  static Serializer<PveNodeRootFs> get serializer => _$pveNodeRootFsSerializer;
}

abstract class PveNodeMemory
    implements Built<PveNodeMemory, PveNodeMemoryBuilder> {
  // Fields
  double get total;
  double get free;
  double get used;

  PveNodeMemory._();

  factory PveNodeMemory([void Function(PveNodeMemoryBuilder) updates]) =
      _$PveNodeMemory;

  static Serializer<PveNodeMemory> get serializer => _$pveNodeMemorySerializer;
}

abstract class PveNodeCpuInfo
    implements Built<PveNodeCpuInfo, PveNodeCpuInfoBuilder> {
  // Fields
  @BuiltValueField(wireName: 'user_hz')
  int get userHz;
  int get sockets;
  int get cpus;
  String get hvm;
  String get mhz;
  String get model;
  String get flags;

  PveNodeCpuInfo._();

  factory PveNodeCpuInfo([void Function(PveNodeCpuInfoBuilder) updates]) =
      _$PveNodeCpuInfo;

  static Serializer<PveNodeCpuInfo> get serializer =>
      _$pveNodeCpuInfoSerializer;
}

abstract class PveNodeSwap implements Built<PveNodeSwap, PveNodeSwapBuilder> {
  // Fields
  double get used;
  double get free;
  double get total;

  PveNodeSwap._();

  factory PveNodeSwap([void Function(PveNodeSwapBuilder) updates]) =
      _$PveNodeSwap;

  static Serializer<PveNodeSwap> get serializer => _$pveNodeSwapSerializer;
}
