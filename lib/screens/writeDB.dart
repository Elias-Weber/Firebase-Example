import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import '../users.dart';

const COLLECTION_NAME = "users";

class writeDB extends StatefulWidget {
  const writeDB({super.key});

  @override
  State<writeDB> createState() => _writeDBState();
}

class _writeDBState extends State<writeDB> {
  List<Users> users = [];

  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var addressController = TextEditingController();

  addUser(String name, String surname, String address) {
    var user = Users(id: "",name: name, surname: surname, address: address);
    FirebaseFirestore.instance.collection(COLLECTION_NAME).add(user.toJson());
  }

  mapDatas(QuerySnapshot<Map<String, dynamic>> data) {
    var _list = data.docs
        .map((users) => Users(
            id: users["id"],
            name: users["name"],
            surname: users["surname"],
            address: users["address"]))
        .toList();

    setState(() {
      users = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write in DB"),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home_Screen()),
              );
          }, icon: Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Column(
            children: [
              Container(
                child: Center(),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name:",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      nameController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: "Surname:",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      surnameController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Address:",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      addressController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                    onPressed: () {
                      var name = nameController.text.trim();
                      var surname = surnameController.text.trim();
                      var address = addressController.text.trim();
                      addUser(name, surname, address);
                      nameController.clear();
                      surnameController.clear();
                      addressController.clear();
                    },
                    child: const Text("add"))
            ],
          ),
        ] //Children
        ), //ListView
      ), //padding
    ); //scaffold
  }
}
