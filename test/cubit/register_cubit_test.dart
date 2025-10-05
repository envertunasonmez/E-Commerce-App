import 'package:basic_e_commerce_app/cubit/auth/register/register_cubit.dart';
import 'package:basic_e_commerce_app/cubit/auth/register/register_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockAuth;
  late RegisterCubit cubit;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    cubit = RegisterCubit(firebaseAuth: mockAuth);
  });

  const testEmail = 'test@example.com';
  const testPassword = 'password123';

  blocTest<RegisterCubit, RegisterState>(
    'emits [loading, success] when registration is successful',
    setUp: () {
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async => MockUserCredential());

      when(() => mockAuth.signOut()).thenAnswer((_) async => {});
    },
    build: () => cubit,
    act: (cubit) async => cubit.register(testEmail, testPassword),
    expect: () => [
      const RegisterState(isLoading: true),
      const RegisterState(isLoading: false, isSuccess: true),
    ],
  );

  blocTest<RegisterCubit, RegisterState>(
    'emits [loading, error] when registration fails',
    setUp: () {
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenThrow(FirebaseAuthException(
              code: 'email-already-in-use', message: 'Email already in use'));
    },
    build: () => cubit,
    act: (cubit) async => cubit.register(testEmail, testPassword),
    expect: () => [
      const RegisterState(isLoading: true),
      const RegisterState(isLoading: false, errorMessage: 'Email already in use'),
    ],
  );
}
