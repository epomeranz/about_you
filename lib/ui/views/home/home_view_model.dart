import 'package:about_you/app/app.locator.dart';
import 'package:about_you/app/app.logger.dart';
import 'package:about_you/constants/global_settings.dart';
import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:about_you/core/services/db/user_snippets_db_service_interface.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';

const PERSIST_USER_SEARCH_HISTORY = 'PERSIST_USER_SEARCH_HISTORY';

class HomeViewModel extends BaseViewModel {
  final IUserSnippetDBService _userSNippetDBService =
      locator<IUserSnippetDBService>();
  final log = getLogger('HomeViewModel');

  List<UserSnippet> _suggestions = List<UserSnippet>.empty(growable: true);

  List<UserSnippet> get suggestions => _suggestions;
  String _nameQuery = '';
  String get query => _nameQuery;
  int _currentPage = 0;

  FloatingSearchBarController _searchBarController =
      FloatingSearchBarController();

  get searchBarController => _searchBarController;

  Future<void> refreshData() async {
    _suggestions = await _userSNippetDBService.read(queries: getQuery());
    _currentPage = 0;
    notifyListeners();
  }

  Map<String, dynamic>? getQuery() {
    if (_nameQuery.isNotEmpty) return {"name": _nameQuery};
    return null;
  }

  Future<void> initilize() async {
    log.d("initilize class");
    clearNameQuery();
    try {
      await refreshData();
    } catch (e) {
      log.e(e);
    }
  }

  void clearNameQuery() {
    _nameQuery = '';
  }

  void onQueryChanged(String query) async {
    if (query == _nameQuery) return;

    try {
      _nameQuery = query;
      setBusy(true);
      await refreshData();
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
  }

  Future handleItemCreated(UserSnippet userCreated) async {
    ///using the item created to trigger pagginations instead of the
    ///controller because listiview creates a few items ahead of time
    ///that way I can load more items before the user reaches
    ///the end of the listview
    int itemPosition = _getItemPosition(userCreated) + 1;
    if (itemPosition == 0) print("take a break");
    bool requestMoreData = itemPosition % Constants.queryLimits == 0;
    //divide and truncate
    int pageToRequest = itemPosition ~/ Constants.queryLimits;
    if (requestMoreData && pageToRequest > _currentPage) {
      try {
        print("fetching next page");
        _currentPage = pageToRequest;
        List<UserSnippet> newPageItems = await _userSNippetDBService.read(
            queries: getQuery(), page: pageToRequest);
        _suggestions.insertAll(_suggestions.length, newPageItems);
        log.d(
            "Next page fetched - items fetched: ${newPageItems.length} - total suggestions Loaded: ${_suggestions.length}");
      } catch (e) {
        log.e(e);
      }
      notifyListeners();
    }
  }

  int _getItemPosition(UserSnippet userCreated) {
    return _suggestions.indexOf(userCreated);
  }
}
