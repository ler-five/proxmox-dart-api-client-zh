import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_nodes_apt_update_model.g.dart';

abstract class PveNodesAptUpdateModel
    implements Built<PveNodesAptUpdateModel, PveNodesAptUpdateModelBuilder> {
  // Fields
  @BuiltValueField(wireName: 'Title')
  String? get title;
  @BuiltValueField(wireName: 'Version')
  String? get version;
  @BuiltValueField(wireName: 'Section')
  String? get section;
  @BuiltValueField(wireName: 'Arch')
  String? get arch;
  @BuiltValueField(wireName: 'Priority')
  String? get priority;
  @BuiltValueField(wireName: 'OldVersion')
  String? get oldVersion;
  @BuiltValueField(wireName: 'Description')
  String? get description;
  @BuiltValueField(wireName: 'ChangeLogUrl')
  String? get changeLogUrl;
  @BuiltValueField(wireName: 'Origin')
  String? get origin;
  @BuiltValueField(wireName: 'Package')
  String? get package;

  PveNodesAptUpdateModel._();

  factory PveNodesAptUpdateModel(
          [void Function(PveNodesAptUpdateModelBuilder)? updates]) =
      _$PveNodesAptUpdateModel;

  static Serializer<PveNodesAptUpdateModel> get serializer =>
      _$pveNodesAptUpdateModelSerializer;
}
