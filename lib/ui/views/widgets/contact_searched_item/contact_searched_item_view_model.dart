import 'package:about_you/app/app.locator.dart';
import 'package:about_you/app/app.logger.dart';
import 'package:about_you/app/app.router.dart';
import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String ParticipantSnippetsStream = 'ParticipantSnippetsStream';
const String ConversationStream = 'ConversationStream';

class ContactSearchedItemViewModel extends BaseViewModel {
  final log = getLogger('ContactSearchedItemViewModel');
  final _navigationService = locator<NavigationService>();

  late UserSnippet _user;
  UserSnippet get user => this._user;

  ContactSearchedItemViewModel(UserSnippet user) {
    this._user = user;
  }

  Future<void> navigateToDetailPage() async {
    log.i("navigate to detail view for item : $_user.name");
    await _navigationService.navigateTo(Routes.detailView,
        arguments: DetailViewArguments(id: _user.uid));
  }
}
