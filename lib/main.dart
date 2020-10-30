import 'package:flutter/material.dart';
import 'mainWidget.dart';
import 'languageFormWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UPPER_TITLE, // Como é mostrado no celular em si.
      theme: ThemeData.dark(),
      home: InitialForm(
          title:
              UPPER_TITLE), // Geralmente coloca-se um Scaffold nesse lugar, será a tela primeira que aparecerá
    );
  }
}

class InitialForm extends StatefulWidget {
  InitialForm({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _InitialFormState createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[LanguageForm()],
        ));
  }
}
