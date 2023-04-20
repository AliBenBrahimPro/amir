import 'package:amir/screen/admin/screen/gestion%20cours/catalogues/read_catalogues.dart';
import 'package:flutter/material.dart';

import '../../../../theme/color.dart';
import '../../../../widgets/menu_item.dart';

class MenuCours extends StatefulWidget {
  const MenuCours({super.key});

  @override
  State<MenuCours> createState() => _MenuCoursState();
}

class _MenuCoursState extends State<MenuCours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF69BB),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItem(
              title: "Gestion de catalogue",
              leadingIcon: "asset/icons/catalog.svg",
              bgIconColor: yellow,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReadCatalogues()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItem(
              title: "Gestion de domaine",
              leadingIcon: "asset/icons/domain.svg",
              bgIconColor: green,
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItem(
              title: "Gestion de cours",
              leadingIcon: "asset/icons/courses.svg",
              bgIconColor: pink,
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItem(
              title: "Gestion de chapitre",
              leadingIcon: "asset/icons/chapters.svg",
              bgIconColor: purple,
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItem(
              title: "Gestion de leçons",
              leadingIcon: "asset/icons/lesson.svg",
              bgIconColor: red,
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItem(
              title: "Gestion de video",
              leadingIcon: "asset/icons/video.svg",
              bgIconColor: orange,
              onTap: () {},
            ),
          ),
        ]),
      ),
    );
  }
}
