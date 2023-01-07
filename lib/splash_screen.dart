import 'package:account_book_user/login.dart';
import 'package:account_book_user/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constant/Strings/Strings.dart';
import 'Constant/TextStyles/Textstyles.dart';
import 'Constant/navigaotors/Navagate_Next.dart';

class splash extends StatefulWidget {
  final tokenid;
  splash({Key? key, this.tokenid}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkloginornot();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: Image(image: AssetImage('image/logo.png')),
              ),
              Text(ConstStr.app_name, style: TextStyles.withColor(TextStyles.mb18, Colors.white))
            ],
          ),
          // nextScreen: login(),
        ),
      ),
    );
  }

  checkloginornot() async {
    var data;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString("login_person_id");
    if (data == null) {
      nextScreen(context, login(token_id:widget.tokenid));
    } else {
      nextScreen(context, HomeScreen());
    }
  }
}
