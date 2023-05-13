import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModel<T> {
  final String? message;
  final T? data;
  int? code;

  ResponseModel({
    this.message,
    this.data,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': data,
      'code': code,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map, int? code) {
    return ResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null ? map['data'] as T : null,
      code: code,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source, int? code) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>, code);

  bool isSuccess() {
    return this.code.toString().startsWith('2');
  }
}
