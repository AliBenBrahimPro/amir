import 'package:amir/screen/video_screen.dart';
import 'package:flutter/material.dart';

import 'ColorScheme.dart';

class TabarScreen extends StatefulWidget {
  final String coursName;
  final String imageUrl;
  final String leconId;

  const TabarScreen(
      {super.key, required this.coursName, required this.imageUrl,required this.leconId});

  @override
  State<TabarScreen> createState() => _TabarScreenState();
}

class _TabarScreenState extends State<TabarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            dividerColor: Colors.white,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.video_collection_sharp),
                text: "Videos",
              ),
              Tab(icon: Icon(Icons.picture_as_pdf_sharp), text: "PDF"),
            ],
          ),
          title: Text('TutorialKart - TabBar & TabBarView'),
        ),
        body: TabBarView(
          children: [
            Center(
                child: CoursePage(
              courName: widget.coursName,
              imageUrl: widget.imageUrl,
              leconId: widget.leconId,

            )),
            Center(child: Text("Page 2")),
          ],
        ),
      ),
    );
  }
}
