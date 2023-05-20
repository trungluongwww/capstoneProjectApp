// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/convenience/convenience.dart';

class ConvenienceResponseModel {
  List<ConvenienceModel> conveniences;
  ConvenienceResponseModel({
    required this.conveniences,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conveniences': conveniences.map((x) => x.toMap()).toList(),
    };
  }

  factory ConvenienceResponseModel.fromMap(Map<String, dynamic> map) {
    return ConvenienceResponseModel(
      conveniences: List<ConvenienceModel>.from(
        (map['conveniences'] as List<dynamic>).map<ConvenienceModel>(
          (x) => ConvenienceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConvenienceResponseModel.fromJson(String source) =>
      ConvenienceResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
