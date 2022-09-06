import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/todo.dart';
import 'package:intl/intl.dart';

class textInfo extends StatefulWidget {
  const textInfo({Key? key}) : super(key: key);

  @override
  State<textInfo> createState() => _textInfoState();
}

class _textInfoState extends State<textInfo> {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        now = value!;
      });
    });
  }

  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String input = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          'Task-Buddy',
          style: TextStyle(color: Colors.white, fontFamily: 'Rubik'),
        ),
      ),
      // backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ADD A NEW TASK",
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'Rubik')),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.only(left: 8),
                    child: TextField(
                        style: TextStyle(fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                            hintText: "e.g get clothes from laundry",
                            border: InputBorder.none),
                        onChanged: (String value) {
                          input = value;
                        }),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black),
                  child: IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: _showDatePicker
                      // style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 15,
                      //     fontFamily: 'Rubik'),

                      // icon: Icon(Icons.add),
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Center(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextButton(
                  child: Text(
                    "ADD TO LIST",
                    style: TextStyle(
                        color: Colors.white, fontSize: 15, fontFamily: 'Rubik'),
                  ),
                  // icon: Icon(Icons.add),
                  onPressed: () {
                    _store
                        .collection('task1')
                        .add({'tasks': input, 'Date': now});

                    Navigator.pop(context);
                  },
                ),
              ),
            )),
          ],
        ),
      ),
    ));
  }
}
