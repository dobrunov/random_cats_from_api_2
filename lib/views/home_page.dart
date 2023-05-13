import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../provider/cats_provider.dart';
import '../views/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CatsProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxHeight10 = SizedBox(height: 10);
    const sizedBoxHeight25 = SizedBox(height: 25);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Consumer<CatsProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      }
                      return Column(
                        children: [
                          value.catImage == null
                              ? const SizedBox()
                              : Container(
                                  width: 280.0,
                                  height: 280.0,
                                  alignment: Alignment.center,
                                  child: Image.memory(value.catImage!, fit: BoxFit.contain),
                                ),
                          sizedBoxHeight25,
                          SizedBox(
                            width: 280.0,
                            height: 100,
                            child: SingleChildScrollView(
                              child: Text(
                                value.catFacts.data[0],
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
                          sizedBoxHeight10,
                          ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              value.getData();
                              value.updateDatabase();
                            },
                            child: const Text('Another fact'),
                          ),
                          sizedBoxHeight10,
                          ElevatedButton(
                            style: buttonStyle,
                            onPressed: () => {
                              value.updateDatabase(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HistoryPage(),
                                ),
                              ),
                            },
                            child: const Text('History'),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
