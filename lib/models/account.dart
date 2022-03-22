class Account {
  final String? id;
  String firstName;
  String lastName;
  String email;
  String password;
  String phoneNumber;
  final String role;
  String? image;

  Account(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.role,
      this.image});
}
