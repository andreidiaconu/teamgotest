import 'package:flutter/material.dart';
import 'package:teamgotest/provided_dependencies.dart';
import 'package:teamgotest/routing.dart';
import 'package:teamgotest/theming.dart';

void main() {
  runApp(
    ProvidedDependencies(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go outside',
      theme: Theming.theme(),
      initialRoute: Routes.HOME,
      routes: Routes.generateRoutes(),
    );
  }
}
