// import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BillingRecapitulationController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // var dataCostumer = {}.obs;
  pw.Widget headerPage() {
    // final image = await networkImage("https://picsum.photos/id/1/200/300");
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        pw.Column(
          children: [
            pw.Text(
              "Kadun Jaya TV Kabel".toUpperCase(),
              style: const pw.TextStyle(
                fontSize: 20,
              ),
            ),
            pw.Text(
              "Rekapan Bulanan".toUpperCase(),
              style: const pw.TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),

        // pw.AspectRatio(
        //   aspectRatio: 4 / 4,
        //   child: pw.Image(
        //     image,
        //     fit: pw.BoxFit.fill,
        //   ),
        // ),
        // pw.AspectRatio(
        //   aspectRatio: 4 / 4,
        //   child: pw.Image(
        //     image,
        //     fit: pw.BoxFit.fill,
        //   ),
        // ),
      ],
    );
  }

  Future<pw.Widget> contentPage(BuildContext context,
      {required QuerySnapshot<Object?> data}) async {
    var tCenter = pw.TextAlign.center;
    var tLeft = pw.TextAlign.left;
    var no = 0;
    var rowsData = <pw.TableRow>[];

    //HEADER
    rowsData.add(
      pw.TableRow(
        children: [
          pw.Expanded(
            flex: 1,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('No', textAlign: tCenter),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('ID TV', textAlign: tCenter),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Nama', textAlign: tCenter),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Jenis', textAlign: tCenter),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Tanggal', textAlign: tCenter),
            ),
          ),
        ],
      ),
    );

    //DATA
    data.docs.forEach((element) async {
      // print("Cek Element");
      var dt = element.data() as Map<String, dynamic>;
      Map<String, dynamic> dtCostumer =
          await getCostumer("${dt['id_customer']}");
      Map<String, dynamic> dtPacket = await getPacket("${dtCostumer['iuran']}");
      DateTime d = DateTime.now();
      if (dt['tanggal_pembayaran'] != null) {
        Timestamp t = dt['tanggal_pembayaran'];
        d = t.toDate();
      }
      no++;

      // Insert Data
      rowsData.add(
        pw.TableRow(
          children: [
            pw.Expanded(
              child: pw.Text("$no", textAlign: tCenter),
            ),
            pw.Expanded(
              child: pw.Text("${dtCostumer['id']}", textAlign: tCenter),
            ),
            pw.Expanded(
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(left: 5),
                child: pw.Text("${dtCostumer['name']}", textAlign: tLeft),
              ),
            ),
            pw.Expanded(
              child: pw.Text("${dtPacket['name']}", textAlign: tCenter),
            ),
            pw.Expanded(
              child: pw.Text(
                  dt['tanggal_pembayaran'] != null
                      ? DateFormat('yyyy-MM-dd').format(d)
                      : '-',
                  textAlign: tCenter),
            ),
          ],
        ),
      );
    });
    await Future.delayed(const Duration(seconds: 2));
    // print(rowsData);
    if (data.docs.isEmpty) {
      rowsData.clear();
      rowsData.add(
        pw.TableRow(
          children: [
            pw.Expanded(
              flex: 1,
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(3),
                child: pw.Text('Data Masih Kosong', textAlign: tCenter),
              ),
            ),
          ],
        ),
      );
    }
    return pw.Align(
      alignment: pw.Alignment.topLeft,
      child: pw.Table(
        border: pw.TableBorder.all(),
        children: rowsData,
      ),
    );
  }

  pw.Widget infoPage({
    required double widthMax,
    required String ket,
    required String data,
  }) {
    double sizeFont = 12;
    return pw.Padding(
      padding: const pw.EdgeInsets.only(right: 35, left: 35),
      child: pw.Row(
        // mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Container(
            width: widthMax * 0.2,
            child: pw.Text(
              "$ket",
              style: pw.TextStyle(fontSize: sizeFont),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: widthMax * 0.03,
            child: pw.Text(
              ":",
              style: pw.TextStyle(fontSize: sizeFont),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: widthMax * 0.6,
            child: pw.Text(
              " $data",
              style: pw.TextStyle(fontSize: sizeFont),
              textAlign: pw.TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> getPDF(
      BuildContext context, QuerySnapshot<Object?> data) async {
    double widthMax = MediaQuery.of(context).size.width;
    var pdf = pw.Document();
    var w = await contentPage(context, data: data);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.only(top: 2),
        build: (pw.Context c) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(10),
            child: pw.Column(
              children: [
                headerPage(),
                pw.SizedBox(height: 20),
                infoPage(widthMax: widthMax, ket: "Bulan", data: "January"),
                pw.SizedBox(height: 5),
                infoPage(widthMax: widthMax, ket: "Jenis", data: "Analog"),
                pw.SizedBox(height: 15),
                w,
              ],
            ),
          );
        },
      ),
    );
    return await pdf.save();
    // final bytes = await pdf.save();
    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/doc.pdf');
    // await file.writeAsBytes(bytes);
  }

  Future<QuerySnapshot<Object?>> getDataWithMonth(String month) {
    Query costumers =
        firestore.collection('billings').where("bulan_bayar", isEqualTo: month);
    return costumers.get();
  }

  Future<Map<String, dynamic>> getCostumer(String docID) async {
    Map<String, dynamic> data = {};
    Query costumers =
        firestore.collection('costumers').where("id", isEqualTo: docID);
    await costumers.get().then(
          (value) => value.docs.forEach(
            (element) {
              data = element.data() as Map<String, dynamic>;
            },
          ),
        );
    // print(data);
    return data;
  }

  Future<Map<String, dynamic>> getPacket(String docID) async {
    Map<String, dynamic> data = {};
    DocumentReference costumers = firestore.collection('packets').doc(docID);
    await costumers
        .get()
        .then((value) => data = value.data() as Map<String, dynamic>);
    // print(data);
    return data;
  }
}
