class DBUser {
  final int? id;
  final String fullname;
  final String email;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;

  DBUser({
    this.id,
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
  });

  // Convert a User into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
    };
  }

  // Implement toString to make it easier to see information about each user when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, fullname: $fullname, email: $email, phoneNumber: $phoneNumber, address: $address, city: $city, state: $state}';
  }
}
