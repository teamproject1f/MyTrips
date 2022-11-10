import 'package:flutter/material.dart';

Widget customScrollableForm({
  required Widget child,
}) => CustomScrollView(
  slivers:
  [
    SliverFillRemaining(
      hasScrollBody: false,
      child: child,
    )
  ],
);









