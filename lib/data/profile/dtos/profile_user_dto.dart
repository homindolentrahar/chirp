import 'package:json_annotation/json_annotation.dart';

part 'profile_user_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileUserDto {
  @JsonKey(name: "id", defaultValue: "")
  String? userId;
  @JsonKey(defaultValue: "")
  String username;
  @JsonKey(defaultValue: "")
  String email;
  @JsonKey(defaultValue: "")
  String phoneNumber;
  @JsonKey(defaultValue: "")
  String avatarUrl;
  @JsonKey(defaultValue: "")
  String displayName;
  @JsonKey(defaultValue: "")
  String bio;
  @JsonKey(defaultValue: "")
  String? createdAt;
  @JsonKey(defaultValue: "")
  String lastSignInAt;

  ProfileUserDto({
    this.userId,
    this.username = "",
    this.email = "",
    this.phoneNumber = "",
    this.avatarUrl = "",
    this.displayName = "",
    this.bio = "",
    this.createdAt,
    this.lastSignInAt = "",
  });

  factory ProfileUserDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUserDtoToJson(this);
}
