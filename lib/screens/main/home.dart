import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/controllers/auth_controller.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
              onTap: () {
                AuthController().signoutUser();
              },
              child: const Icon(Icons.logout))),
    );
  }
}
