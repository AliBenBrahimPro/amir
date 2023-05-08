import 'package:amir/screen/admin/screen/gestion%20cours/catalogues/read_catalogues.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/chapitres/read_chaptres.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/cours/read_cours.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/domaines/read_domaine.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/lecons/read_lecons.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/pdf/read_pdf.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/video/read_video.dart';
import 'package:flutter/material.dart';

import '../../../../theme/color.dart';
import '../../../../widgets/menu_item.dart';
import '../gestion_screen.dart';

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
        leading: BackButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const GestionAdmin()),
          ),
        ),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReadDomaine()),
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
              title: "Gestion de cours",
              leadingIcon: "asset/icons/courses.svg",
              bgIconColor: pink,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReadCours()),
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
              title: "Gestion de chapitre",
              leadingIcon: "asset/icons/chapters.svg",
              bgIconColor: purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReadChapitres()),
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
              title: "Gestion de leçons",
              leadingIcon: "asset/icons/lesson.svg",
              bgIconColor: red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReadLecons()),
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
              title: "Gestion de PDF",
              leadingIcon: "asset/icons/pdf.svg",
              bgIconColor: orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReadPdf()),
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
              title: "Gestion de video",
              leadingIcon: "asset/icons/video.svg",
              bgIconColor: sky,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReadVideos()),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
