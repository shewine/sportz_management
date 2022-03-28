import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.grey,
          backgroundColor: mobileBackgroundColor,
          title: const CircleAvatar(
            backgroundImage: const AssetImage('assets/watulogo.jpg'),
            radius: 25,
          ),
          // const Text(
          //   "Admin Screen",
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          // ),
          actions: [
            IconButton(
              tooltip: 'Log Out',
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
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Center(
            //   child: CircleAvatar(
            //     backgroundImage: AssetImage('assets/watulogo.jpg'),
            //     radius: 50,
            //   ),
            // ),
            const Text(
              'Watumull Institute Presents',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/sportz.png'),
            const Text(
              'Kala-Krida',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Motivating the unique talents',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ],
        )

        // const Center(
        //   child: Text('Admin Screen'),
        // ),
        );
  }
}
