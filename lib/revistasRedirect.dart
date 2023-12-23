import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'standard/design.dart';
import 'standard/layout.dart';
import 'webviewSpr.dart';

class RevistasPage extends StatelessWidget {
  const RevistasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      backgroundColor: Cores.corfundo,
      body: Revistas(),
    );
  }
}

class Revistas extends StatefulWidget {
  const Revistas({Key? key}) : super(key: key);

  @override
  _RevistasState createState() => _RevistasState();
}

class _RevistasState extends State<Revistas> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Flexible(child: Layout().titulo('Publicações da SPR')),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Layout().itemmenuexpansion(
                        "Revistas",
                        "Conheça a RPR",
                        Icons.chrome_reader_mode,
                        [
                          Layout().listDrawerExpansionTile(
                              "Todas as edições",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/revista/',
                                  true) /*Revistas()*/,
                              context),
                          Layout().listDrawerExpansionTile(
                              "Edição atual",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/revista/reumatologia-pediatrica/',
                                  true),
                              context),
                          Layout().listDrawerExpansionTile(
                              "Apresentação",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/revista-paulista-de-reumatologia/',
                                  true),
                              context),
                          Layout().listDrawerExpansionTile(
                              "Expediente",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/revista-paulista-de-reumatologia/expediente/',
                                  true),
                              context),
                          Layout().listDrawerExpansionTile(
                              "Normas para publicação",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/revista-paulista-de-reumatologia/normas-para-publicacao/',
                                  true),
                              context),
                          Layout().listDrawerExpansionTile(
                              "Política Editorial RPR Crossmark",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/politica-editorial-rpr-crossmark/',
                                  true),
                              context),
                        ],
                        expansao: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
