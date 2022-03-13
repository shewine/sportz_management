import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import 'login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          "Admin Screen",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              await AuthMethods().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Admin Screen'),
      ),
    );
  }
}
