import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:video_player/video_player.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  //   late InAppWebViewController webView;

  // @override
  // void initState() {
  //   _controller = VideoPlayerController.network(
  //     'https://github.com/shewine/sportz_management/blob/main/all.mp4',
  //   );
  //   _initializeVideoPlayerFuture = _controller.initialize();

  //   _controller.setLooping(true);

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: mobileBackgroundColor,
        title: const CircleAvatar(
          backgroundImage: AssetImage('assets/atha.jpg'),
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
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  'Atharva College Presents',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset('assets/sportz.png'),
                const Text(
                  'Rhytm',
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Motivating the unique talents',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),

                Container(
                  margin: const EdgeInsets.all(25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage('assets/ess.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // Text(
                      //   'Watumull',
                      //   style: TextStyle(color: Colors.white, fontSize: 26),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   "You ca search quickly for\nthe job you want",
                      //   style: TextStyle(
                      //       height: 1.8, fontWeight: FontWeight.w400, color: Colors.white),
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage('assets/ry.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // Text(
                      //   'Watumull',
                      //   style: TextStyle(color: Colors.white, fontSize: 26),

                      // Text(
                      //   "You ca search quickly for\nthe job you want",
                      //   style: TextStyle(
                      //       height: 1.8, fontWeight: FontWeight.w400, color: Colors.white),
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage('assets/ry2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // Text(
                      //   'Watumull',
                      //   style: TextStyle(color: Colors.white, fontSize: 26),
                      // ),

                      // Text(
                      //   "You ca search quickly for\nthe job you want",
                      //   style: TextStyle(
                      //       height: 1.8, fontWeight: FontWeight.w400, color: Colors.white),
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage('assets/ry4.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // Text(
                      //   'Watumull',
                      //   style: TextStyle(color: Colors.white, fontSize: 26),
                      // ),

                      // Text(
                      //   "You ca search quickly for\nthe job you want",
                      //   style: TextStyle(
                      //       height: 1.8, fontWeight: FontWeight.w400, color: Colors.white),
                      // ),
                    ],
                  ),
                ),

                // FutureBuilder(
                //   future: _initializeVideoPlayerFuture,
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.done) {
                //       return AspectRatio(
                //         aspectRatio: _controller.value.aspectRatio,
                //         child: Container(
                //           padding: const EdgeInsets.all(10),
                //           child: VideoPlayer(
                //             _controller,
                //           ),
                //         ),
                //       );
                //     } else {
                //       return Center(child: CircularProgressIndicator());
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       // pause
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         // play
      //         _controller.play();
      //       }
      //     });
      //   },
      //   // icon
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
