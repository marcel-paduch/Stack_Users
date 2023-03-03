import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_reputation.g.dart';
@JsonSerializable()
class UserReputation extends Equatable {
  @JsonKey(name: 'reputation_history_type')
  final String? reputationType;
  @JsonKey(name: 'reputation_change')
  final int? change;
  @JsonKey(name: 'creation_date')
  final int? createdAt;
  @JsonKey(name: 'post_id')
  final int? postId;

  const UserReputation({
    required this.reputationType,
    required this.change,
    required this.createdAt,
    required this.postId,
  });

  @override
  List<Object?> get props => [reputationType, change, createdAt, postId];

  factory UserReputation.fromJson(Map<String, dynamic> json) =>
      _$UserReputationFromJson(json);

  Map<String, dynamic> toJson() => _$UserReputationToJson(this);

}
