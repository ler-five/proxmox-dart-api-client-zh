import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_nodes_storage_content_model.g.dart';

abstract class PveNodesStorageContentModel
    implements
        Built<PveNodesStorageContentModel, PveNodesStorageContentModelBuilder> {
  String get format;

  @nullable
  String get parent;

  int get size;

  @nullable
  int get used;

  @nullable
  int get vmid;

  String get volid;

  static Serializer<PveNodesStorageContentModel> get serializer =>
      _$pveNodesStorageContentModelSerializer;

  PveNodesStorageContentModel._();
  factory PveNodesStorageContentModel(
          [void Function(PveNodesStorageContentModelBuilder) updates]) =
      _$PveNodesStorageContentModel;
}

class PveStorageContentType extends EnumClass {
  static const PveStorageContentType rootdir = _$rootdir;
  static const PveStorageContentType images = _$images;
  static const PveStorageContentType vztmpl = _$vztmpl;
  static const PveStorageContentType iso = _$iso;
  static const PveStorageContentType backup = _$backup;
  static const PveStorageContentType snippets = _$snippets;

  const PveStorageContentType._(String name) : super(name);

  static BuiltSet<PveStorageContentType> get values => _$psctValues;
  static PveStorageContentType valueOf(String name) => _$psctValueOf(name);
}
