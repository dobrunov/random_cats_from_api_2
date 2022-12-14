import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../models/cat_facts_model.dart';

class CatFactsService {
  //
  Future<CatFacts> getCatFacts() async {
    final response = await get(Uri.parse(
      'https://meowfacts.herokuapp.com/',
    ));
    if (response.statusCode == 200) {
      final catFacts = catFactsFromJson(response.body);
      print('get $catFacts');
      return catFacts;
    } else {
      const CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    }
    throw Exception('Oops');
  }

  //
  Future<Uint8List> getCatImage() async {
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse("https://cataas.com/cat")).load("");
    if (imageData != null) {
      final Uint8List rawImage = imageData.buffer.asUint8List();
      return rawImage;
    } else {
      const CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    }
    throw Exception('Oops');
  }
}
