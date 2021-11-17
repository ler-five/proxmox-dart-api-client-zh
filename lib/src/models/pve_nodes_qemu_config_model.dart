import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:proxmox_dart_api_client/src/utils.dart';

part 'pve_nodes_qemu_config_model.g.dart';

abstract class PveNodesQemuConfigModel
    implements Built<PveNodesQemuConfigModel, PveNodesQemuConfigModelBuilder> {
  PveNodesQemuConfigModel._();
  static Serializer<PveNodesQemuConfigModel> get serializer =>
      _$pveNodesQemuConfigModelSerializer;
  factory PveNodesQemuConfigModel(
          [void Function(PveNodesQemuConfigModelBuilder)? updates]) =
      _$PveNodesQemuConfigModel;

  String? get digest;
  bool? get acpi;
  String? get agent;
  ProcessorArch? get arch;
  //bool get autostart;
  int? get balloon;
  Bios? get bios;
  String? get boot;
  String? get cdrom;
  int? get cores;
  String? get cpu;
  String? get description;
  bool? get freeze;
  BuiltList<String>? get hostpci;
  String? get hotplug;
  Hugepages? get hugepages;
  BuiltList<String>? get ide;
  bool? get kvm;
  bool? get localtime;
  LockType? get lock;
  String? get machine;
  int? get memory;
  String? get name;
  BuiltList<String>? get net;
  bool? get numa;
  bool? get onboot;
  OSType? get ostype;
  bool? get protection;
  bool? get reboot;
  BuiltList<String>? get sata;
  BuiltList<String>? get scsi;
  ScsiControllerModel? get scsihw;
  String? get serial0;
  int? get shares;
  String? get smbios1;
  int? get sockets;
  @BuiltValueField(wireName: 'spice_enhancements')
  String? get spiceEnhancements;
  String? get startdate;
  String? get startup;
  bool? get tablet;
  String? get tags;
  BuiltList<String>? get unused;
  BuiltList<String>? get usb;
  int? get vcpus;
  BuiltList<String>? get virtio;
  String? get vmgenid;
  String? get vmstatestorage;
  String? get watchdog;
  Map<String, dynamic>? get pending;

  dynamic getPending(String field) {
    if (pending == null || pending!.isEmpty) {
      throw StateError('No pending values available');
    }
    if (pending![field] != null && pending![field]['pending'] != null) {
      return pending![field]['pending'];
    }
    return null;
  }

  PveNodesQemuConfigModel postProcessEnumeratedJsonFields(dynamic object) {
    final map = object as Map<String, dynamic>;

    List<String?> hostpci = matchEnumJsonFields('hostpci', 16, map);
    List<String?> net = matchEnumJsonFields('net', 32, map);
    List<String?> usb = matchEnumJsonFields('usb', 5, map);

    List<String?> ide = matchEnumJsonFields('ide', 4, map);
    List<String?> sata = matchEnumJsonFields('sata', 6, map);
    List<String?> scsi = matchEnumJsonFields('scsi', 31, map);
    List<String?> unused = matchEnumJsonFields('unused', 256, map);
    List<String?> virtio = matchEnumJsonFields('virtio', 16, map);

    return rebuild((b) => b
      ..hostpci.replace(hostpci)
      ..ide.replace(ide)
      ..net.replace(net)
      ..sata.replace(sata)
      ..scsi.replace(scsi)
      ..unused.replace(unused)
      ..usb.replace(usb)
      ..virtio.replace(virtio));
  }
}

@BuiltValueEnum(wireName: 'arch')
class ProcessorArch extends EnumClass {
  static Serializer<ProcessorArch> get serializer => _$processorArchSerializer;

  static const ProcessorArch x86_64 = _$x86_64;
  static const ProcessorArch aarch64 = _$aarch64;

  const ProcessorArch._(String name) : super(name);

  static BuiltSet<ProcessorArch> get values => _$paValues;
  static ProcessorArch valueOf(String name) => _$paValueOf(name);
}

@BuiltValueEnum(wireName: 'bios')
class Bios extends EnumClass {
  static Serializer<Bios> get serializer => _$biosSerializer;

  static const Bios seabios = _$seabios;
  static const Bios ovmf = _$ovmf;

  const Bios._(String name) : super(name);

  static BuiltSet<Bios> get values => _$biValues;
  static Bios valueOf(String name) => _$biValueOf(name);
}

@BuiltValueEnum(wireName: 'ostype')
class OSType extends EnumClass {
  static Serializer<OSType> get serializer => _$oSTypeSerializer;

  static const OSType other = _$other;
  static const OSType wxp = _$wxp;
  static const OSType w2k = _$w2k;
  static const OSType w2k3 = _$w2k3;
  static const OSType w2k8 = _$w2k8;
  static const OSType wvista = _$wvista;
  static const OSType win7 = _$win7;
  static const OSType win8 = _$win8;
  static const OSType win10 = _$win10;
  static const OSType win11 = _$win11;
  static const OSType l24 = _$l24;
  static const OSType l26 = _$l26;
  static const OSType solaris = _$solaris;

  const OSType._(String name) : super(name);

  static BuiltSet<OSType> get values => _$osValues;
  static OSType valueOf(String name) => _$osValueOf(name);

  static Map<OSType, Map<String, String>> osChoices = {
    l26: {'desc': '5.x - 2.6 Kernel', 'type': 'Linux'},
    l24: {'desc': '2.4 Kernel', 'type': 'Linux'},
    win10: {'desc': '10/2016/2019', 'type': 'Microsoft Windows'},
    win11: {'desc': '11/2022', 'type': 'Microsoft Windows'},
    win8: {'desc': '8.x/2012/2012r2', 'type': 'Microsoft Windows'},
    win7: {'desc': '7/2008r2', 'type': 'Microsoft Windows'},
    w2k8: {'desc': 'Vista/2008', 'type': 'Microsoft Windows'},
    wxp: {'desc': 'XP/2003', 'type': 'Microsoft Windows'},
    w2k: {'desc': '2000', 'type': 'Microsoft Windows'},
    solaris: {'desc': '-', 'type': 'Solaris Kernel'},
    other: {'desc': '-', 'type': 'Other'},
  };

  String? get description {
    return osChoices[this]!['desc'];
  }

  String? get type {
    return osChoices[this]!['type'];
  }
}

@BuiltValueEnum(wireName: 'scsihw')
class ScsiControllerModel extends EnumClass {
  static Serializer<ScsiControllerModel> get serializer =>
      _$scsiControllerModelSerializer;

  static const ScsiControllerModel lsi = _$lsi;
  static const ScsiControllerModel lsi53c810 = _$lsi53c810;
  @BuiltValueEnumConst(wireName: 'virtio-scsi-pci')
  static const ScsiControllerModel virtioScsiPci = _$virtioScsiPci;
  @BuiltValueEnumConst(wireName: 'virtio-scsi-single')
  static const ScsiControllerModel virtioScsiSingle = _$virtioScsiSingle;
  static const ScsiControllerModel megasas = _$megasas;
  static const ScsiControllerModel pvscsi = _$pvscsi;

  const ScsiControllerModel._(String name) : super(name);

  static BuiltSet<ScsiControllerModel> get values => _$scValues;
  static ScsiControllerModel valueOf(String name) => _$scValueOf(name);
}

class CdType extends EnumClass {
  static Serializer<CdType> get serializer => _$cdTypeSerializer;

  static const CdType iso = _$iso;
  static const CdType cdrom = _$cdrom;
  static const CdType none = _$none;

  const CdType._(String name) : super(name);

  static BuiltSet<CdType> get values => _$values;
  static CdType valueOf(String name) => _$valueOf(name);
}

@BuiltValueEnum(wireName: 'hugepages')
class Hugepages extends EnumClass {
  static const Hugepages any = _$any;
  @BuiltValueEnumConst(wireName: '2')
  static const Hugepages h2 = _$h2;
  @BuiltValueEnumConst(wireName: '1024')
  static const Hugepages h1024 = _$h1024;

  const Hugepages._(String name) : super(name);

  static BuiltSet<Hugepages> get values => _$hugepagesValues;
  static Hugepages valueOf(String name) => _$hugepagesValueOf(name);

  static Serializer<Hugepages> get serializer => _$hugepagesSerializer;
}

@BuiltValueEnum(wireName: 'lock')
class LockType extends EnumClass {
  static const LockType backup = _$backup;
  static const LockType clone = _$clone;
  static const LockType create = _$create;
  static const LockType migrate = _$migrate;
  static const LockType rollback = _$rollback;
  static const LockType snapshot = _$snapshot;
  @BuiltValueEnumConst(wireName: 'snapshot-create')
  static const LockType snapshotDelete = _$snapshotDelete;
  static const LockType suspending = _$suspending;
  static const LockType suspended = _$suspended;

  const LockType._(String name) : super(name);

  static BuiltSet<LockType> get values => _$lockTypeValues;
  static LockType valueOf(String name) => _$lockTypeValueOf(name);

  static Serializer<LockType> get serializer => _$lockTypeSerializer;
}
