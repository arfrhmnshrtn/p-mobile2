import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_mobile/providers/home_provider.dart';
import 'package:project_mobile/screens/dashboard_screen.dart';
import 'package:project_mobile/screens/dosen/dosen_add_screen.dart';
import 'package:project_mobile/screens/jadwal/jadwal_add_screen.dart';
import 'package:project_mobile/screens/jadwal/jadwal_screen.dart';
import 'package:project_mobile/screens/mahasiswa/mahasiswa_add_screen.dart';
import 'package:project_mobile/screens/mahasiswa/mahasiswa_screen.dart';
import 'package:project_mobile/screens/dosen/dosen_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeController = ref.watch(HomeProvider);
    // ref.watch(HomeProvider);

    return DashboardAdmin();
  }
}

final indexProvider = StateProvider<int>((ref) => 0);

class DashboardAdmin extends ConsumerWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);

    List<Map> _fragment = [
      {
        'title': 'Halaman Utama',
        'body': DashboardScreen(),
        'add': MahasiswaAddScreen(),
      },
      {
        'title': 'Mahasiswa',
        'body': MahasiswaScreen(),
        'add': MahasiswaAddScreen(),
      },
      {'title': 'Dosen', 'body': DosenScreen(), 'add': DosenAddScreen()},
      {"title": "Jadwal", "body": JadwalScreen(), "add": JadwalAddScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_fragment[index]['title']),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _fragment[index]['add'],
                ),
              );
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
        foregroundColor: Colors.white,
      ),
      drawer: drawer(ref, context),
      body: _fragment[index]['body'],
    );
  }

  Widget drawer(WidgetRef ref, BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.account_circle, size: 80, color: Colors.white),
                Text(
                  "Arief Rachman Sahertian",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '23312222',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),

          // halaman utama
          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 0;
              Navigator.pop(context);
            },
            leading: const Icon(Icons.home),
            title: const Text('Halaman Utama'),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.blue,
            textColor: Colors.blue,
          ),

          // halaman mahasiswa
          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 1;
              Navigator.pop(context);
            },
            leading: const Icon(Icons.people),
            title: const Text('Mahasiswa'),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.blue,
            textColor: Colors.blue,
          ),

          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 2;
              Navigator.pop(context);
            },
            leading: const Icon(Icons.person),
            title: const Text('Dosen'),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.blue,
            textColor: Colors.blue,
          ),

          ListTile(
            onTap: () {
              ref.read(indexProvider.notifier).state = 3;
              Navigator.pop(context);
            },
            leading: const Icon(Icons.schedule),
            title: const Text('Jadwal'),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.blue,
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
