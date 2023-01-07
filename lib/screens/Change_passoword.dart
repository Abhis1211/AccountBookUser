import 'package:account_book_user/screens/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/TextStyles/Textstyles.dart';
import '../Constant/navigaotors/Navagate_Next.dart';

class change_passowrd extends StatefulWidget {
  final id;
  change_passowrd({Key? key, this.id}) : super(key: key);

  @override
  State<change_passowrd> createState() => _change_passowrdState();
}

class _change_passowrdState extends State<change_passowrd> {
  TextEditingController new_p = TextEditingController();
  TextEditingController con_new_p = TextEditingController();

  bool validation = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              if (new_p.text.length == con_new_p.text.length) {
                final users =
                    FirebaseFirestore.instance.collection("customer_record");
                users
                    .doc(widget.id)
                    .update({'password': new_p.text})
                    .then((value) => print("password updated"))
                    .catchError(
                        (error) => print("Failed to update user: $error"));

                nextScreen(context, Profile());
              } else {
                setState(() {
                  validation = true;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: size.width,
              height: size.height * 0.05,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Save',
                  style: TextStyles.withColor(TextStyles.mb14, Colors.white),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Channge password",
            style: TextStyles.mb16,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: size.height * 0.06,
                child: TextField(
                  onChanged: (text) {},
                  controller: new_p,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'New passowrd',
                      hintStyle: TextStyles.mb14),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: size.height * 0.06,
                child: TextField(
                  onChanged: (text) {},
                  controller: con_new_p,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm new password',
                      hintStyle: TextStyles.mb14),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              validation == true
                  ? Text(
                      "Not same both new and confirm password",
                      style: TextStyles.withColor(TextStyles.mb14, Colors.red),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
