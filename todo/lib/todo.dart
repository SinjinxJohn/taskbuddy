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
  deleteNote(id) {
    FirebaseFirestore.instance.collection('task1').doc(id).delete();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const textInfo()),
          );
        },
        backgroundColor: Colors.pink,

        // style: TextButton.styleFrom(
        //   backgroundColor: Colors.red,
        // ),
        // child: Icon(
        //   Icons.add,
        // )
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(32, 42, 68, 1),
        title: Text(
          'Modern To-do',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
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
                stream:
                    FirebaseFirestore.instance.collection('task1').snapshots(),
                builder: (context, snapshot) {
                  // var tasks = snapshot.data.;
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                        child: Text(
                          "Great Job!! No tasks left",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                  }

                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          // DocumentSnapshot ds = entries[index];
                          return Container(
                            // key: Key("${index}"),
                            height: 65,
                            color: Colors.white,
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
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(231, 246, 242, 1)),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(0, 35, 102, 1)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25.0),
                                          child: Text(
                                            "${entries[index]}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                              color: Colors.red,
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
