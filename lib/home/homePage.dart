import 'package:flutter/material.dart';
import 'package:gestion_school_odc/widget/cours.dart';
import 'package:gestion_school_odc/widget/drawer.dart';

import '../model/user.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue'),
      ),
      drawer: DrawerWidget(user: user),
      body: const CoursPage(),
    );
  }
}
