import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class Description extends StatefulWidget {
  final String title, description, id;

  const Description(
      {Key? key,
      required this.title,
      required this.description,
      required this.id})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  var userData = {};
  var registeredList = [];
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('Tasks')
          .doc(widget.id)
          .get();

      // get post lENGTH

      userData = userSnap.data()!;
      registeredList = userSnap.data()!['registeredUsers'];

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Registered Users: ',
              ),
            ],
          ),

          // FutureBuilder(
          //   future: FirebaseFirestore.instance
          //       .collection('Tasks')
          //       .doc(widget.id)
          //       .get(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return ListView.builder(
          //         itemCount: (snapshot.data! as dynamic).docs.length,
          //         itemBuilder: (context, index) => Text(
          //             (snapshot.data! as dynamic).docs[index]['registeredUsers']
          //                 ['username']));
          //   },
          // ),

          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('Tasks')
          //       .doc(widget.id)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData)
          //       return Text('Loading data.. please wait..');
          //     return Column(
          //       children: <Widget>[
          //         Text(
          //           (snapshot.data! as dynamic)['registeredUsers'],
          //           style: TextStyle(fontSize: 20),
          //         ),
          //       ],
          //     );
          //   },
          // ),

          // FutureBuilder(
          //   future: FirebaseFirestore.instance
          //       .collection('Tasks')
          //       .doc(widget.id)
          //       .get(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return ListView.builder(
          //       itemCount: (snapshot.data! as dynamic).docs.length,
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           // onTap: ()
          //           // => Navigator.of(context).push(
          //           //   MaterialPageRoute(
          //           //     builder: (context) => ProfileScreen(
          //           //       uid: (snapshot.data! as dynamic).docs[index]['uid'],
          //           //     ),
          //           //   ),
          //           // ),
          //           child: ListTile(
          //             // leading: CircleAvatar(
          //             //   backgroundImage: NetworkImage(
          //             //     (snapshot.data! as dynamic).docs[index]['photoUrl'],
          //             //   ),
          //             //   radius: 16,
          //             // ),
          //             title: Text(
          //               (snapshot.data! as dynamic).docs[index]
          //                   ['registeredUsers']['username'],
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // )

          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text('Something went wrong');
          //     } else if (snapshot.hasData || snapshot.data != null) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: snapshot.data?.docs.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           QueryDocumentSnapshot<Object?>? documentSnapshot =
          //               snapshot.data?.docs[index];

          //           return InkWell(
          //             onTap: () {
          //               // Navigator.push(
          //               //   context,
          //               //   MaterialPageRoute(
          //               //     builder: (context) => Description(
          //               //       title: documentSnapshot!['eventTitle'],
          //               //       description: documentSnapshot['eventWinner'],
          //               //     ),
          //               //   ),
          //               // );
          //             },
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Container(
          //                 margin: const EdgeInsets.only(bottom: 10),
          //                 decoration: BoxDecoration(
          //                     color: Colors.blueGrey,
          //                     borderRadius: BorderRadius.circular(10)),
          //                 height: 90,
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           margin: const EdgeInsets.only(left: 20),
          //                           child: Text(
          //                             (documentSnapshot != null)
          //                                 ? (documentSnapshot[index])
          //                                 : "No users",
          //                             style: const TextStyle(
          //                                 fontSize: 20,
          //                                 color: Colors.white,
          //                                 fontWeight: FontWeight.bold),
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           height: 5,
          //                         ),
          //                         // Container(
          //                         //   margin: const EdgeInsets.only(left: 20),
          //                         //   child: Text((documentSnapshot != null)
          //                         //       ? ('Winner Name: ' +
          //                         //           documentSnapshot["eventWinner"])
          //                         //       : ""),
          //                         // ),
          //                       ],
          //                     ),
          //                     // Container(
          //                     //   child: IconButton(
          //                     //     onPressed: () {
          //                     //       setState(() {
          //                     //         //todos.removeAt(index);
          //                     //         deleteTodo((documentSnapshot != null)
          //                     //             ? (documentSnapshot["eventTitle"])
          //                     //             : "");
          //                     //       });
          //                     //     },
          //                     //     icon: const Icon(
          //                     //       Icons.delete,
          //                     //       color: Colors.red,
          //                     //     ),
          //                     //   ),
          //                     // ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     }
          //     return const Center(
          //       child: CircularProgressIndicator(
          //         valueColor: AlwaysStoppedAnimation<Color>(
          //           Colors.red,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      // Container(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         child: Text(
      //           widget.title,
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         child: Text(
      //           widget.description,
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.all(10),
      //         child: const Text(
      //           'List of Registered Players:',
      //         ),
      //       ),

      // FutureBuilder(
      //     future: registeredList as dynamic,
      //     builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
      //         snapshot.hasData
      //             ? ListView.builder(
      //                 itemCount: snapshot.data!.length,
      //                 itemBuilder: (BuildContext context, index) => Card(
      //                   margin: const EdgeInsets.all(10),
      //                   child: ListTile(
      //                     contentPadding: const EdgeInsets.all(10),
      //                     title: Text(snapshot.data![index]['username']),
      //                     // subtitle: Text(snapshot.data![index]['body']),
      //                   ),
      //                 ),
      //               )
      //             : Center(
      //                 child: CircularProgressIndicator(),
      //               )),

      // ListView.builder(
      //   itemCount: registeredList.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(registeredList[index]),
      //     );
      //   },
      // ),

      //  ListView.builder(
      //         itemCount: (snapshot.data! as dynamic).docs.length,
      //         itemBuilder: (context, index) {
      //           return InkWell(
      //             onTap: () => Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) => ProfileScreen(
      //                   uid: (snapshot.data! as dynamic).docs[index]['uid'],
      //                 ),
      //               ),
      //             ),
      //             child: ListTile(
      //               leading: CircleAvatar(
      //                 backgroundImage: NetworkImage(
      //                   (snapshot.data! as dynamic).docs[index]['photoUrl'],
      //                 ),
      //                 radius: 16,
      //               ),
      //               title: Text(
      //                 (snapshot.data! as dynamic).docs[index]['username'],
      //               ),
      //             )
      //   //           ),
      // ],
      // ),
      // ),
    );
  }
}
