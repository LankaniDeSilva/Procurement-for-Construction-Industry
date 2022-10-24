import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';

class AccountStaff extends StatefulWidget {
  const AccountStaff({Key? key}) : super(key: key);

  @override
  State<AccountStaff> createState() => _AccountStaffState();
}

class _AccountStaffState extends State<AccountStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomText(text: "Account Staff Home"),
    );
  }
}
