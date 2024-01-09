import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/calculadoras/referencias/refCriteriosClassificatorios.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';
import '../../standard/objetos.dart';

class CalcEpaxccPage extends StatelessWidget {
  const CalcEpaxccPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcEpaxcc(),
    );
  }
}

class CalcEpaxcc extends StatefulWidget {
  const CalcEpaxcc({Key? key}) : super(key: key);

  @override
  _CalcEpaxccState createState() => _CalcEpaxccState();
}

class _CalcEpaxccState extends State<CalcEpaxcc> {
  bool criterioEntrada = false;
  bool criterioSegundoImagem = false;
  bool criterioSegundoHLAB = false;
  int somaPontos = 0;
  final _controller = ScrollController();

  final checkListEntrada = [
    CheckBoxLupus(
        title:
            'Paciente com dor nas costas ou na coluna vertebral (axial) com mais de 3 meses de duração e idade de início menor que 45 anos',
        pontos: 0),
  ];

  final checkListSegundoCriterio = [
    CheckBoxLupus(title: 'Sacroiliíte pela imagem', pontos: 2),
    CheckBoxLupus(title: 'HLAB27 positivo', pontos: 1)
  ];

  final checkListAchadosEpaImagem = [
    CheckBoxLupus(title: 'Dor lombar inflamatória', pontos: 1),
    CheckBoxLupus(title: 'Artrite', pontos: 1),
    CheckBoxLupus(
        title: 'Entesite (inserção do tendão de aquiles ou fáscia plantar) ',
        pontos: 1),
    CheckBoxLupus(title: 'Uveíte anterior', pontos: 1),
    CheckBoxLupus(title: 'Dactilite', pontos: 1),
    CheckBoxLupus(title: 'Psoríase', pontos: 1),
    CheckBoxLupus(title: 'Doença inflamatória intestinal (DII)', pontos: 1),
    CheckBoxLupus(title: 'Boa resposta ao uso de AINEs', pontos: 1),
    CheckBoxLupus(title: 'História familiar de EpA', pontos: 1),
    CheckBoxLupus(title: 'HLAB27 positivo', pontos: 1),
    CheckBoxLupus(title: 'PCR elevada', pontos: 1),
  ];

  final checkListAchadosEpaHLAB = [
    CheckBoxLupus(title: 'Dor lombar inflamatória', pontos: 1),
    CheckBoxLupus(title: 'Artrite', pontos: 1),
    CheckBoxLupus(
        title: 'Entesite (inserção do tendão de aquiles ou fáscia plantar) ',
        pontos: 1),
    CheckBoxLupus(title: 'Uveíte anterior', pontos: 1),
    CheckBoxLupus(title: 'Dactilite', pontos: 1),
    CheckBoxLupus(title: 'Psoríase', pontos: 1),
    CheckBoxLupus(title: 'Doença inflamatória intestinal (DII)', pontos: 1),
    CheckBoxLupus(title: 'Boa resposta ao uso de AINEs', pontos: 1),
    CheckBoxLupus(title: 'História familiar de EpA', pontos: 1),
    CheckBoxLupus(title: 'PCR elevada', pontos: 1),
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

  Widget buildSegundoCriterio(CheckBoxLupus check) => buildCheckbox(
      check: check,
      onClicked: () {
        setState(() {
          final newValue = !check.value;
          check.value = newValue;
          bool newValueCriterio1 = checkListSegundoCriterio[0].value;
          bool newValueCriterio2 = checkListSegundoCriterio[1].value;
          criterioSegundoImagem =
              newValueCriterio1 ? true : false;
          criterioSegundoHLAB =
          newValueCriterio2 ? true : false;
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
    print(soma);
    return soma;
  }

  int? maiorDaLista() {
    int? maior = 0;
    for (int i = 0; i < checkListSegundoCriterio.length; i++) {
      if (checkListSegundoCriterio[i].value == true) {
        if (checkListSegundoCriterio[i].pontos! > maior!) {
          maior = checkListSegundoCriterio[i].pontos;
        }
      }
    }
    print('maior => ' + maior.toString());
    return maior as int;
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
            Layout().titulo('Espondiloartrite Axial'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'Critérios classificatórios ASAS para espondiloartrite axial 2009',
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
                                    child: Layout()
                                        .titulo('Segundo critério necessário')),
                              ],
                            ),
                            SizedBox(height: 20),
                            ...checkListSegundoCriterio
                                .map(buildSegundoCriterio),
                            Divider(color: Colors.grey, thickness: 1.5),
                            SizedBox(height: 20),
                            criterioSegundoHLAB
                                ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Layout()
                                            .titulo('Achados de EpA:')),
                                  ],
                                ),
                                SizedBox(height: 20),
                                ...checkListAchadosEpaHLAB
                                    .map(buildSingleCheckbox)
                              ],
                            ):
                            criterioSegundoImagem
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Layout()
                                                  .titulo('Achados de EpA:')),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      ...checkListAchadosEpaImagem
                                          .map(buildSingleCheckbox)
                                    ],
                                  )
                                : Container(),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 20),
                  criterioEntrada && (criterioSegundoImagem || criterioSegundoHLAB)
                      ? Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal),
                                  onPressed: () {
                                    int? soma =
                                        somaPontosList(checkListAchadosEpaImagem)! +
                                            somaPontosList(checkListAchadosEpaHLAB) +
                                    maiorDaLista();
                                    setState(() {
                                      somaPontos = soma!;
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
                                            'Paciente classificado como Espondiloartrite Axial: ${somaPontos > 3 ? 'Sim.\nPontos: $somaPontos' : 'Não.\nPontos: $somaPontos pontos'}')),
                              ],
                            ),
                            RefCriteriosClassificatorios().espondiloartriteaxialASAS2009(),
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
