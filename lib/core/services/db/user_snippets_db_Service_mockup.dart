import 'dart:async';

import 'package:about_you/app/app.logger.dart';
import 'package:about_you/constants/global_settings.dart';
import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:about_you/core/services/db/user_snippets_db_service_interface.dart';
import 'package:about_you/helpers/read_json.dart';

class MockupUserSnippetDBService implements IUserSnippetDBService {
  static const _jsonFileName = 'contacts_large';

  final log = getLogger('MockupUserSnippetDBService');

  Future<List<UserSnippet>> readFromAssetsFile() async {
    try {
      List<Map<String, dynamic>> jsonData =
          await ReadJson.readJsonFromAssets(_jsonFileName);

      List<UserSnippet> usersFromJson = List<UserSnippet>.generate(
          jsonData.length,
          (index) => UserSnippet(
              uid: index.toString(),
              name: jsonData[index]['name'] ?? 'unknown'),
          growable: false);

      return usersFromJson;
    } catch (e) {
      log.e(e);
    }
    return [];
  }

  @override
  Future<bool> delete(Map<String, dynamic> ids) async {
    log.v("delete");
    return true;
  }

  @override
  Future<UserSnippet?> readById(id) async {
    log.v("readById");
    try {
      List<UserSnippet> users = await readFromAssetsFile();
      int index = int.tryParse(id) ?? -1;
      if (index >= 0) return users[index];
    } catch (e) {
      log.d("user id:$id not found");
    }
    return null;
  }

  @override
  Future<UserSnippet> update(UserSnippet item) async {
    log.v("update");
    return item;
  }

  @override
  Future<UserSnippet> write(UserSnippet item) async {
    log.v("write");
    return item;
  }

  @override
  Future<List<UserSnippet>> read(
      {Map<String, dynamic>? queries,
      int limit = Constants.queryLimits,
      int page = 0}) async {
    log.v("read - queries: $queries");
    List<UserSnippet> result = List<UserSnippet>.empty(growable: true);
    try {
      await mockupDelay();
      List<UserSnippet> mockupUsers = await readFromAssetsFile();
      _sortData(mockupUsers);
      result = _paginate(
          (queries?["name"] is String)
              ? mockupUsers
                  .where((element) => element.name
                      .trim()
                      .toUpperCase()
                      .contains(
                          queries!["name"].toString().trim().toUpperCase()))
                  .toList()
              : mockupUsers,
          limit,
          page);
    } catch (e) {
      log.e(e);
    }
    return result;
  }

  @override
  Stream<List<UserSnippet>> stream(Map<String, dynamic>? queries) async* {
    log.v("stream");
    try {
      final List<UserSnippet> usersGrowableList =
          List<UserSnippet>.empty(growable: true);
      final List<UserSnippet> finalUsersList = await read(queries: queries);

      for (UserSnippet user in finalUsersList) {
        await mockupDelay();
        usersGrowableList.add(user);
        yield usersGrowableList;
      }
    } catch (e) {
      log.e(e);
    }
    yield [];
  }

  Future<void> mockupDelay() async {
    return await Future.delayed(Duration(milliseconds: 300));
  }

  _sortData(List<UserSnippet> data) {
    data.sort((a, b) =>
        a.name.trim().toUpperCase().compareTo(b.name.trim().toUpperCase()));
  }

  List<UserSnippet> _paginate(List<UserSnippet> list, int limit, int page) {
    try {
      int start = limit * page;
      int end = limit * page + limit;
      if (list.length <= start) start = list.length - 1;
      if (list.length <= end) end = list.length - 1;
      if (start < end) return list.sublist(start, end);
    } catch (e) {
      log.e(e);
    }
    return [];
  }
}
