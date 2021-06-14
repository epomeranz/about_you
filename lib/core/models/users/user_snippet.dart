import 'package:about_you/core/models/base/groupable_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_snippet.g.dart';

enum UserStatus {
  ONLINE,
  OFFLINE,
}

//To automatically build the part classes
// flutter pub run build_runner build (one time build)
// flutter pub run build_runner watch (continuous build)
//   when the build fail try adding '--delete-conflicting-outputs'
//   at the end of the build command

@JsonSerializable(explicitToJson: true)
class UserSnippet implements GroupableModels<UserSnippet> {
  UserSnippet({
    required this.uid,
    required this.name,
    this.status = UserStatus.OFFLINE,
    this.lastSeen,
  });

  @JsonKey(name: 'id', ignore: false, required: true, defaultValue: null)
  final String uid;

  @JsonKey(
      name: 'status',
      ignore: false,
      required: false,
      unknownEnumValue: UserStatus.OFFLINE,
      disallowNullValue: false)
  final UserStatus status;

  @JsonKey(name: 'name', ignore: false, required: false, defaultValue: null)
  final String name;

  @JsonKey(
      name: 'last_seen', ignore: false, required: false, defaultValue: null)
  DateTime? lastSeen;

  factory UserSnippet.fromJson(Map<String, dynamic> json) =>
      _$UserSnippetFromJson(json);

  Map<String, dynamic> toJson() {
    //update the lastSeen value to DateTime.now().toUtc()
    Map<String, dynamic> jsonUser = _$UserSnippetToJson(this);
    jsonUser.update('lastSeen', (value) => DateTime.now().toUtc());
    return jsonUser;
  }

  //used for casting without changing the timestamp
  Map<String, dynamic> toJsonWithNoTimestampUpdate() {
    Map<String, dynamic> jsonUser = _$UserSnippetToJson(this);
    return jsonUser;
  }

  @override
  bool operator ==(Object other) =>
      other is UserSnippet && this.uid == other.uid && this.name == other.name;

  @override
  int get hashCode => super.hashCode + uid.hashCode + name.hashCode;

  @override
  String get listviewGroup {
    String nameAux = this.name.trimLeft().toUpperCase();
    if (nameAux.isEmpty) return "-";
    //if it starts with A to Z
    if (nameAux.substring(0, 1).contains(new RegExp(r'[A-Z]')))
      return nameAux.substring(0, 1);
    else
      return "-";
  }

  @override
  int listviewItemComparator(UserSnippet item1, UserSnippet item2) {
    return item1.name.compareTo(item2.name);
  }
}
