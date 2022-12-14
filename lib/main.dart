import 'package:cat_facts_from_api_with_hive/provider/cats_provider.dart';
import 'package:cat_facts_from_api_with_hive/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CatsProvider(),
      child: MaterialApp(
        color: bgColor,
        title: 'Cat Facts',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const HomePage(),
      ),
    );
  }
}
