import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ResultAdd extends StatefulWidget {
  const ResultAdd({Key? key}) : super(key: key);

  @override
  State<ResultAdd> createState() => _ResultAddState();
}

class _ResultAddState extends State<ResultAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          "Result Add Screen",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: const Center(
        child: Text('Result Screen'),
      ),
    );
  }
}
