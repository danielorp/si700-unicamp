import 'dart:convert';

import 'package:hello_world/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String repoUrl;
  final String name;
  final String ownerName;
  final String description;
  final String language;

  ResultSearchModel(
      {this.repoUrl,
      this.name,
      this.ownerName,
      this.description,
      this.language});

  Map<String, dynamic> toMap() {
    return {
      'repoUrl': repoUrl,
      'name': name,
      'ownerName': ownerName,
      'description': description,
      'language': language
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
        repoUrl: map['repoUrl'],
        name: map['name'],
        ownerName: map['ownerName'],
        description: map['description'],
        language: map['language']);
  }

  String toJson() => json.encode(toMap());

  static ResultSearchModel fromJson(String source) =>
      fromMap(json.decode(source));
}
