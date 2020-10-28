class RepoResult {
  final String repoUrl;
  final String name;
  final String ownerName;
  final String description;
  final Map<String, dynamic> originalRequest;

  RepoResult(
      {this.repoUrl,
      this.name,
      this.ownerName,
      this.description,
      this.originalRequest});
}

class ResultSearch {
  final String language;
  final List<RepoResult> repos;

  ResultSearch({this.language, this.repos});
}
