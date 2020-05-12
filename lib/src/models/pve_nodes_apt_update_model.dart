import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_nodes_apt_update_model.g.dart';

abstract class PveNodesAptUpdateModel
    implements Built<PveNodesAptUpdateModel, PveNodesAptUpdateModelBuilder> {
  // Fields
  @nullable
  @BuiltValueField(wireName: 'Title')
  String get title;
  @nullable
  @BuiltValueField(wireName: 'Version')
  String get version;
  @nullable
  @BuiltValueField(wireName: 'Section')
  String get section;
  @nullable
  @BuiltValueField(wireName: 'Arch')
  String get arch;
  @nullable
  @BuiltValueField(wireName: 'Priority')
  String get priority;
  @nullable
  @BuiltValueField(wireName: 'OldVersion')
  String get oldVersion;
  @nullable
  @BuiltValueField(wireName: 'Description')
  String get description;
  @nullable
  @BuiltValueField(wireName: 'ChangeLogUrl')
  String get changeLogUrl;
  @nullable
  @BuiltValueField(wireName: 'Origin')
  String get origin;
  @nullable
  @BuiltValueField(wireName: 'Package')
  String get package;

  PveNodesAptUpdateModel._();

  factory PveNodesAptUpdateModel(
          [void Function(PveNodesAptUpdateModelBuilder) updates]) =
      _$PveNodesAptUpdateModel;

  static Serializer<PveNodesAptUpdateModel> get serializer =>
      _$pveNodesAptUpdateModelSerializer;
}
