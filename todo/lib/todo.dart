import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/textinfo.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List<String> entries = <String>[];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          'Modern To-do',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                'TODAY\'S TASKS',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                width: 132,
                child: Divider(
                  color: Colors.blue[900],
                  thickness: 2,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _store.collection('task1').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        "Great Job!! No tasks left",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  var tasks = snapshot.data!.docs;

                  for (var task in tasks) {
                    entries.add(task['tasks']);
                  }

                  return Expanded(
                    child: ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 65,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3)),
                                      ],
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.indigo),
                                  child: Center(
                                    child: Text(
                                      "${entries[index]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          );
                        }),
                  );
                },
              ),
              SizedBox(
                height: 7,
              ),
              Center(
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const textInfo()),
                      );
                    },
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.add,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
