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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: paddingsAll8,
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
                                  width: size.width * 0.8,
                                  height: size.width * 0.8,
                                  alignment: Alignment.center,
                                  child: Image.memory(value.catImage!, fit: BoxFit.contain),
                                ),
                          sizedBoxHeight25,
                          SizedBox(
                            width: size.width * 0.8,
                            height: size.width * 0.35,
                            child: SingleChildScrollView(
                              child: Text(
                                value.catFacts.data[0],
                                style: catFactTextStyle,
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
