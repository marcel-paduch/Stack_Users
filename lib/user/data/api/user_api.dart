import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stack_users/user/models/user_list.dart';
import 'package:stack_users/user/models/user_reputation_list.dart';

class UserApiProvider {
  final http.Client httpClient;
  static const String USER_API = "2.2/users";
  static const String HOST = "api.stackexchange.com";
  static const String HISTORY_API = "reputation-history";
  static const String SITE = "stackoverflow";

  const UserApiProvider({required this.httpClient});

  Future<UserList> fetchUsers([int page = 1, int pageSize = 30]) async {
    final response = await httpClient.get(
      Uri.https(
        '$HOST',
        '$USER_API',
        <String, String>{
          'page': '$page',
          'pagesize': '$pageSize',
          'site': '$SITE'
        },
      ),
    );
    if (response.statusCode == 200) {
      return UserList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<UserReputationList> fetchHistory(int userId,
      [int page = 1, int pageSize = 30]) async {
    final response = await httpClient.get(
      Uri.https(
        '$HOST',
        '$USER_API/$userId/$HISTORY_API',
        <String, String>{
          'page': '$page',
          'pagesize': '$pageSize',
          'site': '$SITE'
        },
      ),
    );
    if (response.statusCode == 200) {
      return UserReputationList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

}
