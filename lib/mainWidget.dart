import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

/*
1° Aba: foto, nome, semestre, com o que trabalho.
2° Aba: apresentação da segunda pessoa.
3° Aba: tema do trabalho da disciplina.
*/

const UPPER_TITLE = 'Exercício 2 - SI700';
const DANIEL_DESCRICAO =
    '\nAtualmente curso Análise e Desenvolvimento de Sistemas, estando em meu sexto semestre.'
    '\n\nTenho especial predileção por programar em Python e Javascript, que são também as linguagens utilizadas '
    'nos projetos nos quais me insiro em meu trabalho, no Itaú Unibanco, estando em uma coordenação que desenvolve soluções '
    'de software para monitoração da rede/networking. '
    '\n\nEm meu tempo livre, gosto de estudar Linux e praticar violão e piano. Sou apaixonado por música, especialmente no que '
    'tange à gravação digital, sintetizadores, simulação e geração de instrumentos virtuais, utilização de controladores MIDI, etc.';
const GUSTAVO_DESCRICAO =
    '\nCurso Analise e desenvolvimento de Sistemas, estou no 8º semestre (tive alguns probleminhas de percurso rs).\n'
    '\nAtualmente trabalho na Cielo, fazendo parte da equipe de sustentação das plataformas java. '
    'Programação propriamente dita não é o que eu mais gosto nessa área, procuro estar sempre ligado nas novas tecnologias disponíveis e no mercado tecnológico de maneira geral.\n'
    '\nNo meu tempo livre gosto de assistir séries e praticar esportes no geral!';

class MyInnerApp extends StatefulWidget {
  MyInnerApp({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyInnerApp> {
  int _currentPage;
  var _pages;

  @override
  void initState() {
    super.initState();

    _currentPage = 0;
    _pages = [
      //Container(child: Text("Page 1 - Anúncios")),
      GenerateProfileView(
          imagePath: 'assets/images/daniel.png',
          nome: 'Daniel Orpinelli',
          ra: 'RA 169482',
          descricao: DANIEL_DESCRICAO),

      GenerateProfileView(
        imagePath: 'assets/images/gustavo.png',
        nome: 'Gustavo Eleutério da Silva',
        ra: 'RA 174084',
        descricao: GUSTAVO_DESCRICAO,
      ),
      InitialForm()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(UPPER_TITLE),
      ),
      body: Center(
        child: _pages.elementAt(_currentPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Membro 1')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Membro 2')),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            title: Text('Trabalho'),
          ),
        ],
        currentIndex: _currentPage,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
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

class SearchFormData {
  var sliderValue = .3;

  doSomething() {
    print("Slider: $sliderValue");
  }
}

class InitialForm extends StatefulWidget {
  final SearchFormData searchFormData = new SearchFormData();

  @override
  State<StatefulWidget> createState() {
    return InitialFormState(searchFormData);
  }
}

class InitialFormState extends State<InitialForm> {
  final _formKey = GlobalKey<FormState>();
  final LoginData loginData = new LoginData();
  final SearchFormData searchFormData;

  InitialFormState(this.searchFormData);

  @override
  Widget build(BuildContext context) {
    List _selectedOptions;
    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Caso ainda não exista, usuário será criado.',
                    labelText: 'Nome do  usuário',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String inValue) {
                    if (inValue.length == 0) {
                      return "Por favor, insira o usuário!";
                    }
                    return null;
                  },
                  onSaved: (String inValue) {
                    loginData.username = inValue;
                  }),
              SizedBox(height: 10),
              MultiSelectFormField(
                autovalidate: false,
                chipBackGroundColor: Colors.red,
                chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.red,
                checkBoxCheckColor: Colors.green,
                dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(
                  'Selecione as linguagens da pesquisa.',
                ),
                //border: UnderlineInputBorder(borderSide: BorderSide.none,),
                dataSource: [
                  {
                    "display": "C",
                    "value": "C",
                  },
                  {
                    "display": "C++",
                    "value": "C++",
                  },
                  {
                    "display": "Python",
                    "value": "Python",
                  },
                  {
                    "display": "Java",
                    "value": "Java",
                  },
                ],
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'Cancelar',
                hintWidget: Text('Toque para selecionar uma ou mais opções...'),
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedOptions = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('Escolha o nível de complexidade do repositório.',
                  textAlign: TextAlign.left),
              Slider(
                divisions: 3,
                onChanged: (double value) {
                  setState(() {
                    searchFormData.sliderValue = value;
                  });
                },
                label: 'Escolha o nível de complexidade do repositório.',
                value: searchFormData.sliderValue,
              ),
              SizedBox(height: 10),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ]),
              // Add TextFormFields and RaisedButton here.
            ])));
  }
}

class GenerateProfileView extends StatelessWidget {
  const GenerateProfileView({
    this.imagePath,
    this.nome,
    this.ra,
    this.descricao,
    Key key,
  }) : super(key: key);

  final String imagePath;
  final String nome;
  final String ra;
  final String descricao;

  @override
  Widget build(BuildContext context) {
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
              child: Image.asset(this.imagePath)),
        ),
        Text(this.nome,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )),
        Text(this.ra,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )),
        Text(this.descricao,
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.left),
      ],
    ));
  }
}
