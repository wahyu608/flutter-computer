import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/constant/constant.dart';
import 'package:my_app/pages/components/appbar_component.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final title = TextEditingController();
  final description = TextEditingController();
  final harga = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      String titleValue = title.text;
      String descriptionValue = description.text;
      String hargaValue = harga.text;

      Map<String, String> data = {
        'title': titleValue,
        'description': descriptionValue,
        'harga': hargaValue,
      };

      var url = Uri.parse('https://kusumawardanastudio.com/api/uas/kelompok1/api_create.php');
      var response = await http.post(
        url,
        body: data,
      );

      if (response.statusCode == 200) {
        Map api = json.decode(response.body);
        print(api['status']);
        if (api['status'] == 'Success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(api['message']),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2), 
            ),
          );
          Navigator.pop(context); 
        } else if (api['status'] == 'Error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(api['message']),
              backgroundColor: Colors.red, 
              duration: Duration(seconds: 2), 
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tidak diketahui'),
              backgroundColor: Colors.yellow,
              duration: Duration(seconds: 2), 
            ),
          );
        }
      } else {
        throw Exception('gagal untuk dapat data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        title: 'Create Page',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
        children: [
          Text(
            'Tambahkan Produk Baru',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  labelText: 'Title *',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul Tidak Boleh Kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: description,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description *',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: harga,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga *',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga Juga Tidak Boleh Kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  submitForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(darkColor), 
                  elevation: 5, 
                  padding: EdgeInsets.symmetric(vertical: 16), 
                ),
                child: const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
    ],
      ),
      ),
    );
  }
}
