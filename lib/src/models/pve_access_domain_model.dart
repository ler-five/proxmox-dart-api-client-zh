import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_access_domain_model.g.dart';

abstract class PveAccessDomainModel
    implements Built<PveAccessDomainModel, PveAccessDomainModelBuilder> {
  // Fields
  String get realm;
  @nullable
  String get comment;
  @nullable
  String get tfa;
  PveAccessDomainModel._();

  factory PveAccessDomainModel(
          [void Function(PveAccessDomainModelBuilder) updates]) =
      _$PveAccessDomainModel;

  static Serializer<PveAccessDomainModel> get serializer =>
      _$pveAccessDomainModelSerializer;
}
