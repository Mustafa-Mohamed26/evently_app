class MyUser {
  static const String collectionName = 'Users';

  String id;
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  // object => json
  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name, 'email': email};
  }

  // json => object
  MyUser.fromFirestore(Map<String, dynamic> data)
    : this(
        id: data['id'] as String,
        name: data['name'] as String,
        email: data['email'] as String,
      );
}
