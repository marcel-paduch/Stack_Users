import 'package:stack_users/user/data/user_repository.dart';
import 'package:stack_users/user/models/user_reputation_list.dart';

class GetUserReputationUseCase {
  final UserRepository _userRepository;

  GetUserReputationUseCase(
    this._userRepository,
  );

  Future<UserReputationList> get(int userId, int page, int pageSize) {
    return _userRepository.getUserReputation(userId, page, pageSize);
  }
}
