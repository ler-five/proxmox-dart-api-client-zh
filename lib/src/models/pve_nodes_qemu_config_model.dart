import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_nodes_qemu_config_model.g.dart';

abstract class PveNodesQemuConfigModel
    implements Built<PveNodesQemuConfigModel, PveNodesQemuConfigModelBuilder> {
  PveNodesQemuConfigModel._();
  static Serializer<PveNodesQemuConfigModel> get serializer =>
      _$pveNodesQemuConfigModelSerializer;
  factory PveNodesQemuConfigModel(
          [void Function(PveNodesQemuConfigModelBuilder) updates]) =
      _$PveNodesQemuConfigModel;

  String get digest;
  @nullable
  bool get acpi;
  @nullable
  String get agent;
  @nullable
  ProcessorArch get arch;
  //bool get autostart;
  @nullable
  int get balloon;
  @nullable
  Bios get bios;
  @nullable
  String get boot;
  @nullable
  String get cdrom;
  @nullable
  int get cores;
  @nullable
  String get cpu;
  @nullable
  String get description;
  @nullable
  bool get freeze;
  @nullable
  //TODO add generator
  @nullable
  String get hostpci0;
  @nullable
  String get hotplug;
  @nullable
  Hugepages get hugepages;
  //TODO add generator
  @nullable
  String get ide0;
  @nullable
  bool get kvm;
  @nullable
  bool get localtime;
  @nullable
  LockType get lock;
  @nullable
  String get machine;
  @nullable
  int get memory;
  @nullable
  String get name;
  //TODO add generator
  @nullable
  String get net0;
  @nullable
  bool get numa;
  @nullable
  bool get onboot;
  @nullable
  OSType get ostype;
  @nullable
  bool get protection;
  @nullable
  bool get reboot;
  //TODO add generator
  @nullable
  String get sata0;
  //TODO add generator
  @nullable
  String get scsi0;
  @nullable
  ScsiControllerModel get scsihw;
  @nullable
  String get serial0;
  @nullable
  int get shares;
  @nullable
  String get smbios1;
  @nullable
  int get sockets;
  @nullable
  @BuiltValueField(wireName: 'spice_enhancements')
  String get spiceEnhancements;
  @nullable
  String get startdate;
  @nullable
  String get startup;
  @nullable
  bool get tablet;
  @nullable
  String get tags;
  //TODO add generator
  @nullable
  String get unused0;
  //TODO add generator
  @nullable
  String get usb0;
  @nullable
  int get vcpus;
  //TODO add generator
  @nullable
  String get virtio0;
  @nullable
  String get vmgenid;
  @nullable
  String get vmstatestorage;
  @nullable
  String get watchdog;
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
    win8: {'desc': '8.x/2012/2012r2', 'type': 'Microsoft Windows'},
    win7: {'desc': '7/2008r2', 'type': 'Microsoft Windows'},
    w2k8: {'desc': 'Vista/2008', 'type': 'Microsoft Windows'},
    wxp: {'desc': 'XP/2003', 'type': 'Microsoft Windows'},
    w2k: {'desc': '2000', 'type': 'Microsoft Windows'},
    solaris: {'desc': '-', 'type': 'Solaris Kernel'},
    other: {'desc': '-', 'type': 'Other'},
  };

  String get description {
    return osChoices[this]['desc'];
  }

  String get type {
    return osChoices[this]['type'];
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
