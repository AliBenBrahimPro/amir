import 'package:amir/screen/informatique_screen.dart';
import 'package:flutter/material.dart';
import 'package:amir/screen/ColorScheme.dart';

class CoursScreen extends StatefulWidget {
  const CoursScreen({super.key});

  @override
  State<CoursScreen> createState() => _CoursScreenState();
}

class _CoursScreenState extends State<CoursScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pink,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/searchBg.png"))),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenue chez",
                    style: TextStyle(
                        fontSize: 26, fontFamily: 'circe', color: Colors.white),
                  ),
                  Text(
                    "AMIR",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'circe',
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          tutorWidget(
                              "boy1", "Informatique", "English", "0-6", "150"),
                          tutorWidget(
                              "girl", "Algébre", "Arts & Crafts", "0-4", "100"),
                          tutorWidget("boy2", "Science", "Math", "0-2", "100"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell tutorWidget(
      String img, String name, String subj, String grade, String price) {
    return InkWell(
      onTap: openTeacherPage,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: pink.withOpacity(0.5)),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30)),
                  child: Container(
                    height: 125,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/images/iconBgNew.png'),
                            fit: BoxFit.contain)),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: Hero(
                    tag: img,
                    child: Container(
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('asset/images/$img.png'),
                              fit: BoxFit.contain)),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openTeacherPage() {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  InformatiqueHomeScreen()),
  );
    
  }
}
