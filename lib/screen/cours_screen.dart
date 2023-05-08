import 'package:amir/screen/informatique_screen.dart';
import 'package:flutter/material.dart';
import 'package:amir/screen/ColorScheme.dart';

import '../Services/catalogues_services.dart';
import '../models/catalogues_model.dart';

class CoursScreen extends StatefulWidget {
  const CoursScreen({super.key});

  @override
  State<CoursScreen> createState() => _CoursScreenState();
}

class _CoursScreenState extends State<CoursScreen> {
  CataloguesController cataloguesController = CataloguesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pink,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/searchBg.png"))),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bienvenue chez",
                    style: TextStyle(
                        fontSize: 26, fontFamily: 'circe', color: Colors.white),
                  ),
                  const Text(
                    "AMIR",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'circe',
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Catalogues>>(
                future: cataloguesController.getAllcatalogues(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('somthing went wrong ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    List<Catalogues> catalogues = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView(
                            children: catalogues.map((document) {
                              return tutorWidget(
                                  document.image,
                                  document.collegeYear,
                                  document.collegeYear,
                                  document.nameCatalogue,
                                  document.id);
                            }).toList(),
                          ))
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  InkWell tutorWidget(
      String img, String name, String subj, String grade, String price) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InformatiqueHomeScreen(
                    idCatalog: price,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 130,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: pink.withOpacity(0.5)),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(30)),
                  child: Container(
                    height: 125,
                    width: 150,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/images/iconBgNew.png'),
                            fit: BoxFit.contain)),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: Hero(
                    tag: price,
                    child: Container(
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('http://10.0.2.2:8000/$img'),
                              fit: BoxFit.contain)),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
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
}
