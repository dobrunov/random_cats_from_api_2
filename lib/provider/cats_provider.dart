import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../data/database.dart';
import '../models/cat_facts_model.dart';
import '../services/datetime_service.dart';
import '../services/remote_service.dart';

class CatsProvider extends ChangeNotifier {
  //
  final _service = CatFactsService();
  CatFactsDataBase db = CatFactsDataBase();
  //
  late CatFacts _catFacts;
  late Uint8List _catImage;
  //
  CatFacts get catFacts => _catFacts;
  Uint8List get catImage => _catImage;
  //
  bool isLoading = false;
  //
  ///
  Future<void> getData() async {
    isLoading = true;
    notifyListeners();
    //
    final catFactsResponse = await _service.getCatFacts();
    final catImageResponse = await _service.getCatImage();
    DateTime currentTimeRaw = DateTime.now();
    String currentTime = DateTimeConvert.simplyFormat(currentTimeRaw);

    if (catFactsResponse != null || catImageResponse != null) {
      db.catFactsList.add([catFactsResponse.data[0], false]);
      print(currentTime.toString());
      db.timeList.add([currentTime, false]);
    }
    //
    _catFacts = catFactsResponse;
    _catImage = catImageResponse;
    //
    isLoading = false;
    notifyListeners();
  }
  //

  // List<Country> _countries = [];
  // List<Country> get countries => _countries;
  // String _searchString = "";
  //
  // // get data
  // Future<void> getAllCountries() async {
  //   isLoading = true;
  //   notifyListeners();
  //
  //   final response = await _service.getAll();
  //
  //   _countries = response;
  //   isLoading = false;
  //   notifyListeners();
}
