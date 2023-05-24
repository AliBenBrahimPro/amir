import 'package:amir/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Services/video_service.dart';
import '../theme.dart';

class CoursePage extends StatefulWidget {
  final String courName;
  final String imageUrl;
  final String leconId;

  const CoursePage(
      {super.key,
      required this.courName,
      required this.imageUrl,
      required this.leconId});
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  VideosController videosController = VideosController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.courName,
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
                tag: widget.imageUrl,
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                        image: NetworkImage(
                            'http://10.0.2.2:8000/${widget.imageUrl}'),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Playlist',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<Videos>>(
                  future: videosController.getSpecVideos(widget.leconId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('somthing went wrong ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      final video = snapshot.data!;
                      return ListView(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: video.map((videoDoc) {
                          return productListing(
                              videoDoc, videoDoc.url, 'active');
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
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Column productListing(Videos title, String info, String activeOrInactive) {
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
                onPressed: () {
                  _launchUrl(info);
                  print("i'm herre");
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title.title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  title.subTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
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
