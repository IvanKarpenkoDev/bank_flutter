import 'package:bank_flutter/home.dart';
import 'package:bank_flutter/signUp.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPageNew extends StatefulWidget {
  @override
  _SignInPageNewState createState() => _SignInPageNewState();
}

class _SignInPageNewState extends State<SignInPageNew> {
  TextEditingController _emailController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _passwordController = TextEditingController();
  late String _email;
  // ignore: unused_field
  late String _password;
  bool showLogin = true;
  bool signInChek = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: -50,
                      height: 400,
                      width: width,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/background.png'),
                                fit: BoxFit.fill)),
                      )),
                  Positioned(
                      top: -10,
                      height: 400,
                      width: width + 20,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/background-2.png'),
                                fit: BoxFit.fill)),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Авторизация",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: TextFormField(
                            controller: _emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Логин",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Пароль",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(24, 13, 105, 1),
                    ),
                    child: Center(
                      child: TextButton(
                        child: Text(
                          "Войти",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MySample()));
                          } on FirebaseException catch (e) {
                            final snackBar = SnackBar(
                                content: const Text("Ошибка авторизации"),
                                backgroundColor: (Colors.black26),
                                action: SnackBarAction(
                                  label: 'dismiss',
                                  onPressed: () {},
                                ));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                      child: Text(
                        "Создать аккаунт",
                        style:
                            TextStyle(color: Color.fromRGBO(31, 25, 85, 0.6)),
                      ),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPageNew()))
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
