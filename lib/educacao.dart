import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'standard/design.dart';
import 'standard/layout.dart';
import 'webviewSpr.dart';

class EducacaoPage extends StatelessWidget {
  const EducacaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Layout().defaultAppBar(context, seta: true) as PreferredSizeWidget?,
      backgroundColor: Cores.corfundo,
      body: Educacao(),
    );
  }
}

class Educacao extends StatefulWidget {
  const Educacao({Key? key}) : super(key: key);

  @override
  _EducacaoState createState() => _EducacaoState();
}

class _EducacaoState extends State<Educacao> {
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
              Flexible(child: Layout().titulo('Conhecimento da SPR')),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Layout().itemmenuexpansion(
                        "Educação",
                        "Exclusivos da SPR",
                        Icons.class_,
                        [
                          Layout().listDrawerExpansionTileURL("EAD", context,
                              urlToLaunch:
                                  'https://www.reumatologiasp.com.br/ead/'),
                          Layout().listDrawerExpansionTile(
                              "Fórum de debates",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/conteudo/eventos/forum/',
                                  true),
                              context),
                          Layout().listDrawerExpansionTile(
                              "Encontro de Reumatologia Avançada",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/conteudo/eventos/era/',
                                  true),
                              context),
                          Layout().listDrawerExpansionTile(
                              "Curso de Revisão para Reumatologistas",
                              WebviewSpr(
                                  'https://www.reumatologiasp.com.br/conteudo/eventos/crr/',
                                  true) /*CursosEad()*/,
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
