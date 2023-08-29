class ForgotPasswordResponseModel {
  final String? message;
  ForgotPasswordResponseModel({
    required this.message,
  });

  factory ForgotPasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
    );
  }
}
