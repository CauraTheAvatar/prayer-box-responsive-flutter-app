import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rx<User?> currentUser  = Rx<User?>(null);
  final RxBool    isLoading    = false.obs;
  final RxString  errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.bindStream(_auth.authStateChanges());
    ever(currentUser, _handleAuthStateChange);
  }

  void _handleAuthStateChange(User? user) {
    if (user != null) {
      Get.offAllNamed(AppRoutes.landing);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value    = true;
      errorMessage.value = '';

      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email:    email.trim(),
        password: password.trim(),
      );

      // Store username in Firebase Auth profile only — no Firestore
      await credential.user!.updateDisplayName(username.trim());

      // Force refresh so displayName is available immediately
      await credential.user!.reload();
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _mapFirebaseError(e.code);
    } catch (e) {
      errorMessage.value = AppStrings.errorGeneric;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value    = true;
      errorMessage.value = '';

      await _auth.signInWithEmailAndPassword(
        email:    email.trim(),
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

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      errorMessage.value = AppStrings.errorGeneric;
    }
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 8 characters, including a number and a special character.';
      case 'user-not-found':
        return 'No account found with this email.';
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