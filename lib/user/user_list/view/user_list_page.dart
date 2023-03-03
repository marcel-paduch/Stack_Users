import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_users/user/user_list/bloc/user_list_bloc.dart';
import 'package:stack_users/user/user_list/domain/fetch_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/get_cached_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/get_liked_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/set_user_favourite_status_use_case.dart';
import 'package:stack_users/user/user_list/view/user_list.dart';

class UserListPage extends StatelessWidget {
  final FetchUsersUseCase _fetchUsersUseCase;
  final GetCachedUsersUseCase _getCachedUsersUseCase;
  final SetUserFavouriteStatusUseCase _setUserFavouriteStatusUseCase;
  final GetLikedUsersUseCase _getLikedUsers;

  const UserListPage(
    this._fetchUsersUseCase,
    this._getCachedUsersUseCase,
    this._setUserFavouriteStatusUseCase,
    this._getLikedUsers,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserListBloc(
              _fetchUsersUseCase,
              _getCachedUsersUseCase,
              _setUserFavouriteStatusUseCase,
              _getLikedUsers,
            )..add(Fetch()),
        child: const UserListWidget());
  }
}
