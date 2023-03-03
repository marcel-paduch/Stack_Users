import 'package:stack_users/user/data/user_repository.dart';
import 'package:stack_users/user/models/user.dart';

class GetLikedUsersUseCase {
  final UserRepository _userRepository;

  GetLikedUsersUseCase(this._userRepository,);

  List<User> get() {
    List<User> newList = _userRepository.getUsersFromCache();
    newList.removeWhere((user) => !user.isLiked);
    return newList;
  }
}