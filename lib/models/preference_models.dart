class Preference {
  String id;
  int repo;

  Preference({this.id, this.repo});

  Preference.fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    this.repo = map["repo"];
  }
}
