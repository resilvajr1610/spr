import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/calculadoras/referencias/refIndiceAtividade.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';
import '../../standard/objetos.dart';

class CalcLLdasPage extends StatelessWidget {
  const CalcLLdasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcLLdas(),
    );
  }
}

class CalcLLdas extends StatefulWidget {
  const CalcLLdas({Key? key}) : super(key: key);

  @override
  _CalcLLdasState createState() => _CalcLLdasState();
}

class _CalcLLdasState extends State<CalcLLdas> {
  int somaPontos = 0;
  final _controller = ScrollController();
  bool calculou = false;

  final checkListAchadosEpa = [
    CheckBoxLupus(
        title:
            'SLEDAI-2K ≤ 4, sem atividade em órgão nobre (renal, SNC, vasculite, febre) e sem anemia hemolítica ou atividade gastrointestinal.',
        pontos: 1),
    CheckBoxLupus(
        title:
            'Sem novos indícios de atividade de doença quando comparado com a última consulta.',
        pontos: 1),
    CheckBoxLupus(title: 'PGA ≤ 1', pontos: 1),
    CheckBoxLupus(
        title: 'Dose atual de prednisona (ou equivalente) ≤ 7,5mg/dia.',
        pontos: 1),
    CheckBoxLupus(
        title:
            'Boa tolerância a terapia de manutenção em dose padrão ou biológico aprovado para doença.',
        pontos: 1),
  ];

  Widget buildCheckbox(
          {required CheckBoxLupus check,
          required VoidCallback onClicked,
          bool? isFanPositivo}) =>
      ListTile(
        title: Layout().texto(check.title, 18.0, FontWeight.bold, Colors.black),
        leading:
            Checkbox(value: check.value, onChanged: (value) => onClicked()),
      );

  Widget buildSingleCheckbox(CheckBoxLupus check) => buildCheckbox(
      check: check,
      onClicked: () {
        setState(() {
          final newValue = !check.value;
          check.value = newValue;
          print(check.value);
        });
      });

  int somaPontosList(List lista) {
    int soma = 0;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].value == true) {
        soma++;
      }
    }
    print(soma);
    return soma;
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
            Layout().titulo('LLDAS\n(Lupus Low Disease Activity State)'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'Preencha os campos abaixo e avalie se o paciente está em baixa atividade de doença.',
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
                      Expanded(child: Layout().titulo('Domínios e itens')),
                    ],
                  ),
                  SizedBox(height: 20),
                  ...checkListAchadosEpa.map(buildSingleCheckbox),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.teal),
                            onPressed: () {
                              int soma = somaPontosList(checkListAchadosEpa);
                              setState(() {
                                somaPontos = soma;
                                calculou = true;
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
                          calculou
                              ? Expanded(
                                  child: somaPontos == 5
                                      ? Layout().titulo(
                                          'Estado: estado de baixa atividade de doença\nPontuação: $somaPontos')
                                      : Layout().titulo(
                                          'Não atingido estado de baixa atividade de doença\nPontuação: $somaPontos'))
                              : Expanded(child: Container())
                        ],
                      ),
                      RefIndiceAtividade().lupussLLDAS(),
                      SizedBox(height: 20),
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
}
