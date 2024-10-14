import 'package:currency_converter/core/service_locator/service_locator.dart';
import 'package:currency_converter/features/root_widget_page.dart';
import 'package:flutter/material.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const RootWidgetPage());
}

