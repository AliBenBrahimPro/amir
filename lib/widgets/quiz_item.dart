import 'package:amir/models/cours_model.dart';
import 'package:amir/models/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:amir/theme/color.dart';

import '../models/multiple_quiz_model.dart';
import 'custom_image.dart';

class QuizItem extends StatelessWidget {
  QuizItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 290,
      this.onTap})
      : super(key: key);
  final MultipQuizModel data;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            CustomImage(
              "https://media.istockphoto.com/id/1186386668/vector/quiz-in-comic-pop-art-style-quiz-brainy-game-word-vector-illustration-design.jpg?s=170667a&w=0&k=20&c=If3x4iLdcCqLkdKpu-QnHQwIfjWIVbtrAd9a6SMrLYk=",
              width: double.infinity,
              height: 190,
              radius: 15,
            ),
            Positioned(
              top: 210,
              child: Container(
                width: width - 20,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.quizName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17,
                          color: textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     getAttribute(Icons.play_circle_outlined, labelColor,
                    //         data.),
                    //     SizedBox(
                    //       width: 12,
                    //     ),
                    //     getAttribute(Icons.schedule_rounded, labelColor,
                    //         data.createdAt.minute.toString()),
                    //   ],
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: labelColor, fontSize: 13),
        ),
      ],
    );
  }
}
