import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_users/common/scroll.dart';
import 'package:stack_users/widgets/bottom_loader.dart';
import 'package:stack_users/user/user_reputation/bloc/user_reputation_bloc.dart';
import 'package:stack_users/user/user_reputation/widgets/user_reputation_item.dart';

class UserReputationWidget extends StatefulWidget {
  const UserReputationWidget({super.key});

  @override
  State<UserReputationWidget> createState() => _UserListState();
}

class _UserListState extends State<UserReputationWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserReputationBloc, UserReputationState>(
      builder: (context, state) {
        switch (state.status) {
          case UserReputationStatus.failure:
            return const Center(child: Text('failed to fetch reputation'));
          case UserReputationStatus.success:
            if (state.reputation.isEmpty) {
              return const Center(child: Text('no reputation history'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.reputation.length
                    ? const BottomLoader()
                    : UserReputationItem(reputation: state.reputation[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.reputation.length
                  : state.reputation.length + 1,
              controller: _scrollController,
            );
          case UserReputationStatus.loading:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<UserReputationBloc>().add(Fetch());
  }

  bool get _isBottom {
    return scrollIsBottom(_scrollController);
  }
}
