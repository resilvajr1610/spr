import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calculadoras/calculadoras.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pdfviewer.dart';
import 'standard/design.dart';
import 'standard/layout.dart';
import 'standard/objetos.dart';
import 'standard/pesquisa.dart';

class WebviewSpr extends StatefulWidget {
  final String url;
  final bool appbar, calculadora, firstTime;
  final User? user;

  WebviewSpr(this.url, this.appbar,
      {this.calculadora = false, this.firstTime = true, this.user});

  @override
  _WebviewSprState createState() => _WebviewSprState();
}

class _WebviewSprState extends State<WebviewSpr> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;
  InAppWebViewGroupOptions? options;
  bool valid = false, carregado = false, home = false, entrar = false;
  String? url, urlPDF;
  double progress = 0;

  @override
  void initState() {
    options = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ));

    if (widget.url != null && widget.url.contains('http')) {
      valid = true;
      url = widget.url;
    }

    if (url!.contains("/entrar")) {
      entrar = true;
    }
    super.initState();
  }

  // @override
  // void dispose() {
  //   webViewController.stopLoading();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: (widget.appbar)
            ? AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0.0,
                leading: IconButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      if (url.toString().contains('youtube') ||
                          url.toString().contains('spotify') ||
                          url.toString().contains('/era/') ||
                          url.toString().contains('/crr/') ||
                          url.toString().contains('/forum/') ||
                          url.toString().contains('/nossa-historia/')) {
                        Navigator.pop(context);
                      } else if (url.toString().contains('/conta')) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MyHomePage()),
                        // ).then((value) => setState(() {}));
                        Navigator.pop(context);
                      }
                      else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                actions: [
                  (url.toString() == 'https://www.reumatologiasp.com.br/conta/')
                      ? Row(
                          children: [
                            Layout().texto(
                                'Sair', 16.0, FontWeight.normal, Colors.black),
                            IconButton(
                                icon: Icon(Icons.logout),
                                onPressed: () {
                                  deslogar();
                                  Pesquisa().irpara(
                                      WebviewSpr(
                                          'https://www.reumatologiasp.com.br/sair/',
                                          true),
                                      context);
                                }),
                          ],
                        )
                      : Container()
                ],
                backgroundColor: Cores.corprincipal,
                shadowColor: Cores.corprincipal,
                centerTitle: true,
              )
            : null,
        body: valid
            ? Stack(children: [
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(url: Uri.parse(url!)),
                  initialOptions: options,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) async {
                    print('carregando url : $url');
                    setState(() {
                      this.url = url.toString();
                    });
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunch(url!)) {
                        await launch(
                          url!,
                        );
                        return NavigationActionPolicy.CANCEL;
                      }
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    print("url atual => $url");
                    await metdosWebview(url, context);
                   if (url.toString() == 'https://www.reumatologiasp.com.br/'){
                     Navigator.pop(context);
                     Navigator.pop(context);
                   }
                  },
                  onLoadError: (controller, url, code, message) {},
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {}
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  onUpdateVisitedHistory:
                      (controller, url, androidIsReload) async {
                    if(Platform.isIOS){
                        await metdosWebview(url, context);
                    print('updatedvisited history');
                    setState(() {
                      this.url = url.toString();
                    });}
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print(consoleMessage);
                  },
                ),
                progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
                (!carregado)
                    ? Layout().bodyEstatico(context)
                    : (carregado &&
                            url.toString() !=
                                'https://www.reumatologiasp.com.br/')
                        ? Positioned(
                            bottom: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Cores.corprincipal),
                                  onPressed: () {
                                    launchURLRegistroOuVoltarWebview();
                                  },
                                  child: (entrar)
                                      ? Layout().texto('Quero me associar',
                                          16.0, FontWeight.normal, Colors.white)
                                      : Icon(Icons.arrow_back_sharp)),
                            ),
                          )
                        : Container(),
              ])
            : Center(child: Text('Erro: url inválida')));
  }

  void launchURLRegistroOuVoltarWebview() {
    if (url.toString() ==
            'https://www.reumatologiasp.com.br/entrar/?redirect_to=https%3A%2F%2Fwww.reumatologiasp.com.br%2Fconta%2F' ||
        url.toString() == 'https://www.reumatologiasp.com.br/entrar/') {
      _launchURL('https://www.reumatologiasp.com.br/registro/');
    } else {
      webViewController.goBack();
    }
  }

  Future<void> metdosWebview(Uri? url, BuildContext context) async {
    print("chmou metodo webview");
    await removeHeaderNavBar(url);
    // removerLoginGoogleFace(url);
    verificarUsuarioLogado();
    irParaCalculadora(context);
    irParaRevista(url);
    abrirRevistaPDF(url, context);
    abrirInstagram(url, context);
  }

  Future<void> removeHeaderNavBar(Uri? url) async {
    print('entrou');
    if (url.toString() != 'https://www.reumatologiasp.com.br/entrar/' ||
        url.toString() !=
            'https://www.reumatologiasp.com.br/entrar/?redirect_to=https%3A%2F%2Fwww.reumatologiasp.com.br%2Fconta%2F' ||    url.toString() != "https://www.reumatologiasp.com.br/entrar/?redirect_to=https%3A%2F%2Fwww.reumatologiasp.com.br%2Fconta%2F") {
      print('remove headernavbar');
      await webViewController
          .evaluateJavascript(
              source: "javascript:(function() { " +
                  "document.getElementsByClassName('top-bar')[0].style.display='none';" +
                  "document.getElementsByClassName('mobile-navigation')[0].style.display='none';" +
                  "})()")
          .then((value) => setStateCarregadoShimmer())
          .catchError((onError) => debugPrint('$onError'));

      print('remove headernavbar setstate');
      print('valor carregado dps remover header =>' + carregado.toString());
    }
  }

  void abrirInstagram(Uri? url, BuildContext context) {
    if (url.toString() ==
        'https://www.instagram.com/accounts/onetap/?next=%2F') {
      Navigator.pop(context);
      Pesquisa().irpara(
          WebviewSpr(
            'https://www.instagram.com/reumatologiasp/',
            true,
          ),
          context);
    }
    if (url.toString() == 'https://www.instagram.com/reumatologiasp/') {
      webViewController
          .evaluateJavascript(
              source: "javascript:(function() { " +
                  "var head = document.getElementsByTagName('nav')[0];" +
                  "head.parentNode.removeChild(head);" +
                  "})()")
          .then((value) => setStateCarregadoShimmer())
          .catchError((onError) => debugPrint('$onError'));
    }
  }

  Future<void> removerLoginGoogleFace(Uri? url) async {
    if (url.toString().contains('/entrar/?redirect_to') ||
        url.toString().contains('/entrar')) {
      print('valor carregado antes remover logingoogle =>' +
          carregado.toString());
      print('remover login google face');
      await webViewController.evaluateJavascript(
          source: "javascript:(function() { " +
              "document.getElementsByClassName('top-bar')[0].style.display='none';" +
              "document.getElementsByClassName('mobile-navigation')[0].style.display='none';" +
              "document.querySelector('.um-field').style.display='none';" +
              "document.getElementsByClassName('wpb_wrapper')[2].style.display='none';" +
              "document.querySelector('.um-col-alt').style.display='none';" +
              "})()");
      setStateCarregadoShimmer();
      print('remover login google face setstate');
      print('valor carregado dps remover login =>' + carregado.toString());
    }
  }

  _launchURL(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void abrirRevistaPDF(Uri? url, BuildContext context) {
    print("chamou abrir revista");
    if (url.toString().contains('#!fancybox')) {
      Pesquisa().irpara(DocumentoDetalhes(urlPDF), context);
    }
  }

  Future<void> irParaRevista(Uri? url) async {
    setStateCarregadoShimmer();
    if (url.toString().contains('/revista') ||
        url.toString().contains('/consensos-e-diretrizes') ||
        url.toString().contains('/nossa-historia/')) {
      String? dataSrc = await (webViewController.evaluateJavascript(
          source:
              "document.querySelector('.ari-fancybox-pdf').getAttribute('data-src');") as FutureOr<String?>);
      if (dataSrc != null) {
        String novoUrlPdf =
            dataSrc.split('=')[1].replaceAll('%3A', ':').replaceAll('%2F', '/');
        print(novoUrlPdf);
        setState(() {
          urlPDF = novoUrlPdf;
          print('novo url pdf =>' + novoUrlPdf);
          print('url pdf =>' + urlPDF!);
        });
      }
    }
  }

  void setStateCarregadoShimmer() {
    setState(() {
      carregado = true;
    });
  }

  void setStateLogin() {
    Future.delayed(Duration(milliseconds: 2000), setStateCarregadoShimmer);
  }

  salvarlogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logado', true);
    widget.user!.setLogado(true);
  }

  deslogar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logado', false);
    widget.user!.setLogado(false);
  }

  verificarUsuarioLogado() {
    if (url!.contains('/conta')) {
      salvarlogado();
    }
  }

  void irParaCalculadora(BuildContext context) {
    if (widget.calculadora && url.toString().contains('/conta')) {
      Pesquisa().irpara(CalculadorasPage(), context);
    }
  }
}
