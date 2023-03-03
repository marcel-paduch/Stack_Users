part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends UserListEvent {}
class ToggleFilteredItems extends UserListEvent {}

class UserLikeChanged extends UserListEvent {
  final int index;
  final bool value;

  UserLikeChanged({required this.index, required this.value});

  @override
  List<Object> get props => [index, value];
}
