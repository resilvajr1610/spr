import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spr/calculadoras/referencias/refIndiceAtividade.dart';
import 'package:spr/standard/pesquisa.dart';
import '../../standard/design.dart';

import '../../standard/layout.dart';

class Artrite extends StatelessWidget {
  const Artrite({Key? key}) : super(key: key);

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
  TextEditingController medico = TextEditingController();
  TextEditingController vhs = TextEditingController();
  TextEditingController pcr = TextEditingController();

  //formula : 0.56*raiz(tjc)+0.28*raiz(sjc)+0.7 * logaritimoNatural(vhs)+0.14*eva
  // pcr 0,56*RAIZ(tjc)+0,28*RAIZ(sjc)+0,36*LN(pcr+1)+0,14*eva+0,96)
  // cdai soma (tjc + sjc + eva + medico)
  // sdai (tjc + sjc + (pcr/10) + eva + medico)
  double? das28vhs, das28pcr, cdai, sdai;
  Widget? atividadeDAS28VHS, atividadeDAS28PCR, atividadeCDAI, atividadeSDAI;

  double calcularDAS28VHS() {
    double resultado;
    if (vhs.text == null || vhs.text.isEmpty) {
      return resultado = -1;
    } else {
      double tjcDouble = Pesquisa().replaceForDouble(tjc);
      double sjcDouble = Pesquisa().replaceForDouble(sjc);
      double evaDouble = Pesquisa().replaceForDouble(eva);
      double vhsDouble = Pesquisa().replaceForDouble(vhs);
      resultado = (0.56 * sqrt(tjcDouble)) +
          (0.28 * sqrt(sjcDouble)) +
          (0.7 * log(vhsDouble)) +
          (0.14 * evaDouble);
      print('DAS28VHS : $resultado');
      return resultado;
    }
  }

  calcularDAS28PCR() {
    double resultado;

    if (pcr.text == null || pcr.text.isEmpty) {
      return resultado = -1;
    } else {
      double tjcDouble = Pesquisa().replaceForDouble(tjc);
      double sjcDouble = Pesquisa().replaceForDouble(sjc);
      double evaDouble = Pesquisa().replaceForDouble(eva);
      double pcrDouble = Pesquisa().replaceForDouble(pcr);

      resultado = (0.56 * sqrt(tjcDouble)) +
          (0.28 * sqrt(sjcDouble)) +
          (0.36 * log(pcrDouble + 1)) +
          ((0.14 * evaDouble) + 0.96);
      print('DAS28PCR : $resultado');
      return resultado;
    }
  }

  double calcularCDAI() {
    //bool check = checkNullPCReVHS();
    double resultado;
    double tjcDouble = Pesquisa().replaceForDouble(tjc);
    double sjcDouble = Pesquisa().replaceForDouble(sjc);
    double evaDouble = Pesquisa().replaceForDouble(eva);
    double medicoDouble = Pesquisa().replaceForDouble(medico);

    resultado = (tjcDouble + sjcDouble + evaDouble + medicoDouble);
    print('CDAI: $resultado');
    return resultado;
  }

  double calcularSDAI() {
    double resultado;
    if (pcr.text == null || pcr.text.isEmpty) {
      return resultado = -1;
    } else {
      double tjcDouble = Pesquisa().replaceForDouble(tjc);
      double sjcDouble = Pesquisa().replaceForDouble(sjc);
      double evaDouble = Pesquisa().replaceForDouble(eva);
      double medicoDouble = Pesquisa().replaceForDouble(medico);
      double pcrDouble = Pesquisa().replaceForDouble(pcr);

      resultado =
          (tjcDouble + sjcDouble + (pcrDouble / 10) + evaDouble + medicoDouble);
      print('sdai: $resultado');
      return resultado;
    }
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

  emojiDAS28VHS() {
    setState(() {
      das28vhs = calcularDAS28VHS();
      if (das28vhs == -1) {
        atividadeDAS28VHS = Layout()
            .texto('Faltam variáveis', 11.0, FontWeight.normal, Colors.black);
      } else {
        if (das28vhs! > 5.1) {
          atividadeDAS28VHS = emojiRow(
              condition: 'Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
        } else if (das28vhs! > 3.2) {
          atividadeDAS28VHS = emojiRow(
              condition: 'Moderada',
              icon: Icon(Icons.insert_emoticon_outlined, color: Colors.yellow));
        } else if (das28vhs! > 2.6) {
          atividadeDAS28VHS = emojiRow(
            condition: 'Baixa',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        } else {
          atividadeDAS28VHS = emojiRow(
            condition: 'Remissão',
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.green),
          );
        }
      }
    });
  }

  emojiDAS28PCR() {
    setState(() {
      das28pcr = calcularDAS28PCR();
      if (das28pcr == -1) {
        atividadeDAS28PCR = Layout()
            .texto('Faltam variáveis', 11.0, FontWeight.normal, Colors.black);
      } else {
        if (das28pcr! > 5.1) {
          atividadeDAS28PCR = emojiRow(
              condition: 'Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
        } else if (das28pcr! > 3.2) {
          atividadeDAS28PCR = emojiRow(
              condition: 'Moderada',
              icon: Icon(Icons.insert_emoticon_outlined, color: Colors.yellow));
        } else if (das28pcr! > 2.6) {
          atividadeDAS28PCR = emojiRow(
            condition: 'Baixa',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        } else {
          atividadeDAS28PCR = emojiRow(
            condition: 'Remissão',
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.green),
          );
        }
      }
    });
  }

  emojiCDAI() {
    setState(() {
      cdai = calcularCDAI();
      if (cdai == -1) {
        atividadeCDAI = Layout()
            .texto('Faltam variáveis', 11.0, FontWeight.normal, Colors.black);
      } else {
        if (cdai! > 22) {
          print('entrou');
          atividadeCDAI = emojiRow(
              condition: 'Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
        } else if (cdai! > 10) {
          print('entrou else if 1');
          atividadeCDAI = emojiRow(
              condition: 'Moderada',
              icon: Icon(Icons.insert_emoticon_outlined, color: Colors.yellow));
        } else if (cdai! > 2.8) {
          print('entrou else if 2');
          atividadeCDAI = emojiRow(
            condition: 'Baixa',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        } else {
          atividadeCDAI = emojiRow(
            condition: 'Remissão',
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.green),
          );
        }
      }
    });
  }

  emojiSDAI() {
    setState(() {
      sdai = calcularSDAI();
      if (sdai == -1) {
        atividadeSDAI = Layout()
            .texto('Faltam variáveis', 11.0, FontWeight.normal, Colors.black);
      } else {
        if (sdai! > 26) {
          print('entrou');
          atividadeSDAI = emojiRow(
              condition: 'Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
        } else if (sdai! > 11) {
          print('entrou else if 1');
          atividadeSDAI = emojiRow(
              condition: 'Moderada',
              icon: Icon(Icons.insert_emoticon_outlined, color: Colors.yellow));
        } else if (cdai! > 3.3) {
          print('entrou else if 2');
          atividadeSDAI = emojiRow(
            condition: 'Baixa',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        } else {
          atividadeSDAI = emojiRow(
            condition: 'Remissão',
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.green),
          );
        }
      }
    });
  }

  bool checkNull() {
    if ((tjc.text == null || tjc.text.isEmpty) ||
        (sjc.text == null || sjc.text.isEmpty) ||
        (eva.text == null || eva.text.isEmpty) ||
        (medico.text == null || medico.text.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkNullPCReVHS() {
    if ((vhs.text == null || vhs.text.isEmpty) ||
        (pcr.text == null || pcr.text.isEmpty)) {
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
            Layout().titulo('Artrite Reumatoide'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Layout().texto(
                  'Calcule a atividade de doença.\nDAS28, CDAI e SDAI',
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
                  rowVariaveis(medico, 'Médico (0 - 10)'),
                  Divider(
                    color: Colors.grey,
                  ),
                  rowVariaveis(vhs, 'VHS'),
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
                                'Oops! Faltam variáveis.',
                                'Apenas os campos VHS e PCR podem estar vazios.');

                          }
                          else {
                            if (vhs.text == '0'){
                              vhs.clear();
                            }
                            emojiDAS28VHS();
                            emojiDAS28PCR();
                            emojiCDAI();
                            emojiSDAI();
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
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
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
                Layout().titulo('Artrite Reumatoide'),
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
                            'DAS28VHS', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(
                            das28vhs == null || das28vhs == -1
                                ? ''
                                : das28vhs!.toStringAsFixed(2),
                            18.0,
                            FontWeight.normal,
                            Colors.black,
                            align: TextAlign.center)),
                    atividadeDAS28VHS != null
                        ? Expanded(child: atividadeDAS28VHS!)
                        : Expanded(child: Container())
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: Layout().texto(
                            'DAS28PCR', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(
                            das28pcr == null || das28pcr == -1
                                ? ''
                                : das28pcr!.toStringAsFixed(2),
                            18.0,
                            FontWeight.normal,
                            Colors.black,
                            align: TextAlign.center)),
                    atividadeDAS28PCR != null
                        ? Expanded(child: atividadeDAS28PCR!)
                        : Expanded(child: Container())
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: Layout().texto(
                            'CDAI', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(
                            cdai == null || cdai == -1
                                ? ''
                                : cdai!.toStringAsFixed(2),
                            18.0,
                            FontWeight.normal,
                            Colors.black,
                            align: TextAlign.center)),
                    atividadeCDAI != null
                        ? Expanded(child: atividadeCDAI!)
                        : Expanded(child: Container())
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: Layout().texto(
                            'SDAI', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(
                            sdai == null || sdai == -1
                                ? ''
                                : sdai!.toStringAsFixed(2),
                            18.0,
                            FontWeight.normal,
                            Colors.black,
                            align: TextAlign.center)),
                    atividadeSDAI != null
                        ? Expanded(child: atividadeSDAI!)
                        : Expanded(child: Container())
                  ],
                ),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/ar_tabela.png')),
                Divider(
                  color: Cores.corprincipal.withOpacity(0.7),
                  height: 3,
                ),
                SizedBox(height: 20,),
               RefIndiceAtividade().artrite()
              ],
            ),
          ),
        ));
      },
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
