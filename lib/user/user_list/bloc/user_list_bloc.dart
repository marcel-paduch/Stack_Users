import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stack_users/user/user_list/domain/fetch_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/get_cached_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/get_liked_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/set_user_favourite_status_use_case.dart';
import '../../models/user.dart';
import 'package:stack_users/common/throttle_droppable.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

const _pageSize = 30;
const _throttleDuration = Duration(milliseconds: 100);

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final FetchUsersUseCase _fetchUsersUseCase;
  final GetCachedUsersUseCase _getCachedUsersUseCase;
  final SetUserFavouriteStatusUseCase _setUserFavouriteStatusUseCase;
  final GetLikedUsersUseCase _getLikedUsers;

  UserListBloc(
    this._fetchUsersUseCase,
    this._getCachedUsersUseCase,
    this._setUserFavouriteStatusUseCase,
    this._getLikedUsers,
  ) : super(const UserListState()) {
    on<Init>(_onInit);
    on<Fetch>(
      _onPostFetched,
      transformer: throttleDroppable(_throttleDuration),
    );
    on<UserLikeChanged>(_onUserLikeChanged);
    on<ToggleFilteredItems>(_onToggleFilter);
  }

  Future<void> _onInit(
    Init event,
    Emitter<UserListState> emit,
  ) async {
    final result = await _fetchUsersUseCase.fetch(1, _pageSize);
    return emit(state.copyWith(
      status: UserListStatus.success,
      users: result.users.cast(),
      hasReachedMax: result.hasMore == false,
    ));
  }

  Future<void> _onPostFetched(
    Fetch event,
    Emitter<UserListState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      final result = await _fetchUsersUseCase.fetch(
          (state.users.length ~/ _pageSize) + 1, _pageSize);
      emit(result.hasMore == false
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: UserListStatus.success,
              users: List.of(result.users.cast()),
              hasReachedMax: false,
            ));
    } catch (exception) {
      print(exception.toString());
      emit(state.copyWith(status: UserListStatus.failure));
    }
  }

  Future<void>? _onUserLikeChanged(
    UserLikeChanged event,
    Emitter<UserListState> emit,
  ) {
    _setUserFavouriteStatusUseCase.set(
        state.users[event.index].id, event.value);

    _emitWithUsers(state, emit);
    return null;
  }

  void _emitWithUsers(
    UserListState newState,
    Emitter<UserListState> emit,
  ) {
    List<User> users = newState.isFilterOn
        ? _getLikedUsers.get()
        : _getCachedUsersUseCase.get();
    emit(newState.copyWith(users: users));
  }

  Future<void>? _onToggleFilter(
    ToggleFilteredItems event,
    Emitter<UserListState> emit,
  ) {
    bool isFilterOn = !state.isFilterOn;
    _emitWithUsers(
      state.copyWith(
        isFilterOn: isFilterOn,
      ),
      emit,
    );
    return null;
  }
}
