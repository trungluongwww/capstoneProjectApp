import 'package:roomeasy/form/file/file.dart';

class MessageCreateFormModel {
  final String? content;
  final String type;
  final FileFormModel? file;
  final String? roomId;
  MessageCreateFormModel({
    this.content,
    required this.type,
    this.file,
    this.roomId,
  });

  MessageCreateFormModel copyWith({
    String? content,
    String? type,
    FileFormModel? file,
    String? roomId,
  }) {
    return MessageCreateFormModel(
      content: content ?? this.content,
      type: type ?? this.type,
      file: file ?? this.file,
      roomId: roomId ?? this.roomId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'type': type,
      'file': file?.toMap(),
      'roomId': roomId,
    };
  }
}
