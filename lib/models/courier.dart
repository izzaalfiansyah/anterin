class Courier {
  dynamic id;
  dynamic userId;
  num mapLat;
  num mapLng;

  Courier({
    this.id,
    required this.userId,
    this.mapLat = 0,
    this.mapLng = 0,
  });

  factory Courier.fromJSON(Map<String, dynamic> map) {
    return Courier(
      id: map['id'],
      userId: map['user_id'],
      mapLat: map['map_lat'],
      mapLng: map['map_lng'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'user_id': userId,
      'map_lat': mapLat,
      'map_lng': mapLng,
    };
  }
}
