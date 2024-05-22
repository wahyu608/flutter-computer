import 'package:flutter/material.dart';
import 'package:my_app/model/shop.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.model}) : super(key: key);

  final Shop model;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        title: Text('Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.model.image,
              height: 200, 
              width: double.infinity, 
              fit: BoxFit.cover, 
            ),
            SizedBox(height: 16), 
            Row(
              children: [
                Icon(Icons.wallet, size: 16), 
                SizedBox(width: 8), 
                Text(
                  widget.model.harga,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8), 
            Text(
              widget.model.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), 

            Text(
              widget.model.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
