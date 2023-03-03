import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stack_users/user/models/user_reputation.dart';

part 'user_reputation_list.g.dart';

@JsonSerializable(explicitToJson: true)
class UserReputationList extends Equatable {
  const UserReputationList({required this.reputations,
    required this.hasMore,
  });

  @JsonKey(name: 'items')
  final List<UserReputation> reputations;
  @JsonKey(name: 'has_more')
  final bool hasMore;

  @override
  List<Object> get props => [reputations, hasMore];

  factory UserReputationList.fromJson(Map<String, dynamic> json) => _$UserReputationListFromJson(json);
  Map<String, dynamic> toJson() => _$UserReputationListToJson(this);
}