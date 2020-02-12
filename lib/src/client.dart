import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proxmox_dart_api_client/src/models/pve_cluster_resources_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_cluster_status_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_cluster_tasks_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_storage_content_model.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_storage_model.dart';
import 'package:proxmox_dart_api_client/src/models/serializers.dart';
import 'package:proxmox_dart_api_client/src/utils.dart'
    if (dart.library.html) 'utils_web.dart'
    if (dart.library.io) 'utils_native.dart';
import 'package:proxmox_dart_api_client/src/credentials.dart';
import 'package:proxmox_dart_api_client/src/expiration_exception.dart';
import 'package:proxmox_dart_api_client/src/extentions.dart';
import 'package:proxmox_dart_api_client/src/models/pve_nodes_network_model.dart';

import 'package:proxmox_dart_api_client/src/models/pve_nodes_model.dart';

class ProxmoxApiClient extends http.BaseClient {
  http.Client _httpClient;

  Credentials get credentials => _credentials;
  Credentials _credentials;

  ProxmoxApiClient(this._credentials, {http.Client httpClient})
      : _httpClient = httpClient ?? getCustomIOHttpClient();

  Future<http.Response> getRequest(String path, [Map<String,String> queryParameters]) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());
    queryParameters?.removeWhere((key, value) => value == null);

    var url = baseUrl.replace(path: path, queryParameters: queryParameters);

    return this.get(url);
  }

  Future<http.Response> postRequest(String path, [Map<String,String> parameters]) async {
    if (!path.startsWith("/api2/json")) {
      path = "/api2/json" + path;
    }
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());
    parameters?.removeWhere((key, value) => value == null);
    var url = baseUrl.replace(path: path);

    return this.post(url, body: parameters);
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

  /// Closes this client and its underlying HTTP client.
  @override
  void close() {
    if (_httpClient != null) _httpClient.close();
    _httpClient = null;
  }

  Future<http.Response> _getWithValidation(
      String path, Map<String, String> queryParameters,
      {bool extensiveResponseValidation = false}) async {
    final baseUrl = Uri.parse(await getPlatformAwareOrigin());

    queryParameters?.removeWhere((key, value) => value == null);

    var url = baseUrl.replace(path: path, queryParameters: queryParameters);

    return (await this.get(url)).validate(extensiveResponseValidation);
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
      f['starttime'] = f['starttime'] * 1000 * 1000;
      if (f['endtime'] != null) {
        f['endtime'] = f['endtime'] * 1000 * 1000;
      }
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

  Future<List<PveNodeNetworkModel>> getNodeNetwork(String targetNode,
      {InterfaceType type, bool extensiveResponseValidation}) async {
    final path = '/api2/json/nodes/$targetNode/network';
    var queryParameters = {'type': type?.name};
    final response = await _getWithValidation(path, queryParameters);
    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(PveNodeNetworkModel.serializer, f);
    });

    return data.toList();
  }

  Future<List<PveNodesStorageModel>> getNodeStorage(String targetNode,
      {PveStorageContentType content,
      bool enabled = false,
      bool format = false,
      String storageId,
      String target}) async {
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
      String targetNode, String storageId,
      {PveStorageContentType content, int vmid}) async {
    final path = '/api2/json/nodes/$targetNode/storage/$storageId/content';
    var queryParameters = {'content': content?.name, 'vmid': vmid?.toString()};
    final response = await _getWithValidation(path, queryParameters);

    var data = (json.decode(response.body)['data'] as List).map((f) {
      return serializers.deserializeWith(
          PveNodesStorageContentModel.serializer, f);
    });

    return data.toList();
  }
}
