import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transisi_app/api_provider.dart';
import 'package:transisi_app/general_variable.dart';
import 'package:transisi_app/home.dart';
import 'package:transisi_app/model/contactdetail_result.dart';
import 'package:transisi_app/model/getcontact_result.dart';

import 'generanl_function.dart';

class Login extends StatefulWidget {


  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: GeneralVariable.primaryColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        iconTheme: IconThemeData(
            color: GeneralVariable.primaryColor
        ),
        title: Text("Login",
          style: GeneralVariable.titleTextStyle,
        ),
        backgroundColor: GeneralVariable.primaryColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 2,
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Doe@gmail.com",
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.person, color: GeneralVariable.primaryColor,)
                      ),
                      controller: emailController,
                      focusNode: emailFocus,
                      onSubmitted: (term) {
                        GeneralFunctions.fieldFocusChange(
                            context, emailFocus, passwordFocus);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  elevation: 2,
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "*****",
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.lock, color: GeneralVariable.primaryColor,)
                      ),
                      controller: passwordController,
                      focusNode: passwordFocus,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: (){
                            if(emailController.text == "" || passwordController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "please fill all text field",
                                    textAlign: TextAlign.center,)
                              ));
                            }
                            else{
                              ApiProvider.current.register(emailController.text, passwordController.text).then((value){
                                String result = jsonDecode(value.toString())["token"];
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "Registen Successful with token $result",
                                    textAlign: TextAlign.center,),
                                  duration: const Duration(seconds: 2),
                                ));
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Home();
                                    }));
                              });
                            }
                          },
                          child: Text("Register")),
                      ElevatedButton(
                          onPressed: (){
                            if(emailController.text == "" || passwordController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "please fill all text field",
                                    textAlign: TextAlign.center,)
                              ));
                            }
                            else{
                              ApiProvider.current.login(emailController.text, passwordController.text).then((value){
                                String result = jsonDecode(value.toString())["token"];
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "Login Successful with token $result",
                                    textAlign: TextAlign.center,),
                                  duration: const Duration(seconds: 2),
                                ));
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Home();
                                    }));
                              });
                            }
                          },
                          child: Text("Login"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}