import 'package:flutter/material.dart';
import 'package:my_app/constant/color.dart';
import 'package:my_app/model/product.dart';
import 'package:my_app/pages/detail_page.dart';
import 'package:my_app/utils/utils.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 12),
      child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(grayColor),
            boxShadow: [
              BoxShadow(
                color: const Color(grayColor).withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.network(product.image,
                  height: 170,
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(product.harga, 2),
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          IconButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                iconColor: MaterialStatePropertyAll<Color>(
                                    Color(darkColor))),
                            icon: const Icon(Icons.shopping_bag_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(product: product)));
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                iconColor: MaterialStatePropertyAll<Color>(
                                    Color(darkColor))),
                            icon: const Icon(Icons.info),
                          )
                        ]),
                        Row(
                          children: [
                            TextButton.icon(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.transparent),
                                    iconColor: MaterialStatePropertyAll<Color>(
                                        Colors.grey.shade300)),
                                icon: const Icon(Icons.shopping_basket),
                                label: Text(
                                  "13 Terjual",
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ])
                ],
              ),
            )
          ])),
    );
  }
}
