import 'package:flutter/material.dart';
import 'package:team1/shared/components/components.dart';

class HomeLayout extends StatelessWidget {

  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(),
      body: const Text('HOME LAYOUT'),
    );
  }
}
