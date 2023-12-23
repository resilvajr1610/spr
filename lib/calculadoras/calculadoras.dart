import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'criteriosClassificatorios/CalcEpAp.dart';
import 'criteriosClassificatorios/CalcEpaxcc.dart';
import 'criteriosClassificatorios/calcApso.dart';
import 'criteriosClassificatorios/calcAtriteAcr.dart';
import 'indiceAtividade/calcDapsa.dart';
import 'indiceAtividade/calcSledai.dart';
import 'indiceAtividade/calcArtrite.dart';
import 'indiceAtividade/calcEspondiloartrite.dart';
import 'indiceAtividade/calcLLdas.dart';
import 'criteriosClassificatorios/calcLesCC.dart';
import '../standard/design.dart';
import '../standard/layout.dart';

class CalculadorasPage extends StatelessWidget {
  const CalculadorasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
         Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          Container(
            width: 50.0,
          ),
        ],
        backgroundColor: Cores.corprincipal,
        shadowColor: Cores.corprincipal,
        centerTitle: true,
      ),
      backgroundColor: Cores.corfundo,
      body: Calculadoras(),
    );
  }
}

class Calculadoras extends StatefulWidget {
  const Calculadoras({Key? key}) : super(key: key);

  @override
  _CalculadorasState createState() => _CalculadorasState();
}

class _CalculadorasState extends State<Calculadoras> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height * 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Layout().itemmenuexpansion(
                          "Indíces de Atividade",
                          ' ',
                          Icons.calculate_outlined,
                          [
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Artrite Reumatoide\nDAS28/CDAI/SDAI",
                                Artrite(), context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Espondiloartrite Axial\nASDAS/BASDAI",
                                Espondiloartrite(),
                                context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Artrite Psoriásica\nDAPSA28",
                                CalcDapsaPage(),
                                context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Lúpus Eritematoso Sistêmico\nSLEDAI-2K",
                                CalcSledaiPage(),
                                context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Lupus Eritematoso Sistêmico\nLLDAS",
                                CalcLLdasPage(), context),
                            Divider(),
                          ],
                          expansao: true),
                      Layout().itemmenuexpansion(
                          "Critérios Classificatórios",
                          ' ',
                          Icons.calculate_outlined,
                          [
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Artrite Reumatoide\nACR/EULAR 2010",
                                CalcArtriteAcrPage(),
                                context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Artrite Psoriásica\nCASPAR",
                                CalcApsoPage(),
                                context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Espondiloartrite Axial\nASAS 2009",
                                CalcEpaxccPage(),
                                context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Espondiloartrite Periférica\nASAS 2011",
                                CalcEpApPage(),
                                context),
                            Divider(),
                            Layout().listDrawerExpansionTile(
                                "Lupus Eritematoso Sistêmico\nACR/EULAR 2019",
                                LesCCPage(),
                                context),

                          ],
                          expansao: true),
                      SizedBox(height: 70)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
