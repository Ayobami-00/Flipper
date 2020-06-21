import 'package:flipper_app/ui/pages/home.dart';
import 'package:flipper_app/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flipper_app/models/card_data.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(CardDataAdapter());
  // await Hive.openBox<CardData>('cardsData');
  // await Hive.openBox('gameRoomData');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
       
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage()
    );
  }
}
