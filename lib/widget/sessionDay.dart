import 'package:flutter/material.dart';
import 'package:gestion_school_odc/model/session.dart';
import 'package:gestion_school_odc/register/api.dart';

import '../model/user.dart';
import 'drawer.dart';

class SessionDay extends StatefulWidget {
  final User user;

  const SessionDay({super.key, required this.user});

  @override
  State<SessionDay> createState() => _SessionDayState();
}

class _SessionDayState extends State<SessionDay> {
  @override
  bool isChecked = false;
  bool isDisabled = true;
  SessionResponse? _sessionResponse;

  void initState() {
    _getSessionDay();
    super.initState();
  }

  _registration(userId, sessionId) async {
    var data = {'idUser': userId, 'idSession': sessionId};
    var response = await Api().registration(data, 'emargements');
    print(response.body);
  }

  _getSessionDay() async {
    User userConnect = await Api().getUserConnect();
    await Api().getSessionDay('sessionDay', userConnect.id).then((response) {
      setState(() {
        _sessionResponse = response;
      });
    });
  }

  bool isTodayInInterval(String startStr, String endStr) {
    DateTime today = DateTime.now();
    DateTime startDate = DateTime.parse(startStr);
    DateTime endDate = DateTime.parse(endStr);
    return today.isAfter(startDate) && today.isBefore(endDate);
  }

  _compareDate(date, hd, hf) {
    String concact = '$date $hd';
    String concact1 = '$date $hf';
    if (isTodayInInterval(concact, concact1)) {
      isDisabled = false;
      print("La date d'aujourd'hui est dans l'intervalle de temps.");
    } else {
      isDisabled = true;
      print("La date d'aujourd'hui n'est pas dans l'intervalle de temps.");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue'),
      ),
      drawer: DrawerWidget(user: widget.user),
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(color: Colors.black12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  _sessionResponse?.message ?? '',
                  style: const TextStyle(color: Colors.black87, fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                children: _sessionResponse?.data.sessions.map((session) {
                      String image = session.image;
                      _compareDate(
                          session.date, session.heureDebut, session.heureFin);
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
                                  image: DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session.module,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  session.date,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${session.heureDebut}h ${session.heureFin}h',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Checkbox(
                                            checkColor: Colors.white,
                                            value: isChecked,
                                            onChanged: isDisabled
                                                ? null
                                                : (bool? value) {
                                                    setState(() {
                                                      isChecked = value!;
                                                      if (isChecked) {
                                                        _registration(widget.user.id, session.id);
                                                      }
                                                    });
                                                  }),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    })?.toList() ??
                    [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
