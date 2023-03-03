part of 'user_reputation_bloc.dart';
abstract class UserReputationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends UserReputationEvent {}

