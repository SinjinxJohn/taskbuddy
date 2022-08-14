import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/todo.dart';

class textInfo extends StatefulWidget {
  const textInfo({Key? key}) : super(key: key);

  @override
  State<textInfo> createState() => _textInfoState();
}

class _textInfoState extends State<textInfo> {
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String input = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(32, 42, 68, 1),
          title: Text(
            'Task-Buddy',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add a new task",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100]),
                padding: EdgeInsets.only(left: 8),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter the task", border: InputBorder.none),
                    onChanged: (String value) {
                      input = value;
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(0, 35, 102, 1)),
                    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 1),
                    child: TextButton(
                        onPressed: () {
                          _store.collection('task1').add({'tasks': input});

                          Navigator.pop(context);
                        },
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
