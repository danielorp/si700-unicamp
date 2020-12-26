import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hello_world/bloc/database_event.dart';
import 'package:hello_world/bloc/database_state.dart';
import 'package:hello_world/firebase/database.dart';
import 'package:hello_world/models/preference_models.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseService _databaseService;
  StreamSubscription _databaseSubscription;

  DatabaseBloc(String uid) : super(UnAuthenticatedDatabaseState()) {
    _databaseService = DatabaseService(uid: uid);
    _databaseSubscription =
        _databaseService.preferences.listen((List<Preference> event) {
      add(ReceivedNewList(event));
    });
  }

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    if (event is AddDatabase) {
      _databaseService.addPreference(event.user, event.language);
    } else if (event is DeleteDatabase) {
      _databaseService.removePreference(event.docId);
    } else if (event is UpdateDatabase) {
      _databaseService.updatePreference(
          event.preferenceId, event.user, event.language);
    } else if (event is ReceivedNewList) {
      yield NoteDatabaseState(event.preferences);
    }
  }

  @override
  Future<void> close() {
    _databaseSubscription.cancel();
    return super.close();
  }
}
