import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/constant/color.dart';
import 'package:my_app/model/product.dart';
import 'package:my_app/pages/components/components.dart';
import 'package:my_app/pages/create_page.dart';
import 'dart:convert';

import 'package:my_app/pages/detail_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Product>> productEntries;

  Future<List<Product>> fetchData() async {
    const url =
        'https://kusumawardanastudio.com/api/uas/kelompok1/api_read.php';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> api = json.decode(response.body);
        List<dynamic> jsonResponse = api['data'];

        return jsonResponse.map((data) => Product.fromJson(data)).toList();
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
    productEntries = fetchData();
  }

  Future<void> refetchData() async {
    return setState(() {
      productEntries = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: RefreshIndicator(
          onRefresh: refetchData,
          child: FutureBuilder<List<Product>>(
            future: productEntries,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var productEntries = snapshot.data ?? [];
                var countOfProduct = productEntries.length;
                return ListView.builder(
                  itemCount: countOfProduct,
                  itemBuilder: (context, index) {
                    var product = productEntries[index];
                    return CardComponent(product: product);
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
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreatePage()));
        },
        backgroundColor: const Color(grayColor),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
