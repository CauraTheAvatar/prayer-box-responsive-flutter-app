import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // reactive current user
  final Rx<User?> currentUser = Rx<User?>(null);

  // reactive loading state
  final RxBool isLoading = false.obs;

  // reactive error message
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // bind stream so currentUser updates automatically
    currentUser.bindStream(_auth.authStateChanges());

    // navigate based on auth state
    ever(currentUser, _handleAuthStateChange);
  }

  // auth state handler
  void _handleAuthStateChange(User? user) {
    if (user != null) {
      Get.offAllNamed(AppRoutes.landing);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  // SIGN UP
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // save user profile to Firestore
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'uid': credential.user!.uid,
        'username': username.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'notificationsEnabled': true,
      });

      // update display name
      await credential.user!.updateDisplayName(username.trim());
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _mapFirebaseError(e.code);
    } catch (e) {
      errorMessage.value = AppStrings.errorGeneric;
    } finally {
      isLoading.value = false;
    }
  }

  // LOGIN
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _auth.signInWithEmailAndPassword(
        email: email.trim(), 
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _mapFirebaseError(e.code);
    } catch (e) {
      errorMessage.value = AppStrings.errorGeneric;
    } finally {
      isLoading.value = false;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      errorMessage.value = AppStrings.errorGeneric;
    }
  }

  // Maps firebase error codes to readable messages
  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 8 characters, including a number and a special character.';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      default:
        return AppStrings.errorGeneric;
    }
  }
}