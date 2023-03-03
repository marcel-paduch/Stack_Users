import 'package:stack_users/user/data/user_repository.dart';

class SetUserFavouriteStatusUseCase {
  final UserRepository _userRepository;

  SetUserFavouriteStatusUseCase(this._userRepository);

  void set(int userId, bool value) {
    _userRepository.setUserStatus(userId, value);
  }
}
