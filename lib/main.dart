import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'about_us.dart';
import 'how_app_works.dart';
import 'instructions.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/howAppWork': (context) => const HowAppWorks(),
        '/about': (context) => const AboutUs(),
        '/instructions': (context) => const Instructions(),
      },
      theme: ThemeData.dark(),
    ),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedAnimal = 'dog';
  Color mainButtonColor = Colors.green;
  String modeText = 'DOG MODE';
  AudioCache cache = AudioCache();
  late AudioPlayer player;

  void _stopFile() {
    player.stop(); // stop the file like this
  }

  void _playFile() async {
    player = await cache.loop('$selectedAnimal.mp3'); // assign player here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(modeText),
        actions: [
          MaterialButton(
            onPressed: () {
              showAlertDialog(context);
            },
            child: const Icon(
              Icons.power_settings_new,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  Expanded(child: Text(modeText)),
                  Expanded(
                      child: Image.asset(
                    'Images/$selectedAnimal.png',
                    color: Colors.white,
                  )),
                ],
              ),
            ),
            ListTile(
              title: const Text('How this app works ?'),
              onTap: () {
                Navigator.pushNamed(context, '/howAppWork');
              },
            ),
            ListTile(
              title: const Text('Instructions'),
              onTap: () {
                Navigator.pushNamed(context, "/instructions");
              },
            ),
            ListTile(
              title: const Text('Rate us'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('About us'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            const SizedBox(
              height: 80.0,
            ),
            const Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RawMaterialButton(
                  onPressed: () {
                    if (mainButtonColor == Colors.green) {
                      mainButtonColor = Colors.red;
                      _playFile();
                    } else {
                      mainButtonColor = Colors.green;
                      _stopFile();
                    }
                    setState(() {});
                  },
                  elevation: 10.0,
                  fillColor: mainButtonColor,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image(
                      image: AssetImage('Images/$selectedAnimal.png'),
                    ),
                  ),
                  shape: const CircleBorder(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            animalButton(
                                animalSelected: 'dog', mode: 'DOG MODE'),
                            animalButton(
                                animalSelected: 'mosq', mode: 'MOSQUITO MODE'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            animalButton(
                                animalSelected: 'rat', mode: 'RAT MODE'),
                            animalButton(
                                animalSelected: 'cockroach',
                                mode: 'COCKROACH MODE'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget adSpace() {
  //   try {
  //     return Container(
  //       color: const Color.fromRGBO(255, 255, 255, 0.1),
  //       height: 50,
  //       child: AdWidget(
  //         ad: banner,
  //       ),
  //     );
  //   } catch (e) {
  //     return Container(
  //       color: const Color.fromRGBO(255, 255, 255, 0.1),
  //       height: 50,
  //       child: AdWidget(
  //         ad: banner,
  //       ),
  //     );
  //   }
  // }

  Expanded animalButton(
      {required String animalSelected, required String mode}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RawMaterialButton(
          onPressed: () {
            _stopFile();
            selectedAnimal = animalSelected;
            mainButtonColor = Colors.green;
            modeText = mode;
            setState(() {});
          },
          elevation: 10.0,
          fillColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image(
              image: AssetImage('Images/$animalSelected.png'),
            ),
          ),
          shape: const CircleBorder(),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Quit"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Animal Repeller"),
      content: const Text("Would you want to exit the Animal Repeller"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
