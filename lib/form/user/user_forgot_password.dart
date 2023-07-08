class UserForgotPasswordFormModel {
  final String email;
  UserForgotPasswordFormModel({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }
}
