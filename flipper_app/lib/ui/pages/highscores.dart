// import 'package:flipper_app/models/scores_data.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// class HighScores extends StatefulWidget {
//   @override
//   _HighScoresState createState() => _HighScoresState();
// }

// class _HighScoresState extends State<HighScores> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ValueListenableBuilder(
//     valueListenable: Hive.box('SCORES').listenable(),
//     builder: (context, Box<ScoresData> box, _) {
//       if (box.values.isEmpty) {
//         return Text('data is empty');
//       } else {
//         return ListView.builder(
//           itemCount: box.values.length,
//           itemBuilder: (context, index) {
//             var contact = box.getAt(index);
//             return ListTile(
//               title: Text(contact.name),
//               subtitle: Text(contact.age.toString()),
//             );
//           },
//         );
//       }
//     },
//   );
//     )
//   }
// }
