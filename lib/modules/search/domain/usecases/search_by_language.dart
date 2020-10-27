import 'package:hello_world/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:hello_world/modules/search/domain/errors/errors.dart';
import 'package:hello_world/modules/search/domain/repositories/search_repository.dart';

abstract class SearchByLanguage {
  Future<Either<FailureSearch, List<ResultSearch>>> call(List languages);
}

class SearchByLanguageImpl implements SearchByLanguage {
  final SearchRepository repository;

  SearchByLanguageImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(List languages) async {
    if (languages == null) {
      return Left(InvalidLanguageListError());
    }
    return await repository.search(languages);
  }
}