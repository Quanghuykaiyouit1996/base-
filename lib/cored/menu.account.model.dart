import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.account.model.g.dart';

@JsonSerializable(createToJson: true)
class MenuAccount {
  String? title;
  @JsonKey(ignore: true)
  IconData? icon;
  @JsonKey(ignore: true)
  MenuAccountType? type;
  @JsonKey(ignore: true)
  double? size;

  MenuAccount({this.title, this.icon, this.type, this.size});

  factory MenuAccount.fromJson(Map<String, dynamic> data) =>
      _$MenuAccountFromJson(data);

  Map<String, dynamic> toJson() => _$MenuAccountToJson(this);
}

enum MenuAccountType {
  MY_ROOM,
  MY_REVIEW,

}
