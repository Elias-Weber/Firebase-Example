import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import '../users.dart';
import 'home_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const COLLECTION_NAME = "users";


class readDB extends StatefulWidget {
  const readDB({super.key});

  @override
  State<readDB> createState() => _readDBState();
}

class _readDBState extends State<readDB> {
  List<Users> users = [];
  @override
  void initState() {
    fetchData();
    FirebaseFirestore.instance
        .collection(COLLECTION_NAME)
        .snapshots()
        .listen((data) {
      mapDatas(data);
    });
    super.initState();
  }

  fetchData() async {
    var data =
        await FirebaseFirestore.instance.collection(COLLECTION_NAME).get();
    mapDatas(data);
  }

  mapDatas(QuerySnapshot<Map<String, dynamic>> data) {
    var _list = data.docs
        .map((users) => Users(
            id: users.id,
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
        title: Text("Read and delete Data from DB"),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home_Screen()),
              );
          }, icon: Icon(Icons.home))
        ],
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
            onPressed: (c) {
              deleteUser(users[index].id);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
            spacing: 8,
            ),
          ],
              ),
          
              child: ListTile(
                title: Text(users[index].name + " " + users[index].surname),
                subtitle: Text(users[index].address),
              ),
            );
          }),
    );
  }
  deleteUser(String id) {
    FirebaseFirestore.instance.collection(COLLECTION_NAME).doc(id).delete();
  }
}
