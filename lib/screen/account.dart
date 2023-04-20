import 'package:flutter/material.dart';
import 'package:amir/theme/color.dart';
import 'package:amir/utils/data.dart';
import 'package:amir/widgets/custom_image.dart';
import 'package:amir/widgets/setting_box.dart';
import 'package:amir/widgets/setting_item.dart';
import 'package:provider/provider.dart';

import '../Services/auth_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: pink,
                  radius: 30,
                  child: Text(
                    Provider.of<Auth>(context, listen: true)
                        .user!
                        .firstName[0]
                        .toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                Provider.of<Auth>(context, listen: true).user!.firstName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: SettingBox(
                title: "12 courses",
                icon: "asset/icons/work.svg",
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: SettingBox(
                title: "55 hours",
                icon: "asset/icons/time.svg",
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
              SettingItem(
                title: "Mes informations",
                leadingIcon: "asset/icons/setting.svg",
                bgIconColor: blue,
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Divider(
                  height: 0,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
              SettingItem(
                title: "Changer mot de passe",
                leadingIcon: "asset/icons/password.svg",
                bgIconColor: green,
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Divider(
                  height: 0,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
              SettingItem(
                title: "Enregistrement",
                leadingIcon: "asset/icons/bookmark.svg",
                bgIconColor: primary,
                onTap: () {},
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              SettingItem(
                title: "Notification",
                leadingIcon: "asset/icons/bell.svg",
                bgIconColor: purple,
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Divider(
                  height: 0,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              SettingItem(
                title: "Déconnecté",
                leadingIcon: "asset/icons/logout.svg",
                bgIconColor: darker,
                onTap: () {},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
