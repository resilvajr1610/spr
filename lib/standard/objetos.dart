import 'package:flutter/material.dart';

class CheckBoxLupus {
  String title;
  bool value;
  int? pontos;

  CheckBoxLupus(
      {required this.title, this.value = false, required this.pontos});
}

class ArtriteObj {
  String title;
  int? pontos;

  ArtriteObj({required this.title, required this.pontos});

  static List<ArtriteObj> getOptions1() {
    return <ArtriteObj>[
      ArtriteObj(title: '1 grande articulação', pontos: 0),
      ArtriteObj(title: '2-10 grandes articulações', pontos: 1),
      ArtriteObj(
          title:
              '1-3 pequenas articulações (com ou sem envolvimento de grandes articulações)',
          pontos: 2),
      ArtriteObj(
          title:
              '4-10 pequenas articulações (com ou sem envolvimento de grandes articulações)',
          pontos: 3),
      ArtriteObj(
          title: '> 10 articulações (pelo menos uma pequena articulação)',
          pontos: 5),
    ];
  }

  static List<ArtriteObj> getOptions2() {
    return <ArtriteObj>[
      ArtriteObj(
          title:
              'Fator Reumatoide (FR) e anticorpos antipeptídeos citrulinados cíclicos (antiCCP)',
          pontos: 0),
      ArtriteObj(
          title:
              'Fator reumatoide ou anti-CCP em baixos títulos (1 a 3 vezes o limite superior do normal)',
          pontos: 2),
      ArtriteObj(
          title:
              'Fator reumatoide ou anti-CCP em altos títulos (mais de 3 vezes o limite superior do normal)',
          pontos: 3),
    ];
  }

  static List<ArtriteObj> getOptions3() {
    return <ArtriteObj>[
      ArtriteObj(title: 'VHS e PCR normais', pontos: 0),
      ArtriteObj(title: 'VHS ou PCR alterados', pontos: 1),
    ];
  }

  static List<ArtriteObj> getOptions4() {
    return <ArtriteObj>[
      ArtriteObj(title: 'Duração dos sintomas < 6 semanas', pontos: 0),
      ArtriteObj(title: 'Duração dos sintomas ≥ 6 semanas', pontos: 1),
    ];
  }
}

class User {
  bool logado;

  User({this.logado = false});

  void setLogado(value) {
    this.logado = value;
  }

  bool getLogado() {
    return this.logado;
  }
}
