import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sportz_management/admin/admin_nav_screen.dart';
import 'package:sportz_management/screens/home_screen.dart';

import 'screens/login_screen.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyDTqvU3YYHNY29fSkW1B9DFMt9uIf8NV-Y",
  //           appId: "1:756061261961:web:20dd342323e51695823658",
  //           messagingSenderId: "756061261961",
  //           projectId: "insta-clone-4c01a",
  //           storageBucket: "insta-clone-4c01a.appspot.com"));
  // } else {
  await Firebase.initializeApp();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(
        //       create: (_) => UserProvider(),
        //     ),
        //   ],
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sportz Management',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home:
          // const LoginScreen(),
          StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Checking if the snapshot has any data or not
            if (snapshot.hasData) {
              // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
              return const AdminNavScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          // means connection to future hasnt been made yet
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const LoginScreen();
        },
      ),
      // const Scaffold(
      //   body: Text('Start Page'),
      // ),
    );
  }
}
