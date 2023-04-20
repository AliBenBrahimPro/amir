import 'package:amir/Services/auth_service.dart';
import 'package:amir/models/user_model.dart';
import 'package:amir/screen/ColorScheme.dart';
import 'package:amir/screen/all_course.dart';
import 'package:amir/screen/chat.dart';
import 'package:amir/widgets/qustion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'gestion_screen.dart';


class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  late List<UsersModel> users = [];
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    const GestionAdmin(),
    const AllCourse(),
    const QuestionWidget(),
    const ChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Consumer<Auth>(builder: (_, auth, child) {
          if (!auth.authenticated) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: FractionalOffset.topCenter,
                        child: ListTile(
                          hoverColor: Colors.blue,
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          title: const Text('Logout'),
                          onTap: () {
                            Provider.of<Auth>(context, listen: false).logout();
                            Get.offAllNamed("/login");
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Color(0xff764abc)),
                accountName: Text(
                  '${auth.user?.firstName} ${auth.user?.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  '${auth.user?.email}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: const FlutterLogo(),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title: const Text('Cours player'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title: const Text('Groupe'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.lightbulb,
                ),
                title: const Text('Quiz'),
                onTap: () {
                  Navigator.pop(context);
                   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  QuestionWidget()),
  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.school,
                ),
                title: const Text('Certificats'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.help,
                ),
                title: const Text('Aide en ligne'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.chat,
                ),
                title: const Text('Tchat'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Logout'),
                onTap: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Get.toNamed("/login");
                },
              ),
            ],
          );
        }),
      ),
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
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Gestion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'discussion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: pink,
        unselectedItemColor: const Color.fromARGB(255, 99, 99, 99),
        onTap: _onItemTapped,
      ),
    );
  }
}
