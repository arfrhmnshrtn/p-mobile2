import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';

class JadwalNotifier extends StateNotifier<List<DocumentSnapshot>> {
  JadwalNotifier() : super([]);

  Stream<List<DocumentSnapshot>> streamData() {
    return FirebaseFirestore.instance
        .collection('jadwal_23312222')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<void> addJawal(
    String nama_mk,
    String nama_kelas,
    String hari,
    String jam,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('jadwal_23312222').add({
        'nama_mk': nama_mk,
        'nama_kelas': nama_kelas,
        'hari': hari,
        'jam': jam,
      });
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> deleteJadwal(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('jadwal_23312222')
          .doc(id)
          .delete();
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}

final JadwalProvider =
    StateNotifierProvider<JadwalNotifier, List<DocumentSnapshot>>((ref) {
      return JadwalNotifier();
    });
