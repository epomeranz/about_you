import 'package:about_you/core/models/users/user.dart';

/// Manages the applications current logged user.
///
/// ## usage
///
/// initialize before using
///
abstract class IUserService {
  ///restores the last session
  initialize();

  ///gets the current logged user or null if there is no logged user
  User? get currentUser;

  ///returns true if there is a logged user
  bool get hasLoggedInUser;

  ///Syncs the user in the DB with the user from the auth service and sets the
  ///current user
  Future<void> syncUserAccount();

  ///Syncs the user in the DB with the user from the auth service if the DB
  ///user doesn't exists (firt time loggin in), it creates an entry in the DB.
  Future<void> syncOrCreateUserAccount({required User user});
}
