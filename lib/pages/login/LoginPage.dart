import 'dart:convert';

import 'package:app_tours/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  late bool is_loading;

  Future<void> _readFromStorage() async {
    usernameController.text =
        await _storage.read(key: "username") ?? 'ricardo.jarro';
    passwordController.text =
        await _storage.read(key: "password") ?? 'ricardo1234';
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      Fluttertoast.showToast(msg: 'recuperando credenciales');
      //login();
    }
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    is_loading=false;
    super.initState();
    _readFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Welcome back ! Login with your credentials",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(shrinkWrap: true, children: [
              makeInput(
                label: "Username",
                fieldController: usernameController,
                icon_text: Icons.person,
              ),
              makeInput(
                label: "Password",
                obsureText: true,
                icon_text: Icons.key,
                fieldController: passwordController,
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: MaterialButton(
                  hoverColor: const Color.fromARGB(255, 6, 74, 105),
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return  Center(
                            child:is_loading ?CircularProgressIndicator()
                            :SizedBox(width: 0,height: 0,),
                          );
                        });
                    await login();
                    //Navigator.pop(context);

                  },
                  color: const Color(0xff03a9f4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: const Text(
                    "Signin",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account?"),
                    MaterialButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    )
                  ],
                ),
              )
            ]),
          )),
        ],
      )),
    );
  }

  Future login() async {
    setState(() {
      is_loading = true;
    });
    try {
      var url = "http://redpanda.sytes.net:81/api/auth/signin";
      var bodyData = jsonEncode({
        "username": usernameController.text,
        "password": passwordController.text
      });
      var response = await http.post(Uri.parse(url),
          body: bodyData, headers: {"Content-Type": "application/json"});
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        await _storage.write(key: "username", value: usernameController.text);
        await _storage.write(key: "password", value: passwordController.text);
        await _storage.write(key: "tokenType", value: data['tokenType']);
        await _storage.write(key: "accessToken", value: data['accessToken']);
        await _storage.write(key: "user_id", value: data['id'].toString());

        print(data['accessToken']);

        Fluttertoast.showToast(msg: "Successful access");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const Home(

                )),
                (Route<dynamic> route) => false);

      }
      else if(response.statusCode == 401){
        Fluttertoast.showToast(msg: 'Credenciaes incorrectas');
        Navigator.pop(context);
      }
      else {
        Fluttertoast.showToast(msg: 'Error al momento de ingresar');
        Navigator.pop(context);
      }

      setState(() {
        is_loading = false;
      });

    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Server error');
      setState(() {
        is_loading = false;
      });

    }
  }
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: const OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}
