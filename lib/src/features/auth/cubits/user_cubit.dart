import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favori_map/src/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Define user states
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded(this.user);
}

class UserLoggedOut extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

// UserCubit class
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> fetchUserData() async {
    if (user != null) {
      try {
        emit(UserLoading());
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        if (userDoc.exists) {
          emit(UserLoaded(
              UserModel.fromMap(userDoc.data() as Map<String, dynamic>)));
        } else {
          emit(UserError('User data not found'));
        }
      } catch (e) {
        emit(UserError('Failed to fetch user data: $e'));
      }
    } else {
      emit(UserError('No user is logged in'));
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      emit(UserLoggedOut()); // Emit UserLoggedOut state after sign out
    } catch (e) {
      emit(UserError('Failed to sign out: $e')); // Handle error
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(UserLoading());
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(UserLoaded(UserModel.fromFirebaseUser(_firebaseAuth.currentUser!)));
    } on FirebaseAuthException catch (e) {
      emit(UserError(e.message ?? 'An unknown error occurred'));
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String firstName,
    String lastName,
    String profilePicture,
  ) async {
    try {
      emit(UserLoading());
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = _firebaseAuth.currentUser!;
      await user.updateDisplayName('$firstName $lastName');
      await user.updatePhotoURL(profilePicture);

      // Save additional user data to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'profile_picture': profilePicture,
      });
      await fetchUserData();
      emit(UserLoaded(UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        profilePicture: profilePicture,
      )));
    } on FirebaseAuthException catch (e) {
      emit(UserError(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      emit(UserError('Failed to create user: $e'));
    }
  }

  void checkCurrentUser() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(UserLoaded(UserModel.fromFirebaseUser(user)));
    } else {
      emit(UserInitial());
    }
  }
}
