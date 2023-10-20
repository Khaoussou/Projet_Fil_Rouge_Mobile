import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gestion_school_odc/model/user.dart';
import 'package:gestion_school_odc/register/api.dart';

import '../model/cours.dart';

class CoursPage extends StatefulWidget {
  const CoursPage({super.key});

  @override
  State<CoursPage> createState() => _CoursState();
}

class _CoursState extends State<CoursPage> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  final storage = const FlutterSecureStorage();
  CoursResponse? _cours;

  _initData() async {
    User user = await Api().getUserConnect();
    Api().getData("courUsers", user.id).then((response) {
      setState(() {
        _cours = response;
      });
    });
  }

  Widget build(BuildContext context) {
    if (_cours == null) {
      return const CircularProgressIndicator();
    }
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(color: Colors.black12),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Voici l'ensemble de vos cours !",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                children: _cours!.data.cours.map((cours) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/angular.png'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cours.module,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cours.professeur,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.access_alarm_outlined),
                                const SizedBox(
                                  width: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      cours.coursDetails[0].nbrHeure + ' h',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );

                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
