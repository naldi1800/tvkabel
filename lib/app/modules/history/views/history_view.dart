import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        centerTitle: true,
      ),
      // body: const Center(child: CircularProgressIndicator()),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: controller.getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var allHistory = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: allHistory.length,
                    itemBuilder: (context, index) {
                      var data =
                          allHistory[index].data() as Map<String, dynamic>;
                      DateTime d = DateTime.now();
                      if (data['tanggal_pembayaran'] != null) {
                        Timestamp t = data['tanggal_pembayaran'];
                        d = t.toDate();
                      }
                      return ListTile(
                        title: Text(
                          "${data['id_customer']} - ${data['bulan_bayar']}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd hh:mm').format(d),
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
