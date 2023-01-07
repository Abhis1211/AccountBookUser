import 'dart:convert';
import 'dart:io';
import 'package:account_book_user/Constant/navigaotors/Navagate_Next.dart';
import 'package:account_book_user/screens/homescreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Constant/Strings/Strings.dart';
import 'Constant/TextStyles/Textstyles.dart';

class login extends StatefulWidget {
  final token_id;
  const login({
    Key? key,
    this.token_id,
  }) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  // final databaseReference = FirebaseDatabase.instance.reference();
  var ftoken;
  var data = [];

  bool validation = false;

  final _myFormKey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        ftoken = token;
      });
    });
    print("token_id" + widget.token_id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showAlertDialog(),
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              if (_myFormKey.currentState!.validate()) {
                _login('customer_record', number.text, _password.text);
                prefs.setString("mobile_no", number.text);
                prefs.setString('password', _password.text);
              }
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: size.width,
              height: size.height * 0.05,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Login',
                      style:
                          TextStyles.withColor(TextStyles.mb14, Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
              elevation: 2.0,
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.blue[800],

                // Status bar brightness (optional)
                statusBarIconBrightness:
                    Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'image/logo.png',
                    fit: BoxFit.contain,
                    height: 45,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ConstStr.app_name.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: <Widget>[
            Positioned(
              child: SingleChildScrollView(
                child: Form(
                  key: _myFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        child: TextFormField(
                          controller: number,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Mobile number';
                            }
                            // if (value.length != 10) {
                            //   return 'Mobile number should be of 10 digits';
                            // }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Mobile number",
                              hintText: "Enter your mobile number",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: _password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your Password",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      SizedBox(height: 40),
                      validation == true
                          ? Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Invalid mobile number OR password",
                                style: TextStyles.withColor(
                                    TextStyles.mb14, Colors.red),
                              ))
                          : Text("")
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   child: Container(
            //     margin: const EdgeInsets.only(bottom: 15),
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: ElevatedButton.icon(
            //           icon: Icon(Icons.login),
            //           label: Text('Login'),
            //           style: ElevatedButton.styleFrom(
            //               primary: Colors.blue[800],
            //               elevation: 6,
            //               padding: EdgeInsets.symmetric(
            //                   vertical: 15, horizontal: 150.0)),
            //           onPressed: () async {
            //             SharedPreferences prefs =
            //                 await SharedPreferences.getInstance();
            //             if (_myFormKey.currentState!.validate()) {
            //               _login(
            //                   'customer_record', number.text, _password.text);
            //               prefs.setString("mobile_no", number.text);
            //               prefs.setString('password', _password.text);
            //             }
            //           }),
            //     ),
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }

  showAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: Text("yes"),
      onPressed: () {
        exit(0);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("no"),
      onPressed: () {
        backScreen(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure want to exit"),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _login(tablename, mobile_no, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    FirebaseFirestore.instance
        .collection(tablename)
        .where('mobile_no', isEqualTo: mobile_no)
        .where('password', isEqualTo: password)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot != null) {
        querySnapshot.docs.forEach((element) {
          print("id" + element.id.toString());

          final users =
              FirebaseFirestore.instance.collection("customer_record");
          users
              .doc(element.id)
              .update({'token': ftoken})
              .then((value) => print("token updated"))
              .catchError((error) => print("Failed to update user: $error"));

          nextScreen(context, HomeScreen());
          print("data" + element.data().toString());

          prefs.setString("login_person_id", element.id);

          setState(() {
            data.add(element.data());
          });

          print(data);
          prefs.setString("p_image", data[0]['p_image'].toString());
          prefs.setString("name", data[0]['name'].toString());
          prefs.setString("mobile_no", data[0]['mobile_no'].toString());
          prefs.setString("password", data[0]['password'].toString());
          prefs.setString("business_name", data[0]['business_name'].toString());
        });

        if (data.length > 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          validation = true;
        }
      } else {
        setState(() {
          validation = true;
        });
      }
    });
  }
}
