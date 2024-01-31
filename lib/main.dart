import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_project_bsi_chat/presentation/pages/home_page.dart';
import 'package:mini_project_bsi_chat/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  late var box;

  MainApp({super.key}) {
    box = Hive.box('user');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: box.get('isLogin', defaultValue: false) ? HomePage() : LoginPage(),
    );
  }
}
