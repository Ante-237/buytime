import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:buytime/constants.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuyTime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        brightness: Brightness.light,
        useMaterial3: true,
      textTheme: const TextTheme (
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        )
      )
      ),
      home: const MyHomePage(title: 'BuyTime'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage ({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                    text: "gigs",
                    icon: Icon(Icons.work),

                ),
                Tab(
                  text: "Create",
                    icon: Icon(Icons.post_add)
                ),
                Tab(
                  text: "chats",
                    icon: Icon(Icons.settings),
                ),
              ],
            ),
            title: const Text('BuyTime'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.work),
              Icon(Icons.post_add_outlined),
              Icon(Icons.settings_outlined),
            ],
          ),
        ),
      ),
    );
  }
}



