
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stack_users/user/models/user.dart';
part 'user_list.g.dart';

@JsonSerializable(explicitToJson: true)
class UserList extends Equatable {
  const UserList({required this.users,
    required this.hasMore,
  });

  @JsonKey(name: 'items')
  final List<User> users;
  @JsonKey(name: 'has_more')
  final bool hasMore;

  @override
  List<Object> get props => [users, hasMore];

  factory UserList.fromJson(Map<String, dynamic> json) => _$UserListFromJson(json);
  Map<String, dynamic> toJson() => _$UserListToJson(this);

  UserList copyWith({required List<User> users}) {
    return UserList(
      users: users,
      hasMore: hasMore,
    );
  }
}