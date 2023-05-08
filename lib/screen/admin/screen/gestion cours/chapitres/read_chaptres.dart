import 'dart:async';
import 'dart:developer';

import 'package:amir/screen/admin/screen/gestion%20cours/chapitres/create_chapitres.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../theme.dart';
import '../../../../../Services/chapitres_services.dart';
import '../../../../../models/chapitres_model.dart';
import '../menu_cours_screen.dart';

class ReadChapitres extends StatefulWidget {
  const ReadChapitres({super.key});

  @override
  State<ReadChapitres> createState() => _ReadChapitresState();
}

class _ReadChapitresState extends State<ReadChapitres> {
  List<Chapitres> users = [];
  ChapitresController caloguesController = ChapitresController();
  List<Chapitres> _foundInfo = [];
  final bool _sortAscending = true;
  bool isLoaded = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  var selectedItem = '';
  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Rechercher...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20, color: pink),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${_foundInfo.length}  chapitres',
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: PopupMenuButton(
                                icon: Icon(Icons.sort, color: pink),
                                onSelected: (value) {
                                  // your logic
                                  setState(() {
                                    selectedItem = value.toString();
                                  });
                                },
                                itemBuilder: (BuildContext bc) {
                                  return [
                                    PopupMenuItem(
                                      child: const Text("Tous"),
                                      onTap: () => _sortInfos(false),
                                    ),
                                    PopupMenuItem(
                                      child: const Text("Administrateur"),
                                      onTap: () => _sortNew("admin"),
                                    ),
                                    PopupMenuItem(
                                      child: const Text("Eleve"),
                                      onTap: () => _sortNew("eleve"),
                                    ),
                                    PopupMenuItem(
                                      child: const Text("Enseigne"),
                                      onTap: () => _sortNew("enseigne"),
                                    )
                                  ];
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void _sortInfos(bool ascending) {
    setState(() {
      // _sortAscending = ascending;
      // _foundInfo.sort((a, b) => ascending
      //     ? a.firstName.compareTo(b.firstName)
      //     : b.firstName.compareTo(a.firstName));
      _foundInfo = users;
    });
  }

  void _sortNew(String ascending) {
    List<Chapitres> results = [];
    setState(() {
      results = users
          .where((user) => user.title.toLowerCase().contains(ascending))
          .toList();
      log(results.map((e) => e.title).toString());
      setState(() {
        _foundInfo = results;
      });
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Chapitres> results = [];
    if (enteredKeyword.isEmpty) {
      results = users;
      setState(() {
        _foundInfo = users;
      });
    } else {
      results = users
          .where((user) => user.title
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      log(results.map((e) => e.title).toString());
      setState(() {
        _foundInfo = results;
      });
    }
  }

  getData() async {
    users = await caloguesController.getAllChapitres();
    setState(() {
      isLoaded = false;
      _foundInfo = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateChapitres()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: pink, //<-- SEE HERE
        ),
        appBar: AppBar(
          backgroundColor: pink,
          leading: BackButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuCours()),
            ),
          ),
          title: const Text("Gestion de chapitres"),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                getData();
              });
            },
            child: Visibility(
                visible: !isLoaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: Column(children: [
                  getSearchBarUI(),
                  getFilterBarUI(),
                  Expanded(
                      child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _foundInfo.length,
                    itemBuilder: (BuildContext context, int index) {
                      Chapitres? item = _foundInfo[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.contenu),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
          
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.teal,
                                )),
                            IconButton(
                                onPressed: () {
                                  caloguesController.deleteChapitres(item.id);
                                  setState(() {
                                    _foundInfo.removeWhere(
                                        (element) => element.id == item.id);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        onTap: () {},
                      );
                    },
                  )),
                ]))));
  }
}
