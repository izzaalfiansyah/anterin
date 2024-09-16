class Order {
  dynamic id;
  dynamic userId;
  dynamic courierId;
  String description;
  String? status;
  String pickupAddress;
  String? pickupMapAddress;
  num pickupMapLat;
  num pickupMapLng;
  String deliveryAddress;
  String? deliveryMapAddress;
  num deliveryMapLat;
  num deliveryMapLng;
  num distance;
  DateTime? schedule;
  String? reason;
  dynamic courier;
  dynamic payment;

  Order({
    this.id,
    this.userId,
    this.courierId,
    required this.description,
    this.status,
    required this.pickupAddress,
    this.pickupMapAddress,
    this.pickupMapLat = 0,
    this.pickupMapLng = 0,
    required this.deliveryAddress,
    this.deliveryMapAddress,
    this.deliveryMapLat = 0,
    this.deliveryMapLng = 0,
    this.distance = 0,
    this.schedule,
    this.reason,
    this.courier,
    this.payment,
  });

  factory Order.fromJSON(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['user_id'],
      courierId: map['courier_id'],
      description: map['description'],
      status: map['status'],
      pickupAddress: map['pickup_address'],
      pickupMapAddress: map['pickup_map_address'],
      pickupMapLat: map['pickup_map_lat'],
      pickupMapLng: map['pickup_map_lng'],
      deliveryAddress: map['delivery_address'],
      deliveryMapAddress: map['delivery_map_address'],
      deliveryMapLat: map['delivery_map_lat'],
      deliveryMapLng: map['delivery_map_lng'],
      distance: map['distance'],
      schedule:
          DateTime.parse(map['schedule'] ?? DateTime.now().toIso8601String()),
      reason: map['reason'],
      courier: map['courier'],
      payment: map['payment'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'user_id': userId,
      'courier_id': courierId,
      'description': description,
      'status': status,
      'pickup_address': pickupAddress,
      'pickup_map_address': pickupMapAddress,
      'pickup_map_lat': pickupMapLat,
      'pickup_map_lng': pickupMapLng,
      'delivery_address': deliveryAddress,
      'delivery_map_address': deliveryMapAddress,
      'delivery_map_lat': deliveryMapLat,
      'delivery_map_lng': deliveryMapLng,
      'distance': distance,
      'schedule': schedule?.toIso8601String(),
      'reason': reason,
      'courier': courier,
      'payment': payment,
    };
  }
}
