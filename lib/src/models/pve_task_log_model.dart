import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:proxmox_dart_api_client/src/models/serializers.dart';

part 'pve_task_log_model.g.dart';

abstract class PveTaskLogModel
    implements Built<PveTaskLogModel, PveTaskLogModelBuilder> {
  // Fields
  @BuiltValueField(wireName: 'n')
  int? get lineNumber;
  @BuiltValueField(wireName: 't')
  String? get lineText;

  PveTaskLogModel._();

  factory PveTaskLogModel([void Function(PveTaskLogModelBuilder)? updates]) =
      _$PveTaskLogModel;

  static PveTaskLogModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
        PveTaskLogModel.serializer, json.decode(jsonString));
  }

  static Serializer<PveTaskLogModel> get serializer =>
      _$pveTaskLogModelSerializer;
}

abstract class PveTaskLogResponse
    implements Built<PveTaskLogResponse, PveTaskLogResponseBuilder> {
  // Fields
  @BuiltValueField(wireName: 'data')
  BuiltList<PveTaskLogModel>? get lines;

  int? get total;

  PveTaskLogResponse._();

  factory PveTaskLogResponse(
          [void Function(PveTaskLogResponseBuilder)? updates]) =
      _$PveTaskLogResponse;

  static Serializer<PveTaskLogResponse> get serializer =>
      _$pveTaskLogResponseSerializer;
  static PveTaskLogResponse? fromJson(String jsonString) {
    return serializers.deserializeWith(
        PveTaskLogResponse.serializer, json.decode(jsonString));
  }
}

abstract class PveTaskLogStatus
    implements Built<PveTaskLogStatus, PveTaskLogStatusBuilder> {
  // Fields
  int get pid;
  PveTaskLogStatusType get status;
  String get upid;
  String get user;
  String get node;
  @BuiltValueField(wireName: 'starttime')
  DateTime get startTime;

  String get type;
  @BuiltValueField(wireName: 'exitstatus')
  String? get exitStatus;

  PveTaskLogStatus._();

  factory PveTaskLogStatus([void Function(PveTaskLogStatusBuilder)? updates]) =
      _$PveTaskLogStatus;

  static PveTaskLogStatus? fromJson(String jsonString) {
    return serializers.deserializeWith(
        PveTaskLogStatus.serializer, json.decode(jsonString)['data']);
  }

  static Serializer<PveTaskLogStatus> get serializer =>
      _$pveTaskLogStatusSerializer;

  bool get failed =>
      exitStatus != 'OK' && status == PveTaskLogStatusType.stopped;
}

class PveTaskLogStatusType extends EnumClass {
  static const PveTaskLogStatusType running = _$running;
  static const PveTaskLogStatusType stopped = _$stopped;

  const PveTaskLogStatusType._(super.name);

  static BuiltSet<PveTaskLogStatusType> get values => _$values;
  static PveTaskLogStatusType valueOf(String name) => _$valueOf(name);
  static Serializer<PveTaskLogStatusType> get serializer =>
      _$pveTaskLogStatusTypeSerializer;
}
