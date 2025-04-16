import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/kick/category.dart';
import 'package:irllink/src/domain/repositories/kick_repository.dart';

class KickCategoriesParams {
  final String? searchQuery;
  final int? page;

  const KickCategoriesParams({
    this.searchQuery,
    this.page,
  });
}

class GetCategoriesUseCase
    implements
        UseCase<Either<Failure, List<KickCategory>>, KickCategoriesParams> {
  final KickRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<KickCategory>>> call({
    required KickCategoriesParams params,
  }) {
    return repository.getCategories(
      searchQuery: params.searchQuery,
      page: params.page,
    );
  }
}
