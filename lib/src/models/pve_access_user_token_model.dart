import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_access_user_token_model.g.dart';

abstract class PveAccessUserTokenModel
    implements Built<PveAccessUserTokenModel, PveAccessUserTokenModelBuilder> {
  String? get userid;
  DateTime? get expire;

  bool? get privsep;

  String? get tokenid;

  PveAccessUserTokenModel._();
  factory PveAccessUserTokenModel(
          [void Function(PveAccessUserTokenModelBuilder)? updates]) =
      _$PveAccessUserTokenModel;

  static Serializer<PveAccessUserTokenModel> get serializer =>
      _$pveAccessUserTokenModelSerializer;
}
