// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reputation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReputation _$UserReputationFromJson(Map<String, dynamic> json) =>
    UserReputation(
      reputationType: json['reputation_history_type'] as String?,
      change: json['reputation_change'] as int?,
      createdAt: json['creation_date'] as int?,
      postId: json['post_id'] as int?,
    );

Map<String, dynamic> _$UserReputationToJson(UserReputation instance) =>
    <String, dynamic>{
      'reputation_history_type': instance.reputationType,
      'reputation_change': instance.change,
      'creation_date': instance.createdAt,
      'post_id': instance.postId,
    };
