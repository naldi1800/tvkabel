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
  var total = 0;
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

  Future<pw.Widget> contentPage(
    BuildContext context,
    String bln, {
    required QuerySnapshot<Object?> data,
  }) async {
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
            flex: 2,
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
              child: pw.Text('Tanggal Pemasangan', textAlign: tCenter),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Tanggal Pembayaran', textAlign: tCenter),
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Harga', textAlign: tCenter),
            ),
          ),
        ],
      ),
    );

    //DATA
    total = 0;
    data.docs.forEach((element) async {
      print("Cek Element");
      var dt = element.data() as Map<String, dynamic>;
      // Map<String, dynamic> dtCostumer =
      //     await getCostumer("${dt['id_customer']}");
      Map<String, dynamic> dtBilling = await getDataWithMonth(bln, dt['id']);
      Map<String, dynamic> dtPacket = await getPacket("${dt['iuran']}");
      DateTime d = DateTime.now();
      if (dt['tanggal_pembayaran'] != null) {
        Timestamp t = dt['tanggal_pembayaran'];
        d = t.toDate();
      }
      if (dtBilling['tanggal_pembayaran'] != null) {
        total += int.parse(dtPacket['price'].toString());
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
              child: pw.Text("${dt['id']}", textAlign: tCenter),
            ),
            pw.Expanded(
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(left: 5),
                child: pw.Text("${dt['name']}", textAlign: tLeft),
              ),
            ),
            pw.Expanded(
              child: pw.Text("${dtPacket['name']}", textAlign: tCenter),
            ),
            pw.Expanded(
              // child: pw.Text("as"),
              child: pw.Text(
                  dt['date'] != null ? DateFormat('yyyy-MM-dd').format(d) : '-',
                  textAlign: tCenter),
            ),
            pw.Expanded(
              // child: pw.Text("as"),
              child: pw.Text(
                  dtBilling['tanggal_pembayaran'] != null
                      ? DateFormat('yyyy-MM-dd').format(d)
                      : '-',
                  textAlign: tCenter),
            ),
            pw.Expanded(
              child: pw.Text(
                  (dtBilling['tanggal_pembayaran'] != null)
                      ? "${dtPacket['price']}"
                      : "-",
                  textAlign: tCenter),
            ),
          ],
        ),
      );
    });

    await Future.delayed(const Duration(seconds: 2));
    // rowsData.add(
    //   pw.TableRow(
    //     children: [
    //       pw.Expanded(
    //         flex: 9,
    //         child: pw.Padding(
    //           padding: const pw.EdgeInsets.all(3),
    //           child: pw.Text('Total', textAlign: tCenter),
    //         ),
    //       ),
    //       pw.Expanded(
    //         child: pw.Padding(
    //           padding: const pw.EdgeInsets.all(3),
    //           child: pw.Text('', textAlign: tCenter),
    //         ),
    //       ),
    //       pw.Expanded(
    //         child: pw.Padding(
    //           padding: const pw.EdgeInsets.all(3),
    //           child: pw.Text('', textAlign: tCenter),
    //         ),
    //       ),
    //       pw.Expanded(
    //         child: pw.Padding(
    //           padding: const pw.EdgeInsets.all(3),
    //           child: pw.Text('', textAlign: tCenter),
    //         ),
    //       ),
    //       pw.Expanded(
    //         child: pw.Padding(
    //           padding: const pw.EdgeInsets.all(3),
    //           child: pw.Text('', textAlign: tCenter),
    //         ),
    //       ),
    //       pw.Expanded(
    //         child: pw.Padding(
    //           padding: const pw.EdgeInsets.all(3),
    //           child: pw.Text('', textAlign: tCenter),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

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

  String GetBulan(int i) {
    var bln = "";
    switch (i) {
      case 1:
        bln = "Januari";
        break;

      case 2:
        bln = "Februari";
        break;

      case 3:
        bln = "Maret";
        break;

      case 4:
        bln = "April";
        break;

      case 5:
        bln = "Mei";
        break;

      case 6:
        bln = "Juni";
        break;

      case 7:
        bln = "Juli";
        break;

      case 8:
        bln = "Agustus";
        break;

      case 9:
        bln = "September";
        break;

      case 10:
        bln = "Oktober";
        break;

      case 11:
        bln = "November";
        break;

      case 12:
        bln = "Desember";
        break;
    }
    return bln;
  }

  Future<Uint8List> getPDF(
      BuildContext context, QuerySnapshot<Object?> data, String blnbyr) async {
    // var i =
    var bln = GetBulan(int.parse(Get.arguments.split("-")[1]));
    // print();
    double widthMax = MediaQuery.of(context).size.width;
    var pdf = pw.Document();
    var w = await contentPage(context, blnbyr, data: data);
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
                infoPage(widthMax: widthMax, ket: "Bulan", data: "$bln"),
                pw.SizedBox(height: 5),
                infoPage(
                    widthMax: widthMax, ket: "Jenis", data: "Analog & Dialog"),
                pw.SizedBox(height: 15),
                w,
                infoPage(widthMax: widthMax, ket: "Total", data: "$total")
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

  Future<Map<String, dynamic>> getDataWithMonth(String month, String id) async {
    Map<String, dynamic> data = {};
    Query costumers = firestore
        .collection('billings')
        .where("bulan_bayar", isEqualTo: month)
        .where("id_customer", isEqualTo: id);
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

  Future<QuerySnapshot<Object?>> getData() {
    Query costumers = firestore.collection('costumers').orderBy('id');
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

  Future<Map<String, dynamic>> getBilling(String bulan) async {
    Map<String, dynamic> data = {};
    Query costumers =
        firestore.collection('billings').where("bulan_bayar", isEqualTo: bulan);
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
