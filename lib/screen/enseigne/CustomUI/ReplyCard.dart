import 'package:flutter/material.dart';

class ReplayCard extends StatelessWidget {
  final String message;
  final String time;
  bool isGroup;
  String name;

  ReplayCard(
      {required this.message,
      required this.time,
      required this.isGroup,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white, // Your specific color
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isGroup
                      ? Text(
                          name,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.blueGrey[800]),
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  Text(
                    message,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
