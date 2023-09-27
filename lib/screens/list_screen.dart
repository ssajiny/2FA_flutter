import 'package:flutter/material.dart';
import 'package:otp_flutter/services/database_connect.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Map<String, dynamic>>> data;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    data = DBConnect().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data ?? [];
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final item = data[index];
                return ListTile(
                  title: Text(
                    '${item['UserID']}',
                    style: const TextStyle(color: Colors.black38),
                  ),
                  subtitle: Text(
                    '${item['Content']}',
                    style: const TextStyle(
                        color: Colors.indigoAccent, fontSize: 30),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 30,
                );
              },
            );
          }
        },
      ),
    );
  }
}
