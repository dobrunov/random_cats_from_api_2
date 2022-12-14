import 'dart:convert';

///
CatFacts catFactsFromJson(String str) => CatFacts.fromJson(json.decode(str));

class CatFacts {
  CatFacts({
    required this.data,
  });

  List<String> data;

  factory CatFacts.fromJson(Map<String, dynamic> json) => CatFacts(
        data: List<String>.from(json["data"].map((x) => x)),
      );
}
