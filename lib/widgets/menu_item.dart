import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amir/theme/color.dart';

class MenuItem extends StatelessWidget {
  final String? leadingIcon;
  final Color leadingIconColor;
  final Color bgIconColor;
  final String title;
  final GestureTapCallback? onTap;
  const MenuItem(
      {Key? key,
      required this.title,
      this.onTap,
      this.leadingIcon,
      this.leadingIconColor = Colors.white,
      this.bgIconColor = primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: leadingIcon != null
              ? [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: bgIconColor, shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      leadingIcon!,
                      color: leadingIconColor,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 17,
                  )
                ]
              : [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: darker,
                    size: 18,
                  )
                ],
        ),
      ),
    );
  }
}
