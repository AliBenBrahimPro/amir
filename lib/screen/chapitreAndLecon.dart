import 'dart:math';

import 'package:amir/models/lecons_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_list_view/group_list_view.dart';

import '../Services/chapitres_Services.dart';
import '../Services/cours_service.dart';
import '../Services/domaines_services.dart';
import '../Services/lecons_Services.dart';
import '../models/chapitres_model.dart';
import '../models/cours_model.dart';
import '../models/domaines_model.dart';
import '../theme.dart';
import 'Tabar_screen.dart';

class ChapitreLecon extends StatefulWidget {
  final String idCours;
  final String img;
  final String name;

  const ChapitreLecon({super.key,required this.idCours,required this.img, required this.name});

  @override
  State<ChapitreLecon> createState() => _ChapitreLeconState();
}

class _ChapitreLeconState extends State<ChapitreLecon> {
  List<Color> _colorCollection = <Color>[];

  List<Domaines> domaines = [];
  List<Cours> cours = [];
  List<Chapitres> chapitre = [];
  LeconsController leconsController = LeconsController();
  DomainesController domainesController = DomainesController();
  CoursController coursController = CoursController();
  ChapitresController chapitresController = ChapitresController();
  bool isDomainesLoaded = true;

 Widget getAppBarUI2() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Liste de chapitres et leçons',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: Image.network('http://10.0.2.2:8000/${widget.img}'),
          )
        ],
      ),
    );
  }



  @override
  void initState() {
    getSpecificsChapitres(widget.idCours);

    super.initState();
  }
  

  getSpecificsChapitres(String? id) async {
    chapitre =
        await chapitresController.getSpecChapitres(id);
    setState(() {
      isDomainesLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          elevation: 0,
        ),
        body: Column(
          children: [
            getAppBarUI2(),
            Expanded(
              child: FutureBuilder<List<Chapitres>>(
                  future: chapitresController
                      .getSpecChapitres(widget.idCours),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('somthing went wrong ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      final chapitres = snapshot.data!;
                      return ListView(
                        children: chapitres.map((document) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(top: 30, left: 15, bottom: 10),
                                child: Text(
                                  document.title,
                                  style: TextStyle(
                                      fontSize: 30, color: pink, letterSpacing: 1),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width - 30,
                                height: 2,
                                color: Colors.pink,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 20),
                                child:
                                 FutureBuilder<List<Lecons>>(
                                    future:
                                        leconsController.getSpecLecons(document.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              'somthing went wrong ${snapshot.error}'),
                                        );
                                      } else if (snapshot.hasData) {
                                        final Random random = new Random();
                                        final lecon = snapshot.data!;
                                        return ListView(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          children: lecon.map((leconsDoc) {
                                            return InkWell(
                                              onTap: () {
                                                  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabarScreen(coursName: widget.name,imageUrl: widget.img,leconId: leconsDoc.id,)),
                                          );
                                              },
                                              child: Card(
                                                
                                                margin: const EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: ListTile(
                                                  title: Text(leconsDoc.name,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18)),
                                                  leading: Text(
                                                    leconsDoc.number
                                                        .toString()
                                                        .padLeft(2, "0"),
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black
                                                            .withOpacity(0.3)),
                                                  ),
                                                  trailing: SvgPicture.asset(
                                                    "asset/icons/next.svg",
                                                    color: pink,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              )
                            ],
                          );
                        }).toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ));
  }
}
