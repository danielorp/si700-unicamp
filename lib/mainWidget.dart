import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'modules/search/domain/repositories/search_repository.dart';
import 'modules/search/domain/usecases/search_by_language.dart';

/*
1° Aba: foto, nome, semestre, com o que trabalho.
2° Aba: apresentação da segunda pessoa.
3° Aba: tema do trabalho da disciplina.
*/

const UPPER_TITLE = 'Trabalho 1 - SI700';
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
      LanguageForm(),
      GenerateProfileView(
          imagePath: 'assets/images/daniel.png',
          nome: 'Daniel Orpinelli',
          ra: 'RA 169482',
          descricao: DANIEL_DESCRICAO),
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
              icon: Icon(Icons.collections_bookmark), title: Text('Trabalho'))
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

class ConfigAnimations {
  var color = Colors.yellow;
  var height = 100.0;
  var width = 100.0;

  var crossFadeFirst = true;
}

class LanguageForm extends StatefulWidget {
  final SearchFormData searchFormData = new SearchFormData();

  @override
  State<StatefulWidget> createState() {
    return LanguageFormState(searchFormData);
  }
}

class LanguageFormState extends State<LanguageForm> {
  final _formKey = GlobalKey<FormState>();
  final LoginData loginData = new LoginData();
  final SearchFormData searchFormData;
  List _selectedOptions = [];

  final List languageOptions = [
    {
      "display": "JavaScript",
      "value": "JavaScript",
    },
    {
      "display": "Python",
      "value": "Python",
    },
    {
      "display": "Java",
      "value": "Java",
    },
    {
      "display": "Go",
      "value": "Go",
    },
    {
      "display": "TypeScript",
      "value": "TypeScript",
    },
    {
      "display": "C++",
      "value": "C++",
    },
    {
      "display": "Ruby",
      "value": "Ruby",
    },
    {
      "display": "PHP",
      "value": "PHP",
    },
    {
      "display": "C#",
      "value": "C#",
    },
    {
      "display": "C",
      "value": "C",
    },
    {
      "display": "Dart",
      "value": "Dart",
    },
  ];

  LanguageFormState(this.searchFormData);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 10),
                  MultiSelectFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione as linguagens para a pesquisa!';
                      }
                      return null;
                    },
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
                    dataSource: languageOptions,
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'Cancelar',
                    hintWidget:
                        Text('Toque para selecionar uma ou mais opções...'),
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        this._selectedOptions = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Consultando API do Github...')));

                          // Fazer consulta à API do Github...
                          List languages = ['Dart', 'Python', 'Go'];

                          final repository = SearchRepositoryGithub();
                          final usecase = SearchByLanguageImpl(repository);
                          var result = await usecase(languages);
                          print(result);
                        }
                      },
                      child: Text('Pesquisar'),
                    ),
                  ),
                  // Add TextFormFields and RaisedButton here.
                ])));
  }
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      Duration(seconds: 2),
      () => 'Large Latte',
    );

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
