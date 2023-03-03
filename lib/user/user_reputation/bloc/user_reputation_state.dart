part of 'user_reputation_bloc.dart';

enum UserReputationStatus { initial, success, failure }

class UserReputationState extends Equatable {
  const UserReputationState({
    this.status = UserReputationStatus.initial,
    this.reputation = const <UserReputation>[],
    this.hasReachedMax = false,
  });

  final UserReputationStatus status;
  final List<UserReputation> reputation;
  final bool hasReachedMax;

  UserReputationState copyWith({
    UserReputationStatus? status,
    List<UserReputation>? users,
    bool? hasReachedMax,
  }) {
    return UserReputationState(
      status: status ?? this.status,
      reputation: users ?? this.reputation,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''UserReputationState { status: $status, hasReachedMax: $hasReachedMax, users: ${reputation.length} }''';
  }

  @override
  List<Object> get props => [status, reputation, hasReachedMax];
}