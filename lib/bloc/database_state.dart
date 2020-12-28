import 'package:hello_world/models/preference_models.dart';

abstract class DatabaseState {}

class UnAuthenticatedDatabaseState extends DatabaseState {}

class PreferenceDatabaseState extends DatabaseState {
  List<Preference> preferences;
  PreferenceDatabaseState(this.preferences);
}
