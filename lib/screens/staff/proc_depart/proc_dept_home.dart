import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../components/custom_text.dart';

class ProcDeptHome extends StatefulWidget {
  const ProcDeptHome({Key? key}) : super(key: key);

  @override
  State<ProcDeptHome> createState() => _ProcDeptHomeState();
}

class _ProcDeptHomeState extends State<ProcDeptHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomText(text: "Proc Department Home"),
    );
  }
}
