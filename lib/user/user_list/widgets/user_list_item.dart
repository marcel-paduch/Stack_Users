import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_users/user/user_list/bloc/user_list_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../models/user.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user, required this.index});

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (user.isLiked) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    String userId = user.id.toString();
    return Material(
      child: ListTile(
        onTap: () => context.go(
          "/history/$userId",
        ),
        leading: Image.network(user.avatar),
        title: Row(
          children: [
            Text(user.name),
            SizedBox(width: 10),
            if (user.age > 0) Text(user.age.toString()),
          ],
        ),
        isThreeLine: true,
        subtitle: Text(user.location),
        dense: true,
        trailing: ElevatedButton.icon(
            onPressed: () {
              context
                  .read<UserListBloc>()
                  .add(UserLikeChanged(index: index, value: !user.isLiked));
            },
            icon: Icon(icon),
            label: Text("Like")),
      ),
    );
  }
}
