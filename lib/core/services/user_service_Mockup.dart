import 'dart:async';

import 'package:about_you/app/app.logger.dart';
import 'package:about_you/core/models/users/user.dart';
import 'package:about_you/core/services/user_service_interface.dart';

class MockupUserService implements IUserService {
  final log = getLogger('UserService');
  User? _currentUser;

  @override
  User? get currentUser => _currentUser;

  @override
  bool get hasLoggedInUser => _currentUser != null;

  @override
  initialize() async {
    await _restoreSession();
    log.v("MockupUserService initialized");
  }

  @override
  Future<void> syncUserAccount() async {
    log.v("mockup sync the user from the auth service to the DB");
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<void> syncOrCreateUserAccount({required User user}) async {
    log.i('user:$user');
    if (hasLoggedInUser) {
      await syncUserAccount();
    } else {
      //retrive the user from the database;
      if (_currentUser == null) {
        _currentUser = user;
        log.v('There is no user account in the DB. Create a new user ...');
        await Future.delayed(Duration(microseconds: 250));
        log.v('$_currentUser has been saved');
      }
    }
  }

  Future<void> _restoreSession() async {
    log.v("mockup fetch last user");
    await Future.delayed(Duration(microseconds: 250));

    await syncOrCreateUserAccount(
      user: User(
        name: "Eric Pomeranz",
        email: "epomeranz@gmail.com",
        uid: "1",
      ),
    );
  }
}
