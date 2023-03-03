// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reputation_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReputationList _$UserReputationListFromJson(Map<String, dynamic> json) =>
    UserReputationList(
      reputations: (json['items'] as List<dynamic>)
          .map((e) => UserReputation.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['has_more'] as bool,
    );

Map<String, dynamic> _$UserReputationListToJson(UserReputationList instance) =>
    <String, dynamic>{
      'items': instance.reputations.map((e) => e.toJson()).toList(),
      'has_more': instance.hasMore,
    };
