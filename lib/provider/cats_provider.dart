import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../data/database.dart';
import '../models/cat_facts_model.dart';
import '../services/datetime_service.dart';
import '../services/remote_service.dart';

class CatsProvider extends ChangeNotifier {
  //
  final _service = RemoteService();
  final _db = CatFactsDataBase();
  //
  late CatFacts catFacts = CatFacts(data: [""]);
  Uint8List? catImage;

  bool isLoading = false;

  Future<void> getData() async {
    try {
      setLoading(true);

      final catImage = await _service.getCatImage();
      final catFacts = await _service.getCatFacts();

      final currentTime = DateTime.now();

      if (catImage != null && catImage.isNotEmpty) {
        addToDatabase(catFacts!.data[0], currentTime);
        setCatFacts(catFacts);
        setCatImage(catImage);
      }
    } catch (e) {
      handleError(e);
    } finally {
      setLoading(false);
      debugPrint('cat data loaded');
      debugPrint(catFacts.data[0]);
    }
  }

  void addToDatabase(String fact, DateTime time) {
    final formattedTime = DateTimeConvert.simplyFormat(time);
    _db.catFactsList.add([fact, false]);
    _db.timeList.add([formattedTime, false]);
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void setCatFacts(dynamic catFacts) {
    this.catFacts = catFacts;
    notifyListeners();
  }

  void setCatImage(dynamic catImage) {
    this.catImage = catImage;
    notifyListeners();
  }

  void handleError(dynamic error) {
    debugPrint(error);
  }

  void updateDatabase() => _db.updateDatabase();
}
