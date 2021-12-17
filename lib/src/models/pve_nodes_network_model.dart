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
          [void Function(PveNodeNetworkModelBuilder)? updates]) =
      _$PveNodeNetworkModel;

  bool? get active;
  String? get address;
  bool? get autostart;
  @BuiltValueField(wireName: 'bridge_fd')
  String? get bridgeForwardDelay;
  @BuiltValueField(wireName: 'bridge_ports')
  String? get bridgePorts;
  @BuiltValueField(wireName: 'bridge_stp')
  String? get bridgeStp;
  String? get cidr;
  String? get gateway;
  String? get iface;
  String? get method;
  String? get method6;
  String? get netmask;
  int? get priority;
  InterfaceType get type;
  String? get comment;
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
