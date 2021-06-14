import 'package:about_you/app/app.locator.dart';
import 'package:about_you/core/models/users/user.dart';
import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:about_you/core/services/db/user_snippets_db_service_interface.dart';
import 'package:about_you/core/services/user_service_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import 'test_helpers.mocks.dart';

const String UserIdTestKey = 'default_user';
const String UserNameTest = 'John Doe';
const String UsereMailTest = 'John@Doe.com';

@GenerateMocks([], customMocks: [
  MockSpec<IUserService>(returnNullOnMissingStub: true),
  MockSpec<NavigationService>(returnNullOnMissingStub: true),
  MockSpec<IUserSnippetDBService>(returnNullOnMissingStub: true),
])
MockIUserService getAndRegisterUserService({
  bool hasLoggedInUser = false,
  User? currentUser,
}) {
  _removeRegistrationIfExists<IUserService>();
  final service = MockIUserService();
  when(service.hasLoggedInUser).thenReturn(hasLoggedInUser);
  when(service.currentUser).thenReturn(currentUser ??
      User(uid: UserIdTestKey, name: UserNameTest, email: UsereMailTest));
  locator.registerSingleton<IUserService>(service);
  return service;
}

MockIUserSnippetDBService getAndRegisterUserSnippetService({
  UserSnippet? userSnippet,
}) {
  _removeRegistrationIfExists<IUserSnippetDBService>();
  final service = MockIUserSnippetDBService();
  when(service.readById(any)).thenAnswer(
    (realInvocation) => Future<UserSnippet?>.value(
      userSnippet ?? UserSnippet(uid: UserIdTestKey, name: UserNameTest),
    ),
  );
  when(service.read()).thenAnswer(
    (realInvocation) => Future<List<UserSnippet>>.value(
      [userSnippet ?? UserSnippet(uid: UserIdTestKey, name: UserNameTest)],
    ),
  );

  locator.registerSingleton<IUserSnippetDBService>(service);
  return service;
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

void registerServices() {
  getAndRegisterUserService();
  getAndRegisterNavigationService();
  getAndRegisterUserSnippetService();
}

void unregisterServices() {
  locator.unregister<IUserService>();
  locator.unregister<NavigationService>();
  locator.unregister<IUserSnippetDBService>();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
