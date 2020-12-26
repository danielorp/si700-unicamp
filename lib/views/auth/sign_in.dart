import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/firebase/auth.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginForm();
  }
}

class _LoginForm extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuthenticationService service = FirebaseAuthenticationService();
  String user = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Usuário',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira o nome de usuário!';
                      }
                      this.user = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      hintText: 'Senha',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira a senha do usuário!';
                      }
                      this.password = value;
                      return null;
                    },
                  )
                ],
              )),
          ElevatedButton(
            onPressed: () async {
              try {
                if (_formKey.currentState.validate()) {
                  service.signInWithEmailAndPassword(
                      email: this.user, password: this.password);
                }
              } catch (e) {
                print('deu ruim');
              }
            },
            child: Text('Logar usuário'),
          )
        ]));
  }
}
