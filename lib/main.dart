import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transisi_app/general_variable.dart';
import 'package:transisi_app/home.dart';
import 'package:transisi_app/register.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transisi',
      theme: ThemeData(
          primaryColor: GeneralVariable.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "NunitoSans"),
      initialRoute: '/',
      routes: {
        '/' : (context) => Login(),
      },
    );
  }
}