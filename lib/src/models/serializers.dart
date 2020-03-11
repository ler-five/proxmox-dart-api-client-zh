import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:proxmox_dart_api_client/src/models/pve_bool_serializer.dart';
import 'package:proxmox_dart_api_client/src/models/pve_datetime_from_epoch_serializer.dart';


part 'serializers.g.dart';

@SerializersFor([
  PveClusterResourcesModel,
  PveClusterTasksModel,
  PveNodesModel,
  PveNodesStorageModel,
  PveNodesStorageContentModel,
  PveNodeNetworkModel,
  PveGuestRRDdataModel,
  PveClusterStatusModel,
  PveQemuStatusModel,
  PveHAMangerServiceStatusModel,
  PveNodesQemuConfigModel
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())..add(PveBoolSerializer())..add(PveDateTimeFromEpoch())).build();

