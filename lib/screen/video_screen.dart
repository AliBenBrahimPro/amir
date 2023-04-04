import 'package:flutter/material.dart';

import '../theme.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late String chosenImg;
  late String chosenTitle;
  @override
  Widget build(BuildContext context) {
    final Map arguments = {'img': "laravel", 'title': "Laravel"};
    chosenImg = arguments['img'];
    chosenTitle = arguments['title'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              chosenTitle,
              style: const TextStyle(
                color: Color(0xff2657ce),
                fontSize: 27,
              ),
            ),
            Text(
              'Par AMIR',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 0.2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Hero(
                tag: chosenImg,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                        image: AssetImage('asset/images/$chosenImg.png'),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Playlist',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xffd3defa),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 35,
                        child: IconButton(
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        "Voir le cours",
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    productListing(
                        'Introduction', 'Introduction de Laravel', 'active'),
                    productListing('Routing de base',
                        'Apprendre routing de base..', 'inactive'),
                    productListing('Les contrôleurs',
                        'Apprendre les contrôleurs..', 'inactive'),
                    productListing('Les vues avec Blade',
                        'Apprendre les vues avec Blade..', 'inactive')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column productListing(String title, String info, String activeOrInactive) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (activeOrInactive == 'active')
                    ? const Color(0xff2657ce)
                    : const Color(0xffd3defa),
                borderRadius: const BorderRadius.all(Radius.circular(17)),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: (activeOrInactive == 'active')
                      ? Colors.white
                      : const Color(0xff2657ce),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  info,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                )
              ],
            )
          ],
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.85,
            height: 0.5,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
