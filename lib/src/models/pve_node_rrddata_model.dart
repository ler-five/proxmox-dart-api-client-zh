import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_node_rrddata_model.g.dart';

// iowait: 0.000563001655121094
// netin: 560247.886666667
// netout: 8843.365
// memused: 16582805913.6
// swaptotal: 998240256
// roottotal: 258363686912
// swapused: 63700992
// rootused: 80830384264.5334
// maxcpu: 16
// time: 1586443140
// loadavg: 3.62416666666667
// cpu: 0.355373131264274
// memtotal: 33668456448

abstract class PveNodeRRDDataModel
    implements Built<PveNodeRRDDataModel, PveNodeRRDDataModelBuilder> {
  // Fields
  DateTime get time;
  @nullable
  double get iowait;
  @nullable
  double get netin;
  @nullable
  double get netout;
  @nullable
  double get memused;
  @nullable
  double get memtotal;
  @nullable
  double get swapused;
  @nullable
  double get swaptotal;
  @nullable
  double get roottotal;
  @nullable
  double get rootused;
  @nullable
  double get cpu;
  @nullable
  double get maxcpu;
  @nullable
  double get loadavg;

  PveNodeRRDDataModel._();

  factory PveNodeRRDDataModel(
          [void Function(PveNodeRRDDataModelBuilder) updates]) =
      _$PveNodeRRDDataModel;

  static Serializer<PveNodeRRDDataModel> get serializer =>
      _$pveNodeRRDDataModelSerializer;
}
