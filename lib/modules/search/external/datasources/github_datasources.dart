import 'dart:convert';

import 'package:hello_world/modules/search/domain/errors/errors.dart';
import 'package:hello_world/modules/search/infra/datasources/search_datasource.dart';
import 'package:hello_world/modules/search/infra/models/result_search_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GithubDatasource implements SearchDataSource {
  @override
  Future<List<ResultSearchModel>> getSearch(List languages) async {
    // API do Github não suporta o operador OR, então temos que realizar cada consulta por linguagem individualmente.
    final List<Response> responses = [];
    for (var language in languages) {
      responses.add(await http.get(
          "https://api.github.com/search/repositories?q=language:${language}&page=1&sort=stars"));
    }
    final List<ResultSearchModel> list = [];
    for (var response in responses) {
      try {
        if (response.statusCode == 200) {
          final jsoned = json.decode(response.body);
          for (var item in jsoned['items']) {
            list.add(ResultSearchModel.fromJson(item));
          }
        }
      } catch (e) {
        print(e);
      }
    }

    final anyResponseIs200 = (Response s) => s.statusCode == 200;
    if (responses.any(anyResponseIs200)) {
      return list;
    } else {
      throw DatasourceError();
    }
  }
}
