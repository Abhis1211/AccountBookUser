import 'package:account_book_user/Constant/TextStyles/Textstyles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class userdetails extends StatefulWidget {
  userdetails({Key? key}) : super(key: key);

  @override
  State<userdetails> createState() => _userdetailsState();
}

class _userdetailsState extends State<userdetails> {
  List data = [];
  List got_data = [];
  List gave_data = [];
  TextEditingController customer = TextEditingController();

  bool showloading = false;
  double total_got_data_amount = 0.0;
  double total_gave_data_amount = 0.0;
  double total = 0;

  void initState() {
    get_customer_entry_record("Entry");
    totalgotmoney("Entry");
    totalgavemoney("Entry");
    super.initState();
  }

  // callfunctionfor_refresh() {
  //   get_customer_entry_record("Entry");
  //   totalgotmoney("Entry");
  //   totalgavemoney("Entry");
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    total = total_got_data_amount - total_gave_data_amount;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () {
            return get_customer_entry_record('Entry');
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total you will Gave',
                                style: TextStyles.withColor(
                                    TextStyles.mb14, Colors.black)),
                            Text('\u{20B9} ' + total.toString(),
                                style: TextStyles.withColor(
                                    TextStyles.mb20, Colors.red)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                    '\u{20B9} ' +
                                        total_got_data_amount.toString(),
                                    style: TextStyles.withColor(
                                        TextStyles.mb20, Colors.red)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("you  Got",
                                    style: TextStyles.withColor(
                                        TextStyles.mn14, Colors.red))
                              ],
                            ),
                            VerticalDivider(
                              width: 5,
                              color: Colors.black,
                              thickness: 2,
                            ),
                            Column(
                              children: [
                                Text(
                                    '\u{20B9} ' +
                                        total_gave_data_amount.toString(),
                                    style: TextStyles.withColor(
                                        TextStyles.mb20, Colors.green)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("you  Gave",
                                    style: TextStyles.withColor(
                                        TextStyles.mn14, Colors.green))
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        // GestureDetector(
                        //   onTap: () {
                        //     // nextScreen(context, ViewReport());
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text("View Report",
                        //             style: TextStyles.withColor(
                        //                 TextStyles.mb14, Colors.black)),
                        //       ),
                        //       SizedBox(width: 10),
                        //       Icon(
                        //         Icons.arrow_forward_ios_outlined,
                        //         size: 15,
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(left: 10, top: 5),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey),
              //       borderRadius: BorderRadius.all(Radius.circular(15))),
              //   height: size.height * 0.06,
              //   child: TextField(
              //     onChanged: (text) {
              //       _runFilter(text);
              //     },
              //     controller: customer,
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         prefixIcon: Icon(
              //           Icons.search,
              //           size: 30,
              //         ),
              //         hintText: 'search Entries',
              //         hintStyle: TextStyles.mb14),
              //   ),
              // ),
              // Divider(),
              if (showloading == true)
                Center(child: CircularProgressIndicator()),

              if (data.length == 0 && showloading == false)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "NO DATA FOUND",
                    style: TextStyles.mb14,
                  )),
                ),
              SingleChildScrollView(
                child: Container(
                  height: size.height * 0.62,
                  child: RefreshIndicator(
                    onRefresh: () => get_customer_entry_record('Entry'),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(DateTime.parse(data[index]
                                                      ['date']
                                                  .toString()))
                                              .toString(),
                                          style: TextStyles.mb14,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        data[index]['description'] == ""
                                            ? Text(
                                                data[index]['description']
                                                    .toString(),
                                                style: TextStyles.mn14,
                                              )
                                            : Text(
                                                "no description",
                                                style: TextStyles.mn14,
                                              )
                                      ],
                                    ),
                                    Text(
                                      '\u{20B9}' +
                                          data[index]['amount'].toString(),
                                      style: data[index]['type'] == '0'
                                          ? TextStyles.withColor(
                                              TextStyles.mb18, Colors.red)
                                          : TextStyles.withColor(
                                              TextStyles.mb18, Colors.green),
                                    ),
                                  ],
                                )),
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  get_customer_entry_record(tablename) async {
    data.clear();

    setState(() {
      showloading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('login_person_id');
    FirebaseFirestore.instance
        .collection(tablename)
        .where('user_id', isEqualTo: id)
        .where('deleted_status', isEqualTo: '0')
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot != null) {
        querySnapshot.docs.forEach((element) {
          print("data" + element.data().toString());
          setState(() {
            data.add(element.data());
          });
        });
        total_got_data_amount = 0.0;
        total_gave_data_amount = 0.0;
        total = 0;
        totalgotmoney("Entry");
        totalgavemoney("Entry");
        setState(() {
          showloading = false;
        });
      }
    });
  }

  totalgotmoney(tablename) async {
    got_data.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('login_person_id');
    FirebaseFirestore.instance
        .collection(tablename)
        .where('user_id', isEqualTo: id)
        .where('deleted_status', isEqualTo: '0')
        .where('type', isEqualTo: "0")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot != null) {
        querySnapshot.docs.forEach((element) {
          setState(() {
            got_data.add(element.data());
          });
        });
        print("got" + got_data.length.toString());
        for (var i = 0; i <= got_data.length; i++) {
          total_got_data_amount =
              double.parse(got_data[i]['amount']) + total_got_data_amount;
          print(total_got_data_amount);
        }
      }
    });
  }

  totalgavemoney(tablename) async {
    gave_data.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('login_person_id');
    FirebaseFirestore.instance
        .collection(tablename)
        .where('user_id', isEqualTo: id)
        .where('deleted_status', isEqualTo: '0')
        .where('type', isEqualTo: "1")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot != null) {
        querySnapshot.docs.forEach((element) {
          setState(() {
            gave_data.add(element.data());
          });
        });
        print("got" + gave_data.length.toString());
        for (var i = 0; i <= gave_data.length; i++) {
          total_gave_data_amount =
              double.parse(gave_data[i]['amount']) + total_gave_data_amount;
        }
      }
    });
  }

  void _runFilter(String enteredKeyword) {
    var results = [];

    if (enteredKeyword.isEmpty) {
      get_customer_entry_record('Entry');
      // if the search field is empty or only contains white-space, we'll display all users
    } else {
      results = data
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      data = results;
    });
  }
}
