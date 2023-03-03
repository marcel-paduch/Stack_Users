import 'package:stack_users/user/data/api/user_api.dart';
import 'package:stack_users/user/data/local/user_shared_prefs.dart';
import 'package:stack_users/user/models/user_list.dart';
import 'package:stack_users/user/models/user_reputation_list.dart';
import 'package:stack_users/user/models/user.dart';

class UserRepository {
  final UserApiProvider _apiProvider;
  final UserSharedPrefsProvider _sharedPrefsProvider;

  final List<User> _userListCache;

  const UserRepository(
      this._apiProvider,
       this._sharedPrefsProvider,
       this._userListCache);

  Future<UserList> getUsersWithFavourites(
      [int page = 1, int pageSize = 30]) async {
    UserList userList = await _apiProvider.fetchUsers(page, pageSize);
    List<User> newList = userList.users
        .map(
            (user) => user.copyWith(isLiked: _sharedPrefsProvider.getUserStatus(user.id)))
        .toList();

    _userListCache.addAll(newList);
    return userList.copyWith(users: List.of(_userListCache));
  }

  Future<UserReputationList> getUserReputation(int userId,
      [int page = 1, int pageSize = 30]) {
    return _apiProvider.fetchHistory(userId, page, pageSize);
  }

  void setUserStatus(int userId, bool isLiked) {
    _sharedPrefsProvider.setUserStatus(userId, isLiked);
    int userIndex = _userListCache.indexWhere((element) => element.id == userId);
    _userListCache[userIndex] =
        _userListCache[userIndex].copyWith(isLiked: isLiked);
  }

  List<User> getUsersFromCache(){
    return List.of(_userListCache);
  }

}
