import 'package:flutter/material.dart';

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
      MySecondFormWidget()
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
  MySecondFormWidget({
    Key key,
  }) : super(key: key);
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
              Switch(
                onChanged: (bool value) {
                  setState(() {
                    otherData.switchValue = value;
                  });
                },
                value: otherData.switchValue,
              ),
              Slider(
                  min: 0,
                  max: 20,
                  value: otherData.sliderValue,
                  onChanged: (double value) {
                    setState(() {
                      otherData.sliderValue = value;
                    });
                  }),
              Row(
                children: [
                  Tooltip(
                      message: "Nada de bom sairá desse botão",
                      child: RaisedButton(
                        child: Text("Não clique"),
                        onPressed: () {},
                      ))
                ],
              )
            ],
          )),
      padding: EdgeInsets.all(50.0),
    );
  }
}
