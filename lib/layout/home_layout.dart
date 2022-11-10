import 'package:flutter/material.dart';
import '../shared/components/app_bar.dart';

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
