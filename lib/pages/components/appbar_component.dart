import 'package:flutter/material.dart';
import 'package:my_app/constant/color.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarComponent({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        title: Text(title, //update title to more flexible
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Color(grayColor));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
