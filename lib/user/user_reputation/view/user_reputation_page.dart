import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_users/user/user_reputation/bloc/user_reputation_bloc.dart';
import 'package:stack_users/user/user_reputation/domain/get_user_reputation_use_case.dart';
import 'package:stack_users/user/user_reputation/view/user_reputation_list.dart';

class UserReputationPage extends StatelessWidget {
  final GetUserReputationUseCase _getUserReputationUseCase;
  final int userId;

  const UserReputationPage(this._getUserReputationUseCase, this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reputation history')),
      body: BlocProvider(
        create: (_) => UserReputationBloc(
          _getUserReputationUseCase,
          userId: userId,
        )..add(Init()),
        child: const UserReputationWidget(),
      ),
    );
  }
}
