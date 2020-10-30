import 'package:flutter/material.dart';
import 'languageFormWidget.dart';

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

class DisplaySearchResults extends StatefulWidget {
  DisplaySearchResults({Key key}) : super(key: key);

  @override
  _DisplaySearchResultsState createState() => _DisplaySearchResultsState();
}

class _DisplaySearchResultsState extends State<DisplaySearchResults> {
  int _currentPage;
  var _pages;

  @override
  void initState() {
    super.initState();

    _currentPage = 0;
    _pages = [
      //Container(child: Text("Page 1 - Anúncios")),
      LanguageList(),
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
