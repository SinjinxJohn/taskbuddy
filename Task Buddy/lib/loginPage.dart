import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/signup.dart';
import 'package:todo/todo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    navToHome();
  }

  void navToHome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 70, 45),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.task,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "TaskBuddy",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator()
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         // border: Border.all(color: Colors.grey),
              //         borderRadius: BorderRadius.circular(8),
              //         color: Colors.grey[100]),
              //     padding: EdgeInsets.only(left: 8),
              //     child: TextField(
              //         decoration: InputDecoration(
              //             hintText: "Enter your", border: InputBorder.none),
              //         onChanged: (String value) {
              //           input1 = value;
              //         }),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
