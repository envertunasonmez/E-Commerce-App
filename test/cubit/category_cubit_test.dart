import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:basic_e_commerce_app/cubit/category/category_cubit.dart';
import 'package:basic_e_commerce_app/data/repositories/product_repository.dart';

// Mock Repository
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late CategoryCubit categoryCubit;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    categoryCubit = CategoryCubit(mockRepository);
  });

  tearDown(() {
    categoryCubit.close();
  });

  final categories = [
    'electronics',
    'jewelery',
    'men clothing',
    'women clothing',
  ];

  group('CategoryCubit Tests', () {
    blocTest<CategoryCubit, List<String>>(
      'emits categories when loadCategories is successful',
      build: () {
        when(
          () => mockRepository.getCategories(),
        ).thenAnswer((_) async => categories);
        return categoryCubit;
      },
      act: (cubit) => cubit.loadCategories(),
      expect: () => [categories],
      verify: (_) => verify(() => mockRepository.getCategories()).called(1),
    );

    blocTest<CategoryCubit, List<String>>(
      'emits empty list when repository throws an exception',
      build: () {
        when(
          () => mockRepository.getCategories(),
        ).thenThrow(Exception('Failed to fetch'));
        return categoryCubit;
      },
      act: (cubit) async {
        try {
          await cubit.loadCategories();
        } catch (_) {}
      },
      expect: () => [], // No categories emitted on failure, state remains []
    );
  });
}

