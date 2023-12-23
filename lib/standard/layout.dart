
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import '../calculadoras/calculadoras.dart';
import '../main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../webviewSpr.dart';
import 'design.dart';
import 'objetos.dart';
import 'pesquisa.dart';

class Layout {

  Widget scrollDefaultPage(scrollController, user,  context, String tituloPg,
      {required List<Widget> children,
      bool hasDrawer = false,
      bool setaVoltar = false,
      String? subtitulo,
      double appBarHeight = 120,
      floatingActionButton}) {
    return Scaffold(
      appBar: Layout().defaultAppBar(context, seta: setaVoltar) as PreferredSizeWidget?,
      drawer: hasDrawer ? Layout().defaultDrawer(user, context) : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(children: [
            Container(
              color: Cores.corprincipal,
              height: MediaQuery.of(context).size.height * 0.10,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                child: tituloesubtitulo(tituloPg,
                    textSubtitle: subtitulo, isSubtitle: subtitulo != null),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: children),
                SizedBox(height: 70),
              ],
            ),
          ]),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  bodyEstatico(context){
    return Column(children: [
      Container(
          height: 80,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              SizedBox(width: 30,),
              Image.asset('assets/logohorizontal_mono.png', fit: BoxFit.contain, width: 250,),
              Spacer(),
            ],
          )),
      Expanded(child: Container(
        color: Colors.teal[50],
        width: MediaQuery.of(context).size.width,
        child: Shimmer.fromColors(
          baseColor: Colors.teal[300]!,
          highlightColor: Colors.teal[100]!,
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Image.asset(
              'assets/logo_sub.png',
            ),
          ),
        ),
      ),)
    ],);
  }

  Widget defaultAppBar(BuildContext context,
      {bool seta = true,
      bool menu = false,
      Widget? titulo}) {
    return AppBar(
      title: titulo != null ? titulo : null,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,
      leading: seta
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios))
          : null,
      actions: [
        Container(
          width: 50.0,
        ),
      ],
      backgroundColor: Cores.corprincipal,
      shadowColor: Cores.corprincipal,
      centerTitle: true,
    );
  }

  itemmenuexpansion(String text, subtitle, icon, List<Widget> lista,
      {bool? expansao}) {
    return ExpansionTile(
      initiallyExpanded: expansao == null ? false : expansao,
      backgroundColor: Cores.corfundo,
      tilePadding: EdgeInsets.only(right: 15),
      title: ListTile(
        selectedTileColor: Cores.corprincipal,
        title: Text(
          text,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600,
              fontSize: 17.0),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w300,
              fontSize: 14.0),
        ),
        leading: Icon(icon),
      ),
      children: lista,
    );
  }

  listDrawerExpansionTile(
    String titulo,
    destino,
    context,
  ) {
    return ListTile(
        onTap: () {
          Pesquisa().irpara(destino, context);
        },
        title: Text(
          titulo,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w300,
              fontSize: 17.0),
        ),
        leading: Container(
          width: 30,
        ));
  }

  listDrawerExpansionTileURL(String titulo, context, {String? urlToLaunch}) {
    return ListTile(
        onTap: () {
          if (urlToLaunch != null && urlToLaunch.isNotEmpty) {
            _launchURL(urlToLaunch);
          }
        },
        title: Text(
          titulo,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w300,
              fontSize: 17.0),
        ),
        leading: Container(
          width: 30,
        ));
  }

  Drawer defaultDrawer(user, context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Layout().menuheader(user, context),
              SizedBox(height: 10),
              user.getLogado()
                  ? Layout().itemdrawer("Calculadoras",
                      Icons.calculate_outlined, CalculadorasPage(), context)
                  : Layout().itemdrawerComDialog(
                      "Calculadoras",
                      Icons.calculate_outlined,
                      WebviewSpr(
                          'https://www.reumatologiasp.com.br/entrar', true,
                          calculadora: true),
                      context),
              Layout().itemmenuexpansion(
                  "Conteúdo", "Agenda, notícias, etc", Icons.assignment, [
                listDrawerExpansionTile(
                    "Agenda",
                    WebviewSpr('https://www.reumatologiasp.com.br/agenda/',
                        true) /*Agenda(usuario)*/,
                    context),
                listDrawerExpansionTile(
                    "Notícias",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/conteudo/noticias/',
                        true) /*Noticias()*/,
                    context),
                listDrawerExpansionTile(
                    "SPR na midia",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/conteudo/spr-na-midia/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Artigos cientificos",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/artigos-cientificos/#1615285995038-bef094e9-f8e9',
                        true) /*Artigos()*/,
                    context),
                listDrawerExpansionTile(
                    "Lives SPR 2021",
                    WebviewSpr(
                        'https://www.youtube.com/playlist?list=PLFK4fswpKc9tvK018QjgelE9ClO_qFnPp',
                        true),
                    context),
                Layout().itemmenuexpansion("Reumacast", "", null, [
                  listDrawerExpansionTile(
                      "Spotify",
                      WebviewSpr(
                          'https://open.spotify.com/show/2q2bNUiTkyzcBIcaHD6oDH?si=v1GCPZI9RvKWQplwvgJP9Q&nd=1',
                          true),
                      context),
                  listDrawerExpansionTileURL("Deezer", context,
                      urlToLaunch: 'https://www.deezer.com/br/show/1359922'),
                  listDrawerExpansionTile(
                      "YouTube",
                      WebviewSpr(
                          'https://www.youtube.com/playlist?list=PLFK4fswpKc9s_dzlgvsIPShZIYPjaAaCU',
                          true),
                      context),
                ]),
                listDrawerExpansionTileURL(
                    "Criterios classificatórios", context,
                    urlToLaunch:
                        'https://www.reumatologiasp.com.br/criterios-classificatorios/'),
                listDrawerExpansionTileURL("Métricas de avaliação", context,
                    urlToLaunch: 'https://www.reumatologiasp.com.br/metricas/'),
                listDrawerExpansionTileURL(
                  "Consenso e diretrizes",
                  context,
                  urlToLaunch:
                      'https://www.reumatologiasp.com.br/consensos-e-diretrizes/',
                ),
                listDrawerExpansionTileURL(
                  "Medicamentos de alto custos",
                  context,
                  urlToLaunch:
                      'https://www.reumatologiasp.com.br/medicamentos-de-alto-custo/',
                ),
                listDrawerExpansionTileURL(
                    "Protocolos clínicos e diretrizes terapêuticas", context,
                    urlToLaunch: 'https://www.reumatologiasp.com.br/pcdts/'),
              ]),
              // Layout().itemmenuexpansion("Pacientes", "Informações gerais",
              //     Icons.pageview_outlined, [
              //       listDrawerExpansionTile("Informações aos pacientes",WebviewSpr('https://www.reumatologiasp.com.br/pacientes/',true), context),
              //       listDrawerExpansionTile("Busque um reumatologista",WebviewSpr('https://www.reumatologiasp.com.br/busque-um-reumatologista/',true), context),
              //     ]),
              Layout().itemmenuexpansion(
                  "Associados", "Veja os benefícios", Icons.medical_services, [
                listDrawerExpansionTile(
                    "Conheça os benefícios do associado",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/beneficios/', true),
                    context),
                listDrawerExpansionTile(
                    "Sou reumatologista quero me registrar",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/registro/', true),
                    context),
                listDrawerExpansionTile(
                    "Sou residente e quero me registrar",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/registro-de-residente/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Planos de acesso",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/planos/', true),
                    context),
              ]),
              Layout().itemmenuexpansion(
                  "Revistas", "Conheça a RPR", Icons.chrome_reader_mode, [
                listDrawerExpansionTile(
                    "Todas as edições",
                    WebviewSpr('https://www.reumatologiasp.com.br/revista/',
                        true) /*Revistas()*/,
                    context),
                listDrawerExpansionTile(
                    "Edição atual",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/revista/reumatologia-pediatrica/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Apresentação",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/revista-paulista-de-reumatologia/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Expediente",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/revista-paulista-de-reumatologia/expediente/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Normas para publicação",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/revista-paulista-de-reumatologia/normas-para-publicacao/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Política Editorial RPR Crossmark",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/politica-editorial-rpr-crossmark/',
                        true),
                    context),
              ]),
              Layout().itemmenuexpansion(
                  "Educação", "Exclusivos da SPR", Icons.class_, [
                listDrawerExpansionTileURL("EAD", context,
                    urlToLaunch: 'https://www.reumatologiasp.com.br/ead/'),
                listDrawerExpansionTile(
                    "Fórum de debates",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/conteudo/eventos/forum/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Encontro de Reumatologia Avançada",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/conteudo/eventos/era/',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Curso de Revisão para Reumatologistas",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/conteudo/eventos/crr/',
                        true) /*CursosEad()*/,
                    context),
              ]),
              Layout().itemmenu(
                  "Contato",
                  "Fale conosco",
                  Icons.chat,
                  WebviewSpr(
                      'https://www.reumatologiasp.com.br/contato/', true),
                  context),
              Layout().itemmenuexpansion(
                  "Sobre", 'Conheça a SPR', Icons.supervisor_account_outlined, [
                listDrawerExpansionTile(
                    "Nossa história",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/nossa-historia',
                        true),
                    context),
                listDrawerExpansionTile(
                    "Diretoria",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/diretoria/', true),
                    context),
                listDrawerExpansionTile(
                    "Responsabilidade social",
                    WebviewSpr(
                        'https://www.reumatologiasp.com.br/responsabilidade-social/',
                        true),
                    context)
              ]),
              //      Layout().footerdesenvolvidopor(),
/*          (!kIsWeb) ? Layout().footerversao(version, buildNumber) : Container(),*/
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  Widget itemmenu(title, subtitle, icon, destino, context) {
    return InkWell(
      hoverColor: Cores.corprincipal.withOpacity(0.2),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destino));
      },
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'Kanit', fontWeight: FontWeight.w600, fontSize: 17.0),
        ),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }

  Widget menuheader(user, context) {
    return Container(
      child: DrawerHeader(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                height: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logocor_semsub.png"),
                        fit: BoxFit.contain)),
                child: Container()),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Pesquisa().irpara(
                  WebviewSpr(
                      'https://www.reumatologiasp.com.br/entrar/?redirect_to=https%3A%2F%2Fwww.reumatologiasp.com.br%2Fconta%2F',
                      true, user: user,),
                  context);

            },
            child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Cores.corprincipal,
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 18),
                  child: Text(
                    "Minha conta",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      )),
    );
  }

  dialogConfirmacaoDeletar(Function deleteFunction, BuildContext context,
      deleteDialogTitle, telaDeSucessoTitle,
      {textoBotaoConfirmar = 'Sim, deletar'}) {
    showDialog(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(45),
            child: AlertDialog(
                contentPadding: EdgeInsets.all(0),
                titlePadding: EdgeInsets.all(0),
                title: Container(
                  color: Cores.corprincipal,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Layout().texto(
                        deleteDialogTitle, 16, FontWeight.normal, Colors.white,
                        align: TextAlign.center),
                  )),
                ),
                content: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Cores.corprincipal, width: 3)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Cores.corprincipal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 25),
                            child: Layout().texto(
                                'Não', 16, FontWeight.normal, Colors.white),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            deleteFunction();
                            if (telaDeSucessoTitle != null)
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                          },
                          child: Layout().texto(textoBotaoConfirmar, 16,
                              FontWeight.normal, Cores.corprincipal,
                              align: TextAlign.center,
                              textDecoration: TextDecoration.underline))
                    ],
                  ),
                )),
          );
        },
        context: context);
  }

  Widget titulo(String texto, {fontweight = FontWeight.bold}) {
    return Text(texto,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "Kanit",
            color: Colors.black,
            fontSize: 22,
            fontWeight: fontweight));
  }

  Widget tituloesubtitulo(String texto,
      {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
      fontweight = FontWeight.bold,
      isSubtitle = false,
      String? textSubtitle = ''}) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Text(texto,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Kanit",
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: fontweight)),
        ),
        SizedBox(height: 15),
        isSubtitle
            ? Flexible(
                child: Text(textSubtitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Kanit",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal)),
              )
            : Container(),
      ],
    );
  }

  Widget caixadetexto(
    min,
    max,
    textinputtype,
    controller,
    placeholder,
    capitalization, {
    showObscureOption = false,
    bool obscureTextValue = false,
    Function? obscureFunction,
    generalColor = Colors.black,
    enabledBorderColor = Colors.grey,
    bool? hasFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        inputFormatters: hasFormatters == null
            ? null
            : [FilteringTextInputFormatter.deny(new RegExp(r'[-]|[ ]'))],
        obscureText: obscureTextValue,
        minLines: min,
        maxLines: max,
        keyboardType: textinputtype,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: showObscureOption
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    obscureTextValue ? Icons.visibility_off : Icons.visibility,
                    color: generalColor,
                  ),
                  onPressed: obscureFunction as void Function()?)
              : Container(
                  height: 1,
                  width: 1,
                ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: generalColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 1.5),
          ),
          labelText: placeholder,
          labelStyle: TextStyle(
              letterSpacing: 1,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: generalColor),
        ),
        textCapitalization: capitalization,
        autofocus: false,
        style: TextStyle(
            letterSpacing: 0.8,
            color: generalColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget itemdrawer(text, icon, destino, context) {
    return Card(
      child: InkWell(
        hoverColor: Cores.corprincipal.withOpacity(0.4),
        onTap: () {
          if (destino != null) {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => destino));
          }
        },
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
          ),
          leading: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget itemdrawerComDialog(text, icon, destino, context) {
    return Card(
      child: InkWell(
        hoverColor: Cores.corprincipal.withOpacity(0.4),
        onTap: () {
          Layout().dialog2botoesParaDrawer(
              context,
              'Aviso',
              'Será necessário efetuar o login para acessar as calculadoras.',
              'Prosseguir',
              destino);
        },
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
          ),
          leading: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  dialog2botoes(context, titulo, texto, textobotao, destinoBotaoDireito) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData.dark(),
            child: CupertinoAlertDialog(
              title: Text(titulo),
              content: Text(texto),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Cores.corprincipal),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    textobotao,
                    style: TextStyle(color: Cores.corprincipal),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Pesquisa().irpara(destinoBotaoDireito, context);
                  },
                ),
              ],
            ),
          );
        });
  }

  dialog2botoesParaDrawer(
      context, titulo, texto, textobotao, destinoBotaoDireito) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData.dark(),
            child: CupertinoAlertDialog(
              title: Text(titulo),
              content: Text(texto),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Cores.corprincipal),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    textobotao,
                    style: TextStyle(color: Cores.corprincipal),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Pesquisa().irpara(destinoBotaoDireito, context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget footerdesenvolvidopor() {
    return InkWell(
      onTap: () async {
        const url = 'http://www.oneplanet.tech';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Desenvolvido por OnePlanet Tech",
          style: TextStyle(fontSize: 12.0),
        ),
      ),
    );
  }

  whatsappUrl() async {
    const url = 'https://wa.me/5511998275959/?text=Olá,%20tudo%20bem?%20';
    if (await canLaunch(url)) {
      print('launching url');
      await launch(url).then((value) => print('url launched'));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget footerversao(version, buildNumber) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
      child: Text("Versão: $version - $buildNumber",
          style: TextStyle(fontSize: 12.0)),
    );
  }

  Widget texto(texto, size, fontWeight, color,
      {TextAlign? align, TextDecoration? textDecoration}) {
    return Text(
      texto ?? '',
      style: TextStyle(
          color: color,
          fontSize: size.toDouble(),
          fontWeight: fontWeight,
          decoration: textDecoration),
      textAlign: align,
    );
  }

  dialog1botao(context, titulo, texto, {destino}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: new Text(titulo),
            content: new Text(texto),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  "OK",
                  style: TextStyle(color: Cores.corprincipal),
                ),
                onPressed: () {
                  if (destino == null) {
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => destino),
                        (Route<dynamic> route) => false);
                  }
                },
              ),
            ],
          );
        });
  }


}
