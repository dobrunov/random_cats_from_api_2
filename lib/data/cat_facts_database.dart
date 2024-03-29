import 'package:hive_flutter/hive_flutter.dart';

class CatFactsDataBase {
  List catFactsList = [];
  List timeList = [];

  // reference te box
  final _myBox = Hive.box('myBox');

  // run tis method if this is the 1st time ever opening this app
  void createInitialData() {
    catFactsList = [
      ["First fact", false],
      ["Second fact", false],
    ];
    timeList = [
      ["0", false],
      ["1", false],
    ];
  }

  // load the data from database
  void loadData() {
    catFactsList = _myBox.get("CatFactsLIST");
    timeList = _myBox.get("TIMELIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("CatFactsLIST", catFactsList);
    _myBox.put("TIMELIST", timeList);
  }
}
