import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_access_group_model.g.dart';

abstract class PveAccessGroupModel
    implements Built<PveAccessGroupModel, PveAccessGroupModelBuilder> {
  // Fields
  String get groupid;
  String get comment;
  String get users;

  PveAccessGroupModel._();

  factory PveAccessGroupModel(
          [void Function(PveAccessGroupModelBuilder) updates]) =
      _$PveAccessGroupModel;

  static Serializer<PveAccessGroupModel> get serializer =>
      _$pveAccessGroupModelSerializer;
}
