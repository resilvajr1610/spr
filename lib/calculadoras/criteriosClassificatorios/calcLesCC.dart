import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/calculadoras/referencias/refCriteriosClassificatorios.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';
import '../../standard/objetos.dart';

class LesCCPage extends StatelessWidget {
  const LesCCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: LesCC(),
    );
  }
}

class LesCC extends StatefulWidget {
  const LesCC({Key? key}) : super(key: key);

  @override
  _LesCCState createState() => _LesCCState();
}

class _LesCCState extends State<LesCC> {
  bool fanPositivo = false;
  final _controller = ScrollController();

  final checkListEntrada = [
    CheckBoxLupus(title: 'FAN positivo ≥ 1:80', pontos: 0),
  ];

  final checklistConstitucional = [
    CheckBoxLupus(title: 'Febre > 38,3º C', pontos: 2),
  ];

  final checklistHematologico = [
    CheckBoxLupus(title: 'Leucopenia < 4.000//mm³', pontos: 3),
    CheckBoxLupus(title: 'Plaquetopenia < 100.000//mm³', pontos: 4),
    CheckBoxLupus(title: 'Anemia hemolítica autoimune', pontos: 4),
  ];

  final checkListNeuroPsiquiatrico = [
    CheckBoxLupus(title: 'Delirium', pontos: 2),
    CheckBoxLupus(title: 'Psicose', pontos: 3),
    CheckBoxLupus(title: 'Convulsão', pontos: 5),
  ];

  final checkListMucocutaneo = [
    CheckBoxLupus(title: 'Alopecia não cicatricial', pontos: 2),
    CheckBoxLupus(title: 'Úlceras orais', pontos: 2),
    CheckBoxLupus(title: 'Lupus cutâneo subagudo ou lupus discoide', pontos: 4),
    CheckBoxLupus(title: 'Lupus cutâneo agudo', pontos: 6),
  ];

  final checkListSerosite = [
    CheckBoxLupus(title: 'Derrame pleural ou pericárdico', pontos: 5),
    CheckBoxLupus(title: 'Pericardite aguda', pontos: 6),
  ];

  final checkListMusculoEsqueletico = [
    CheckBoxLupus(title: 'Acometimento articular', pontos: 6),
  ];

  final checkListRenal = [
    CheckBoxLupus(title: 'Proteinúria > 0,5g / 24 horas', pontos: 4),
    CheckBoxLupus(
        title: 'Nefrite lúpica Classe 2 ou 5 na biópsia renal', pontos: 8),
    CheckBoxLupus(
        title: 'Nefrite lúpica Classe 3 ou 4 na biópsia renal', pontos: 10),
  ];

  final checkListCriterios = [
    CheckBoxLupus(title: 'Anticorpos antifosfolípides positivos', pontos: 2),
    CheckBoxLupus(title: 'C3 OU C4 abaixo', pontos: 3),
    CheckBoxLupus(title: 'C3 E C4 abaixo', pontos: 4),
    CheckBoxLupus(title: 'Anti-DNAds ou Anti-SM positivo', pontos: 6),
  ];

  List<int> elementosSoma = [];
  int? resultadoSoma = 0;

  Widget buildCheckbox(
          {required CheckBoxLupus check,
          required VoidCallback onClicked,
          bool? isFanPositivo}) =>
      ListTile(
          title:
              Layout().texto(check.title, 18.0, FontWeight.bold, Colors.black),
          leading:
              Checkbox(value: check.value, onChanged: (value) => onClicked()),
          trailing: isFanPositivo == null
              ? Layout().texto(check.pontos.toString(), 18.0, FontWeight.normal,
                  Colors.black)
              : null);

  int checkMaior(lista) {
    int maior = 0;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].value == true) {
        if (lista[i].pontos! > maior) {
          maior = lista[i].pontos!;
        }
      }
      print('maior => $maior');
      print(lista[i].title);
    }
    return maior;
  }

  somaCriterios() {
    int soma = 0;
    for (int i = 0; i < checkListCriterios.length; i++) {
      if (checkListCriterios[i].value == true) {
        soma += checkListCriterios[i].pontos!;
      }
    }
    print(soma);
    return soma;
  }

  Widget buildSingleCheckbox(CheckBoxLupus check) => buildCheckbox(
      check: check,
      onClicked: () {
        setState(() {
          final newValue = !check.value;
          check.value = newValue;
          print(check.value);
          final newValueConst = checkListEntrada[0].value;
          fanPositivo = newValueConst;
        });
      });

  Widget buildCriterioEntrada(CheckBoxLupus check) => buildCheckbox(
      check: check,
      isFanPositivo: true,
      onClicked: () {
        setState(() {
          final newValue = !check.value;
          check.value = newValue;
          print(check.value);
          final newValueConst = checkListEntrada[0].value;
          fanPositivo = newValueConst;
        });
      });

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
            Layout().titulo('LES'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'Critérios Classificatórios ACR/EULAR 2019',
                  16.0,
                  FontWeight.normal,
                  Colors.black,
                  align: TextAlign.center),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Layout()
                              .titulo('Critério de entrada obrigatório')),
                    ],
                  ),
                  SizedBox(height: 20),
                  ...checkListEntrada.map(buildCriterioEntrada),
                  Divider(color: Colors.grey, thickness: 1.5),
                  SizedBox(height: 20),
                  fanPositivo
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Layout().titulo(
                                        'Domínios e critérios clínicos')),
                                Expanded(child: Layout().titulo('Pontuação'))
                              ],
                            ),
                            SizedBox(height: 20),
                            Layout().texto('Constitucional', 18.0,
                                FontWeight.bold, Colors.black,
                                textDecoration: TextDecoration.underline),
                            SizedBox(height: 10),
                            ...checklistConstitucional.map(buildSingleCheckbox),
                            SizedBox(height: 20),
                            Layout().texto('Hematológico', 18.0,
                                FontWeight.bold, Colors.black,
                                textDecoration: TextDecoration.underline),
                            SizedBox(height: 10),
                            ...checklistHematologico.map(buildSingleCheckbox),
                            Divider(),
                            SizedBox(height: 20),
                            Layout().texto('Neuropsiquiátrico', 18.0,
                                FontWeight.bold, Colors.black,
                                textDecoration: TextDecoration.underline),
                            SizedBox(height: 10),
                            ...checkListNeuroPsiquiatrico
                                .map(buildSingleCheckbox),
                            Divider(),
                            SizedBox(height: 20),
                            Layout().texto('Mucocutâneo', 18.0, FontWeight.bold,
                                Colors.black,
                                textDecoration: TextDecoration.underline),
                            SizedBox(height: 10),
                            ...checkListMucocutaneo.map(buildSingleCheckbox),
                            Divider(),
                            SizedBox(height: 20),
                            Layout().texto(
                                'Serosite', 18.0, FontWeight.bold, Colors.black,
                                textDecoration: TextDecoration.underline),
                            SizedBox(height: 10),
                            ...checkListSerosite.map(buildSingleCheckbox),
                            Divider(),
                            SizedBox(height: 20),
                            Layout().texto('Musculoesquelético', 18.0,
                                FontWeight.bold, Colors.black,
                                textDecoration: TextDecoration.underline),
                            SizedBox(height: 10),
                            ...checkListMusculoEsqueletico
                                .map(buildSingleCheckbox),
                            Divider(),
                            SizedBox(height: 20),
                            Layout().texto(
                                'Renal', 18.0, FontWeight.bold, Colors.black,
                                textDecoration: TextDecoration.underline),
                            ...checkListRenal.map(buildSingleCheckbox),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Layout().texto(
                                        'Domínios e critérios imunológicos',
                                        18.0,
                                        FontWeight.bold,
                                        Colors.black,
                                        textDecoration:
                                            TextDecoration.underline)),
                              ],
                            ),
                            SizedBox(height: 20),
                            ...checkListCriterios.map(buildSingleCheckbox),
                            SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.teal),
                                  onPressed: () {
                                    if (checkListCriterios[1].value == true &&
                                        checkListCriterios[2].value == true) {
                                      Layout().dialog1botao(context, 'Oops!',
                                          'As opções C3 e/ou C4 não podem ser marcadas simultaneamente');
                                    } else {
                                      int? somaMaior = checkMaior(
                                              checklistConstitucional) +
                                          checkMaior(checklistHematologico) +
                                          checkMaior(
                                              checkListNeuroPsiquiatrico) +
                                          checkMaior(checkListMucocutaneo) +
                                          checkMaior(checkListSerosite) +
                                          checkMaior(
                                              checkListMusculoEsqueletico) +
                                          checkMaior(checkListRenal);
                                      print('soma maior => $somaMaior');
                                      setState(() {
                                        resultadoSoma = somaMaior;
                                      });
                                      int somaDominios = somaCriterios();
                                      setState(() {
                                        resultadoSoma = resultadoSoma! + somaDominios!;
                                      });
                                      _controller.animateTo(
                                        _controller.position.maxScrollExtent,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.fastOutSlowIn,
                                      );
                                    }
                                  },
                                  child: Layout().texto('Calcular', 18.0,
                                      FontWeight.bold, Cores.corfundo)),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: resultadoSoma == 0
                                        ? Layout().titulo('')
                                        : Layout().titulo(
                                            'Valor total: $resultadoSoma')),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: resultadoSoma == 0
                                        ? Layout().titulo('')
                                        : Layout().titulo(
                                            'Paciente classificado como LES: ${resultadoSoma! >= 10 ? 'Sim. Pontuação ≥ 10' : 'Não. Pontuação < 10'}')),
                              ],
                            ),
                            RefCriteriosClassificatorios().lupusACREULAR(),
                            SizedBox(height: 50),
                          ],
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
