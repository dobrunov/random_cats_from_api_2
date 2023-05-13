import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../models/cat_facts_model.dart';

class RemoteService {
  static const catsBaseUri = "https://cataas.com/";
  static const factsBaseUrl = "https://meowfacts.herokuapp.com/";

  final catsUrl = Uri.parse(catsBaseUri);
  final factsUrl = Uri.parse(factsBaseUrl);

  final catKey = "cat";

  Future<CatFacts?> getCatFacts() async {
    try {
      final response = await get(factsUrl);
      if (response.statusCode == 200) {
        return catFactsFromJson(response.body);
      } else {
        const CircularProgressIndicator(
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      throw Exception('Oops: $e');
    }
    return null;
  }

  //
  Future<Uint8List?> getCatImage() async {
    try {
      final imageData = await NetworkAssetBundle(catsUrl).load(catKey);

      if (imageData.lengthInBytes > 0) {
        return imageData.buffer.asUint8List();
      } else {
        const CircularProgressIndicator(
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print('Error while fetching image: $e');
    }
    return null;
  }
}
