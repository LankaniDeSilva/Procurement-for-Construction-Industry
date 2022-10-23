import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(text: "Home"),
      ),
    );
  }
}
