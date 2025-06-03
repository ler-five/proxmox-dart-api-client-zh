import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_access_domain_model.g.dart';

abstract class PveAccessDomainModel
    implements Built<PveAccessDomainModel, PveAccessDomainModelBuilder> {
  // Fields
  String get realm;
  String? get comment;
  String? get tfa;
  @BuiltValueField(wireName: 'default')
  int? get defaultValue;

  bool get isDefaultRealm => defaultValue == 1;

  PveAccessDomainModel._();

  factory PveAccessDomainModel(
          [void Function(PveAccessDomainModelBuilder)? updates]) =
      _$PveAccessDomainModel;

  static Serializer<PveAccessDomainModel> get serializer =>
      _$pveAccessDomainModelSerializer;
}
