import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

//To automatically build the part classes
// flutter pub run build_runner build (one time build)
// flutter pub run build_runner watch (continuous build)
//   when the build fail try adding '--delete-conflicting-outputs'
//   at the end of the build command

@JsonSerializable(explicitToJson: true)
class User extends UserSnippet {
  User({
    required String uid,
    required String name,
    required this.email,
    UserStatus status = UserStatus.OFFLINE,
    DateTime? lastSeen,
  }) : super(uid: uid, name: name, lastSeen: lastSeen, status: status);

  @JsonKey(
      name: 'email', ignore: false, required: false, disallowNullValue: false)
  final String email;

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    //update the lastSeen value to DateTime.now().toUtc()
    Map<String, dynamic> jsonUser = _$UserToJson(this);
    jsonUser.update('lastSeen', (value) => DateTime.now().toUtc());
    return jsonUser;
  }

  //used for casting without changing the timestamp
  Map<String, dynamic> toJsonWithNoTimestampUpdate() {
    Map<String, dynamic> jsonUser = _$UserToJson(this);
    return jsonUser;
  }

  @override
  bool operator ==(Object other) =>
      other is User &&
      this.uid == other.uid &&
      this.name == other.name &&
      this.email == other.email;

  @override
  int get hashCode =>
      super.hashCode + uid.hashCode + name.hashCode + email.hashCode;
}
