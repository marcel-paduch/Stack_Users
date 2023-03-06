import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_users/user/data/api/user_api.dart';
import 'package:stack_users/user/data/local/user_shared_prefs.dart';
import 'package:stack_users/user/data/user_repository.dart';
import 'package:stack_users/user/user_list/domain/fetch_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/get_cached_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/get_liked_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/set_user_favourite_status_use_case.dart';
import 'package:stack_users/user/user_list/view/user_list_page.dart';
import 'package:stack_users/user/user_reputation/domain/get_user_reputation_use_case.dart';
import 'package:stack_users/user/user_reputation/view/user_reputation_page.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // START common deps
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  UserRepository userRepository = UserRepository(
      UserApiProvider(httpClient: http.Client()),
      UserSharedPrefsProvider(sharedPreferences), []);
  // END common deps

  // START UserListPage deps
  FetchUsersUseCase fetchUsersUseCase = FetchUsersUseCase(userRepository);
  GetCachedUsersUseCase getCachedUsersUseCase =
      GetCachedUsersUseCase(userRepository);
  SetUserFavouriteStatusUseCase _setUserFavouriteStatusUseCase =
      SetUserFavouriteStatusUseCase(userRepository);
  GetLikedUsersUseCase _getLikedUsersUseCase =
      GetLikedUsersUseCase(userRepository);
  // END UserListPage deps

  // START UserReputationPage deps
  GetUserReputationUseCase _getUserReputationUseCase =
      GetUserReputationUseCase(userRepository);
  // END UserReputationPage deps

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => UserListPage(
                fetchUsersUseCase,
                getCachedUsersUseCase,
                _setUserFavouriteStatusUseCase,
                _getLikedUsersUseCase,
              ),
          routes: [
            GoRoute(
              path: 'reputation_history/:userId',
              builder: (context, state) => UserReputationPage(
                _getUserReputationUseCase,
                int.parse(state.params["userId"]!),
              ),
            ),
          ]),
    ],
  );
  runApp(MaterialApp.router(
    routerConfig: _router,
  ));
}
