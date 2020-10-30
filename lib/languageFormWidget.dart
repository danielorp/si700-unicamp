import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:hello_world/modules/search/domain/errors/errors.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'mainWidget.dart';
import 'modules/search/domain/entities/result_search.dart';
import 'modules/search/domain/usecases/search_by_language.dart';
import 'modules/search/external/datasources/github_datasources.dart';
import 'modules/search/infra/models/result_search_model.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';

class LanguageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LanguageFormState();
  }
}

class LanguageFormState extends State<LanguageForm> {
  final _formKey = GlobalKey<FormState>();
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

                          final datasource = GithubDatasource();
                          final repository = SearchRepositoryImpl(datasource);
                          final dartz.Either<FailureSearch, List<ResultSearch>>
                              result = await SearchByLanguageImpl(repository)
                                  .call(_selectedOptions);
                          result.fold(
                              (exception) => print('deu ruim'),
                              (languages) => setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LanguageList(
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

class LanguageList extends StatelessWidget {
  final List<ResultSearchModel> languages;

  const LanguageList({@required this.languages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(UPPER_TITLE),
      ),
      body: Padding(
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
    );
  }
}

class LanguageItem extends StatelessWidget {
  const LanguageItem({@required this.item});

  final ResultSearch item;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text(item.language));
  }
}
