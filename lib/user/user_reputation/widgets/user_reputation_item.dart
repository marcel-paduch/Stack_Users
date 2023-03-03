import 'package:flutter/material.dart';
import 'package:stack_users/user/models/user_reputation.dart';

class UserReputationItem extends StatelessWidget {
  const UserReputationItem({super.key, required this.reputation});

  final UserReputation reputation;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        if (reputation.reputationType != null) Text(reputation.reputationType!),
        if (reputation.change != null) Text(reputation.change!.toString()),
        if (reputation.postId != null) Text(reputation.postId!.toString()),
      ],
    ));
  }
}
