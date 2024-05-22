import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/model/shop.dart';
import 'package:my_app/pages/create_page.dart';
import 'dart:convert';

import 'package:my_app/pages/detail_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Shop>> data;

  Future<List<Shop>> fetchData() async {
    const url = 'https://kusumawardanastudio.com/api/uas/kelompok1/api_read.php';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> api = json.decode(response.body);
        List<dynamic> jsonResponse = api['data'];

        return jsonResponse.map((data) => Shop.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load API data');
      }
    } catch (e) {
      throw Exception('Errorrr: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        title: Text("UNHI Fashion"),
      ),
      body: FutureBuilder<List<Shop>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var shop = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DetailPage(model: shop)),
                    );
                  },
                  title: Text(shop.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(shop.description, maxLines: 2, style: TextStyle(overflow: TextOverflow.ellipsis)),
                  leading: shop.image.isNotEmpty
                      ? Image.network(shop.image, fit: BoxFit.cover)
                      : Icon(Icons.image),
                  trailing: Text("Rp. " + shop.harga),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreatePage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 255, 214, 9),
      ),
    );
  }
}
