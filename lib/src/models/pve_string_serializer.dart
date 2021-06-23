import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class PveStringSerializer implements PrimitiveSerializer<String> {
  final bool structured = false;
  @override
  final Iterable<Type> types = BuiltList<Type>([String]);
  @override
  final String wireName = 'String';

  @override
  Object serialize(Serializers serializers, String string,
      {FullType specifiedType = FullType.unspecified}) {
    return string;
  }

  @override
  String deserialize(Serializers serializers, Object? serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is int || serialized is double) {
      return serialized.toString();
    }
    return serialized as String;
  }
}
