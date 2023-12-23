import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spr/calculadoras/referencias/refCriteriosClassificatorios.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';
import '../../standard/objetos.dart';

class CalcArtriteAcrPage extends StatelessWidget {
  const CalcArtriteAcrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcArtriteAcr(),
    );
  }
}

class CalcArtriteAcr extends StatefulWidget {
  const CalcArtriteAcr({Key? key}) : super(key: key);

  @override
  _CalcArtriteAcrState createState() => _CalcArtriteAcrState();
}

class _CalcArtriteAcrState extends State<CalcArtriteAcr> {
  int somaPontos = 0;
  final _controller = ScrollController();
  int? selectedRadioTile1 = -1,
      selectedRadioTile2 = -1,
      selectedRadioTile3 = -1,
      selectedRadioTile4 = -1,
      selectedRadioEntrada = -1;
  int pontoAcometimento = 0,
      pontoSorologia = 0,
      pontoAtividadeInflamatoria = 0,
      pontoDuracaoSintomas = 0;
  late List<ArtriteObj> optionsList1;
  late List<ArtriteObj> optionsList2;
  late List<ArtriteObj> optionsList3;
  late List<ArtriteObj> optionsList4;
  bool criterioEntrada = false;

  final checkListEntrada = [
    CheckBoxLupus(
        title: 'Paciente apresenta sinovite em ao menos uma articulação que não seja melhor explicada por outra doença',
        pontos: 0),
  ];

  setSelectedRadio1(int? val) {
    setState(() {
      selectedRadioTile1 = val;
    });
  }

  setSelectedRadio2(int? val) {
    setState(() {
      selectedRadioTile2 = val;
    });
  }

  setSelectedRadio3(int? val) {
    setState(() {
      selectedRadioTile3 = val;
    });
  }

  setSelectedRadio4(int? val) {
    setState(() {
      selectedRadioTile4 = val;
    });
  }

  setSelectedRadioEntrada(int val) {
    setState(() {
      selectedRadioEntrada = val;
    });
  }

  @override
  void initState() {
    optionsList1 = ArtriteObj.getOptions1();
    optionsList2 = ArtriteObj.getOptions2();
    optionsList3 = ArtriteObj.getOptions3();
    optionsList4 = ArtriteObj.getOptions4();
    super.initState();
  }

  int calcularPontosGrupo1() {
    int pontos;
    pontos = (optionsList1[selectedRadioTile1!].pontos)!;
    return pontos;
  }

  int calcularPontosGrupo2() {
    int pontos;
    pontos = (optionsList2[selectedRadioTile2!].pontos)!;
    return pontos;
  }

  int calcularPontosGrupo3() {
    int pontos;
    pontos = (optionsList3[selectedRadioTile3!].pontos)!;
    return pontos;
  }

  int calcularPontosGrupo4() {
    int pontos;
    pontos = (optionsList4[selectedRadioTile4!].pontos)!;
    return pontos;
  }

  calculoFinal() {
    int i = calcularPontosGrupo1();
    int p = calcularPontosGrupo2();
    int k = calcularPontosGrupo3();
    int z = calcularPontosGrupo4();
    setState(() {
      pontoAcometimento = i;
      pontoSorologia = p;
      pontoAtividadeInflamatoria = k;
      pontoDuracaoSintomas = z;
      somaPontos = i + p + k + z;
    });
    print('z =>' + pontoDuracaoSintomas.toString());
    goToBottomOfPage();
  }

  rowTabela(String titulo, int pontos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Layout().texto(titulo, 15.0, FontWeight.normal, Colors.black,
                align: TextAlign.center)),
        Expanded(
          child: Layout().texto(
              '$pontos pontos', 15.0, FontWeight.normal, Colors.black,
              align: TextAlign.center),
        ),
      ],
    );
  }

  goToBottomOfPage() {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  Widget dividerPadrao() {
    return Column(
      children: [
        Divider(color: Colors.grey, thickness: 1.5),
        SizedBox(height: 20),
      ],
    );
  }

  bool checkIfNotChecked() {
    if (selectedRadioTile1 == -1 ||
        selectedRadioTile2 == -1 ||
        selectedRadioTile3 == -1 ||
        selectedRadioTile4 == -1) {
      print('nada marcado');
      return true;
    } else {
      return false;
    }
  }

  Widget buildCheckbox({required CheckBoxLupus check,
    required VoidCallback onClicked,
    bool? isFanPositivo}) =>
      ListTile(
        title: Layout().texto(check.title, 18.0, FontWeight.normal, Colors.black),
        leading:
        Checkbox(value: check.value, onChanged: (value) => onClicked()),
      );

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
            Layout().titulo('Artrite Reumatoide'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto('Critérios de classificação ACR/EULAR 2010',
                  16.0, FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
            SizedBox(height: 20),
            dividerPadrao(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Layout().titulo('Critério de entrada obrigatório')),
                    ],
                  ),
                  SizedBox(height: 10),
                  ...checkListEntrada.map(buildCriterioEntrada),
                  SizedBox(height: 10),
                  dividerPadrao(),
                  SizedBox(height: 10),
                  criterioEntrada ?
                  Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Layout().titulo('Acometimento articular')),
                    ],
                  ),
                  SizedBox(height: 10),
                  RadioListTile(
                      value: 0,
                      groupValue: selectedRadioTile1,
                      title: Layout().texto(optionsList1[0].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList1[0].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      activeColor: Cores.corprincipal,
                      onChanged: (dynamic val) {
                        setSelectedRadio1(val);
                      }),
                  RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile1,
                      title: Layout().texto(optionsList1[1].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList1[1].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      activeColor: Cores.corprincipal,
                      onChanged: (dynamic val) {
                        setSelectedRadio1(val);
                      }),
                  RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile1,
                      title: Layout().texto(optionsList1[2].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList1[2].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      activeColor: Cores.corprincipal,
                      onChanged: (dynamic val) {
                        setSelectedRadio1(val);
                      }),
                  RadioListTile(
                      value: 3,
                      groupValue: selectedRadioTile1,
                      title: Layout().texto(optionsList1[3].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList1[3].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      activeColor: Cores.corprincipal,
                      onChanged: (dynamic val) {
                        setSelectedRadio1(val);
                      }),
                  RadioListTile(
                      value: 4,
                      groupValue: selectedRadioTile1,
                      title: Layout().texto(optionsList1[4].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList1[4].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      activeColor: Cores.corprincipal,
                      onChanged: (dynamic val) {
                        setSelectedRadio1(val);
                      }),
                  dividerPadrao(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Layout().titulo('Sorologia')),
                    ],
                  ),
                  SizedBox(height: 10),
                  RadioListTile(
                      value: 0,
                      groupValue: selectedRadioTile2,
                      title: Layout().texto(optionsList2[0].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList2[0].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      onChanged: (dynamic val) {
                        setSelectedRadio2(val);
                        setState(() {});
                      }),
                  RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile2,
                      title: Layout().texto(optionsList2[1].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList2[1].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      onChanged: (dynamic val) {
                        setSelectedRadio2(val);
                      }),
                  RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile2,
                      title: Layout().texto(optionsList2[2].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList2[2].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      onChanged: (dynamic val) {
                        setSelectedRadio2(val);
                      }),
                  dividerPadrao(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Layout()
                              .titulo('Provas de atividades inflamatórias')),
                    ],
                  ),
                  SizedBox(height: 10),
                  RadioListTile(
                      value: 0,
                      groupValue: selectedRadioTile3,
                      title: Layout().texto(optionsList3[0].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList3[0].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      onChanged: (dynamic val) {
                        setSelectedRadio3(val);
                      }),
                  RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile3,
                      title: Layout().texto(optionsList3[1].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList3[1].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      onChanged: (dynamic val) {
                        setSelectedRadio3(val);
                      }),
                  dividerPadrao(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Layout().titulo('Duração dos sintomas')),
                    ],
                  ),
                  SizedBox(height: 10),
                  RadioListTile(
                      value: 0,
                      groupValue: selectedRadioTile4,
                      title: Layout().texto(optionsList4[0].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList4[0].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      onChanged: (dynamic val) {
                        setSelectedRadio4(val);
                      }),
                  RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile4,
                      title: Layout().texto(optionsList4[1].title, 15.0,
                          FontWeight.normal, Colors.black),
                      subtitle: Layout().texto(
                          'Pontos: ' + optionsList4[1].pontos.toString(),
                          15.0,
                          FontWeight.bold,
                          Colors.black),
                      onChanged: (dynamic val) {
                        setSelectedRadio4(val);
                      }),
                  ],) : Container(),
                  criterioEntrada ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.teal),
                        onPressed: () {
                          bool check = checkIfNotChecked();
                          if (check == true) {
                            Layout().dialog1botao(
                                context,
                                'Oops! Campos vazios encontrados.',
                                'É necessário a marcação de ao menos um critério por grupo.');
                          } else {
                            calculoFinal();
                            modalMetrica();
                            print('\n');
                            print('1 =>' + selectedRadioTile1.toString());
                            print('2 =>' + selectedRadioTile2.toString());
                            print('3 =>' + selectedRadioTile3.toString());
                            print('4 =>' + selectedRadioTile4.toString());
                            print('\n');
                          }
                        },
                        child: Layout().texto(
                            'Calcular', 18.0, FontWeight.bold, Cores.corfundo)),
                  ) : Container(),
                  SizedBox(height: 50)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  modalMetrica() {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        color: Cores.corprincipal,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios))
                  ],
                ),
                Layout().titulo('Artrite Reumatoide'),
                SizedBox(height: 15),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Layout().titulo('Grupo'),
                    ),
                    Expanded(
                      child: Layout().titulo('Pontuação'),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                SizedBox(height: 20),
                rowTabela('Acometimento articular', pontoAcometimento),
                SizedBox(height: 20),
                rowTabela('Sorologia', pontoSorologia),
                SizedBox(height: 20),
                rowTabela('Atividade inflamatória', pontoAtividadeInflamatoria),
                SizedBox(height: 20),
                rowTabela('Duração sintomas', pontoDuracaoSintomas),
                SizedBox(height: 20),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Layout().titulo('Total')),
                    Expanded(
                        child:
                            Layout().titulo(somaPontos.toString() + ' pontos')),
                  ],
                ),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                SizedBox(height: 15),
                Layout().texto(
                    'Resultado:', 18.0, FontWeight.bold, Colors.black,
                    align: TextAlign.center),
                somaPontos >= 6
                    ? Layout().texto('Preenche critério para AR', 18.0,
                        FontWeight.normal, Colors.red, align: TextAlign.center)
                    : Layout().texto('Não preenche critério para AR', 18.0,
                        FontWeight.normal, Cores.corprincipal,
                        align: TextAlign.center),
                Divider(),
                SizedBox(height: 10),
                Layout().texto(
                    'Pontuação maior ou igual a 6, classifica como Artrite Reumatoide.',
                    18.0,
                    FontWeight.normal,
                    Colors.black,
                    align: TextAlign.center),
                RefCriteriosClassificatorios().artritereumatoide()
              ],
            ),
          ),
        ));
      },
    );
  }
}
