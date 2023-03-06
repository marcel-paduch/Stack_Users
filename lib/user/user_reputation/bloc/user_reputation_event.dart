part of 'user_reputation_bloc.dart';
abstract class UserReputationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Init extends UserReputationEvent {}
class Fetch extends UserReputationEvent {}

