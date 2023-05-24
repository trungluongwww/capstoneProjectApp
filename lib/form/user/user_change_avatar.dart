// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserChangeAvatarFormModel {
  final String avatar;
  UserChangeAvatarFormModel({
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar,
    };
  }
}
