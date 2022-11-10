import 'package:flutter/material.dart';
import 'package:team1/shared/components/components.dart';

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
