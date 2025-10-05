import 'package:basic_e_commerce_app/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('PasswordVisibilityCubit Tests', () {
    late PasswordVisibilityCubit cubit;

    setUp(() {
      cubit = PasswordVisibilityCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is true (password hidden)', () {
      expect(cubit.state, true);
    });

    blocTest<PasswordVisibilityCubit, bool>(
      'emits [false] when toggle is called once',
      build: () => cubit,
      act: (cubit) => cubit.toggle(),
      expect: () => [false],
    );

    blocTest<PasswordVisibilityCubit, bool>(
      'emits [false, true] when toggle is called twice',
      build: () => cubit,
      act: (cubit) {
        cubit.toggle();
        cubit.toggle();
      },
      expect: () => [false, true],
    );
  });
}
