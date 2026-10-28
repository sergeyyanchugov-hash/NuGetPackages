import 'package:flutter/material.dart';
import 'ui/package_list_screen.dart';

void main() {
  runApp(const NuGetPackagesApp());
}

class NuGetPackagesApp extends StatelessWidget {
  const NuGetPackagesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '.NET Packages',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PackageListScreen(),
    );
  }
}
