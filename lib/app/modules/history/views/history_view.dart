import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tvkabel/app/utils/ui.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat',
          style: TextStyle(color: ui.object, fontFamily: 'arvo'),
        ),
        centerTitle: true,
        backgroundColor: ui.foreground,
      ),
      backgroundColor: ui.background,
      // body: const Center(child: CircularProgressIndicator()),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: controller.getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var allHistory = snapshot.data!.docs;
                return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(color: ui.object),
                    itemCount: allHistory.length,
                    itemBuilder: (context, index) {
                      var data =
                          allHistory[index].data() as Map<String, dynamic>;
                      DateTime d = DateTime.now();
                      if (data['tanggal_pembayaran'] != null) {
                        Timestamp t = data['tanggal_pembayaran'];
                        d = t.toDate();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          width: double.infinity,
                          color: ui.foreground,
                          padding: const EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(
                              "${data['id_customer']} - ${data['bulan_bayar']}",
                              style: const TextStyle(
                                  fontSize: 20, color: ui.object),
                            ),
                            subtitle: Text(
                              DateFormat('yyyy-MM-dd hh:mm').format(d),
                              style: const TextStyle(
                                  fontSize: 15, color: ui.object),
                            ),
                          ),
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
