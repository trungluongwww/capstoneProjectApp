import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class KeyValueModel {
  final String? key;
  final String? value;
  final String? option;
  final bool? isDefault;

  KeyValueModel({
    this.key,
    this.value,
    this.option,
    this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
      'option': option,
      'isDefault': isDefault,
    };
  }

  factory KeyValueModel.fromMap(Map<String, dynamic> map) {
    return KeyValueModel(
      key: map['key'] != null ? map['key'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      option: map['option'] != null ? map['option'] as String : null,
      isDefault: map['isDefault'] != null ? map['isDefault'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyValueModel.fromJson(String source) =>
      KeyValueModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
