// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stack_users/user/data/user_repository.dart';
import 'package:stack_users/user/models/user_list.dart';
import 'package:stack_users/user/user_list/domain/fetch_users_use_case.dart';

import 'fetch_users_use_case_test.mocks.dart';

@GenerateMocks([UserRepository, UserList])
void main() {
  MockUserRepository mockUserRepository = MockUserRepository();
  MockUserList mockUserList = MockUserList();
  FetchUsersUseCase fetchUsersUseCase = FetchUsersUseCase(mockUserRepository);

  test('returns userList from repository', () async {
    // given
    when(mockUserRepository.getUsersWithFavourites())
        .thenAnswer((realInvocation) => Future.value(mockUserList));
    // when
    UserList res = await fetchUsersUseCase.fetch(1, 30);

    // then
    verify(mockUserRepository.getUsersWithFavourites());
    expect(res, mockUserList);
  });
}
