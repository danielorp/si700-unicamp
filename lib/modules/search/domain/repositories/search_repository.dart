import 'package:dartz/dartz.dart';
import 'package:hello_world/modules/search/domain/entities/result_search.dart';
import 'package:hello_world/modules/search/domain/errors/errors.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(List language);
}
