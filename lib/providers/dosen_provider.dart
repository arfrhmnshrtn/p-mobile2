import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';

class DosenNotifier extends StateNotifier<List<DocumentSnapshot>> {
  DosenNotifier() : super([]);

  Stream<List<DocumentSnapshot>> streamData() {
    return FirebaseFirestore.instance
        .collection('dosen')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<void> addDosen(
    String nidn,
    String nama,
    String prodi,
    String fakultas,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('dosen').add({
        'nidn': nidn,
        'nama': nama,
        'prodi': prodi,
        'fakultas': fakultas,
      });
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> deleteDosen(String id) async {
    try {
      await FirebaseFirestore.instance.collection('dosen').doc(id).delete();
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}

final DosenProvider =
    StateNotifierProvider<DosenNotifier, List<DocumentSnapshot>>((ref) {
      return DosenNotifier();
    });
