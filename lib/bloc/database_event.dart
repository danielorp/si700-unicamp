import 'package:hello_world/models/preference_models.dart';

abstract class DatabaseEvent {}

class UpdateDatabase extends DatabaseEvent {
  String preferenceId;
  String user;
  int repo;

  UpdateDatabase({this.preferenceId, this.user, this.repo});
}

class AddDatabase extends DatabaseEvent {
  String user;
  int repo;

  AddDatabase({this.user, this.repo});
}

class DeleteDatabase extends DatabaseEvent {
  String docId;
  DeleteDatabase({this.docId});
}

class ReceivedNewList extends DatabaseEvent {
  List<Preference> preferences;
  ReceivedNewList(this.preferences);
}
