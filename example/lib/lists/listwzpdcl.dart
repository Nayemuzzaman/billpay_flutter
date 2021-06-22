import 'package:flutter/material.dart';
import 'package:login_example/HistoryScreen.dart';
import 'package:login_example/model/data.dart';

class ListWzpdcl extends StatefulWidget {
  @override
  _ListWzpdcl createState() => _ListWzpdcl();
}

class _ListWzpdcl extends State<ListWzpdcl> {
  //List<dynamic> dataValueprofile = HistoryScreen.data_taken;
  var dataValueprofile = HistoryScreen.data_taken;

  Future<bool> _onBackTap() async {
    Navigator.of(context).pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //var mobileValue = [];
    // var payment;
    // for ( payment in dataValueprofile) {
    //   //mobileValue = payment.mobile;
    //   print('listpalli history, ${payment.mobile}!');
    // }
    
    return WillPopScope(
      onWillPop: _onBackTap,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('WZPDCL History'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[50],
        body: Material(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            color: Colors.grey[900],
                            width: 100,
                            height: 30,
                            child: Text('Mobile', 
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center),
                          ),
                          
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.grey[850],
                            width: 100,
                            height: 30,
                            child: Text('Acc Number', 
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.grey[900],
                            width: 100,
                            height: 30,
                            child: Text('SMS Acc. No', 
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.grey[850],
                            width: 100,
                            height: 30,
                            child: Text('Bill Amount', 
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center)
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            color: Colors.deepPurple[200],
                            width: 100,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: <Widget>[
                                for (var item in dataValueprofile)
                                  Text(item.mobile),
                              ],
                            ),
                          ),
                          
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.deepPurple[100],
                            width: 100,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: <Widget>[
                                for (var item in dataValueprofile)
                                  Text(item.acnumber),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.deepPurple[200],
                            width: 100,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: <Widget>[
                                for (var item in dataValueprofile)
                                  Text(item.smsaccno),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.deepPurple[100],
                            width: 100,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: <Widget>[
                                for (var item in dataValueprofile)
                                  Text(item.netbill),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
