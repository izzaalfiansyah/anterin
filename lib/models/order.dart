class Order {
  dynamic userId;
  dynamic courierId;
  String description;
  String? status;
  String pickupAddress;
  num pickupMapLat;
  num pickupMapLng;
  String deliveryAddress;
  num deliveryMapLat;
  num deliveryMapLng;
  DateTime? schedule;
  String? reason;
  dynamic courier;
  dynamic payment;

  Order({
    this.userId,
    this.courierId,
    required this.description,
    this.status,
    required this.pickupAddress,
    required this.pickupMapLat,
    required this.pickupMapLng,
    required this.deliveryAddress,
    required this.deliveryMapLat,
    required this.deliveryMapLng,
    this.schedule,
    this.reason,
    this.courier,
    this.payment,
  });

  factory Order.fromJSON(Map<String, dynamic> map) {
    return Order(
      userId: map['user_id'],
      courierId: map['courier_id'],
      description: map['description'],
      status: map['status'],
      pickupAddress: map['pickup_address'],
      pickupMapLat: map['pickup_map_lat'],
      pickupMapLng: map['pickup_map_lng'],
      deliveryAddress: map['deliveryAddress'],
      deliveryMapLat: map['delivery_map_lat'],
      deliveryMapLng: map['delivery_map_lng'],
      schedule: map['schedule'],
      reason: map['reason'],
      courier: map['courier'],
      payment: map['payment'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'user_id': userId,
      'courier_id': courierId,
      'description': description,
      'status': status,
      'pickup_address': pickupAddress,
      'pickup_map_lat': pickupMapLat,
      'pickup_map_lng': pickupMapLng,
      'deliveryAddress': deliveryAddress,
      'delivery_map_lat': deliveryMapLat,
      'delivery_map_lng': deliveryMapLng,
      'schedule': schedule,
      'reason': reason,
      'courier': courier,
      'payment': payment,
    };
  }
}
