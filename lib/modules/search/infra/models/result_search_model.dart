import 'dart:convert';

import 'package:hello_world/modules/search/domain/entities/result_search.dart';

class RepoResultModel extends RepoResult {
  final String id;
  final String repoUrl;
  final String name;
  final String ownerName;
  final String description;
  final int stars;
  final Map<String, dynamic> originalRequest;

  RepoResultModel(
      {this.id,
      this.repoUrl,
      this.name,
      this.ownerName,
      this.description,
      this.stars,
      this.originalRequest});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'repoUrl': repoUrl,
      'name': name,
      'ownerName': ownerName,
      'description': description,
      'stars': stars
    };
  }

  static RepoResultModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RepoResultModel(
        id: map['id'] != null ? map['id'] : '',
        repoUrl: map['html_url'] != null ? map['html_url'] : '',
        name: map['name'] != null ? map['name'] : '',
        ownerName: map['owner']['login'] != null ? map['owner']['login'] : '',
        description: map['description'] != null ? map['description'] : '',
        stars: map['stargazers_count'],
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

  static ResultSearchModel fromRepos(List<RepoResultModel> repos) {
    final sorting = sortByStars(repos);
    return fromMap(sorting);
  }

  static sortByStars(List<RepoResultModel> repos) {
    repos.sort((a, b) => (b.stars).compareTo(a.stars));
    return repos;
  }
}
