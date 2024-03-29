import 'package:buytime/UI/MORE/chat_box.dart';
import 'package:buytime/UI/MORE/create_gigs.dart';
import 'package:buytime/UI/SettingsPage.dart';
import 'package:buytime/search_logic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/UserProfilePage.dart';
import 'firebase_options.dart';
import 'package:buytime/constants.dart';
import 'package:buytime/gigs.dart';
import 'package:buytime/Maps/map_page.dart';
import 'package:buytime/UI/login_page/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  FirebaseFirestore.instance.settings  = const Settings( persistenceEnabled: true,);
  runApp(const BuyTime());
}

class BuyTime extends StatelessWidget {
  const BuyTime({super.key});

  //static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  //static FirebaseAnalyticsObserver observer =
  //FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 4000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()),);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/app_load.png"), width: 200, height: 100),
            SizedBox(height: 20),
            SpinKitCubeGrid(
              color: Colors.blue,  // Change to your preferred color
              size: 50.0,
            ),
            //SpinKitRipple(color: Colors.blue, size: 150.0,),
          ],
        )
      ),
    );
  }
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
          textTheme: const TextTheme(
              displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ))),
      home: const MyHomePage(title: 'BuyTime'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.initialIndex = 0});

  final String title;
   final int initialIndex;
  final bool StateOfVerification = false;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  bool isSearchOpen = false;
  late TabController _tabController;
  final SearchManager searchManager = SearchManager();

  // location improvements



  void openSettings(BuildContext context) {

    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()),);
  }

  void openUserProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfilePage()),
    );
  }

  void toggleSearch() {
    setState(() {
      isSearchOpen = !isSearchOpen;

    });
  }



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "BuyTime",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: toggleSearch, icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () => openSettings(context),
                  icon: const Icon(Icons.more_vert)),
              IconButton(
                icon: const Icon(Icons.account_circle),
                color: Colors.blue,
                onPressed: () => openUserProfile(context),
              )
              //openUserProfile(context)
            ],
            bottom:  TabBar(
              controller:  _tabController,
              dividerHeight: 5,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(
                  text: "gigs",
                  icon: Icon(Icons.work),
                ),
                Tab(text: "Create", icon: Icon(Icons.post_add)),
                Tab(
                  text: "chats",
                  icon: Icon(Icons.chat),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: [
                  GigsParallax(key: null, searchManager: searchManager),
                  CreateGigs(),
                  ChatPage(),
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
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (query) {
                              setState(() {
                                searchManager.searchItems(query);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: toggleSearch,
                        ),
                        IconButton(
                            onPressed: () => openSettings(context),
                            icon: const Icon(Icons.more_vert))
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
