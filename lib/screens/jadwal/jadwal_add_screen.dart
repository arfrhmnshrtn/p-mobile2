import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_mobile/providers/dosen_provider.dart';
import 'package:project_mobile/providers/jadwal_provider.dart';

class JadwalAddScreen extends ConsumerWidget {
  final TextEditingController cNama_mk = TextEditingController();
  final TextEditingController cNama_kelas = TextEditingController();
  final TextEditingController cHari = TextEditingController();
  final TextEditingController cJam = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Jadwal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cNama_mk,
              decoration: InputDecoration(labelText: 'Nama Matakuliah'),
            ),
            TextField(
              controller: cNama_kelas,
              decoration: InputDecoration(labelText: 'Kelas'),
            ),
            TextField(
              controller: cHari,
              decoration: InputDecoration(labelText: 'Hari'),
            ),
            TextField(
              controller: cJam,
              decoration: InputDecoration(labelText: 'Jam'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(JadwalProvider.notifier)
                    .addJawal(
                      cNama_mk.text,
                      cNama_kelas.text,
                      cHari.text,
                      cJam.text,
                    );
                Navigator.pop(context);
              },
              child: Text("Tambah"),
            ),
          ],
        ),
      ),
    );
  }
}
