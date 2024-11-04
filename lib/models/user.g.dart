// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String,
      password: json['password'] as String?,
      image: json['image'] as String?,
      finishedExercises: (json['finishedExercises'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'image': instance.image,
      'finishedExercises': instance.finishedExercises,
    };
