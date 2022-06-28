import 'dart:convert';

import 'package:app_tours/models/User.dart';
import 'package:app_tours/widgets/profileWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  var username = '';
  var password = '';
  final _storage = const FlutterSecureStorage();
  final emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    final emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData == null) {
            return Container();
          }

          User user = User.fromJson(snapshot.data);
          print(snapshot.data);

          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              ProfileWidget(
                imagePath:
                "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                onClicked: () async {},
              ),
              const SizedBox(
                height: 24,
              ),
              buildName(user),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: makeInput(
                  label: "Email",
                  icon_text: Icons.email_outlined,
                  fieldController: emailController,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Update email'),
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue)),
              )
            ],
          );
        },
      ), /*
      */
    );
  }

  Future<void> _readFromStorage() async {
    username = await _storage.read(key: "username") ?? 'ricardo.jarro';
    password = await _storage.read(key: "password") ?? 'ricardo1234';
  }

  Future getUserInfo() async {
    try {
      await _readFromStorage();
      var url = "http://redpanda.sytes.net:8081/api/auth/signin";
      var bodyData = jsonEncode({"username": username, "password": password});

      var response = await http.post(Uri.parse(url),
          body: bodyData, headers: {"Content-Type": "application/json"});
      var data = json.decode(response.body);

      return data;
    } catch (e) {
      print(e);
    }
    throw Exception();
  }

  Widget buildName(User user) {
    return Column(
      children: [
        Text(
          user.username ?? 'nn',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          user.email ?? 'nn',
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget makeInput({label, obsureText = false, fieldController, icon_text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: fieldController,
          obscureText: obsureText,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon_text),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}