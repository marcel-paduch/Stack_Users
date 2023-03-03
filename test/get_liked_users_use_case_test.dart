// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stack_users/user/data/user_repository.dart';
import 'package:stack_users/user/models/user.dart';
import 'package:stack_users/user/models/user_list.dart';
import 'package:stack_users/user/user_list/domain/fetch_users_use_case.dart';
import 'package:stack_users/user/user_list/domain/get_liked_users_use_case.dart';

import 'fetch_users_use_case_test.mocks.dart';

@GenerateMocks([GetLikedUsersUseCase])
void main() {
  MockUserRepository mockUserRepository = MockUserRepository();
  GetLikedUsersUseCase useCase = GetLikedUsersUseCase(mockUserRepository);

  test('returns filtered list of users with isLiked == true', () async {
    // given
    List<User> userList = [
      User(
          id: 1,
          name: "",
          avatar: "avatar",
          location: "location",
          age: 0,
          isLiked: false),
      User(
          id: 1,
          name: "",
          avatar: "avatar",
          location: "location",
          age: 0,
          isLiked: true),
      User(
          id: 1,
          name: "",
          avatar: "avatar",
          location: "location",
          age: 0,
          isLiked: false),
    ];
    when(mockUserRepository.getUsersFromCache()).thenReturn(userList);

    // when
    List<User> res = useCase.get();

    // then
    verify(mockUserRepository.getUsersFromCache());
    res.forEach((element) {
      expect(element.isLiked, true);
    });
  });
}
