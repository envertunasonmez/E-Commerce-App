import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth auth;

  RegisterCubit({FirebaseAuth? firebaseAuth})
      : auth = firebaseAuth ?? FirebaseAuth.instance,
        super(const RegisterState());

  Future<void> register(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await auth.signOut();

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    }
  }
}
