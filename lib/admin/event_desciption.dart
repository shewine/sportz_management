import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String title, description;

  const Description({Key? key, required this.title, required this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                title,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                description,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                'List of Registered Players:',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
