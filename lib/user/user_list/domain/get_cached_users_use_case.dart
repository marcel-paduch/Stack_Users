import 'package:stack_users/user/data/user_repository.dart';
import 'package:stack_users/user/models/user.dart';

class GetCachedUsersUseCase {
  final UserRepository _userRepository;

  GetCachedUsersUseCase(this._userRepository);

  List<User> get() {
    return _userRepository.getUsersFromCache();
  }
}
