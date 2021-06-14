// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return User(
    uid: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    status: _$enumDecode(_$UserStatusEnumMap, json['status'],
        unknownValue: UserStatus.OFFLINE),
    lastSeen: json['last_seen'] == null
        ? null
        : DateTime.parse(json['last_seen'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.uid,
      'status': _$UserStatusEnumMap[instance.status],
      'name': instance.name,
      'last_seen': instance.lastSeen?.toIso8601String(),
      'email': instance.email,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$UserStatusEnumMap = {
  UserStatus.ONLINE: 'ONLINE',
  UserStatus.OFFLINE: 'OFFLINE',
};
