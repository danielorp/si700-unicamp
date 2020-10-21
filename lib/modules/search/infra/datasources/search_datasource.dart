import 'package:hello_world/modules/search/infra/models/result_search_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchModel>> getSearch(List language);
}

class SearchGithub implements SearchDataSource {
  @override
  Future<List<ResultSearchModel>> getSearch(List language) async {
    List resultsearchmodel = [];
    resultsearchmodel.add(ResultSearchModel());
    return resultsearchmodel;
  }
}
