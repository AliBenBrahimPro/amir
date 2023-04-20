import 'dart:convert';
import 'dart:developer';

import 'package:amir/screen/ColorScheme.dart';
import 'package:amir/screen/informatique_list_view.dart';
import 'package:amir/screen/video_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/informatique_list_data.dart';

class InformatiqueHomeScreen extends StatefulWidget {
  const InformatiqueHomeScreen({super.key});

  @override
  _InformatiqueHomeScreenState createState() => _InformatiqueHomeScreenState();
}

class _InformatiqueHomeScreenState extends State<InformatiqueHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<InformatiqueListData> informatiqueList = InformatiqueListData.informatiqueList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  List<InformatiqueListData> _foundInfo = [];
  bool _sortAscending = true;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _foundInfo = informatiqueList;
    _sortNew(false);
    super.initState();
  }

  void _sortInfos(bool ascending) {
    setState(() {
      _sortAscending = ascending;
      _foundInfo.sort((a, b) => ascending
          ? a.titleTxt.compareTo(b.titleTxt)
          : b.titleTxt.compareTo(a.titleTxt));
    });
  }

  void _sortNew(bool ascending) {
    setState(() {
      _sortAscending = ascending;
      _foundInfo.sort((a, b) => ascending
          ? a.createdAt.compareTo(b.createdAt)
          : b.createdAt.compareTo(a.createdAt));
    });
  }

  void _runFilter(String enteredKeyword) {
    List<InformatiqueListData> results = [];
    if (enteredKeyword.isEmpty) {
      results = informatiqueList;
      log("id : ${results}");
    } else {
      results = informatiqueList
          .where((user) => user.titleTxt
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      log(results.map((e) => e.titleTxt).toString());
      setState(() {
        _foundInfo = results;
      });
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  getAppBarUI2(),
                  getSearchBarUI(),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverPersistentHeader(
                            pinned: true,
                            floating: true,
                            delegate: ContestTabHeader(
                              getFilterBarUI(),
                            ),
                          ),
                        ];
                      },
                      body: _foundInfo.isNotEmpty
                          ? 
                          Container(
                              color: Colors.white,
                              child: ListView.builder(
                                itemCount: _foundInfo.length,
                                padding: const EdgeInsets.only(top: 8),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  final int count = _foundInfo.length > 10
                                      ? 10
                                      : _foundInfo.length;
                                  final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0)
                                          .animate(CurvedAnimation(
                                              parent: animationController!,
                                              curve: Interval(
                                                  (1 / count) * index, 1.0,
                                                  curve:
                                                      Curves.fastOutSlowIn)));
                                  animationController?.forward();
                                  return InformatiqueListView(
                                    callback: () {
                                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  CoursePage()),
  );
                                    },
                                    
                                    informatiqueData: _foundInfo[index],
                                    animation: animation,
                                    animationController: animationController!,
                                    

                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w300),
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: informatiqueList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          informatiqueList.length > 10 ? 10 : informatiqueList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return InformatiqueListView(
                        callback: () {},
                        informatiqueData: informatiqueList[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getInformatiqueViewList() {
    final List<Widget> informatiqueListViews = <Widget>[];
    for (int i = 0; i < informatiqueList.length; i++) {
      final int count = informatiqueList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      informatiqueListViews.add(
        InformatiqueListView(
          callback: () {},
          informatiqueData: informatiqueList[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: informatiqueListViews,
    );
  }

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
                    decoration: InputDecoration(
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
                      '${_foundInfo.length} cours disponible',
                      style: TextStyle(
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
                          Text(
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
                                      child: Text("Plus recent"),
                                      onTap: () => _sortNew(false),
                                    ),
                                    PopupMenuItem(
                                      child: Text("A-Z"),
                                      onTap: () => _sortInfos(true),
                                    ),
                                    PopupMenuItem(
                                      child: Text("Z-A"),
                                      onTap: () => _sortInfos(false),
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

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.locationDot),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

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
                  'Choisi ton',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Informatique Cours',
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
            child: Image.asset('asset/images/boy1.png'),
          )
        ],
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
