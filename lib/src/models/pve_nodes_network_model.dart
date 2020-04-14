import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_nodes_network_model.g.dart';

abstract class PveNodeNetworkModel
    implements Built<PveNodeNetworkModel, PveNodeNetworkModelBuilder> {
  static Serializer<PveNodeNetworkModel> get serializer =>
      _$pveNodeNetworkModelSerializer;

  PveNodeNetworkModel._();
  factory PveNodeNetworkModel(
          [void Function(PveNodeNetworkModelBuilder) updates]) =
      _$PveNodeNetworkModel;

  bool get active;
  @nullable
  String get address;
  @nullable
  bool get autostart;
  @BuiltValueField(wireName: 'bridge_fd')
  @nullable
  String get bridgeForwardDelay;
  @BuiltValueField(wireName: 'bridge_ports')
  @nullable
  String get bridgePorts;
  @BuiltValueField(wireName: 'bridge_stp')
  @nullable
  String get bridgeStp;
  @nullable
  String get cidr;
  @nullable
  String get gateway;
  @nullable
  String get iface;
  @nullable
  String get method;
  @nullable
  String get method6;
  @nullable
  String get netmask;
  @nullable
  int get priority;
  @nullable
  InterfaceType get type;
  @nullable
  String get comment;
}

@BuiltValueEnum(wireName: 'type')
class InterfaceType extends EnumClass {
  static Serializer<InterfaceType> get serializer => _$interfaceTypeSerializer;

  static const InterfaceType bridge = _$bridge;
  static const InterfaceType bond = _$bond;
  static const InterfaceType eth = _$eth;
  static const InterfaceType alias = _$alias;
  static const InterfaceType vlan = _$vlan;
  @BuiltValueEnumConst(wireName: 'OVSBridge')
  static const InterfaceType ovsBridge = _$ovsBridge;
  @BuiltValueEnumConst(wireName: 'OVSBond')
  static const InterfaceType ovsBond = _$ovsBond;
  @BuiltValueEnumConst(wireName: 'OVSPort')
  static const InterfaceType ovsPort = _$ovsPort;
  @BuiltValueEnumConst(wireName: 'OVSIntPort')
  static const InterfaceType ovsIntPort = _$ovsIntPort;

  const InterfaceType._(String name) : super(name);

  static BuiltSet<InterfaceType> get values => _$interfaceTypeValues;
  static InterfaceType valueOf(String name) => _$interfaceTypeValueOf(name);
}
