import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/calculadoras/referencias/refCriteriosClassificatorios.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';
import '../../standard/objetos.dart';

class CalcEpApPage extends StatelessWidget {
  const CalcEpApPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcEpAp(),
    );
  }
}

class CalcEpAp extends StatefulWidget {
  const CalcEpAp({Key? key}) : super(key: key);

  @override
  _CalcEpApState createState() => _CalcEpApState();
}

class _CalcEpApState extends State<CalcEpAp> {
  bool criterioEntrada = false;
  int somaPontos = 0;
  final _controller = ScrollController();

  final checkListEntrada = [
    CheckBoxLupus(
        title: 'Paciente com artrite ou entesite ou dactilite', pontos: 1),
  ];

  final checkListAchadosEpa = [
    CheckBoxLupus(title: 'Uveíte', pontos: 2),
    CheckBoxLupus(title: 'Psoríase', pontos: 2),
    CheckBoxLupus(title: 'Doença inflamatória intestinal (DII)', pontos:2),
    CheckBoxLupus(title: 'Infecção (urogenital ou intestinal)', pontos: 2),
    CheckBoxLupus(title: 'HLA-B27', pontos: 2),
    CheckBoxLupus(title: 'Sacroiliíte pela imagem', pontos: 2),
    CheckBoxLupus(title: 'Artrite', pontos: 1),
    CheckBoxLupus(title: 'Entesite', pontos: 1),
    CheckBoxLupus(title: 'Dactilite', pontos: 1),
    CheckBoxLupus(
        title: 'Passado de Doença Inflamatória Intestinal', pontos: 1),
    CheckBoxLupus(title: 'História familiar de EpA', pontos: 1),
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

  Widget buildCriterioEntrada(CheckBoxLupus check) => buildCheckbox(
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
            Layout().titulo('Espondiloartrite Periférica'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'Critérios classificatórios ASAS para espondiloartrite periférica 2011.',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Layout().titulo('Achados de Espondiloartrite')),
                              ],
                            ),
                            SizedBox(height: 20),
                            ...checkListAchadosEpa.map(buildSingleCheckbox),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 20),
                  criterioEntrada
                      ? Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.teal),
                                  onPressed: () {
                                    int soma =
                                        somaPontosList(checkListAchadosEpa) +
                                            somaPontosList(checkListEntrada);
                                    print(soma);
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
                                            'Paciente classificado como Espondiloartrite Periférica: ${somaPontos > 2 ? 'Sim.\nPontos: $somaPontos' : 'Não.\n $somaPontos pontos'}')),
                              ],
                            ),
                            RefCriteriosClassificatorios().espondiloartriteaxialASAS2011(),
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
