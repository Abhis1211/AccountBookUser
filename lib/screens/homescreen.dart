import 'dart:io';

import 'package:account_book_user/Constant/Colors/Colors.dart';
import 'package:account_book_user/screens/Credit_Score.dart';
import 'package:account_book_user/screens/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/Strings/Strings.dart';
import '../Constant/TextStyles/Textstyles.dart';
import '../Constant/navigaotors/Navagate_Next.dart';
import '../widget/BottomBar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

@override
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TextEditingController business = TextEditingController();

  List data = [];

  String business_name = 'JD finance';

  String? id;

  void initState() {
    getbusiness_name();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showAlertDialog(),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              child: InkWell(
                onTap: () {},
                splashColor: Colors.black,
                child: InkWell(
                    onTap: () {
                      // _business_bottomsheet();
                    },
                    child: Container(
                      height: size.height * 0.07,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      color: MyColors.primarycolor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'image/logo_bar.png',
                                height: 35,
                                width: 35,
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(business_name,
                                  style: TextStyles.withColor(
                                      TextStyles.mb16, Colors.white)),
                              SizedBox(
                                width: 14,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              nextScreen(
                                  context,
                                  Credit_Score(
                                    id: id,
                                  ));
                            },
                            child: Image.asset(
                              'image/credit_score.png',
                              height: 45,
                              width: 45,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              preferredSize: Size.fromHeight(80)),
          body: userdetails(),
          bottomNavigationBar: BottomBar(
            index: 0,
          ),
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

  // _business_bottomsheet() {
  //   var size = MediaQuery.of(context).size;
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         height: size.height * 0.38,
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(height: 10),
  //               Text(
  //                 "Business name",
  //                 style: TextStyles.mb16,
  //               ),
  //               SizedBox(height: 20),
  //               Container(
  //                 padding: EdgeInsets.only(left: 10, top: 10),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.black),
  //                 ),
  //                 width: size.width,
  //                 child: TextField(
  //                   onChanged: (text) {},
  //                   controller: business,
  //                   decoration: InputDecoration(
  //                     border: InputBorder.none,
  //                     hintText: 'Enter business name',
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 15),
  //               Center(
  //                 child: ElevatedButton(
  //                   child: Text(' Save '),
  //                   onPressed: () {
  //                     // Provider.of<Insetdatamodel>(context, listen: false)
  //                     //     .setusinessname(business.text);
  //                     // backScreen(context);
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     primary: MyColors.primarycolor,
  //                     padding:
  //                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //                     textStyle: TextStyles.mb14,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  getbusiness_name() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // business_name = prefs.getString('business_name')!;
      id = prefs.getString('login_person_id');
    });
  }
}
