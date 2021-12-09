import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:proxmox_dart_api_client/src/models/pve_access_user_token_model.dart';

part 'pve_access_user_model.g.dart';

abstract class PveAccessUserModel
    implements Built<PveAccessUserModel, PveAccessUserModelBuilder> {
  static Serializer<PveAccessUserModel> get serializer =>
      _$pveAccessUserModelSerializer;

  // Fields
  String? get userid;
  String? get comment;
  String? get email;
  bool? get enable;
  int? get expire;
  String? get firstname;
  String? get lastname;
  String? get groups;
  String? get keys;
  BuiltList<PveAccessUserTokenModel>? get tokens;

  PveAccessUserModel._();

  factory PveAccessUserModel(
          [void Function(PveAccessUserModelBuilder) updates]) =
      _$PveAccessUserModel;
}
