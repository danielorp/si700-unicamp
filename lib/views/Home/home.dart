import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc/auth_bloc.dart';
import 'package:hello_world/bloc/auth_event.dart';
import 'package:hello_world/bloc/auth_state.dart';
import 'package:hello_world/languageFormWidget.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/views/Home/note_entry.dart';
import 'package:hello_world/views/Home/note_list.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title, this.state}) : super(key: key);

  final String title;
  final AuthState state;

  @override
  _MyHomePageState createState() => _MyHomePageState(state);
}

class _MyHomePageState extends State<Home> {
  final AuthState state;

  _MyHomePageState(this.state);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          FlatButton.icon(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(Logout());
              },
              icon: Icon(Icons.logout),
              label: Text("Sair"))
        ],
      ),
      body: Center(child: LanguageForm(state: this.state)),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Informacoes do Usuario'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Repositórios Salvos'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DisplayResults(state: this.state)));
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
