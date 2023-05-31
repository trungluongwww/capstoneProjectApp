class RoomChangeStatusFormModel {
  final String status;

  RoomChangeStatusFormModel({
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }
}
