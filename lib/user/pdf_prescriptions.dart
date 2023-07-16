import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPrescription extends StatelessWidget {
  const PdfPrescription(
      {Key? key,
      required this.formattedDate,
      required this.name,
      required this.age,
      required this.selectedSymptomList,
      required this.medList})
      : super(key: key);

  final String formattedDate;
  final String name;
  final String age;
  final List<String> selectedSymptomList;
  final List medList;

  @override
  Widget build(BuildContext context) {
    print(selectedSymptomList);
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Herbit',
                        style: pw.TextStyle(
                          fontSize: 18
                        )
                        )
                        ,
                        pw.Text(
                        'Date:$formattedDate',
                        style: const pw.TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ]
                  ),
                 
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text(
                            'Name :',
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          pw.SizedBox(
                            width: 10,
                          ),
                          pw.Text(
                            name,
                            style: pw.TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text(
                            'Age :',
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          pw.SizedBox(
                            width: 10,
                          ),
                          pw.Text(
                            age,
                            style: pw.TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 30,
                  ),
                  pw.Text(
                    'Symptoms :',
                    style: pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: selectedSymptomList
                        .map((e) => pw.Text(
                              e,
                              style: pw.TextStyle(
                                fontSize: 15,
                              ),
                            ))
                        .toList(),
                  ),
                  pw.SizedBox(
                    height: 30,
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    'Medicines :',
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Column(
                    children: medList
                        .map((e) => pw.Text(
                              e,
                              style: pw.TextStyle(
                                fontSize: 15,
                              ),
                            ))
                        .toList(),
                  ),
                  pw.Spacer(),
                  pw.Divider(
                    indent: 10,
                    endIndent: 10
                  ),
                  pw.SizedBox(height: 10),
                  pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text('HERBIT',style: pw.TextStyle(fontSize: 20))
                  ),
                  pw.SizedBox(height: 10),

                 
                ],
              ),
            ),
          );
        }));

    return pdf.save();
  }
}
