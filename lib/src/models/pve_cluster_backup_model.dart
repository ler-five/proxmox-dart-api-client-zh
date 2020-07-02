import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'pve_cluster_backup_model.g.dart';

class PveVZDumpCompressionType extends EnumClass {
  @BuiltValueEnumConst(fallback: true)
  static const PveVZDumpCompressionType none = _$none;

  static const PveVZDumpCompressionType lzo = _$lzo;
  static const PveVZDumpCompressionType gzip = _$gzip;
  static const PveVZDumpCompressionType zstd = _$zstd;

  const PveVZDumpCompressionType._(String name) : super(name);

  static BuiltSet<PveVZDumpCompressionType> get values =>
      _$enumNamePveVZDumpCompressionTypeValues;
  static PveVZDumpCompressionType valueOf(String name) =>
      _$enumNamePveVZDumpCompressionTypeValueOf(name);
}

class PveVZDumpModeType extends EnumClass {
  @BuiltValueEnumConst(fallback: true)
  static const PveVZDumpModeType snapshot = _$snapshot;

  static const PveVZDumpModeType suspend = _$suspend;
  static const PveVZDumpModeType stop = _$stop;

  const PveVZDumpModeType._(String name) : super(name);

  static BuiltSet<PveVZDumpModeType> get values => _$pveVZDumpModeTypeValues;
  static PveVZDumpModeType valueOf(String name) =>
      _$pveVZDumpModeTypeValueOf(name);
}
