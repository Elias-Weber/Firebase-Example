import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/screens/readDB.dart';
import 'package:firebase_example/screens/writeDB.dart';


class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutterfire DB test"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => readDB()),
              );
                },
                child: Container(
                  width: 200, height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Read/delete from DB",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                      ),
                      ), 
                    ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => writeDB()),
              );
                },
                child: Container(
                  width: 200, height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Write in DB",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                      ),
                      ), 
                    ),
                ),
              )
          ]
          ),
        ),
      ),
    );
  }
}
