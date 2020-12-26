import 'package:hello_world/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/firebase/auth.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterForm();
  }
}

class _RegisterForm extends State<Register> {
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
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira o nome de usuário!';
                        }
                        this.user = value;
                        return null;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        hintText: 'Senha',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira uma senha para o usuário!';
                        }
                        this.password = value;
                        return null;
                      })
                ],
              )),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                try {
                  UserModel register =
                      await service.createUserWithEmailAndPassword(
                          email: this.user, password: this.password);
                } catch (e) {
                  final snackBar = SnackBar(content: Text(e.message));
                  Scaffold.of(context).showSnackBar(snackBar);
                  return;
                }
                final snackBar =
                    SnackBar(content: Text('Usuário cadastrado com sucesso!'));
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            child: Text('Cadastrar Usuário'),
          )
        ]));
  }
}
