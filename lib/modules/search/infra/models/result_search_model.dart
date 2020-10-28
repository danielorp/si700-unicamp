import 'dart:convert';

import 'package:hello_world/modules/search/domain/entities/result_search.dart';

class RepoResultModel extends RepoResult {
  final String repoUrl;
  final String name;
  final String ownerName;
  final String description;
  final Map<String, dynamic> originalRequest;

  RepoResultModel(
      {this.repoUrl,
      this.name,
      this.ownerName,
      this.description,
      this.originalRequest});

  Map<String, dynamic> toMap() {
    return {
      'repoUrl': repoUrl,
      'name': name,
      'ownerName': ownerName,
      'description': description
    };
  }

  static RepoResultModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RepoResultModel(
        repoUrl: map['url'],
        name: map['name'],
        ownerName: map['owner']['login'],
        description: map['description'],
        originalRequest: map);
  }

  String toJson() => json.encode(toMap());

  static RepoResultModel fromJson(Map source) => fromMap(source);
}

class ResultSearchModel extends ResultSearch {
  final String language;
  final List<RepoResultModel> repos;

  ResultSearchModel({this.language, this.repos});

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'repos': repos,
    };
  }

  static ResultSearchModel fromMap(List<RepoResultModel> repos) {
    if (repos == null || repos == []) return null;

    return ResultSearchModel(
        language: repos[0].originalRequest['language'],
        repos: new List<RepoResultModel>.from(repos));
  }

  String toJson() => json.encode(toMap());

  static ResultSearchModel fromRepos(List<RepoResultModel> repos) =>
      fromMap(repos);
}
