import 'package:basic_e_commerce_app/cubit/navigation/navigation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('NavigationCubit Tests', () {
    late NavigationCubit navigationCubit;

    setUp(() {
      navigationCubit = NavigationCubit();
    });

    tearDown(() {
      navigationCubit.close();
    });

    test('initial state is 0', () {
      expect(navigationCubit.state, 0);
    });

    blocTest<NavigationCubit, int>(
      'emits [1] when setIndex(1) is called',
      build: () => navigationCubit,
      act: (cubit) => cubit.setIndex(1),
      expect: () => [1],
    );

    blocTest<NavigationCubit, int>(
      'emits [2, 0] when setIndex(2) then setIndex(0) are called',
      build: () => navigationCubit,
      act: (cubit) {
        cubit.setIndex(2);
        cubit.setIndex(0);
      },
      expect: () => [2, 0],
    );
  });
}
