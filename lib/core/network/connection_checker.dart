import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter/core/utils/message_show_helper.dart';
import 'package:flutter/material.dart';

class ConnectionChecker{
  static StreamSubscription<List<ConnectivityResult>>? _subscription;
  static checkConnection({required BuildContext context})async{
    List<ConnectivityResult> connectionStatus =await Connectivity().checkConnectivity();
    if (connectionStatus.contains(ConnectivityResult.none)) {
      networkErrorShowSnackbar(context: context);
    }
  }

  static void listenForConnectionChanges({required BuildContext context}) {
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> connectionStatus) {
      if (connectionStatus.contains(ConnectivityResult.none)) {
        networkErrorShowSnackbar(context: context);
      } else {
        // call the event that you want for fetch data
        
      }
    });
  }

  static void cancelConnectionSubscription() {
    _subscription?.cancel();
  }



  static void networkErrorShowSnackbar({String? message,required BuildContext context,}){
    MessageShowhelper.showSnackbar(snackBarContent: message??"Please check your network connection",context: context, );
  }
}