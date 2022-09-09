import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/textinfo.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List entries = [];
  deleteNote(id) {
    FirebaseFirestore.instance.collection('task1').doc(id).delete();
  }
  // deleteNote2(id) {
  //   FirebaseFirestore.instance.collection('task1').doc(id).delete();
  // }

  List date = [];

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const textInfo()),
          );
        },
        backgroundColor: Color.fromARGB(255, 8, 46, 77),

        // style: TextButton.styleFrom(
        //   backgroundColor: Colors.red,
        // ),
        // child: Icon(
        //   Icons.add,
        // )
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
          child: Icon(
            Icons.add,
            color: Color.fromRGBO(230, 230, 250, 2),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 8, 46, 77),
        title: Text(
          'Task Buddy',
          style:
              TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Rubik'),
        ),
      ),
      backgroundColor: Color.fromRGBO(230, 230, 250, 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'TASK LIST',
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 13, 24),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 23,
                      fontFamily: 'Rubik',
                      fontFeatures: [FontFeature.historicalLigatures()]),
                ),
              ),
              // SizedBox(
              //   width: 137,
              //   child: Divider(
              //     color: Colors.green,
              //     thickness: 2,
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('task1').snapshots(),
                builder: (context, snapshot) {
                  entries = [];
                  date = [];
                  // var tasks = snapshot.data.;
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                        child: Text(
                          "Great Job!! No tasks left",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik'),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  for (var task in snapshot.data!.docs) {
                    entries.add(task['tasks']);
                    // DateTime date = task['Date'];
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(task['Date'].toDate());

                    date.add(formattedDate);
                    // date.sort();
                  }
                  print(entries);
                  print(date);
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, int index) {
                          // DocumentSnapshot ds = entries[index];
                          return Container(
                            // key: Key("${index}"),
                            height: 65,
                            // color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        // BoxShadow(
                                        //     color: Colors.grey.withOpacity(0.5),
                                        //     spreadRadius: 5,
                                        //     blurRadius: 7,
                                        //     offset: Offset(0, 3)),
                                      ],
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      children: [
                                        // Text(_dateTime.toString()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "${date[index]}",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),

                                        Text(
                                          "${entries[index]}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Rubik'),
                                        ),

                                        IconButton(
                                            onPressed: () async {
                                              await deleteNote(snapshot
                                                  .data!.docs[index].id);

                                              // _store
                                              //     .collection('task1')
                                              //     .doc('tasks').
                                              // print("Delete");
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
                  );
                },
              ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
