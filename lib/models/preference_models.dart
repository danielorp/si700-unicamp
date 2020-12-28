class Preference {
  String id;
  String user;
  String repo;

  Preference({this.id, this.user, this.repo});

  Preference.fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    this.user = map["user"];
    this.repo = map["repo"];
  }
}
