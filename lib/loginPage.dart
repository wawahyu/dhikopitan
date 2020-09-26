import 'dart:ui';

import 'package:dhikopitan/landingPage.dart';
import 'package:dhikopitan/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController(),
      password = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool load = false;

  dialog({String title, String content}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title ?? ''),
        content: Text(content ?? ''),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: width * 6 / 10,
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF00B4AA),
                        Color(0xFF00B4AA),
                        Color(0xFF00A7E1),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: width * 4 / 10,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: height,
                width: width,
                child: Row(
                  children: [
                    height < width
                        ? Container(
                            width: width * 6 / 10,
                            height: height,
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                height: height / 2,
                                width: width * 6 / 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dhi Kopitan',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Menyediakan List Tempat Test Covid-19, yang Tersedia di Kota Bandung\n',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  // borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF00B4AA),
                                  Color(0xFF00B4AA),
                                  Color(0xFF00A7E1),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                        width: width,
                        height: height,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: (width * 7 / 10) / 10,
                              vertical: 12,
                            ),
                            height: height * 7 / 10,
                            width: width,
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Color(0xFF00A7E1),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: username,
                                    cursorColor: Color(0xFF00A7E1),
                                    style: TextStyle(
                                      color: Color(0xFF00A7E1),
                                    ),
                                    onChanged: (val) {
                                      if (password.text.length > 0) {
                                        formKey.currentState.validate();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF00B4AA),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF00A7E1),
                                          width: 2,
                                        ),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF00A7E1),
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF00A7E1),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val == null || val == '') {
                                        return 'Username tidak boleh kosong';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: password,
                                    cursorColor: Color(0xFF00A7E1),
                                    style: TextStyle(
                                      color: Color(0xFF00A7E1),
                                    ),
                                    obscureText: true,
                                    onChanged: (val) {
                                      setState(() {
                                        formKey.currentState.validate();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF00B4AA),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF00A7E1),
                                          width: 2,
                                        ),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF00A7E1),
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                          color: Color(0xFF00A7E1),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val == null || val == '') {
                                        return 'Password tidak boleh kosong';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (formKey.currentState.validate() &&
                                          !load) {
                                        setState(() {
                                          load = true;
                                        });
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        if (username.text != '' &&
                                            password.text != '') {
                                          bool emailValid = RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(username.text);
                                          if (emailValid) {
                                            Auth()
                                                .signIn(username.text,
                                                    password.text)
                                                .then((onValue) {
                                              if (onValue is User) {
                                                setState(() {
                                                  load = false;
                                                });
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LandingPage(),
                                                  ),
                                                );
                                              } else {
                                                setState(() {
                                                  load = false;
                                                });
                                                dialog(
                                                  title: 'Waaalaah!!',
                                                  content:
                                                      'Pengguna tidak ditemukan',
                                                );
                                              }
                                            });
                                          } else {
                                            var data = await FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .where('username',
                                                    isEqualTo: username.text)
                                                .get();
                                            if (data.docs.length > 0) {
                                              Auth()
                                                  .signIn(
                                                      data.docs[0]
                                                          .data()['email'],
                                                      password.text)
                                                  .then((onValue) {
                                                if (onValue is User) {
                                                  setState(() {
                                                    load = false;
                                                  });
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LandingPage(),
                                                    ),
                                                  );
                                                } else {
                                                  setState(() {
                                                    load = false;
                                                  });
                                                  dialog(
                                                    title: 'Ooppss!!',
                                                    content:
                                                        'Pengguna tidak ditemukan',
                                                  );
                                                }
                                              });
                                            }
                                          }
                                        }
                                      } else {
                                        setState(() {
                                          load = false;
                                        });
                                        dialog(
                                          title: 'Hmm!!!',
                                          content:
                                              'Harap isi Username dan Password dengan benar',
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            formKey.currentState?.validate() ??
                                                    false || !load
                                                ? Color(0xFF00A7E1)
                                                : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[500],
                                  offset: Offset(2, 0),
                                  blurRadius: 4,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Positioned(
                  left: 16,
                  top: 16,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LandingPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
