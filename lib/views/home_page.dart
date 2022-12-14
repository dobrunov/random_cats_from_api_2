import 'package:flutter/material.dart';
import 'dart:typed_data';

import '../constants/constants.dart';
import '../models/cat_facts_model.dart';
import '../services/datetime_service.dart';
import '../services/remote_service.dart';
import '../views/history.dart';
import '../data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CatFacts catFacts;
  late Uint8List catImage;
  late DateTime now1;

  CatFactsDataBase db = CatFactsDataBase();

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    catFacts = await CatFactsService().getCatFacts();
    catImage = await CatFactsService().getCatImage();
    DateTime currentTimeRaw = DateTime.now();
    String currentTime = DateTimeConvert.simplyFormat(currentTimeRaw);

    if (catFacts != null || catImage != null) {
      setState(() {
        isLoaded = true;
        db.catFactsList.add([catFacts.data[0], false]);

        print(currentTime.toString());
        db.timeList.add([currentTime, false]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded == false) {
      return const Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 280.0,
                  height: 280.0,
                  alignment: Alignment.center,
                  child: Image.memory(catImage, fit: BoxFit.contain),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 280.0,
                  height: 100,
                  child: SingleChildScrollView(
                    child: Text(
                      catFacts.data[0],
                      style: const TextStyle(
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.4,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    getData();
                    db.updateDatabase();
                  },
                  child: const Text('Another fact'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () => {
                    db.updateDatabase(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const History()),
                    )
                  },
                  child: const Text('History'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
