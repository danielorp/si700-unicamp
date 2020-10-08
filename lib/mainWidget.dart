import 'package:flutter/material.dart';

/*
1° Aba: foto, nome, semestre, com o que trabalho.
2° Aba: apresentação da segunda pessoa.
3° Aba: tema do trabalho da disciplina.
*/

const UPPER_TITLE = 'Exercício 1 - SI700';

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meu primeiro app!',
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: Text(UPPER_TITLE),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.collections_bookmark))
                ]),
              ),
              body: TabBarView(
                  children: [MyFirstFormWidget(), MySecondFormWidget()])),
        ));
  }
}

class LoginData {
  String username = "";
  String password = "";

  doSomething() {
    print("Username: $username");
    print("Password: $password");
    print("");
  }
}

class MyFirstFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final LoginData loginData = new LoginData();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (String inValue) {
                if (inValue.length == 0) {
                  return "Please entender username";
                }
                return null;
              },
              onSaved: (String inValue) {
                loginData.username = inValue;
              },
            ),
            TextFormField(
                obscureText: true,
                validator: (String inValue) {
                  if (inValue.length < 10) {
                    return "Password precisa ser maior do que 10 caracteres";
                  }
                  return null;
                },
                onSaved: (String inValue) {
                  loginData.password = inValue;
                }),
            RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                  }
                })
          ]),
        ));
  }
}

class SecondFormData {
  var checkboxValue = false;
  var switchValue = false;
  var sliderValue = .3;
  var radioValue = 1;

  doSomething() {
    print("Checkbox: $checkboxValue");
    print("Switch: $switchValue");
    print("Slider: $sliderValue");
    print("Radio: $radioValue");
  }
}

class MySecondFormWidget extends StatefulWidget {
  final SecondFormData otherData = new SecondFormData();

  @override
  State<StatefulWidget> createState() {
    return _MySecondFormWidgetState(otherData);
  }
}

class _MySecondFormWidgetState extends State<MySecondFormWidget> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final SecondFormData otherData;

  _MySecondFormWidgetState(this.otherData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: formKey,
          child: Column(
            children: [
              Checkbox(
                onChanged: (bool inValue) {
                  setState(() {
                    otherData.checkboxValue = inValue;
                  });
                },
                value: otherData.checkboxValue,
              ),
            ],
          )),
      padding: EdgeInsets.all(50.0),
    );
  }
}

Widget generateForm() {
  return Center(
      child: ListView(
    padding: const EdgeInsets.all(12),
    children: [
      Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/gustavo.png')),
      ),
      Text('Gustavo Eleutério da Silva',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
      Text('RA 174084',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
      Text(
          '\nCurso Analise e desenvolvimento de Sistemas, estou no 8º semestre (tive alguns probleminhas de percurso rs).\n'
          '\nAtualmente trabalho na Cielo, fazendo parte da equipe de sustentação das plataformas java. '
          'Programação propriamente dita não é o que eu mais gosto nessa área, procuro estar sempre ligado nas novas tecnologias disponíveis e no mercado tecnológico de maneira geral.\n'
          '\nNo meu tempo livre gosto de assistir séries e praticar esportes no geral!',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 1,
          ),
          textAlign: TextAlign.left),
    ],
  ));
}

Widget generateSynthaxView() {
  return Center(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      /*Padding(padding: EdgeInsets.all(30), child: Text('aaaa')),
      Container(
        padding: EdgeInsets.all(30),
        child: Text('alooo'),
        transform: new Matrix4.identity()..scale(2.0),
      ),*/

      /*ConstrainedBox(
        constraints: BoxConstraints(minWidth: 50, minHeight: 50),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text('alo'),
        ),
      )*/

      Card(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 50.0)),
              Text('InnerChild1'),
              Divider(),
              Text('InnerChild2')
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          color: Colors.blueAccent,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
    ],
  ));
}
