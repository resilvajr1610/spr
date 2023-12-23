import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:spr/standard/layout.dart';

class RefIndiceAtividade {

  artrite() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          titulo("DAS28:"),
          item(
            "- Prevoo ML, van 't Hof MA, Kuper HH, et al. Modified disease activity scores that include twenty-eight-joint counts. Development and validation in a prospective longitudinal study of patients with rheumatoid arthritis. Arthritis Rheum 1995; 38:44.",
          ),
          titulo("CDAI/SDAI:"),
          item(
            "- Aletaha D, Nell VP, Stamm T, et al. Acute phase reactants add little to composite disease activity indices for rheumatoid arthritis: validation of a clinical activity score. Arthritis Res Ther 2005; 7:R796.\n- Aletaha D, Smolen J. The Simplified Disease Activity Index (SDAI) and the Clinical Disease Activity Index (CDAI): a review of their usefulness and validity in rheumatoid arthritis. Clin Exp Rheumatol 2005; 23:S100.",
          )
        ],
      ),
    );
  }

  espondiloartrite(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          titulo("BASDAI:"),
          item(
            "- Garrett S, Jenkinson T, Kennedy LG, et al. A new approach to defining disease status in ankylosing spondylitis: the Bath Ankylosing Spondylitis Disease Activity Index. J Rheumatol 1994; 21:2286.\n- Garrett S, Jenkinson T, Kennedy LG, et al. A new approach to defining disease status in ankylosing spondylitis: the Bath Ankylosing Spondylitis Disease Activity Index. J Rheumatol 1994; 21:2286\n- Fagerli KM, Lie E, van der Heijde D, et al. Selecting patients with ankylosing spondylitis for TNF inhibitor therapy: comparison of ASDAS and BASDAI eligibility criteria. Rheumatology (Oxford) 2012; 51:1479."
          ),
          titulo("ASDAS:"),
          item(
            "- Lukas C, Landewé R, Sieper J, Dougados M, Davis J, Braun J, van der Linden S, van der Heijde D. Development of an ASAS-endorsed disease activity score (ASDAS) in patients with ankylosing spondylitis.\n- van der Heijde D, Lie E, Kvien TK, Sieper J, van den Bosch F, Listing J, Braun J, Landewé R. ASDAS, a highly discriminatory ASAS-endorsed disease activity score in patients with ankylosing spondylitis.\n- Machado P, Landewé R, Lie E, Kvien TK, Braun J, Baker D, van der Heijde D. Ankylosing Spondylitis Disease Activity Score (ASDAS): defining cut-off values for disease activity states and improvement scores.\n- Machado PM, Landewé R, van der Heijde DV. Assessment of SpondyloArthritis international Society (ASAS). Ankylosing Spondylitis Disease Activity Score (ASDAS): 2018 update of the nomenclature for disease activity states.\n- Machado P, Landewé R, van der Heijde D. Endorsement of the definitions of disease activity states and improvement scores for the Ankylosing Spondylitis Disease Activity Score (ASDAS): results from the Outcome Measures in Rheumatology (OMERACT) 10 conference."
          )
        ],
      ),
    );
  }

  artritePsoriasica(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          titulo("DAPSA28:"),
          item(
            "- Schoels, M. M., Aletaha, D., Alasti, F., & Smolen, J. S. (2016). Disease activity in psoriatic arthritis (PsA): Defining remission and treatment success using the DAPSA score. Annals of the Rheumatic Diseases, 75(5), 811–818. https://doi.org/10.1136/annrheumdis-2015-207507\n- Schoels, M., Aletaha, D., Funovits, J., Kavanaugh, A., Baker, D., & Smolen, J. S. (2010). Application of the DAREA/DAPSA score for assessment of disease activity in psoriatic arthritis. Annals of the Rheumatic Diseases, 69(8), 1441–1447. https://doi.org/10.1136/ard.2009.122259"
          ),
        ],
      ),
    );
  }

  lupussledai2k(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          titulo("SLEDAI-2K:"),
          item(
            "- Gladman, D. D., Ibanez, D., & Urowitz, M. B. (2002). Systemic lupus erythematosus disease activity index 2000. The Journal of rheumatology, 29(2), 288-291. https://www.jrheum.org/content/29/2/288.full"
          ),
        ],
      ),
    );
  }

  lupussLLDAS(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Layout().texto("Referências", 18.0, FontWeight.bold, Colors.black,
              align: TextAlign.center),
          titulo("LLDAS:"),
          item(
            "Franklyn K, Lau CS, Navarra S V., Louthrenoo W, Lateef A, Hamijoyo L, et al. Definition and initial validation of a Lupus Low Disease Activity State (LLDAS). Ann Rheum Dis. 2016;75(9):1615–21."
          ),
        ],
      ),
    );
  }
}

// titulo("LLDAS: "),
// item(
// "Franklyn K, Lau CS, Navarra S V., Louthrenoo W, Lateef A, Hamijoyo L, et al. Definition and initial validation of a Lupus Low Disease Activity State (LLDAS). Ann Rheum Dis. 2016;75(9):1615–21."
// ),

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
