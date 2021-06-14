import 'package:about_you/app/app.locator.dart';
import 'package:about_you/app/app.logger.dart';
import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:about_you/core/services/db/user_snippets_db_service_interface.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String ParticipantSnippetsStream = 'ParticipantSnippetsStream';
const String ConversationStream = 'ConversationStream';

class DetailViewModel extends FutureViewModel {
  final log = getLogger('DetailViewModel');
  final _navigationService = locator<NavigationService>();
  final IUserSnippetDBService _userSNippetDBService =
      locator<IUserSnippetDBService>();

  late String _id;
  UserSnippet? _user;
  UserSnippet? get user => this._user;

  DetailViewModel(String id) {
    this._id = id;
  }

  @override
  Future futureToRun() {
    return _userSNippetDBService.readById(_id);
  }

  void navigateBack() {
    log.i("Leave the detail page");
    _navigationService.back(result: _navigationService.previousRoute);
  }
}
