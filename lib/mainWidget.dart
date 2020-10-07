import 'package:flutter/material.dart';

/*
1° Aba: foto, nome, semestre, com o que trabalho.
2° Aba: apresentação da segunda pessoa.
3° Aba: tema do trabalho da disciplina.
*/

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meu primeiro app!',
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text('Exercício 1 - SI700'),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.collections_bookmark))
                ]),
              ),
              body: TabBarView(children: [
                Center(child: generateProfileView()),
                Center(child: Text("Filho 2")),
                Center(child: generateContentView()),
              ])),
        ));
  }
}

Widget generateContentView() {
  return Center(
      child: ListView(
    padding: const EdgeInsets.all(12),
    children: [
      Container(
        margin: EdgeInsets.all(50),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/github.png')),
      ),
      Text('Github Guide',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
      Text(
          '\nUma questão emergente ao se aprender uma nova linguagem de programação, seus principais paradigmas e arquiteturas, '
          'é a dúvida: estou organizando e codificando da melhor maneira possível, a fim de que se tenha uma base de código '
          'escalável e extensível?\n'
          '\nMesmo conhecendo os principais design patterns, boas práticas e tendo em mãos a documentação do framework utilizado, '
          'pode não ser fácil para um iniciante juntar todas essas peças. Entretanto, isso pode se tornar mais fácil se utilizarmos '
          'como molde uma base de código madura, revisada por muitos programadores, que resolve problemas comuns do dia-a-dia de todo programador.\n '
          '\nO objetivo do aplicativo será ajudar o usuário, a partir das respostas de um simples '
          'questionário que traçará seu perfil, a conhecer os repositórios e projetos Open Source mais famosos '
          'e, por consequência, pela Lei de Linus, mais bem estruturados.\n',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 1,
          ),
          textAlign: TextAlign.left),
      Text('"Given enough eyeballs, all bugs are shallow."\n',
          style: TextStyle(
              fontSize: 16, letterSpacing: 1, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center),
      Text('Eric S. Raymond',
          style: TextStyle(
              fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right),
    ],
  ));
}

Widget generateProfileView() {
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
            child: Image.asset('assets/images/daniel.png')),
      ),
      Text('Daniel Orpinelli',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
      Text('RA 169482',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
      Text(
          '\nAtualmente curso Análise e Desenvolvimento de Sistemas, estando em meu sexto semestre.'
          '\n\nTenho especial predileção por programar em Python e Javascript, que são também as linguagens utilizadas '
          'nos projetos nos quais me insiro em meu trabalho, no Itaú Unibanco, estando em uma coordenação que desenvolve soluções '
          'de software para monitoração da rede/networking. '
          '\n\nEm meu tempo livre, gosto de estudar Linux e praticar violão e piano. Sou apaixonado por música, especialmente no que '
          'tange à gravação digital, sintetizadores, simulação e geração de instrumentos virtuais, utilização de controladores MIDI, etc.',
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
