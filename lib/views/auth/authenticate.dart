import 'package:hello_world/views/auth/register.dart';
import 'package:hello_world/views/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc/auth_bloc.dart';
import 'package:hello_world/bloc/auth_event.dart';

import '../../main.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text(appTitle),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.login)),
                  Tab(icon: Icon(Icons.person_add))
                ])),
            body: TabBarView(children: [Login(), Register()])));
  }
}
