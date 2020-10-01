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
                title: Text('TOP 10 CELULARES'),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.announcement)),
                  Tab(icon: Icon(Icons.cake)),
                  Tab(icon: Icon(Icons.cloud))
                ]),
              ),
              body: TabBarView(children: [
                Center(child: generateProfileView()),
                Center(child: Text("Filho 2")),
                Center(child: Text("Filho 3")),
              ])),
        ));
  }
}

//generateSynthaxView()

Widget generateProfileView() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: EdgeInsets.all(20),
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
          ))
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
