import 'dart:math';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spr/calculadoras/referencias/refIndiceAtividade.dart';
import 'package:spr/standard/pesquisa.dart';

import '../../standard/design.dart';
import '../../standard/layout.dart';

class Espondiloartrite extends StatelessWidget {
  const Espondiloartrite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      body: CalcEspondilo(),
    );
  }
}

class CalcEspondilo extends StatefulWidget {
  const CalcEspondilo({Key? key}) : super(key: key);

  @override
  _CalcEspondiloState createState() => _CalcEspondiloState();
}

class _CalcEspondiloState extends State<CalcEspondilo> {
  TextEditingController dorAxial = TextEditingController();
  TextEditingController artPeriferica = TextEditingController();
  TextEditingController entesite = TextEditingController();
  TextEditingController fadiga = TextEditingController();
  TextEditingController rigidezTempo = TextEditingController();
  TextEditingController rigidezIntensidade = TextEditingController();
  TextEditingController eva = TextEditingController();
  TextEditingController vhs = TextEditingController();
  TextEditingController pcr = TextEditingController();

  double? asdaspcr, asdasvhs, basdai;
  Widget? atividadeASDASPCR, atividadeASDASVHS, atividadeBASDAI;

  double calculoASDASPCR() {
    double resultado;
    if (pcr.text == null || pcr.text.isEmpty) {
      return resultado = -1;
    } else {
      double pcrDouble = Pesquisa().replaceForDouble(pcr);
      double dorAxialDouble = Pesquisa().replaceForDouble(dorAxial);
      double artPerifericaDouble = Pesquisa().replaceForDouble(artPeriferica);
      double rigidezTempoDouble = Pesquisa().replaceForDouble(rigidezTempo);
      double evaDouble = Pesquisa().replaceForDouble(eva);

      resultado = (0.121 * dorAxialDouble) +
          (0.058 * rigidezTempoDouble) +
          (0.11 * evaDouble) +
          (0.073 * artPerifericaDouble) +
          (0.579 * (log(pcrDouble + 1)));
      print('asdaspcr : $resultado');
      return resultado;
    }
  }

  double calculoASDASVHS() {
    double resultado;
    if (vhs.text == null || vhs.text.isEmpty) {
      return resultado = -1;
    } else {
      double dorAxialDouble = Pesquisa().replaceForDouble(dorAxial);
      double artPerifericaDouble = Pesquisa().replaceForDouble(artPeriferica);
      double rigidezTempoDouble = Pesquisa().replaceForDouble(rigidezTempo);
      double evaDouble = Pesquisa().replaceForDouble(eva);
      double vhsDouble = Pesquisa().replaceForDouble(vhs);

      resultado = 0.079 * dorAxialDouble +
          0.069 * rigidezTempoDouble +
          0.113 * evaDouble +
          0.086 * artPerifericaDouble +
          0.293 * sqrt(vhsDouble);
      print('asdasvhs : $resultado');
      return resultado;
    }
  }

  double calculoBASDAI() {
    double resultado;
    double dorAxialDouble = Pesquisa().replaceForDouble(dorAxial);
    double artPerifericaDouble = Pesquisa().replaceForDouble(artPeriferica);
    double entesiteDouble = Pesquisa().replaceForDouble(entesite);
    double fadigaDouble = Pesquisa().replaceForDouble(fadiga);
    double rigidezTempoDouble = Pesquisa().replaceForDouble(rigidezTempo);
    double rigidezIntensidadeDouble = Pesquisa().replaceForDouble(rigidezIntensidade);

    resultado = (dorAxialDouble +
            artPerifericaDouble +
            entesiteDouble +
            fadigaDouble +
            ((rigidezTempoDouble + rigidezIntensidadeDouble) / 2)) /
        5;
    print('basdai : $resultado');
    return resultado;
  }

  bool checkNullPCReVHS() {
    if ((vhs.text == null || vhs.text.isEmpty) ||
        (pcr.text == null || pcr.text.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkNull() {
    if ((dorAxial.text == null || dorAxial.text.isEmpty) ||
        (artPeriferica.text == null || artPeriferica.text.isEmpty) ||
        (entesite.text == null || entesite.text.isEmpty) ||
        (fadiga.text == null || fadiga.text.isEmpty) ||
        (rigidezTempo.text == null || rigidezTempo.text.isEmpty) ||
        (rigidezIntensidade.text == null || rigidezIntensidade.text.isEmpty) ||
        (eva.text == null || eva.text.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  emojiASDASPCR() {
    setState(() {
      asdaspcr = calculoASDASPCR();
      if (asdaspcr == -1) {
        atividadeASDASPCR = Layout()
            .texto('Faltam variáveis', 11.0, FontWeight.normal, Colors.black);
      } else {
        if (asdaspcr! > 3.5) {
          atividadeASDASPCR = emojiRow(
              condition: 'Muito Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
        } else if (asdaspcr! > 2.2) {
          atividadeASDASPCR = emojiRow(
              condition: 'Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.yellow));
        } else if (asdaspcr! >= 1.3) {
          atividadeASDASPCR = emojiRow(
            condition: 'Baixa',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        } else {
          atividadeASDASPCR = emojiRow(
            condition: 'Inativa',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        }
      }
    });
  }

  emojiASDASVHS() {
    setState(() {
      asdasvhs = calculoASDASVHS();
      if (asdasvhs == -1) {
        atividadeASDASVHS = Layout()
            .texto('Faltam variáveis', 11.0, FontWeight.normal, Colors.black);
      } else {
        if (asdasvhs! > 3.5) {
          atividadeASDASVHS = emojiRow(
              condition: 'Muito Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
        } else if (asdasvhs! > 2.2) {
          atividadeASDASVHS = emojiRow(
              condition: 'Alta',
              icon: Icon(Icons.mood_bad_outlined, color: Colors.yellow));
        } else if (asdasvhs! >= 1.3) {
          atividadeASDASVHS = emojiRow(
            condition: 'Bom',
            icon: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.green,
            ),
          );
        } else {
          atividadeASDASVHS = emojiRow(
            condition: 'Inativa',
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.green),
          );
        }
      }
    });
  }

  emojiBASDAI() {
    setState(() {
      basdai = calculoBASDAI();
      if (basdai! >= 4.0) {
        atividadeBASDAI = emojiRow(
            condition: 'Doença ativa',
            icon: Icon(Icons.mood_bad_outlined, color: Colors.red));
      } else {
        atividadeBASDAI = emojiRow(
          condition: 'Inativa ou doença leve',
          icon: Icon(Icons.emoji_emotions_outlined, color: Colors.green),
        );
      }
    });
  }

  Widget emojiRow({String? condition, required Widget icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Layout().texto(
              condition, 11.0, FontWeight.normal, Colors.black,
              align: TextAlign.center),
        ),
        Expanded(child: icon)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Layout().titulo('Espondiloartrite Axial'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Layout().texto(
                    'Calcule a atividade de doença.\nASDAS e BASDAI',
                    16.0,
                    FontWeight.normal,
                    Colors.black,
                    align: TextAlign.center),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
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
                    rowVariaveis(dorAxial, 'Dor axial (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(artPeriferica, 'Artrite Periférica (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(entesite, 'Entesite (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(fadiga, 'Fadiga (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(rigidezTempo, 'Rigidez Matinal Tempo (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(rigidezIntensidade,
                        'Rigidez Matinal Intensidade (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(eva, 'EVA (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(vhs, 'VHS (0-10)'),
                    Divider(
                      color: Colors.grey,
                    ),
                    rowVariaveis(pcr, 'PCR(mg/L)'),
                    SizedBox(height: 20),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.teal),
                          onPressed: () {
                            bool check = checkNull();
                            if (check) {
                              Layout().dialog1botao(
                                  context,
                                  'Oops! Faltam variáveis.',
                                  'Apenas os campos VHS e PCR podem estar vazios.');
                            } else {
                              emojiASDASPCR();
                              emojiASDASVHS();
                              emojiBASDAI();
                              modalProduto();
                            }
                          },
                          child: Layout().texto('Calcular', 18.0,
                              FontWeight.bold, Cores.corfundo)),
                    ),
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
      ),
    );
  }

  modalProduto() {
    showCupertinoModalBottomSheet(
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
                Layout().titulo('Espondiloartrite Axial'),
                SizedBox(height: 20),
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
                            'ASDASPCR', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(
                            asdaspcr == null || asdaspcr == -1
                                ? ''
                                : asdaspcr!.toStringAsFixed(2),
                            18.0,
                            FontWeight.normal,
                            Colors.black,
                            align: TextAlign.center)),
                    atividadeASDASPCR != null
                        ? Expanded(child: atividadeASDASPCR!)
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
                            'ASDASVHS', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(
                            asdasvhs == null || asdasvhs == -1
                                ? ''
                                : asdasvhs!.toStringAsFixed(2),
                            18.0,
                            FontWeight.normal,
                            Colors.black,
                            align: TextAlign.center)),
                    atividadeASDASVHS != null
                        ? Expanded(child: atividadeASDASVHS!)
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
                            'BASDAI', 18.0, FontWeight.bold, Colors.black,
                            align: TextAlign.center)),
                    Expanded(
                        child: Layout().texto(
                            basdai == null || basdai == -1
                                ? ''
                                : basdai!.toStringAsFixed(2),
                            18.0,
                            FontWeight.normal,
                            Colors.black,
                            align: TextAlign.center)),
                    atividadeBASDAI != null
                        ? Expanded(child: atividadeBASDAI!)
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
                tabelaReferenciaASDAS(),
                tabelaReferenciaBasdai(),
                RefIndiceAtividade().espondiloartrite(),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  Widget tabelaReferenciaASDAS() {
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
                  'ASDAS', 18.0, FontWeight.bold, Colors.black,
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
                  '< 1,3', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto(
                  'Doença Inativa', 18.0, FontWeight.normal, Colors.black,
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
                  '≥ 1,3  e 2,2', 18.0, FontWeight.bold, Colors.black,
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
                  ' 2,2 e ≤ 3,5', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto('Alta atividade de doença', 18.0,
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
                  '> 3,5', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto('Atividade de doença muito alta', 18.0,
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

  Widget tabelaReferenciaBasdai() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Layout().texto(
                  'BASDAI', 18.0, FontWeight.bold, Colors.black,
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
                  '< 4', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto(
                  'Inativa ou doença leve', 18.0, FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Layout().texto('≥ 4', 18.0, FontWeight.bold, Colors.black,
                  align: TextAlign.center),
            ),
            Expanded(
              child: Layout().texto(
                  'Doença Ativa', 18.0, FontWeight.normal, Colors.black,
                  align: TextAlign.center),
            ),
          ],
        ),
      ],
    );
  }

  Widget rowVariaveis(TextEditingController controller, String nomeVariavel,
      {String? intervalo}) {
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
          child: Layout().caixadetexto(
              1,
              1,
              TextInputType.numberWithOptions(decimal: true),
              controller,
              nomeVariavel,
              TextCapitalization.none,
              hasFormatters: true),
        ),
      ],
    );
  }
}
