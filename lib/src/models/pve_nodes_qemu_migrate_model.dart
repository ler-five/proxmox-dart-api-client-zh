import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'pve_nodes_qemu_migrate_model.g.dart';

abstract class PveNodesQemuMigrate
    implements Built<PveNodesQemuMigrate, PveNodesQemuMigrateBuilder> {
  // Fields
  @BuiltValueField(wireName: 'local_disks')
  BuiltSet<JsonObject> get localDisks;
  @BuiltValueField(wireName: 'local_resources')
  BuiltSet<JsonObject> get localResources;
  bool get running;
  @nullable
  @BuiltValueField(wireName: 'allowed_nodes')
  BuiltSet<String> get allowedNodes;
  @nullable
  @BuiltValueField(wireName: 'not_allowed_nodes')
  BuiltMap<String,JsonObject> get notAllowedNodes;

  PveNodesQemuMigrate._();

  factory PveNodesQemuMigrate(
          [void Function(PveNodesQemuMigrateBuilder) updates]) =
      _$PveNodesQemuMigrate;

  static Serializer<PveNodesQemuMigrate> get serializer =>
      _$pveNodesQemuMigrateSerializer;
}
