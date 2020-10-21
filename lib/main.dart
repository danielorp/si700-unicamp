import 'package:flutter/material.dart';
import 'mainWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Como é mostrado no celular em si.
      theme: ThemeData.dark(),
      home: InitialForm(
          title:
              UPPER_TITLE), // Geralmente coloca-se um Scaffold nesse lugar, será a tela primeira que aparecerá
    );
  }
}

class InitialForm extends StatefulWidget {
  InitialForm({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _InitialFormState createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm> {
  void _submitInitialForm() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => MyInnerApp()));
    });
  }

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
