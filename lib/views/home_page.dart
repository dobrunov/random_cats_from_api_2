import 'dart:typed_data';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CatsProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: paddingsAll8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<CatsProvider>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          !value.isLoading ? CatImageWidget(image: value.catImage, size: size) : const ProgressWheel(),
                          h25,
                          !value.isLoading ? CatFactWidget(fact: value.catFacts.data[0], size: size) : const ProgressWheel(),
                          h10,
                          ActionButtons(value: value),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressWheel extends StatelessWidget {
  const ProgressWheel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    );
  }
}

class CatImageWidget extends StatelessWidget {
  final Uint8List? image;
  final Size size;

  const CatImageWidget({super.key, required this.image, required this.size});

  @override
  Widget build(BuildContext context) {
    return image == null
        ? const SizedBox()
        : Container(
            width: size.width * 0.8,
            height: size.width * 0.8,
            alignment: Alignment.center,
            child: Image.memory(image!, fit: BoxFit.contain),
          );
  }
}

class CatFactWidget extends StatelessWidget {
  final String fact;
  final Size size;

  const CatFactWidget({super.key, required this.fact, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      child: SingleChildScrollView(
        child: Text(
          fact,
          style: catFactTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final CatsProvider value;

  const ActionButtons({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            value.getData();
            value.updateDatabase();
          },
          child: const Text('Another fact'),
        ),
        h10,
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            value.updateDatabase();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ),
            );
          },
          child: const Text('History'),
        ),
      ],
    );
  }
}
