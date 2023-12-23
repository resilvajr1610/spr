import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/standard/layout.dart';

class RefCriteriosClassificatorios {
  artritereumatoide() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          item(
              "- Aletaha D, Neogi T, Silman AJ, Funovits J, Felson DT, Bingham CO, et al. 2010 Rheumatoid arthritis classification criteria: An American College of Rheumatology/European League Against Rheumatism collaborative initiative. Ann Rheum Dis. 2010;69(9):1580–8"),
        ],
      ),
    );
  }

  artritepsoriaca() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          item(
              "- Taylor W, Gladman D, Helliwell P, Marchesoni A, Mease P, Mielants H. Classification criteria for psoriatic arthritis: Development of new criteria from a large international study. Arthritis Rheum. 2006;54(8):2665–73.")
        ],
      ),
    );
  }

  espondiloartriteaxial() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          item(
              "- Rudwaleit M, Van Der Heijde D, Landewé R, Listing J, Akkoc N, Brandt J, et al. The development of Assessment of SpondyloArthritis international Society classification criteria for axial spondyloarthritis (part II): Validation and final selection. Ann Rheum Dis. 2009;68(6):777–83.")
        ],
      ),
    );
  }

  lupus() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            SizedBox(height: 15,),
            Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
                align: TextAlign.center),
            item(
                "Aringer M, Costenbader K, Daikh D, Brinks R, Mosca M, Ramsey-Goldman R, et al. 2019 European League Against Rheumatism/American College of Rheumatology classification criteria for systemic lupus erythematosus. Ann Rheum Dis. 2019;78(9):1151–9."),
          ],
        ));
  }

  espondiloartriteperiferica() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          item(
              '- - Rudwaleit M, Van Der Heijde D, Landewé R, Akkoc N, Brandt J, Chou CT, et al. The Assessment of SpondyloArthritis international Society classification criteria for peripheral spondyloarthritis and for spondyloarthritis in general. Ann Rheum Dis. 2011;70(1):25–31.'),
        ],
      ),
    );
  }
  artritepsoriCASPAR() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          SizedBox(height: 5,),
          item(
            "- Taylor W, Gladman D, Helliwell P, Marchesoni A, Mease P, Mielants H. Classification criteria for psoriatic arthritis: Development of new criteria from a large international study. Arthritis Rheum. 2006;54(8):2665–73."
          ),
        ],
      ),
    );
  }

  espondiloartriteaxialASAS2009() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          SizedBox(height: 5,),
          item(
            "- Rudwaleit M, Van Der Heijde D, Landewé R, Listing J, Akkoc N, Brandt J, et al. The development of Assessment of SpondyloArthritis international Society classification criteria for axial spondyloarthritis (part II): Validation and final selection. Ann Rheum Dis. 2009;68(6):777–83."
          ),
        ],
      ),
    );
  }

  espondiloartriteaxialASAS2011() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          SizedBox(height: 5,),
          item(
            "- Rudwaleit M, Van Der Heijde D, Landewé R, Akkoc N, Brandt J, Chou CT, et al. The Assessment of SpondyloArthritis international Society classification criteria for peripheral spondyloarthritis and for spondyloarthritis in general. Ann Rheum Dis. 2011;70(1):25–31."
          ),
        ],
      ),
    );
  }

  lupusACREULAR() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 15,),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          SizedBox(height: 5,),
          item(
              "- Aringer M, Costenbader K, Daikh D, Brinks R, Mosca M, Ramsey-Goldman R, et al. 2019 European League Against Rheumatism/American College of Rheumatology classification criteria for systemic lupus erythematosus. Ann Rheum Dis. 2019;78(9):1151–9."
          ),
        ],
      ),
    );
  }
}

titulo(titulo) {
  return Column(
    children: [
      SizedBox(
        height: 5,
      ),
      Layout().texto(titulo, 14.0, FontWeight.normal, Colors.black,
          align: TextAlign.justify),
    ],
  );
}

item(texto) {
  return Row(
    children: [
      SizedBox(
        width: 25,
      ),
      Expanded(
        child: Layout().texto(texto, 14.0, FontWeight.normal, Colors.black,
            align: TextAlign.justify),
      ),
    ],
  );
}
