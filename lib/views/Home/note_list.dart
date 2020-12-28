import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc/database_bloc.dart';
import 'package:hello_world/bloc/database_state.dart';
import 'package:hello_world/models/preference_models.dart';

import 'note_tile.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      builder: (context, state) {
        if (state is PreferenceDatabaseState) {
          List<Preference> list = state.preferences;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return NoteTile(note: list[index]);
              });
        } else {
          return Text("Nenhuma preferencia encontrada.");
        }
      },
    );
  }
}
