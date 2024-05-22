import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        final snackBar = SnackBar(
          content: Text(api['message']),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.green,
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (api['status'] == 'Error') {
        final snackBar = SnackBar(
          content: Text(api['message']),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.red,
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Tidak diketahui'),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.yellow,
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      throw Exception('gagal untuk dapat data');
    }
    }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        title: const Text('UNHI Fashion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
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
                    return 'Title is required';
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
                    return 'Description is required';
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
                    return 'Harga is required'; 
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
                  primary: Colors.amber,
                  textStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
