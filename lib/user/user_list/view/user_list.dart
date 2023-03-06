import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_users/common/scroll.dart';
import 'package:stack_users/user/user_list/bloc/user_list_bloc.dart';
import 'package:stack_users/widgets/bottom_loader.dart';

import '../widgets/user_list_item.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  State<UserListWidget> createState() => _UserListState();
}

class _UserListState extends State<UserListWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        Widget body;
        IconData icon;
        if (state.isFilterOn) {
          icon = Icons.favorite;
        } else {
          icon = Icons.favorite_border;
        }
        switch (state.status) {
          case UserListStatus.failure:
            body = const Center(child: Text('failed to fetch users'));
            break;
          case UserListStatus.success:
            if (state.users.isEmpty) {
              body = const Center(child: Text('no users'));
            }
            body = ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.users.length && !state.isFilterOn
                    ? const BottomLoader()
                    : UserListItem(user: state.users[index], index: index);
              },
              itemCount: state.hasReachedMax || state.isFilterOn
                  ? state.users.length
                  : state.users.length + 1,
              controller: _scrollController,
            );
            break;
          case UserListStatus.loading:
            body = const Center(child: CircularProgressIndicator());
            break;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Users"),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<UserListBloc>().add(ToggleFilteredItems());
                },
                icon: Icon(icon),
              )
            ],
          ),
          body: body,
        );
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
    if (_isBottom) context.read<UserListBloc>().add(Fetch());
  }

  bool get _isBottom {
    return scrollIsBottom(_scrollController);
  }
}
