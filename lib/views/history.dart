import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../data/database.dart';
import '../util/cat_fact_tile.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // reference te hive box
  final _myBox = Hive.box('mybox');
  CatFactsDataBase db = CatFactsDataBase();

  @override
  void initState() {
    if (_myBox.get("CatFactsLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  void deleteFact(int index) {
    setState(() {
      db.catFactsList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Cat Facts',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.catFactsList.length,
        itemBuilder: (BuildContext context, int index) {
          return CatFactsTile(
            catFactText: db.catFactsList[index][0],
            timeStamp: db.timeList[index][0],
            deleteFunction: (context) => deleteFact(index),
          );
        },
      ),
    );
  }
}
