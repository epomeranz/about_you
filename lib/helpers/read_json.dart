import 'dart:convert';

import 'package:about_you/app/app.logger.dart';
import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:flutter/services.dart';

class ReadJson {
  static final _log = getLogger('ReadJson');
  static const _jsonDir = 'assets/json/';
  static const _jsonExtension = '.json';

  static Future<List<Map<String, dynamic>>> readJsonFromAssets(
      String fileName) async {
    try {
      final resourcePath = _jsonDir + fileName + _jsonExtension;
      _log.d("reading mockup data from: $resourcePath");
      final ByteData data = await rootBundle.load(resourcePath);
      final List<dynamic> map = json.decode(
        utf8.decode(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        ),
      );
      return castListItems(map);
    } catch (e) {
      _log.e(e);
    }
    return [];
  }

  static List<M> castListItems<T, M>(List<T> source) {
    final List<M> result = List<M>.empty(growable: true);
    source.forEach((element) {
      result.add(element as M);
    });
    return result;
  }

  static dynamic dataSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    if (object is UserSnippet) {
      var json = object.toJsonWithNoTimestampUpdate();
      return JsonEncoder().convert(json);
    }

    return object;
  }
}
