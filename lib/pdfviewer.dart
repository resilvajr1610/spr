import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'standard/layout.dart';

class DocumentoDetalhes extends StatefulWidget {
  final String? linkPdf;

  DocumentoDetalhes(this.linkPdf);

  @override
  _DocumentoDetalhesState createState() => _DocumentoDetalhesState();
}

class _DocumentoDetalhesState extends State<DocumentoDetalhes> {
  PdfViewerController? _pdfViewerController;

  @override
  void initState() {
    print("Chamou tela pdf");
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerController!.previousPage();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerController!.nextPage();
            },
          )
        ],
      ),
      body: widget.linkPdf != null
          ? SfPdfViewer.network(
              widget.linkPdf!,
              controller: _pdfViewerController,
            )
          : Layout().texto('Documento não encontrado', 25.0, FontWeight.normal,
              Colors.black),
    );
  }
}
