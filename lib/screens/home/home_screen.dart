import 'package:flutter/material.dart';

import '../../shared/components/app_bar.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      body: const Center(child: Text('HOME Screen')),
    );
  }
}
