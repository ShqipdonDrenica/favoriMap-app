import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String profilePicture,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Save additional user data to Firestore
    await _firestore.collection('users').doc(userCredential.user?.uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_picture': profilePicture,
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
