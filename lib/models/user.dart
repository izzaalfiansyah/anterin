class User {
  dynamic id;
  String name;
  String email;
  String? password;
  String phone;
  String? whatsappNumber;
  String? whatsappNumberUrl;
  dynamic provinceId;
  dynamic regencyId;
  dynamic districtId;
  String? address;
  String? role;
  DateTime? emailVerifiedAt;

  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    this.whatsappNumber,
    this.whatsappNumberUrl,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.address,
    this.role,
    this.emailVerifiedAt,
  });

  factory User.fromJSON(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      whatsappNumber: map['whatsapp_number'],
      whatsappNumberUrl: map['whatsapp_number_url'],
      provinceId: map['province_id'],
      regencyId: map['regency_id'],
      districtId: map['district_id'],
      address: map['address'],
      role: map['role'],
      emailVerifiedAt: map['email_verified_at'] != null
          ? DateTime.parse(map['email_verified_at'])
          : null,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'whatsapp_number': whatsappNumber,
      'whatsapp_number_url': whatsappNumberUrl,
      'province_id': provinceId,
      'regency_id': regencyId,
      'district_id': districtId,
      'address': address,
      'role': role,
      'email_verified_at': emailVerifiedAt,
    };
  }
}
