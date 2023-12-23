import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calculadoras/calculadoras.dart';
import 'educacao.dart';
import 'revistasRedirect.dart';
import 'standard/layout.dart';
import 'standard/objetos.dart';
import 'standard/pesquisa.dart';
import 'webviewSpr.dart';
import 'webviewSprInicio.dart';

// Android (key.properties, manifest nome, e package name, pubspec - versao)
// comentar fb.firebase no pesquisa
// Android > app > main > java > configurar SDK
// flutter clean
// flutter pub get
// criar icones: flutter packages pub run flutter_launcher_icons:main
// testar
// flutter build appbundle

// ios
// comentar fb.firebase no pesquisa
// flutter clean
// flutter pub get
// flutter packages pub run flutter_launcher_icons:main
// flutter precache
// cd ios > pod deintegrate
// pod install
// xCode Runner (bundle, version, build), Sigin (Team, Push), Info (Nome, permissões), new file swift,
// arquivo Firebase, icone 1024
// Fecha workspace Podfile : platform: iOS, 9.0 , use_frameworks!, pod 'Firebase/MLVisionTextModel'
// testar
// fechar Xcode
// flutter clean
// flutter pub get
// flutter build ios

// WEB
// descomentar fb.firebase no pesquisa
// diferente: verificar index.html, firebase.json,  design, imagem, favicon, icon-192, icons-512, fundo.png
// flutter clean
// flutter pub get
// flutter build web
// firebase deploy --only hosting

// FUNCTION
// firebase deploy --only functions:enviarEmail
//indexes - firestore.indexes.json - firebase deploy --only firestore:indexes
// Fotos adicionadas para controle da coordenação e administração da escola.
// io.flutter.embedded_views_preview and the value YES
// imagem circular: http://crop-circle.imageonline.co/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black, hintColor: Colors.teal),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int _selectedIndex = 0;
  User user = User();

  @override
  void initState() {
    super.initState();

    verificarUsuarioLogado();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  void _onItemTapped(int index) {
    verificarUsuarioLogado();
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          user.getLogado()
              ? Pesquisa().irpara(CalculadorasPage(), context)
              : Layout().dialog2botoes(
                  context,
                  'Aviso',
                  'Será necessário efetuar o login para acessar as calculadoras.',
                  'Prosseguir',
                  WebviewSpr(
                    'https://www.reumatologiasp.com.br/entrar',
                    true,
                    calculadora: true,
                    user: user,
                  ));
          break;
        case 1:
          //revistas
          Pesquisa().irpara(RevistasPage(), context);
          break;
        case 2:
          //educação
          Pesquisa().irpara(EducacaoPage(), context);
          break;
        case 3:
          //instagram
          Pesquisa().irpara(
              WebviewSpr(
                'https://www.instagram.com/reumatologiasp/',
                true,
              ),
              context);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_connectionStatus == ConnectivityResult.mobile ||
              _connectionStatus == ConnectivityResult.wifi)
          ? Layout().defaultAppBar(context, seta: false) as PreferredSizeWidget?
          : null,
      drawer: Layout().defaultDrawer(user, context),
      body: (_connectionStatus == ConnectivityResult.mobile ||
              _connectionStatus == ConnectivityResult.wifi)
          ? WebviewSprInicio('https://www.reumatologiasp.com.br', false)
          : Layout().bodyEstatico(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: (_connectionStatus == ConnectivityResult.mobile ||
              _connectionStatus == ConnectivityResult.wifi)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  child: Image.asset(
                    'assets/reumazap.png',
                    fit: BoxFit.fill,
                  ),
                  onPressed: () {
                    Layout().whatsappUrl();
                  },
                ),
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.teal),
        unselectedLabelStyle: TextStyle(color: Colors.teal),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calculate_outlined,
                color: Colors.teal,
              ),
              label: "Calculadora"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                color: Colors.teal,
              ),
              label: "Revistas"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.school_outlined,
                color: Colors.teal,
              ),
              label: "Educação"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.tv,
                color: Colors.teal,
              ),
              label: "Mídias sociais"),
        ],
      ),
    );
  }

  verificarUsuarioLogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.getBool('logado') ?? false;
    print('valor bool antes => $result');
    setState(() {
      user.setLogado(result);
    });
  }
}
