import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class PveIntSerializer implements PrimitiveSerializer<int> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>([int]);
  @override
  final String wireName = 'String';

  @override
  Object serialize(Serializers serializers, int value,
      {FullType specifiedType = FullType.unspecified}) {
    return value;
  }

  @override
  int deserialize(Serializers serializers, Object? serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is String) {
      return int.parse(serialized);
    }
    return serialized as int;
  }
}
