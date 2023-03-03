// Mocks generated by Mockito 5.3.2 from annotations
// in stack_users/test/get_liked_users_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:stack_users/user/models/user.dart' as _i3;
import 'package:stack_users/user/user_list/domain/get_liked_users_use_case.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [GetLikedUsersUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLikedUsersUseCase extends _i1.Mock
    implements _i2.GetLikedUsersUseCase {
  MockGetLikedUsersUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.User> get() => (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
        ),
        returnValue: <_i3.User>[],
      ) as List<_i3.User>);
}