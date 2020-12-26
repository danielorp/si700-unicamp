import 'package:hello_world/models/preference_models.dart';

abstract class DatabaseState {}

class UnAuthenticatedDatabaseState extends DatabaseState {}

class NoteDatabaseState extends DatabaseState {
  List<Preference> notes;
  NoteDatabaseState(this.notes);
}
