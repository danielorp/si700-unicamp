class Preference {
  String id;
  String user;
  String language;

  Preference({this.id, this.user, this.language});

  Preference.fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    this.user = map["user"];
    this.language = map["language"];
  }
}
