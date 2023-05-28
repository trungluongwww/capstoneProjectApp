class RoomRemovePhotoFormModel {
  final String fileId;

  RoomRemovePhotoFormModel({
    required this.fileId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileId': fileId,
    };
  }
}
