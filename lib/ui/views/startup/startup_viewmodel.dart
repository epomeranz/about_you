import 'package:about_you/app/app.locator.dart';
import 'package:about_you/app/app.logger.dart';
import 'package:about_you/app/app.router.dart';
import 'package:about_you/core/services/user_service_interface.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final log = getLogger('StartUpViewModel');
  final _navigationService = locator<NavigationService>();
  final _userService = locator<IUserService>();

  Future<void> runStartupLogic() async {
    await _userService.initialize();

    if (_userService.hasLoggedInUser) {
      log.v('User logged in');
      log.v('Naviage to the home page');
      await _navigationService.replaceWith(Routes.homeView);
    } else {
      log.v('User Not Logged in. Navigate to the login page');
      await _navigationService.replaceWith(Routes.homeView);
    }
  }
}
