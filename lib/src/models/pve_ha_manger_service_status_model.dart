import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_ha_manger_service_status_model.g.dart';

abstract class PveHAMangerServiceStatusModel
    implements
        Built<PveHAMangerServiceStatusModel,
            PveHAMangerServiceStatusModelBuilder> {
  bool get managed;
  @nullable
  String get group;
  @nullable
  String get state;

  PveHAMangerServiceStatusModel._();
  factory PveHAMangerServiceStatusModel(
          [void Function(PveHAMangerServiceStatusModelBuilder) updates]) =
      _$PveHAMangerServiceStatusModel;
  static Serializer<PveHAMangerServiceStatusModel> get serializer =>
      _$pveHAMangerServiceStatusModelSerializer;
}
