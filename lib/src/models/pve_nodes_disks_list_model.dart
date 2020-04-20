import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_nodes_disks_list_model.g.dart';

abstract class PveNodesDisksListModel
    implements Built<PveNodesDisksListModel, PveNodesDisksListModelBuilder> {
  // Fields
  @BuiltValueField(wireName: 'devpath')
  String get devPath;
  bool get gpt;
  int get size;

  @nullable
  String get health;
  @nullable
  String get type;
  @nullable
  String get model;
  @nullable
  String get serial;
  @nullable
  String get used;
  @nullable
  String get vendor;
  @nullable
  String get wwn;
  @nullable
  JsonObject get wearout;

  PveNodesDisksListModel._();

  factory PveNodesDisksListModel(
          [void Function(PveNodesDisksListModelBuilder) updates]) =
      _$PveNodesDisksListModel;

  static Serializer<PveNodesDisksListModel> get serializer =>
      _$pveNodesDisksListModelSerializer;
}

class PveNodesDiskListType extends EnumClass {
  static const PveNodesDiskListType unused = _$unused;
  @BuiltValueEnum(wireName: 'journal_disks')
  static const PveNodesDiskListType journalDisks = _$journalDisks;

  const PveNodesDiskListType._(String name) : super(name);

  static BuiltSet<PveNodesDiskListType> get values => _$values;
  static PveNodesDiskListType valueOf(String name) => _$valueOf(name);
  static Serializer<PveNodesDiskListType> get serializer =>
      _$pveNodesDiskListTypeSerializer;
}
