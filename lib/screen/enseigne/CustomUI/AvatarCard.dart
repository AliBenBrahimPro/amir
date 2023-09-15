import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/user_model.dart';


class AvatarCard extends StatelessWidget {
  final UsersModel chatModel;
  const AvatarCard({super.key,required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
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
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 11,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          Text(
           "${chatModel.firstName} ${chatModel.lastName}",
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
