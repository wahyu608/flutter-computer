import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/model/product.dart';
import 'package:my_app/pages/components/appbar_component.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<DetailPage> createState() => _DetailPageState();

  static void launchWhatsApp(String number,String message, BuildContext context) async {
    String whatsappUrl = 'whatsapp://send?phone=$number&text=${Uri.encodeFull(message)}';
    if (await canLaunchUrlString(whatsappUrl)) {
      await launchUrlString(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuka WhatsApp')),
      );
    }
  }
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    double harga = double.tryParse(widget.product.harga) ?? 0.0;

    return Scaffold(
      appBar: const AppBarComponent(
        title: 'Detail Page',
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.wallet, size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                  const SizedBox(width: 8),
                  Text(
                    formatCurrency.format(harga),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      DetailPage.launchWhatsApp('6282293338225','Halo, saya mau membeli "${widget.product.title}" boskuu, apakah masih tersedia produknya?', context);
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Beli'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.product.title)).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Link produk telah disalin!")));
                      });
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
