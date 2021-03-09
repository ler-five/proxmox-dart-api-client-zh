import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pve_guest_rrddata_model.g.dart';

// RRD online return
// cpu: 0.0325027686566402
// diskwrite: 88164.6933333333
// disk: 0
// netin: 6370.92
// maxdisk: 53687091200
// time: 1583327280
// netout: 14.8
// maxcpu: 4
// mem: 224064648.533333
// maxmem: 4294967296
// diskread: 990832.826666667

// RRD offline return
// disk: 0
// maxmem: 4294967296
// time: 1583327220
// maxdisk: 53687091200
// maxcpu: 4
abstract class PveGuestRRDdataModel
    implements Built<PveGuestRRDdataModel, PveGuestRRDdataModelBuilder> {
  static Serializer<PveGuestRRDdataModel> get serializer =>
      _$pveGuestRRDdataModelSerializer;

  DateTime? get time;

  double? get cpu;
  double? get diskread;
  double? get diskwrite;
  double? get netin;
  double? get netout;
  double? get mem;
  double? get maxmem;
  double? get maxdisk;
  double? get maxcpu;
  double? get disk;

  PveGuestRRDdataModel._();
  factory PveGuestRRDdataModel(
          [void Function(PveGuestRRDdataModelBuilder)? updates]) =
      _$PveGuestRRDdataModel;
}

class PveRRDTimeframeType extends EnumClass {
  static const PveRRDTimeframeType hour = _$hour;
  static const PveRRDTimeframeType day = _$day;
  static const PveRRDTimeframeType week = _$week;
  static const PveRRDTimeframeType month = _$month;
  static const PveRRDTimeframeType year = _$year;

  const PveRRDTimeframeType._(String name) : super(name);

  static BuiltSet<PveRRDTimeframeType> get values => _$prrdTValues;
  static PveRRDTimeframeType valueOf(String name) => _$prrdTValueOf(name);
}
