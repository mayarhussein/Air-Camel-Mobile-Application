class Client {
  String image;
  String name;
  String email;
  String phone;

  // Constructor
  Client({
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
  });

  Client copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
  }) =>
      Client(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  static Client fromJson(Map<String, dynamic> json) => Client(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
        'phone': phone,
      };
}
