import 'package:flutter/material.dart';

import 'constants.dart';

class HowAppWorks extends StatelessWidget {
  const HowAppWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'How this app works ?',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(kHowWorks),
        ),
      ),
    );
  }
}
