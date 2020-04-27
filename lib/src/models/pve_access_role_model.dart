import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_access_role_model.g.dart';

abstract class PveAccessRoleModel
    implements Built<PveAccessRoleModel, PveAccessRoleModelBuilder> {
  // Fields
  String get roleid;
  @nullable
  String get privs;
  @nullable
  bool get special;

  PveAccessRoleModel._();

  factory PveAccessRoleModel(
          [void Function(PveAccessRoleModelBuilder) updates]) =
      _$PveAccessRoleModel;

  static Serializer<PveAccessRoleModel> get serializer =>
      _$pveAccessRoleModelSerializer;
}
