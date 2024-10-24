import 'package:currency_converter/config/routes/app_routes.dart';
import 'package:currency_converter/config/routes/routes_name.dart';
import 'package:currency_converter/core/constants/navigator_key.dart';
import 'package:currency_converter/core/network/connection_checker.dart';
import 'package:flutter/material.dart';

class RootWidgetPage extends StatefulWidget {
  const RootWidgetPage({super.key});

  @override
  State<RootWidgetPage> createState() => _RootWidgetPageState();
}

class _RootWidgetPageState extends State<RootWidgetPage> {
  @override
  void initState() {
    ConnectionChecker.listenForConnectionChanges(context: context);
    super.initState();
  }

  @override
  void dispose() {
    ConnectionChecker.cancelConnectionSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.homePage,
      routes: AppRoutes.routes,
    );
  }
}
