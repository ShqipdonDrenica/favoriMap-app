import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String profilePicture;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      profilePicture: map['profile_picture'] ?? '',
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    // Assuming Firebase user's display name is in the format "First Last"
    List<String> nameParts = user.displayName?.split(' ') ?? ['', ''];
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName = nameParts.length > 1 ? nameParts[1] : '';

    return UserModel(
      firstName: firstName,
      lastName: lastName,
      email: user.email ?? '',
      profilePicture:
          user.photoURL ?? '', // You can adjust this based on your needs
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_picture': profilePicture,
    };
  }
}
