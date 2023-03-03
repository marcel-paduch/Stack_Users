import 'package:stack_users/user/data/user_repository.dart';
import 'package:stack_users/user/models/user_list.dart';

class FetchUsersUseCase {
  final UserRepository _userRepository;

  FetchUsersUseCase(this._userRepository);

  Future<UserList> fetch(int page, int pageSize) {
    return _userRepository.getUsersWithFavourites(page, pageSize);
  }
}
