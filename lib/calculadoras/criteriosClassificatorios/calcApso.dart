import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/calculadoras/referencias/refCriteriosClassificatorios.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';
import '../../standard/objetos.dart';

class CalcApsoPage extends StatelessWidget {
  const CalcApsoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcApso(),
    );
  }
}

class CalcApso extends StatefulWidget {
  const CalcApso({Key? key}) : super(key: key);

  @override
  _CalcApsoState createState() => _CalcApsoState();
}

class _CalcApsoState extends State<CalcApso> {
  bool criterioEntrada = false;
  int somaPontos = 0;
  final _controller = ScrollController();

  final checkListEntrada = [
    CheckBoxLupus(
        title: 'Paciente com doença inflamatória (articular, êntese ou colona) e pelo menos 3 pontos',
        pontos: 1),
  ];

  final checklist1 = [
    CheckBoxLupus(title: 'Psoríase Cutânea atual', pontos: 2),
    CheckBoxLupus(title: 'História pessoal de psoríase', pontos: 1),
    CheckBoxLupus(title: 'História familiar de psoríase', pontos: 1),
  ];

  final checklist2 = [
    CheckBoxLupus(title: 'Distrofia ungueal', pontos: 1),
    CheckBoxLupus(
        title: 'Dactilite atual ou episódio anterior visto por médico',
        pontos: 1),
    CheckBoxLupus(title: 'Fator reumatoide negativo', pontos: 1),
    CheckBoxLupus(
        title: 'Neoformação óssea justarticular na radiografia de mãos ou pés',
        pontos: 1),
  ];

  Widget buildCheckbox({required CheckBoxLupus check,
    required VoidCallback onClicked,
    bool? isFanPositivo}) =>
      ListTile(
        title: Layout().texto(check.title, 18.0, FontWeight.bold, Colors.black),
        leading:
        Checkbox(value: check.value, onChanged: (value) => onClicked()),
      );

  Widget buildSingleCheckbox(CheckBoxLupus check) =>
      buildCheckbox(
          check: check,
          onClicked: () {
            setState(() {
              final newValue = !check.value;
              check.value = newValue;
              print(check.value);
            });
          });

  Widget buildCriterioEntrada(CheckBoxLupus check) =>
      buildCheckbox(
          check: check,
          onClicked: () {
            setState(() {
              final newValue = !check.value;
              check.value = newValue;
              print(check.value);
              final newValueCriterio1 = checkListEntrada[0].value;
              criterioEntrada = newValueCriterio1;
            });
          });

  int somaPontosList(List lista) {
    int soma = 0;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].value == true) {
        soma++;
      }
    }
    return soma;
  }

  int checkMaior() {
    int maior = 0;
    for (int i = 0; i < checklist1.length; i++) {
      if (checklist1[i].value == true) {
        if (checklist1[i].pontos! > maior) {
          maior = checklist1[i].pontos!;
        }
      }
      print('maior => $maior');
      print(checklist1[i].title);
    }
    return maior;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Layout().titulo('CASPAR'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'Preencha os campos abaixo e obtenha a classificação do paciente em relação a metrica CASPAR (Classiﬁcation criteria for Psoriatic ARthritis), utilizada para detecção da Artrite Psoriásica.',
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
                  criterioEntrada
                      ? Column(
                    children: [
                      Layout().titulo('Psoríase'),
                      SizedBox(height: 10),
                      ...checklist1.map(buildSingleCheckbox),
                      Divider(color: Colors.grey, thickness: 1.5),
                      SizedBox(height: 20),
                      Layout().titulo('Outros'),
                      SizedBox(height: 10),
                      ...checklist2.map(buildSingleCheckbox),
                    ],
                  )
                      : Container(),
                  SizedBox(height: 20),
                  criterioEntrada
                      ? Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal),
                            onPressed: () {
                              int maior = checkMaior();
                              int soma;
                              maior == 1 ?
                              soma = somaPontosList(checklist1) +
                                  somaPontosList(checklist2)
                                  : soma = maior +
                                  somaPontosList(checklist2);
                              setState(() {
                                somaPontos = soma;
                              });

                              print(somaPontos);
                              _controller.animateTo(
                                _controller.position.maxScrollExtent,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                            },
                            child: Layout().texto('Calcular', 18.0,
                                FontWeight.bold, Cores.corfundo)),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: somaPontos == 0
                                  ? Layout().titulo('')
                                  : Layout().titulo(
                                  'Paciente classificado como Artrite Psoriásica: ${somaPontos >
                                      2
                                      ? 'Sim.'
                                      : 'Não.'}\nPontuação: $somaPontos')),
                        ],
                      ),
                      RefCriteriosClassificatorios().artritepsoriCASPAR(),
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
