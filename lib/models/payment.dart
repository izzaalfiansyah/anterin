class Payment {
  dynamic id;
  dynamic orderId;
  String? method;
  String? status;
  num amount;
  num adminFee;
  num shippingCost;
  num total;
  String? photoNotes;
  String? photoNotesUrl;
  DateTime? createdAt;

  Payment({
    this.id,
    this.orderId,
    this.method,
    this.status,
    this.amount = 0,
    this.adminFee = 0,
    this.shippingCost = 0,
    this.total = 0,
    this.photoNotes,
    this.photoNotesUrl,
    this.createdAt,
  });

  factory Payment.fromJSON(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      orderId: map['order_id'],
      method: map['method'],
      status: map['status'],
      amount: map['amount'],
      adminFee: map['admin_fee'],
      shippingCost: map['shipping_cost'],
      total: map['total'],
      photoNotes: map['photo_notes'],
      photoNotesUrl: map['photo_notes_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'order_id': orderId,
      'method': method,
      'status': status,
      'amount': amount,
      'admin_fee': adminFee,
      'shipping_cost': shippingCost,
      'total': total,
      'photo_notes': photoNotes,
      'photo_notes_url': photoNotesUrl,
      'created_at': createdAt,
    };
  }
}
