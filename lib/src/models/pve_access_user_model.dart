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
  @nullable
  String get userid;
  @nullable
  String get comment;
  @nullable
  String get email;
  @nullable
  bool get enable;
  @nullable
  int get expire;
  @nullable
  String get firstname;
  @nullable
  String get lastname;
  @nullable
  String get groups;
  @nullable
  String get keys;
  @nullable
  BuiltList<PveAccessUserTokenModel> get tokens;

  PveAccessUserModel._();

  factory PveAccessUserModel(
          [void Function(PveAccessUserModelBuilder) updates]) =
      _$PveAccessUserModel;
}
