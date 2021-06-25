import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transisi_app/api_provider.dart';
import 'package:transisi_app/detail.dart';
import 'package:transisi_app/general_variable.dart';
import 'package:transisi_app/model/getcontact_result.dart';

import 'generanl_function.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  GetcontactResult getcontactResult;

  Future getcontactResultFuture;

  _getcontactResultFuture()async{
    return ApiProvider.current.getContact("");
  }

  @override
  void initState() {
    super.initState();
    getcontactResultFuture =_getcontactResultFuture();
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
        title: Text("Contact",
          style: GeneralVariable.titleTextStyle,
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            child: IconButton(
                icon: new Icon(Icons.search, size: 30, color: GeneralVariable.whiteColor,),
                onPressed: () => Navigator.of(context).pop()
            ),
          )
        ],
        backgroundColor: GeneralVariable.primaryColor,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
          child : Icon(Icons.add, size: 30, color: GeneralVariable.whiteColor,),
        onPressed: (){
          setState(() {
              modalbottomadd(context);
            });
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getcontactResultFuture,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                getcontactResult = GetcontactResult.fromJson(jsonDecode(snapshot.data.toString()));
                return ListView.builder(
                  itemCount: getcontactResult.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return   Container(
                      child: ListTile(
                        leading: Container(
                          child: Image.network(getcontactResult.data[index].avatar),
                        ),
                        title: Text(getcontactResult.data[index].firstName + " " + getcontactResult.data[index].lastName),
                        subtitle: Text(getcontactResult.data[index].email),
                        trailing: Icon(Icons.star_border),
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return Detail(useridx: getcontactResult.data[index].id.toString());
                              }));
                        },
                      ),
                    );
                  },
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  void modalbottomadd(context) async{

    TextEditingController firstnameController = new TextEditingController();
    TextEditingController lastnameController = new TextEditingController();
    TextEditingController phonenumberController = new TextEditingController();
    TextEditingController jobController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController websiteController = new TextEditingController();

    final firstnameFocus = FocusNode();
    final lastnameFocus = FocusNode();
    final phonenumberFocus = FocusNode();
    final jobFocus = FocusNode();
    final emailFocus = FocusNode();
    final websiteFocus = FocusNode();

    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        enableDrag: true,
        builder: (builder){
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
            return Container(
              height: MediaQuery.of(context).size.height*0.95,
              child: Scaffold(
                backgroundColor: GeneralVariable.whiteColor,
                extendBodyBehindAppBar: true,
                resizeToAvoidBottomInset: false,
                appBar: new AppBar(
                  iconTheme: IconThemeData(
                      color: GeneralVariable.primaryColor
                  ),
                  title: Text("Add More Contact",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: GeneralVariable.whiteColor,
                    ),
                  ),
                  leading: new IconButton(
                    icon: new Icon(Icons.close, size: 30, color: GeneralVariable.whiteColor,),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  actions: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Text("Save"),
                        onTap: (){
                          if(firstnameController.text == "" || lastnameController.text== "" || jobController.text == "" || phonenumberController.text == "" || emailController.text == "" || websiteController.text == ""){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Please fill all text field",
                                textAlign: TextAlign.center,),
                              duration: const Duration(seconds: 2),
                            ));
                          }else{
                            ApiProvider.current.createContact(firstnameController.text, lastnameController.text, jobController.text, phonenumberController.text, emailController.text, websiteController.text).then((value){
                              String result = jsonDecode(value.toString())["id"];
                              print("id $result");
                              if(result != null){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "Create new contact successful with id $result",
                                    textAlign: TextAlign.center,),
                                  duration: const Duration(seconds: 2),
                                ));
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                      ),
                    )
                  ],
                  backgroundColor: GeneralVariable.primaryColor,
                  elevation: 0.0,
                  centerTitle: false,
                ),
                body: SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(26.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: MediaQuery.of(context).size.width * 0.28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: GeneralVariable.primaryColor),
                              ),
                              child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    height: MediaQuery.of(context).size.width * 0.25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.camera_alt, size: 40,),
                                  )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: "First Name",
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        hintText: "John",
                                        border: UnderlineInputBorder(),
                                        prefixIcon: Icon(Icons.person, color: GeneralVariable.primaryColor,)
                                    ),
                                    controller: firstnameController,
                                    focusNode: firstnameFocus,
                                    onSubmitted: (term) {
                                      GeneralFunctions.fieldFocusChange(
                                          context, firstnameFocus, lastnameFocus);
                                    },
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: "Last Name",
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        hintText: "Doe",
                                        border: UnderlineInputBorder(),
                                        prefixIcon: Icon(Icons.person, color: GeneralVariable.primaryColor,)
                                    ),
                                    controller: lastnameController,
                                    focusNode: lastnameFocus,
                                    onSubmitted: (term) {
                                      GeneralFunctions.fieldFocusChange(
                                          context, lastnameFocus, jobFocus);
                                    },
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: "Job",
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        hintText: "Doctor",
                                        border: UnderlineInputBorder(),
                                        prefixIcon: Icon(Icons.shopping_bag, color: GeneralVariable.primaryColor,)
                                    ),
                                    controller: jobController,
                                    focusNode: jobFocus,
                                    onSubmitted: (term) {
                                      GeneralFunctions.fieldFocusChange(
                                          context, jobFocus, phonenumberFocus);
                                    },
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: "Phone Number",
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        hintText: "+62xxx",
                                        border: UnderlineInputBorder(),
                                        prefixIcon: Icon(Icons.phone, color: GeneralVariable.primaryColor,)
                                    ),
                                    controller: phonenumberController,
                                    focusNode: phonenumberFocus,
                                    onSubmitted: (term) {
                                      GeneralFunctions.fieldFocusChange(
                                          context, phonenumberFocus, emailFocus);
                                    },
                                  ),
                                  TextField(
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
                                        hintText: "john@gmail.com",
                                        border: UnderlineInputBorder(),
                                        prefixIcon: Icon(Icons.mail, color: GeneralVariable.primaryColor,)
                                    ),
                                    controller: emailController,
                                    focusNode: emailFocus,
                                    onSubmitted: (term) {
                                      GeneralFunctions.fieldFocusChange(
                                          context, emailFocus, websiteFocus);
                                    },
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.url,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        labelText: "Website",
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        hintText: "www",
                                        border: UnderlineInputBorder(),
                                        prefixIcon: Icon(Icons.web, color: GeneralVariable.primaryColor,)
                                    ),
                                    controller: websiteController,
                                    focusNode: websiteFocus,
                                    onSubmitted: (term) {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        }
        );
  }
}