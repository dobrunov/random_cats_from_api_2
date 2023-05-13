import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../data/cat_facts_database.dart';
import '../provider/cats_provider.dart';
import '../widgets/cat_fact_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _myBox = Hive.box('myBox');
  CatFactsDataBase db = CatFactsDataBase();
  late CatsProvider provider;

  @override
  void initState() {
    if (_myBox.get("CatFactsLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<CatsProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Cat Facts',
          style: TextStyle(color: buttonTextColor),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.catFactsList.length,
        itemBuilder: (BuildContext context, int index) {
          return CatFactsTile(
            catFactText: db.catFactsList[index][0],
            timeStamp: db.timeList[index][0],
            deleteFunction: (context) => provider.deleteFact(index),
          );
        },
      ),
    );
  }
}
