import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'pve_cluster_status_model.g.dart';

abstract class PveClusterStatusModel
    implements Built<PveClusterStatusModel, PveClusterStatusModelBuilder> {
  PveClusterStatusModel._();
  factory PveClusterStatusModel(
          [void Function(PveClusterStatusModelBuilder)? updates]) =
      _$PveClusterStatusModel;
  static Serializer<PveClusterStatusModel> get serializer =>
      _$pveClusterStatusModelSerializer;

  String get id;
  String get name;
  String get type;
  String? get ip;
  String? get level;
  bool? get local;
  int? get nodeid;
  int? get nodes;
  bool? get online;
  bool? get quorate;
  int? get version;
}
