import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/cats_provider.dart';
import '../views/history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CatsProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<CatsProvider>(builder: (context, value, child) {
                  // print(value.bestCountries.toString());
                  if (value.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }
                  final catImage1 = value.catImage;
                  final catFacts1 = value.catFacts;
                  return Column(
                    children: [
                      Container(
                        width: 280.0,
                        height: 280.0,
                        alignment: Alignment.center,
                        child: Image.memory(catImage1, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 280.0,
                        height: 100,
                        child: SingleChildScrollView(
                          child: Text(
                            catFacts1.data[0],
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
                          value.getData();
                          value.db.updateDatabase();
                        },
                        child: const Text('Another fact'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () => {
                          value.db.updateDatabase(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const History(),
                            ),
                          ),
                        },
                        child: const Text('History'),
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
