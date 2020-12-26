import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc/database_bloc.dart';
import 'package:hello_world/bloc/database_event.dart';
import 'package:hello_world/models/preference_models.dart';

class NoteTile extends StatelessWidget {
  final Preference note;

  const NoteTile({this.note}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
            // margin: EdgeInsets.all(10),
            // child: ListTile(
            //   leading: CircleAvatar(
            //     backgroundColor: Colors.blue[note.done ? 100 : 1],
            //   ),
            //   title: Text(note.title),
            //   subtitle: Text(note.description),
            //   trailing: GestureDetector(
            //       child: note.done ? Icon(Icons.delete) : Icon(Icons.check),
            //       onTap: () {
            //         if (note.done) {
            //           BlocProvider.of<DatabaseBloc>(context)
            //               .add(DeleteDatabase(docId: note.id));
            //         } else {
            //           BlocProvider.of<DatabaseBloc>(context).add(UpdateDatabase(
            //               description: note.description,
            //               done: true,
            //               noteId: note.id,
            //               title: note.title));
            //         }
            //       }),
            // ),
            ));
  }
}
