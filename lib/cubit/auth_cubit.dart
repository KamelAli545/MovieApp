import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    checkSession();
  }

  final _auth = FirebaseAuth.instance;

  void checkSession() {
    final user = _auth.currentUser;
    emit(user == null ? AuthInitial() : AuthAuthenticated());
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      emit(AuthAuthenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Something went wrong'));
    }
  }

  Future<void> register(String namee,String email, String password) async {
    emit(AuthLoading());
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await cred.user?.updateDisplayName(namee.trim());

      emit(AuthAuthenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Something went wrong'));
    }
  }
  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthInitial());
  }
}