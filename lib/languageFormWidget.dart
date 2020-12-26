import 'package:dartz/dartz.dart' as dartz;
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/modules/search/domain/errors/errors.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'modules/search/domain/entities/result_search.dart';
import 'modules/search/domain/usecases/search_by_language.dart';
import 'modules/search/external/datasources/github_datasources.dart';
import 'modules/search/infra/models/result_search_model.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';
import 'package:url_launcher/url_launcher.dart';

String UPPER_TITLE = 'Trabalho 2';

List LANGUAGE_OPTIONS = [
  {
    "display": "JavaScript",
    "value": "JavaScript",
    // TODO: Utilizar ícone com a imagem da linguagem.
    "img": "assets/images/language_icons/javascript.png"
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
    "value": "CPP",
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
    "value": "CSHARP",
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

class LanguageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LanguageFormState();
  }
}

class LanguageFormState extends State<LanguageForm> {
  final _formKey = GlobalKey<FormState>();
  List _selectedOptions = [];

  LanguageFormState();

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
                    dataSource: LANGUAGE_OPTIONS,
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

                          final datasource = GithubDatasource();
                          final repository = SearchRepositoryImpl(datasource);
                          final dartz.Either<FailureSearch, List<ResultSearch>>
                              result = await SearchByLanguageImpl(repository)
                                  .call(_selectedOptions);
                          result.fold(
                              (exception) => print('Falha na busca!'),
                              (languages) => setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DisplayResults(
                                                  languages: languages,
                                                )));
                                  }));
                        }
                      },
                      child: Text('Pesquisar'),
                    ),
                  ),
                  // Add TextFormFields and RaisedButton here.
                ])));
  }
}

class DisplayResults extends StatefulWidget {
  final List<ResultSearchModel> languages;
  const DisplayResults({this.languages});

  @override
  _DisplayResultsState createState() => _DisplayResultsState();
}

class _DisplayResultsState extends State<DisplayResults> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Business',
      style: optionStyle,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(UPPER_TITLE),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Column(children: [
                    for (var item in widget.languages)
                      LanguageItem(
                        item: item,
                      )
                  ])
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark),
                title: Text('Repositórios')),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              title: Text('Detalhes'),
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}

class LanguageByStarRating extends StatelessWidget {
  final List<ResultSearchModel> languages;

  const LanguageByStarRating({@required this.languages});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Column(children: [
                for (var item in languages)
                  LanguageItem(
                    item: item,
                  )
              ])
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageItem extends StatelessWidget {
  const LanguageItem({@required this.item});

  final ResultSearch item;

  @override
  Widget build(BuildContext context) {
    final TextStyle linkStyle = TextStyle(color: Colors.blue);

    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      childrenPadding: EdgeInsets.all(0),
      title: Text(item.language),
      children: [
        for (var element in item.repos)
          ExpansionTile(
            title: Text(element.name),
            trailing: Wrap(spacing: 10, children: [
              Text(NumberFormat.compact(locale: 'en')
                  .format(element.stars)
                  .toString()),
              Icon(
                Icons.star,
                size: 18,
              ),
              Icon(Icons.arrow_drop_down)
            ]),
            children: [
              ListTile(
                title: Text('Descrição'),
                subtitle: Text(element.description),
                trailing: Icon(Icons.description),
                isThreeLine: true,
              ),
              ListTile(
                title: Text('URL'),
                subtitle: RichText(
                    text: TextSpan(
                        style: linkStyle,
                        text: element.repoUrl,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchURL(element.repoUrl);
                          })),
                //subtitle: Text(element.repoUrl),
                trailing: Icon(Icons.web),
                isThreeLine: true,
              ),
              ListTile(
                title: Text('Autor'),
                subtitle: Text(element.ownerName),
                trailing: Icon(Icons.person),
                isThreeLine: true,
              )
            ],
          )
      ],
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Falha ao abrir a URL: $url';
  }
}
