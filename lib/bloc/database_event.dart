import 'package:hello_world/models/preference_models.dart';

abstract class DatabaseEvent {}

class UpdateDatabase extends DatabaseEvent {
  String preferenceId;
  int repo;

  UpdateDatabase({this.preferenceId, this.repo});
}

class AddDatabase extends DatabaseEvent {
  int repo;

  AddDatabase({this.repo});
}

class DeleteDatabase extends DatabaseEvent {
  String docId;
  DeleteDatabase({this.docId});
}

class ReceivedNewList extends DatabaseEvent {
  List<Preference> preferences;
  ReceivedNewList(this.preferences);
}
