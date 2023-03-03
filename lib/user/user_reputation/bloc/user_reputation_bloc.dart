import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_users/user/models/user_reputation.dart';
import 'package:equatable/equatable.dart';
import 'package:stack_users/common/throttle_droppable.dart';
import 'package:stack_users/user/user_reputation/domain/get_user_reputation_use_case.dart';

part 'user_reputation_state.dart';

part 'user_reputation_event.dart';

const _pageSize = 30;
const throttleDuration = Duration(milliseconds: 100);

class UserReputationBloc
    extends Bloc<UserReputationEvent, UserReputationState> {
  final GetUserReputationUseCase _getUserReputationUseCase;
  final int userId;

  UserReputationBloc(this._getUserReputationUseCase, {required this.userId})
      : super(const UserReputationState()) {
    on<Fetch>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
      UserReputationEvent event, Emitter<UserReputationState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == UserReputationStatus.initial) {
        final reputations =
            await _getUserReputationUseCase.get(userId, 1, _pageSize);
        return emit(state.copyWith(
          status: UserReputationStatus.success,
          users: reputations.reputations.cast(),
          hasReachedMax: reputations.hasMore == false,
        ));
      }

      final reputations = await _getUserReputationUseCase.get(
          userId, (state.reputation.length ~/ _pageSize) + 1, _pageSize);
      emit(reputations.hasMore == false
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: UserReputationStatus.success,
              users: List.of(state.reputation)
                ..addAll(reputations.reputations.cast()),
              hasReachedMax: false,
            ));
    } catch (exception) {
      emit(state.copyWith(status: UserReputationStatus.failure));
    }
  }
}
