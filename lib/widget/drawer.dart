import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gestion_school_odc/home/homePage.dart';
import 'package:gestion_school_odc/widget/cours.dart';
import 'package:gestion_school_odc/widget/loginPage.dart';

import '../model/user.dart';
import '../register/api.dart';

class DrawerWidget extends StatefulWidget {
  final User user;
  const DrawerWidget({super.key, required this.user});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  late User _user;

  Future<void> getUser() async {
    var json = await storage.read(key: 'user');
    _user = User.fromJson(jsonDecode(json!));
    setState(() {});
  }

  _logout() async {
    await Api().logout('logout');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
            child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: Colors.orange[400]),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/odc.jpeg'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(children: [
                            Text(
                              widget.user.nom,
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ]),
                          Row(children: [
                            Text(
                              '+221 ' + widget.user.telephone,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 14),
                            ),
                          ])
                        ],
                      )
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26))),
                  child: ListTile(
                      onTap: () async {
                        _logout();
                        storage.delete(key: 'user');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      leading: const Icon(
                          IconData(0xe3b3, fontFamily: 'MaterialIcons')),
                      title: const Text(
                        'Deconnexion',
                        style: TextStyle(fontSize: 18),
                      ))),
              Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26))),
                  child: ListTile(
                      onTap: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(user: widget.user),
                          ),
                        );
                      },
                      leading: const Icon(
                          IconData(0xe3dd, fontFamily: 'MaterialIcons')),
                      title: const Text(
                        'Liste cours',
                        style: TextStyle(fontSize: 18),
                      ))),
              Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26))),
                  child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.cancel),
                      title: const Text(
                        'Liste des absences',
                        style: TextStyle(fontSize: 18),
                      ))),
            ],
          ));
  }
}
