
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/calculadoras/referencias/refIndiceAtividade.dart';
import 'package:spr/standard/pesquisa.dart';
import '../../standard/design.dart';

import '../../standard/layout.dart';

class CalcDapsaPage extends StatelessWidget {
  const CalcDapsaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corfundo,
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcArtrite(),
    );
  }
}

class CalcArtrite extends StatefulWidget {
  const CalcArtrite({Key? key}) : super(key: key);

  @override
  _CalcArtriteState createState() => _CalcArtriteState();
}

class _CalcArtriteState extends State<CalcArtrite> {
  TextEditingController tjc = TextEditingController();
  TextEditingController sjc = TextEditingController();
  TextEditingController eva = TextEditingController();
  TextEditingController avaliacaoglobal = TextEditingController();
  TextEditingController pcr = TextEditingController();


  double? dapsa28, das28pcr, cdai, sdai;
  Widget? atividadedapsa28, atividadeDAS28PCR, atividadeCDAI, atividadeSDAI;

  double calculardapsa28() {
    double resultado;
      double tjcDouble = Pesquisa().replaceForDouble(tjc);
      double sjcDouble = Pesquisa().replaceForDouble(sjc);
      double evaDouble = Pesquisa().replaceForDouble(eva);
      double avaliacaoDouble = Pesquisa().replaceForDouble(avaliacaoglobal);
      double pcrDouble = Pesquisa().replaceForDouble(pcr);
      resultado = ((1.6 * tjcDouble) + (1.6 * sjcDouble) + evaDouble + avaliacaoDouble + (pcrDouble/10));
      print('dapsa28 : $resultado');
      return resultado;
    }

  emojidapsa28() {
    setState(() {
      dapsa28 = calculardapsa28();
      if (dapsa28 == -1) {
        atividadedapsa28 = Layout()
            .texto('Faltam variáveis', 11.0, FontWeight.normal, Colors.black);
      } else {
        if (dapsa28! > 28.0) {
          atividadedapsa28 = emojiRow(
              condition: 'Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
        } else if (dapsa28! > 14.0) {
          atividadedapsa28 = emojiRow(
              condition: 'Moderada',
              icon: Icon(Icons.insert_emoticon_outlined, color: Colors.yellow));
        } else if (dapsa28! > 4.0) {
          atividadedapsa28 = emojiRow(
            condition: 'Baixa',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        } else {
          atividadedapsa28 = emojiRow(
            condition: 'Remissão',
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.green),
          );
        }
      }
    });
  }

  Widget emojiRow({String? condition, required Widget icon}) {
    return Row(
      children: [
        Flexible(
            child: Layout().texto(
                condition, 11.0, FontWeight.normal, Colors.black,
                align: TextAlign.center)),
        SizedBox(width: 10),
        Flexible(child: icon)
      ],
    );
  }



  bool checkNull() {
    if ((tjc.text == null || tjc.text.isEmpty) ||
        (sjc.text == null || sjc.text.isEmpty) ||
        (eva.text == null || eva.text.isEmpty) ||
        (avaliacaoglobal.text == null || avaliacaoglobal.text.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Layout().titulo('DAPSA28\n(Disease Activity in Psoriatic Arthritis)'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'Calcule a atividade da doença.',
                  16.0,
                  FontWeight.normal,
                  Colors.black,
                  align: TextAlign.center),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Layout().titulo('Variáveis'),
                      Layout().titulo('Valores')
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  rowVariaveis(tjc, 'TJC', intervalo: '0 - 28'),
                  Divider(
                    color: Colors.grey,
                  ),
                  rowVariaveis(sjc, 'SJC', intervalo: '0 - 28'),
                  Divider(
                    color: Colors.grey,
                  ),
                  rowVariaveis(eva, 'EVA (0-10)'),
                  Divider(
                    color: Colors.grey,
                  ),
                  rowVariaveis(avaliacaoglobal, 'Avaliação Global do Paciente (0 - 10)'),
                  Divider(
                    color: Colors.grey,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  rowVariaveis(pcr, 'PCR (mg/L)'),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                        onPressed: () {
                          bool check = checkNull();
                          if (check) {
                            Layout().dialog1botao(
                                context,
                                'Faltam variáveis.',
                                'Preencha todos os campos.');
                          } else {
                            emojidapsa28();
                            modalMetrica();
                          }
                        },
                        child: Layout().texto(
                            'Calcular', 18.0, FontWeight.bold, Cores.corfundo)),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
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
                    Layout().titulo('Artrite Psoriásica'),
                    SizedBox(height: 30),
                    Divider(
                      color: Cores.corprincipal.withOpacity(0.7),
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Layout().texto(
                                'DAPSA28', 18.0, FontWeight.bold, Colors.black,
                                align: TextAlign.center)),
                        Expanded(
                            child: Layout().texto(
                                dapsa28 == null || dapsa28 == -1
                                    ? ''
                                    : dapsa28!.toStringAsFixed(2),
                                18.0,
                                FontWeight.normal,
                                Colors.black,
                                align: TextAlign.center)),
                        atividadedapsa28 != null
                            ? Expanded(child: atividadedapsa28!)
                            : Expanded(child: Container())
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
                    tabelaReferenciaDAPSA(),
                    RefIndiceAtividade().artritePsoriasica()
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget tabelaReferenciaDAPSA() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Layout().titulo('Valores de referência'),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Cores.corprincipal.withOpacity(0.7),
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Layout().texto(
                  'DAPSA28', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto(
                  'Atividade', 18.0, FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
          ],
        ),
        Divider(
          color: Cores.corprincipal.withOpacity(0.7),
          height: 3,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Layout().texto(
                  '≤ 4', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto(
                  'Remissão', 18.0, FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Layout().texto(
                  '> 4 até 14', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto('Baixa atividade de doença', 18.0,
                  FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Layout().texto(
                  '> 14 até 28', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto('Moderada atividade de doença', 18.0,
                  FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Layout().texto(
                  '> 28', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto('Alta altividade de doença', 18.0,
                  FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          color: Cores.corprincipal.withOpacity(0.7),
          height: 3,
        ),
      ],
    );
  }

  Widget rowVariaveis(TextEditingController controller, String nomeVariavel,
      {String? intervalo, Function? function}) {
    return Row(
      children: [
        Expanded(
            child: Layout().texto(
                intervalo == null
                    ? nomeVariavel
                    : nomeVariavel + '($intervalo)',
                18.0,
                FontWeight.normal,
                Colors.black,
                align: TextAlign.center)),
        Expanded(
          child: Layout().caixadetexto(1, 1, TextInputType.numberWithOptions(decimal: true), controller,
              nomeVariavel, TextCapitalization.none, hasFormatters: true),
        ),
      ],
    );
  }
}
