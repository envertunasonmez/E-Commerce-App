import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:basic_e_commerce_app/cubit/auth/login/login_cubit.dart';
import 'package:basic_e_commerce_app/cubit/auth/login/login_state.dart';

// Mock classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockAuth;
  late LoginCubit loginCubit;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    loginCubit = LoginCubit(auth: mockAuth);
  });

  group('LoginCubit Tests', () {
    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] when login is successful',
      build: () {
        when(
          () => mockAuth.signInWithEmailAndPassword(
            email: 'test@test.com',
            password: '123456',
          ),
        ).thenAnswer((_) async => MockUserCredential());

        return loginCubit;
      },
      act: (cubit) => cubit.login('test@test.com', '123456'),
      expect: () => [
        const LoginState(isLoading: true),
        const LoginState(isLoading: false, isSuccess: true),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, error] when login fails',
      build: () {
        when(
          () => mockAuth.signInWithEmailAndPassword(
            email: 'wrong@test.com',
            password: 'wrongpassword',
          ),
        ).thenThrow(
          FirebaseAuthException(
            code: 'user-not-found',
            message: 'User not found',
          ),
        );

        return loginCubit;
      },
      act: (cubit) => cubit.login('wrong@test.com', 'wrongpassword'),
      expect: () => [
        const LoginState(isLoading: true),
        const LoginState(isLoading: false, errorMessage: 'User not found'),
      ],
    );
  });
}
