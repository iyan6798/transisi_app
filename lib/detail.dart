import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transisi_app/api_provider.dart';
import 'package:transisi_app/general_variable.dart';
import 'package:transisi_app/model/contactdetail_result.dart';
import 'package:transisi_app/model/getcontact_result.dart';

import 'generanl_function.dart';

class Detail extends StatefulWidget {

  String useridx;

  Detail({
     this.useridx
}):super();

  @override
  _Detail createState() => _Detail(
      useridx: useridx
  );
}

class _Detail extends State<Detail> {

  _Detail({
    this.useridx
}):super();

  String useridx;

  ContactdetailResult contactdetailResult;

  Future contactdetailResultFuture;

  _contactdetailResultFuture()async{
    return ApiProvider.current.getContact(useridx);
  }

  @override
  void initState() {
    super.initState();
    contactdetailResultFuture =_contactdetailResultFuture();
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
        title: Text("",
          style: GeneralVariable.titleTextStyle,
        ),
        leading: IconButton(
            icon: new Icon(Icons.arrow_back, size: 30, color: GeneralVariable.whiteColor,),
            onPressed: () => Navigator.of(context).pop()
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            child: IconButton(
                icon: new Icon(Icons.star_border, size: 30, color: GeneralVariable.whiteColor,),
                // onPressed: () => Navigator.of(context).pop()
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: IconButton(
                icon: new Icon(Icons.edit, size: 30, color: GeneralVariable.whiteColor,),
                // onPressed: () => Navigator.of(context).pop()
            ),
          )
        ],
        backgroundColor: GeneralVariable.primaryColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: FutureBuilder(
              future: contactdetailResultFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  contactdetailResult = ContactdetailResult.fromJson(jsonDecode(snapshot.data.toString()));
                  return Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*0.4,
                        color: GeneralVariable.primaryColor,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height*0.3,
                              alignment: Alignment.bottomCenter,
                              child: Image.network(contactdetailResult.data.avatar),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.bottomCenter,
                              child: Text(contactdetailResult.data.firstName + " " + contactdetailResult.data.lastName,
                                style: TextStyle(
                                    fontSize: 30
                                ),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: Icon(Icons.mail,size: 35,),
                                  title: Text(contactdetailResult.data.email),
                                  subtitle: Text("Email"),
                                  trailing: Icon(Icons.chat),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: Icon(Icons.share,size: 35,),
                                  title: Text(contactdetailResult.data.firstName + " " + contactdetailResult.data.lastName),
                                  subtitle: Text(contactdetailResult.data.email),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                else{
                  return Container(
                     height: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}