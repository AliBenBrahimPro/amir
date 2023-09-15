import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/user_model.dart';


class ContactCard extends StatelessWidget {
  final UsersModel chatModel;
  const ContactCard({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
     
      title: Text(
        "${chatModel.firstName} ${chatModel.lastName}",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        chatModel.email,
        style: const TextStyle(fontSize: 13),
      ),
      leading: SizedBox(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blueGrey[200],
                child: SvgPicture.asset(
                  'asset/icons/person.svg',
                  color: Colors.white,
                  height: 30,
                  width: 30,
                )),
            chatModel.select
                ? const Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 11,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
