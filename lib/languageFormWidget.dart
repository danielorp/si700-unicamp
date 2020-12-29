import 'package:dartz/dartz.dart' as dartz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/bloc/auth_state.dart';
import 'package:hello_world/bloc/database_state.dart';
import 'package:hello_world/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/modules/search/domain/errors/errors.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'bloc/database_bloc.dart';
import 'bloc/database_event.dart';
import 'firebase/database.dart';
import 'models/preference_models.dart';
import 'modules/search/domain/entities/result_search.dart';
import 'modules/search/domain/usecases/search_by_language.dart';
import 'modules/search/external/datasources/github_datasources.dart';
import 'modules/search/infra/models/result_search_model.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';
import 'package:url_launcher/url_launcher.dart';

List languageOptions = [
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

class LanguageForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = new GlobalKey();
  final Preference inModel = Preference();
  List _selectedOptions = [];
  final AuthState state;

  LanguageForm({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: listLinguagens(context),
    );
  }

  Widget listLinguagens(context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Form(
          key: formKey,
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
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
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Consultando API do Github...')));
                            final datasource = GithubDatasource();
                            final repository = SearchRepositoryImpl(datasource);
                            final dartz
                                    .Either<FailureSearch, List<ResultSearch>>
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
                                                    state: this.state,
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
    });
  }
}

class DisplayResults extends StatefulWidget {
  final List<ResultSearchModel> languages;

  final state;
  const DisplayResults({this.languages, this.state});

  @override
  _DisplayResultsState createState() => _DisplayResultsState(state);
}

class _DisplayResultsState extends State<DisplayResults> {
  int _selectedIndex = 0;
  final AuthState state;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      '',
      style: optionStyle,
    )
  ];

  _DisplayResultsState(this.state);

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
          title: Text(appTitle),
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
                      BlocProvider(
                        create: (BuildContext context) =>
                            DatabaseBloc(this.state.user.uid),
                        child: LanguageItem(
                          item: item,
                        ),
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
                icon: Icon(Icons.collections_bookmark), label: 'Repositórios'),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'Detalhes',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}

class LanguageItem extends StatefulWidget {
  const LanguageItem({@required this.item});

  final ResultSearch item;

  @override
  _LanguageItemState createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  @override
  Widget build(BuildContext context) {
    final TextStyle linkStyle = TextStyle(color: Colors.blue);

    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      childrenPadding: EdgeInsets.all(0),
      title: Text(widget.item.language),
      children: [
        for (var element in widget.item.repos)
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
                  title: Text('Salvar Repositório'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.brown[900],
                    ),
                    onPressed: () {
                      BlocProvider.of<DatabaseBloc>(context)
                          .add(AddDatabase(repo: element.id));
                    },
                  )),
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
