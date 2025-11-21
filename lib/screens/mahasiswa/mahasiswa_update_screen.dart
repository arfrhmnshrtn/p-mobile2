import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_mobile/providers/mahasiswa_provider.dart';

class MahasiswaUpdateScreen extends ConsumerWidget {
  final TextEditingController cNpm = TextEditingController();
  final TextEditingController cNama = TextEditingController();
  final TextEditingController cProdi = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final mahasiswaAsyncValue = ref.watch(MahasiswaDataProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text("Update Mahasiswa")),
      body: mahasiswaAsyncValue.when(
        data: (mahasiswa) {
          if (mahasiswa != null) {
            cNpm.text = mahasiswa['npm'];
            cNama.text = mahasiswa['nama'];
            cProdi.text = mahasiswa['prodi'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: cNpm,
                    decoration: InputDecoration(labelText: 'NPM'),
                  ),
                  TextField(
                    controller: cNama,
                    decoration: InputDecoration(labelText: 'Nama'),
                  ),
                  TextField(
                    controller: cProdi,
                    decoration: InputDecoration(labelText: 'Program Studi'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(MahasiswaProvider.notifier)
                          .updateMahasiswa(
                            cNpm.text,
                            cNama.text,
                            cProdi.text,
                            id,
                          );
                      Navigator.pop(context);
                    },
                    child: Text("Ubah"),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Data Mahasiswa tidak ditemukan'));
          }
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
