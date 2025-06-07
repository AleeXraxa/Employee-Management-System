class UserModel {
  final String uid;
  final String username;
  final String fname;
  final String lname;
  final String email;
  final String role;
  final bool isApproved;

  UserModel({
    required this.uid,
    required this.username,
    required this.fname,
    required this.lname,
    required this.email,
    required this.role,
    required this.isApproved,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      username: data['username'],
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      role: data['role'],
      isApproved: data['isApproved'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'fname': fname,
      'lname': lname,
      'email': email,
      'role': role,
      'isApproved': isApproved,
    };
  }
}
