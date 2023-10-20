import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:gestion_school_odc/home/homePage.dart';
import 'package:gestion_school_odc/register/api.dart';

import '../model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isConnected = false;

  @override
  void initState()  {
    storage.read(key: 'user').then((userJson) {
      if (userJson != null) {
        User user = User.fromJson(jsonDecode(userJson));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage(user: user)));
      }
    });
    super.initState();
  }

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Future<User?> _register() async {
    var data = {
      'username': loginController.text,
      'password': passwordController.text
    };
    var response = await Api().login(data, 'login');

    var bodyString = response.body;
    var body = jsonDecode(bodyString);

    if (body.containsKey('token')) {
      User user = User(
          token: body['token'],
          telephone: body['telephone'],
          nom: body['nom'],
          role: body['role'],
          id: body['user_id']);
      await storage.write(key: 'user', value: jsonEncode(user));
      return user;
    } else {
      return null;
    }
  }

  _logout() async {
    isConnected = false;
    await Api().logout('logout');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(50),
              decoration: const BoxDecoration(color: Colors.cyan),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/odc.jpeg'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(color: Colors.white10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          cursorColor: const Color(0XFF000000),
                          controller: loginController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.account_circle,
                              color: Colors.cyan,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(width: 2)),
                            labelText: 'Login',
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(color: Colors.white10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          cursorColor: const Color(0XFF000000),
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                                IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                                color: Colors.cyan),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(width: 2)),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(top: 30),
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      User? result = await _register();
                      if (result != null) {
                        if (result.role == "Etudiant") {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(user: result)));
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Connexion réussie !")));
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Vous n'êtes pas un étudiant"),
                            ));
                          _logout();
                          storage.delete(key: 'user');
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text("Login ou mot de passe incorrect !")));
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.cyan[600]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
