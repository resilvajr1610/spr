import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/calculadoras/referencias/refIndiceAtividade.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';
import '../../standard/objetos.dart';

class CalcSledaiPage extends StatelessWidget {
  const CalcSledaiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcSledai(),
    );
  }
}

class CalcSledai extends StatefulWidget {
  const CalcSledai({Key? key}) : super(key: key);

  @override
  _CalcSledaiState createState() => _CalcSledaiState();
}

class _CalcSledaiState extends State<CalcSledai> {
  int somaPontos = 0;
  final _controller = ScrollController();
  String atividade = '';
  bool calculou = false;

  final checkList = [
    CheckBoxLupus(title: 'Convulsão (início recente)', pontos: 8),
    CheckBoxLupus(title: 'Psicose', pontos: 8),
    CheckBoxLupus(title: 'Sd cerebral orgânica', pontos: 8),
    CheckBoxLupus(
        title: 'Ditúrbio visual (retina ou neurite óptica)', pontos: 8),
    CheckBoxLupus(title: 'Desordem de nervo craniano (novo)', pontos: 8),
    CheckBoxLupus(title: 'Cefaléia lúpica', pontos: 8),
    CheckBoxLupus(title: 'AVC (novo; excluído aterosclerose)', pontos: 8),
    CheckBoxLupus(title: 'Vasculite', pontos: 8),
    CheckBoxLupus(title: 'Artrite (>2 articulações)', pontos: 4),
    CheckBoxLupus(title: 'Miosite', pontos: 4),
    CheckBoxLupus(title: 'Cilindros urinários', pontos: 4),
    CheckBoxLupus(title: 'Hematúria', pontos: 4),
    CheckBoxLupus(title: 'Proteinúria (>0,5g/24h)', pontos: 4),
    CheckBoxLupus(title: 'Piúria', pontos: 4),
    CheckBoxLupus(title: 'Rash cutâneo', pontos: 2),
    CheckBoxLupus(title: 'Alopecia', pontos: 2),
    CheckBoxLupus(title: 'Úlceras orais ou nasais', pontos: 2),
    CheckBoxLupus(title: 'Pleurisia', pontos: 2),
    CheckBoxLupus(title: 'Pericardite', pontos: 2),
    CheckBoxLupus(title: 'Complemento baixo', pontos: 2),
    CheckBoxLupus(title: 'anti-DNA elevado', pontos: 2),
    CheckBoxLupus(title: 'Febre (>38°)', pontos: 1),
    CheckBoxLupus(title: 'Trombocitopenia (<100.000)', pontos: 1),
    CheckBoxLupus(title: 'Leucopenia (<3.000)', pontos: 1),
  ];

  Widget buildCheckbox(
          {required CheckBoxLupus check,
          required VoidCallback onClicked,
          bool? isFanPositivo}) =>
      ListTile(
          title:
              Layout().texto(check.title, 18.0, FontWeight.bold, Colors.black),
          leading:
              Checkbox(value: check.value, onChanged: (value) => onClicked()),
          trailing: Layout().texto(
              check.pontos.toString(), 18.0, FontWeight.normal, Colors.black));

  Widget buildSingleCheckbox(CheckBoxLupus check) => buildCheckbox(
      check: check,
      onClicked: () {
        setState(() {
          final newValue = !check.value;
          check.value = newValue;
          print(check.value);
        });
      });

   somaPontosList(List lista) {
    int? soma = 0;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].value == true) {
        final pontos = lista[i].pontos;
        if (pontos != null) {
          soma =pontos! as int?;
        }
      }
    }
    return soma;
  }

   atividadeSLEDAI2K() {
    setState(() {
      calculou = true;
      int soma = somaPontosList(checkList);
      somaPontos = soma;
      if (soma > 4) {
        atividade = 'Flare.';
      } else if (soma == 3) {
        atividade = 'Atividade persistente;';
      } else if (soma == 2) {
        atividade = 'Atividade, mas melhora;';
      } else if (soma == 1) {
        atividade = 'Atividade leve;';
      } else {
        atividade = 'Sem atividade.';
      }
      print(somaPontos);
    });
  }

  goToBottomOfPage() {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Layout().titulo('Lúpus Eritematoso Sistêmico'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'SLEDAI-2K (Systemic Lupus Erythematosus Disease Activity Index 2000).',
                  16.0,
                  FontWeight.normal,
                  Colors.black,
                  align: TextAlign.center),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Container()),
                          Flexible(child: Layout().titulo('Descritor')),
                          Flexible(child: Layout().titulo('Pontuação')),
                        ],
                      ),
                      SizedBox(height: 20),
                      ...checkList.map(buildSingleCheckbox),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                            onPressed: () {
                              atividadeSLEDAI2K();
                              goToBottomOfPage();
                              modalMetrica();
                            },
                            child: Layout().texto('Calcular', 18.0,
                                FontWeight.bold, Cores.corfundo)),
                      ),
                      SizedBox(height: 50),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  modalMetrica() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        color: Cores.corprincipal,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios))
                  ],
                ),
                Layout().titulo('Lúpus Eritematoso Sistêmico'),
                SizedBox(height: 30),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                Row(
                  children: [
                    Expanded(child: Layout().titulo('Métrica')),
                    Expanded(child: Layout().titulo('Valor')),
                    Expanded(child: Layout().titulo('Atividade')),
                  ],
                ),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: Layout().texto(
                            'SLEDAI-2K', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(somaPontos.toString(), 18.0,
                            FontWeight.normal, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                      child: Layout().texto(
                          atividade, 18.0, FontWeight.normal, Colors.black, align: TextAlign.center),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                SizedBox(
                  height: 15,
                ),
                RefIndiceAtividade().lupussledai2k()
              ],
            ),
          ),
        ));
      },
    );
  }
}
