import 'package:flutter/material.dart';

import '../utils/colors.dart';

class UserResult extends StatefulWidget {
  const UserResult({Key? key}) : super(key: key);

  @override
  State<UserResult> createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
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
        child: Text('User Result Screen'),
      ),
    );
  }
}
