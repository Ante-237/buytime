import 'package:buytime/search_logic.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:buytime/constants.dart';
import 'package:buytime/gigs.dart';

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

  bool isSearchOpen = false;

  final SearchManager searchManager = SearchManager();


  void toggleSearch() {
    setState(() {
      isSearchOpen = !isSearchOpen;
    });
  }

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("BuyTime", style:  TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            actions: [
              IconButton(onPressed: toggleSearch, icon: const Icon(Icons.search)),
            ],
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
          ),
          body:  Stack(
            children: [
              TabBarView(
                children: [
                  GigsParallax(key: null, searchManager: searchManager),
                  const Icon(Icons.post_add_outlined),
                  const Icon(Icons.settings_outlined),
                ],
              ),
              // Search bar overlay
              if (isSearchOpen)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: Colors.white,
                    padding:const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                         Expanded(
                          child: TextField(
                            onChanged: (query) { setState(() {
                              searchManager.searchItems(query);
                            });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: toggleSearch,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}



