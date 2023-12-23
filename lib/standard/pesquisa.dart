
import 'package:flutter/material.dart';

class Pesquisa {

  irpara(destino, context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destino),
    );
  }

  double replaceForDouble(controllerText){
    return double.parse(controllerText.text.replaceAll(',', '.'));
  }
}
