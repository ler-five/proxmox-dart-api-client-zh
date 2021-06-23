import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class PveDoubleSerializer implements PrimitiveSerializer<double> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>([double]);
  @override
  final String wireName = 'double';

  @override
  Object serialize(Serializers serializers, double value,
      {FullType specifiedType = FullType.unspecified}) {
    return value;
  }

  @override
  double deserialize(Serializers serializers, Object? serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is String) {
      return double.parse(serialized);
    }
    if (serialized is int) {
      return (serialized).toDouble();
    }
    return serialized as double;
  }
}
