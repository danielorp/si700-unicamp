import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc/database_bloc.dart';
import 'package:hello_world/bloc/database_event.dart';
import 'package:hello_world/models/preference_models.dart';

class NoteEntry extends StatelessWidget {
  final GlobalKey<FormState> formKey = new GlobalKey();
  final Preference inModel = Preference();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: addNoteFormulario(context),
    );
  }

  Widget addNoteFormulario(BuildContext context) {
    bool is_checked = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  validator: (value) {
                    if (value.length == 0) {
                      return "Insira um título para a anotação";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    //inModel.title = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Título", labelText: "Título da anotação")),
              TextFormField(
                  validator: (value) {
                    if (value.length == 0) {
                      return "Por favor insira a descrição";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    //inModel.description = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Descrição", labelText: "Descrição")),
              RaisedButton(
                  child: Text("Inserir"),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      // BlocProvider.of<DatabaseBloc>(context).add(AddDatabase(
                      //     title: inModel.title,
                      //     description: inModel.description,
                      //     done: false));
                      formKey.currentState.reset();
                    }
                  })
            ],
          ));
    });
  }
}
