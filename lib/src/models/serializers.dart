import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:proxmox_dart_api_client/src/models/pve_bool_serializer.dart';
import 'package:proxmox_dart_api_client/src/models/pve_cluster_resources_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_cluster_status_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_cluster_tasks_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_network_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_storage_content_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_storage_model.dart';


part 'serializers.g.dart';

@SerializersFor([
  PveClusterResourcesModel,
  PveClusterTasksModel,
  PveNodesModel,
  PveNodesStorageModel,
  PveNodesStorageContentModel,
  PveNodeNetworkModel,
  PveClusterStatusModel
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())..add(PveBoolSerializer())).build();

