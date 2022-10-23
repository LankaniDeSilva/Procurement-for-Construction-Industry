import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/providers/auth/forgot_provider.dart';
import 'package:procurement_for_construction_industry/providers/auth/login_provider.dart';
import 'package:procurement_for_construction_industry/providers/auth/signup_provider.dart';
import 'package:procurement_for_construction_industry/providers/auth/user_provider.dart';
import 'package:procurement_for_construction_industry/providers/inventory/inventory_provider.dart';
import 'package:procurement_for_construction_industry/providers/site_manager/site_manager_provider.dart';
import 'package:procurement_for_construction_industry/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SignupProvider()),
      ChangeNotifierProvider(create: (context) => UserPrivider()),
      ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => ForgotProvider()),
      ChangeNotifierProvider(create: (context) => SiteManagerProvider()),
      ChangeNotifierProvider(create: (context) => InventoryProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Procurement for Construction Industry Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      home: const SplashScreen(),
    );
  }
}
