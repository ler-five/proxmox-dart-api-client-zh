import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_node_services_model.g.dart';

abstract class PveNodeServicesModel
    implements Built<PveNodeServicesModel, PveNodeServicesModelBuilder> {
  // Fields
  String get state;
  String get name;
  String get service;
  String get desc;
  PveNodeServicesModel._();

  factory PveNodeServicesModel(
          [void Function(PveNodeServicesModelBuilder) updates]) =
      _$PveNodeServicesModel;

  static Serializer<PveNodeServicesModel> get serializer =>
      _$pveNodeServicesModelSerializer;
}
