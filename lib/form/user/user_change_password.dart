// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserChangePassWordFormModel {
  final String currentPassword;
  final String newPassword;
  UserChangePassWordFormModel({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}
