import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_mobile/providers/dosen_provider.dart';

class DosenAddScreen extends ConsumerWidget {
  final TextEditingController cNidn = TextEditingController();
  final TextEditingController cNama = TextEditingController();
  final TextEditingController cProdi = TextEditingController();
  final TextEditingController cFakultas = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Dosen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cNidn,
              decoration: InputDecoration(labelText: 'NIDN'),
            ),
            TextField(
              controller: cNama,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: cProdi,
              decoration: InputDecoration(labelText: 'Program Studi'),
            ),
            TextField(
              controller: cFakultas,
              decoration: InputDecoration(labelText: 'Fakultas'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(DosenProvider.notifier)
                    .addDosen(
                      cNidn.text,
                      cNama.text,
                      cProdi.text,
                      cFakultas.text,
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
