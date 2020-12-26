import 'package:hello_world/models/preference_models.dart';

abstract class DatabaseEvent {}

class UpdateDatabase extends DatabaseEvent {
  String preferenceId;
  String user;
  String language;

  UpdateDatabase({this.preferenceId, this.user, this.language});
}

class AddDatabase extends DatabaseEvent {
  String user;
  String language;

  AddDatabase({this.user, this.language});
}

class DeleteDatabase extends DatabaseEvent {
  String docId;
  DeleteDatabase({this.docId});
}

class ReceivedNewList extends DatabaseEvent {
  List<Preference> preferences;
  ReceivedNewList(this.preferences);
}
