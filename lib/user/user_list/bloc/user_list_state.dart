part of 'user_list_bloc.dart';

enum UserListStatus { loading, success, failure }

class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.loading,
    this.users = const <User>[],
    this.hasReachedMax = false,
    this.isFilterOn = false,
  });

  final UserListStatus status;
  final List<User> users;
  final bool hasReachedMax;
  final bool isFilterOn;

  UserListState copyWith({
    UserListStatus? status,
    List<User>? users,
    bool? hasReachedMax,
    bool? isFilterOn,
  }) {
    return UserListState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFilterOn: isFilterOn ?? this.isFilterOn,
    );
  }

  @override
  String toString() {
    return '''UserListState { status: $status, hasReachedMax: $hasReachedMax, users: ${users.length} }''';
  }

  @override
  List<Object> get props => [status, users, hasReachedMax, isFilterOn];
}
