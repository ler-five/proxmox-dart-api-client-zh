import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/models/pve_access_user_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_models.dart';
import 'package:proxmox_dart_api_client/src/models/serializers.dart';
import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';
import 'package:proxmox_dart_api_client/src/credentials.dart';
import 'package:proxmox_dart_api_client/src/expiration_exception.dart';
import 'package:proxmox_dart_api_client/src/extentions.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_network_model.dart';

import 'package:proxmox_dart_api_client/src/models/pve_nodes_model.dart';
import 'package:retry/retry.dart';

class ProxmoxApiClient extends http.BaseClient {
  http.Client _httpClient;

  Credentials get credentials => _credentials;
  Credentials _credentials;

  ProxmoxApiClient(this._credentials, {http.Client httpClient})
      : _httpClient = httpClient ?? getCustomIOHttpClient();

  Future<http.Response> getRequest(
    String path, [
    Map<String, String> queryParameters,
  ]) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());
    queryParameters
        ?.removeWhere((key, value) => value == null || value.isEmpty);

    var url = baseUrl.replace(path: path, queryParameters: queryParameters);

    return this.get(url);
  }

  Future<http.Response> postRequest(
    String path, [
    Map<String, String> parameters,
  ]) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());
    parameters?.removeWhere((key, value) => value == null || value.isEmpty);
    var url = baseUrl.replace(path: path);

    return this.post(url, body: parameters);
  }

  Future<http.Response> putRequest(
    String path, [
    Map<String, String> parameters,
  ]) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());
    parameters?.removeWhere((key, value) => value == null || value.isEmpty);
    var url = baseUrl.replace(path: path);

    return put(url, body: parameters);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (credentials.isExpired) {
      if (!credentials.canRefresh) throw ExpirationException(credentials);
      await refreshCredentials();
    }
    request.headers['Authorization'] = 'PVEAuthCookie ${credentials.ticket}';

    request.headers['CSRFPreventionToken'] = credentials.csrfToken;
    var response = await _httpClient.send(request);

    return response;
  }

  Future<ProxmoxApiClient> refreshCredentials() async {
    if (!credentials.canRefresh) {
      throw StateError("Credentials can't be refreshed.");
    }

    _credentials = await credentials.refresh(httpClient: _httpClient);

    return this;
  }

  Future<ProxmoxApiClient> finishTfaChallenge(String code) async {
    if (!credentials.tfa) {
      throw StateError("No tfa challange expected");
    }

    _credentials = await credentials.tfaChallenge(code, httpClient: this);

    return this;
  }

  /// Closes this client and its underlying HTTP client.
  @override
  void close() {
    if (_httpClient != null) _httpClient.close();
    _httpClient = null;
  }

  Future<http.Response> _getWithValidation(
      String path, Map<String, dynamic> queryParameters,
      {bool extensiveResponseValidation = false}) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());

    queryParameters
        ?.removeWhere((key, value) => value == null || value.isEmpty);

    var url = baseUrl.replace(path: path, queryParameters: queryParameters);

    return (await retry(
      () => get(url),
      retryIf: (e) => e is http.ClientException,
    ))
        .validate(extensiveResponseValidation);
  }

  Future<http.Response> _postWithValidation(
      String path, Map<String, dynamic> queryParameters,
      {bool extensiveResponseValidation = false}) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());

    queryParameters
        ?.removeWhere((key, value) => value == null || value.isEmpty);

    var url = baseUrl.replace(path: path, queryParameters: queryParameters);

    return (await post(url)).validate(extensiveResponseValidation);
  }

  Future<http.Response> _deleteWithValidation(
      String path, Map<String, dynamic> queryParameters,
      {bool extensiveResponseValidation = false}) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());

    queryParameters?.removeWhere((key, value) => value == null);

    var url = baseUrl.replace(path: path, queryParameters: queryParameters);

    return (await delete(url)).validate(extensiveResponseValidation);
  }

  Future<String> getNextFreeID({String id}) async {
    final path = '/api2/json/cluster/nextid';
    var queryParameters = {'vmid': id};
    final response = await _getWithValidation(path, queryParameters,
        extensiveResponseValidation: true);

    var jsonBody = json.decode(response.body);
    return jsonBody['data'];
  }

  Future<List<PveClusterResourcesModel>> getResources(
      {PveClusterResourceType type}) async {
    var path = '/api2/json/cluster/resources';
    var queryParameters = {'type': type?.name};

    final response = await _getWithValidation(path, queryParameters);

    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(
          PveClusterResourcesModel.serializer, f);
    });

    return data.toList();
  }

  Future<List<PveClusterStatusModel>> getClusterStatus() async {
    final path = '/api2/json/cluster/status';
    final response = await _getWithValidation(path, null);

    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveClusterStatusModel.serializer, f);
    });

    return data.toList();
  }

  Future<List<PveClusterTasksModel>> getClusterTasks() async {
    var path = '/api2/json/cluster/tasks';
    final response = await _getWithValidation(path, null);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveClusterTasksModel.serializer, f);
    }).toList();
    return data;
  }

  Future<List<PveNodesModel>> getNodes() async {
    final path = '/api2/json/nodes';
    final response = await _getWithValidation(path, null);

    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodesModel.serializer, f);
    });

    return data.toList();
  }

  Future<List<PveNodeNetworkModel>> getNodeNetwork(
    String targetNode, {
    InterfaceType type,
    bool extensiveResponseValidation,
  }) async {
    final path = '/api2/json/nodes/$targetNode/network';
    var queryParameters = {'type': type?.name};
    final response = await _getWithValidation(path, queryParameters);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodeNetworkModel.serializer, f);
    });

    return data.toList();
  }

  Future<List<PveNodesStorageModel>> getNodeStorage(
    String targetNode, {
    PveStorageContentType content,
    bool enabled = false,
    bool format = false,
    String storageId,
    String target,
  }) async {
    var path = '/api2/json/nodes/$targetNode/storage';
    var queryParameters = {
      'content': content?.name,
      'enabled': enabled ? '1' : '0',
      'format': format ? '1' : '0',
      'storage': storageId,
      'target': target,
    };

    final response = await _getWithValidation(path, queryParameters);

    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodesStorageModel.serializer, f);
    });

    return data.toList();
  }

  Future<List<PveNodesStorageContentModel>> getNodeStorageContent(
    String targetNode,
    String storageId, {
    PveStorageContentType content,
    int vmid,
  }) async {
    final path = '/api2/json/nodes/$targetNode/storage/$storageId/content';
    var queryParameters = {'content': content?.name, 'vmid': vmid?.toString()};
    final response = await _getWithValidation(path, queryParameters);

    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(
          PveNodesStorageContentModel.serializer, f);
    });

    return data.toList();
  }

  Future<void> deleteNodeStorageContent(
    String targetNode,
    String storageId,
    String volume, {
    int delay,
  }) async {
    final path =
        '/api2/json/nodes/$targetNode/storage/$storageId/content/$volume';
    var queryParameters = {'delay': delay?.toString()};
    await _deleteWithValidation(path, queryParameters);
  }

  Future<List<PveGuestRRDdataModel>> getNodeQemuRRDdata(
    String targetNode,
    String guestId,
    PveRRDTimeframeType timeframe,
  ) async {
    final path = '/api2/json/nodes/$targetNode/qemu/$guestId/rrddata';
    var queryParameters = {
      'timeframe': timeframe.name,
    };
    final response = await _getWithValidation(path, queryParameters);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveGuestRRDdataModel.serializer, f);
    });
    return data.toList();
  }

  Future<PveQemuStatusModel> getQemuStatusCurrent(
    String targetNode,
    String guestId,
  ) async {
    final path = '/api2/json/nodes/$targetNode/qemu/$guestId/status/current';
    final response = await _getWithValidation(path, null);
    var data = json.decode(response.body)['data'];
    return serializers.deserializeWith(PveQemuStatusModel.serializer, data);
  }

  Future<Map<String, dynamic>> getQemuPendingConfig(
    String targetNode,
    String guestId,
  ) async {
    var response = await _getWithValidation(
        '/nodes/$targetNode/qemu/$guestId/pending', null);
    final jsonList = (jsonDecode(response.body)['data'] as List);
    final pConfigMap = {
      for (var e in jsonList) '${e['key']}': e,
    };
    return pConfigMap;
  }

  Future<PveNodesQemuConfigModel> getQemuConfig(
    String targetNode,
    String guestId, {
    bool current,
    String snapshot,
  }) async {
    final path = '/api2/json/nodes/$targetNode/qemu/$guestId/config';
    var queryParameters = {
      'current': current ? '1' : '0',
      'snapshot': snapshot
    };
    final response = await _getWithValidation(path, queryParameters);
    var data = json.decode(response.body)['data'];
    var model =
        serializers.deserializeWith(PveNodesQemuConfigModel.serializer, data);
    final pending = await getQemuPendingConfig(targetNode, guestId);
    model = model.rebuild((b) => b..pending = pending);
    return model.postProcessEnumeratedJsonFields(data);
  }

  Future<void> doResourceAction(
    String targetNode,
    String guestId,
    String type,
    PveClusterResourceAction action, {
    Map<String, String> parameters,
  }) async {
    String url;

    switch (type) {
      case 'qemu':
        url =
            '/api2/json/nodes/$targetNode/$type/$guestId/status/${action.name}';
        break;
      case 'lxc':
        url =
            '/api2/json/nodes/$targetNode/$type/$guestId/status/${action.name}';
        break;
      case 'node':
        url = '/api2/json/nodes/$targetNode/status/?command=${action.name}';
        break;
      default:
        throw ArgumentError.value(
            type, 'name', 'Only qemu, lxc and node are valid types');
    }

    await _postWithValidation(url, parameters);
  }

  Future<NodeTasksResponse> getNodeTasks(
    String targetNode, {
    String guestId,
    bool errors = false,
    String limit,
    String start,
    String source,
    String typefilter,
    String userfilter,
  }) async {
    final path = '/api2/json/nodes/$targetNode/tasks';
    var queryParameters = {
      'vmid': guestId,
      'errors': errors ? '1' : '0',
      'limit': limit,
      'start': start,
      'source': source,
      'typefilter': typefilter,
      'userfilter': userfilter
    };
    final response = await _getWithValidation(path, queryParameters);
    final decoded = json.decode(response.body);

    var data = (decoded['data'] as List).map((f) {
      return serializers.deserializeWith(PveClusterTasksModel.serializer, f);
    });
    return NodeTasksResponse(
        total: decoded['total'] ?? 0, tasks: data.toList());
  }

  Future<PveTaskLogResponse> getNodeTaskLog(
    String targetNode,
    String upid, {
    String limit,
    String start,
  }) async {
    final path = '/api2/json/nodes/$targetNode/tasks/$upid/log';
    var queryParameters = {
      'limit': limit,
      'start': start,
    };
    final response = await _getWithValidation(path, queryParameters);
    return PveTaskLogResponse.fromJson(response.body);
  }

  Future<PveTaskLogStatus> getNodeTaskStatus(
    String targetNode,
    String upid,
  ) async {
    final path = '/api2/json/nodes/$targetNode/tasks/$upid/status';
    final response = await _getWithValidation(path, null);
    return PveTaskLogStatus.fromJson(response.body);
  }

  Future<PveNodesQemuMigrate> getMigratePreconditions(
    String targetNode,
    String guestId, {
    String migrationTarget,
  }) async {
    final path = '/api2/json/nodes/$targetNode/qemu/$guestId/migrate';
    var queryParameters = {'target': migrationTarget};
    final response = await _getWithValidation(path, queryParameters);
    var data = json.decode(response.body)['data'];
    return serializers.deserializeWith(PveNodesQemuMigrate.serializer, data);
  }

  Future<String> qemuMigrate(
    String targetNode,
    String guestId,
    String migrationTarget, {
    String bandwidthLimit,
    bool force = false,
    String migrationNetwork,
    bool online = false,
    String targetStorage,
    bool withLocalDisks = false,
  }) async {
    final path = '/api2/json/nodes/$targetNode/qemu/$guestId/migrate';
    var queryParameters = {
      'target': migrationTarget,
      'bwlimit': bandwidthLimit,
      'force': force ? '1' : '0',
      'migration_network': migrationNetwork,
      'online': online ? '1' : '0',
      'targetstorage': targetStorage,
      'with-local-disks': withLocalDisks ? '1' : '0',
    };
    final response = await _postWithValidation(path, queryParameters,
        extensiveResponseValidation: true);
    return json.decode(response.body)['data'];
  }

  Future<Map<String, dynamic>> getLxcPendingConfig(
    String targetNode,
    String guestId,
  ) async {
    var response = await _getWithValidation(
        '/nodes/$targetNode/lxc/$guestId/pending', null);
    final jsonList = (jsonDecode(response.body)['data'] as List);
    final pConfigMap = {
      for (var e in jsonList) '${e['key']}': e,
    };
    return pConfigMap;
  }

  Future<PveNodesLxcConfigModel> getLxcConfig(
    String targetNode,
    String guestId, {
    bool current,
    String snapshot,
  }) async {
    final path = '/api2/json/nodes/$targetNode/lxc/$guestId/config';
    var queryParameters = {
      'current': current ? '1' : '0',
      'snapshot': snapshot
    };
    final response = await _getWithValidation(path, queryParameters);
    var data = json.decode(response.body)['data'];
    var model =
        serializers.deserializeWith(PveNodesLxcConfigModel.serializer, data);
    final pending = await getLxcPendingConfig(targetNode, guestId);
    model = model.rebuild((b) => b..pending = pending);
    return model.postProcessEnumeratedJsonFields(data);
  }

  Future<PveNodesLxcStatusModel> getLxcStatusCurrent(
    String targetNode,
    String guestId,
  ) async {
    final path = '/api2/json/nodes/$targetNode/lxc/$guestId/status/current';
    final response = await _getWithValidation(path, null);
    var data = json.decode(response.body)['data'];
    return serializers.deserializeWith(PveNodesLxcStatusModel.serializer, data);
  }

  Future<String> lxcMigrate(
    String targetNode,
    String guestId,
    String migrationTarget, {
    String bandwidthLimit,
    String migrationNetwork,
    bool online = false,
    bool restart = false,
    bool withLocalDisks = false,
    int timeout,
  }) async {
    final path = '/api2/json/nodes/$targetNode/lxc/$guestId/migrate';
    var queryParameters = {
      'target': migrationTarget,
      'bwlimit': bandwidthLimit,
      'migration_network': migrationNetwork,
      'online': online ? '1' : '0',
      'restart': restart ? '1' : '0',
      'timeout': timeout
    };
    final response = await _postWithValidation(path, queryParameters,
        extensiveResponseValidation: true);
    return json.decode(response.body)['data'];
  }

  Future<PveNodeStatusModel> getNodeStatus(String targetNode) async {
    final path = '/api2/json/nodes/$targetNode/status';
    final response = await _getWithValidation(path, null);
    var data = json.decode(response.body)['data'];
    return serializers.deserializeWith(PveNodeStatusModel.serializer, data);
  }

  Future<List<PveNodeRRDDataModel>> getNodeRRDdata(
    String targetNode,
    PveRRDTimeframeType timeframe,
  ) async {
    final path = '/api2/json/nodes/$targetNode/rrddata';
    var queryParameters = {
      'timeframe': timeframe.name,
    };
    final response = await _getWithValidation(path, queryParameters);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodeRRDDataModel.serializer, f);
    });
    return data.toList();
  }

  Future<List<PveNodeServicesModel>> getNodeServices(
    String targetNode,
  ) async {
    final path = '/api2/json/nodes/$targetNode/services';

    final response = await _getWithValidation(path, null);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodeServicesModel.serializer, f);
    });
    return data.toList();
  }

  Future<List<PveNodesAptUpdateModel>> getNodeAptUpdate(
    String targetNode,
  ) async {
    final path = '/api2/json/nodes/$targetNode/apt/update';

    final response = await _getWithValidation(path, null);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodesAptUpdateModel.serializer, f);
    });
    return data.toList();
  }

  Future<List<PveNodesDisksListModel>> getNodeDisksList(
    String targetNode, {
    bool skipsmart = false,
    PveNodesDiskListType type,
  }) async {
    final path = '/api2/json/nodes/$targetNode/disks/list';
    var queryParameters = {
      'skipsmart': skipsmart ? '1' : '0',
      'type': type != null ? serializers.serialize(type) : null
    };
    final response = await _getWithValidation(path, queryParameters);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodesDisksListModel.serializer, f);
    });
    return data.toList();
  }

  Future<String> getNodesVZDumpExtractConfig(
      String targetNode, String volume) async {
    final path = '/api2/json/nodes/$targetNode/vzdump/extractconfig';
    var queryParameters = {'volume': volume};
    final response = await _getWithValidation(path, queryParameters);
    final data = json.decode(response.body)['data'];
    return data;
  }

  Future<String> nodesVZDumpCreateBackup(
    String targetNode,
    String storage,
    String guestId, {
    bool remove = false,
    PveVZDumpCompressionType compressionType,
    PveVZDumpModeType mode,
  }) async {
    final path = '/api2/json/nodes/$targetNode/vzdump';
    var queryParameters = {
      'storage': storage,
      'vmid': guestId,
      'remove': remove ? '1' : '0',
      'compress': compressionType != PveVZDumpCompressionType.none
          ? compressionType.name
          : null,
      'mode': mode.name
    };
    final response = await _postWithValidation(path, queryParameters);
    final data = json.decode(response.body)['data'];
    return data;
  }

  Future<List<PveAccessUserModel>> getAccessUsersList({
    bool full = false,
  }) async {
    final path = '/api2/json/access/users';
    var queryParameters = {
      'full': full ? '1' : '0',
    };
    final response = await _getWithValidation(path, queryParameters);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveAccessUserModel.serializer, f);
    });
    return data.toList();
  }

  Future<List<PveAccessGroupModel>> getAccessGroupsList() async {
    final path = '/api2/json/access/groups';
    final response = await _getWithValidation(path, null);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveAccessGroupModel.serializer, f);
    });
    return data.toList();
  }

  Future<List<PveAccessRoleModel>> getAccessRolesList() async {
    final path = '/api2/json/access/roles';
    final response = await _getWithValidation(path, null);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveAccessRoleModel.serializer, f);
    });
    return data.toList();
  }

  Future<List<PveAccessDomainModel>> getAccessDomainsList() async {
    final path = '/api2/json/access/domains';
    final response = await _getWithValidation(path, null);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveAccessDomainModel.serializer, f);
    });
    return data.toList();
  }
}
