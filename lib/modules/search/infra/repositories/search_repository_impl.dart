import 'package:dartz/dartz.dart';
import 'package:hello_world/modules/search/domain/entities/result_search.dart';
import 'package:hello_world/modules/search/domain/errors/errors.dart';
import 'package:hello_world/modules/search/domain/repositories/search_repository.dart';
import 'package:hello_world/modules/search/infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      List languages) async {
    try {
      final result = await datasource.getSearch(languages);
      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
