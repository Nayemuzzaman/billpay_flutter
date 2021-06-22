import 'dart:typed_data';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_example/utils/validator.dart';
import 'package:login_example/widgets/loader.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:flutter/material.dart';
import 'package:login_example/dashboard_screen.dart';
import 'package:login_example/payment_screen.dart';
import 'package:login_example/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class FormWzpdc extends StatefulWidget {
  @override
  _FeedbackFormScreenState createState() => _FeedbackFormScreenState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _FeedbackFormScreenState extends State<FormWzpdc> with Validator {
  // var balanceFromOne = DashboardScreen.data_taken;
  // var dataValuePalli = LoginScreen.data_taken_login;
  //var balanceValue = double.parse(LoginScreen.balance_taken);
  var mobileValuePalli = double.parse(LoginScreen.mobile_taken);
  var dataValuepalli = PaymentScreen.data_taken_Paymentscreen;

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 1050);

  final TextEditingController _smsbillnoController = TextEditingController();
  final TextEditingController _smsaccnoController = TextEditingController();
  final TextEditingController _netbillController = TextEditingController();
  final TextEditingController _meterChargeController4 = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  final TextEditingController _holderController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _acNumberController = TextEditingController();

  final double _minValue = 8.0;
  bool isLoading = false;
  bool hasError = false;
  String message = "";

  String _feedbackType = 'COMMENT';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<bool> _onBackTap() async {
    Navigator.of(context).pop();
    return true;
  }

  Widget _buildFirstName() {
    return TextFormField(
      controller: _mobileNumberController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        errorStyle: _errorStyle,
        border: OutlineInputBorder(),
        contentPadding:
            EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
        labelText: 'Mobile Number',
        hintText: 'Mobile Number',
        labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
      // validator: usernameValidator,
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      controller: _acNumberController,
      // validator: usernameValidator,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          errorStyle: _errorStyle,
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
          hintText: 'A/C Number',
          labelText: 'A/C Number',
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _holderController,
      keyboardType: TextInputType.text,
      //validator: validateEmail,
      onChanged: (String value) {},
      decoration: InputDecoration(
          errorStyle: _errorStyle,
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
          hintText: 'Holder Name',
          labelText: 'Holder Name',
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
    );
  }

//Holder Name
  Widget _buildDescription() {
    return TextFormField(
      controller: _smsbillnoController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          errorStyle: _errorStyle,
          hintText: 'SMS Bill No',
          labelText: 'SMS Bill No',
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
    );
  }

  Widget _buildDescription2() {
    return TextFormField(
      controller: _smsaccnoController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          errorStyle: _errorStyle,
          labelText: 'SMS ACC No',
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
    );
  }

  Widget _buildDescription3() {
    print('from_one buildDescription3 Net Bill $dataValuepalli');

    return TextFormField(
      controller: _netbillController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          errorStyle: _errorStyle,
          labelText: 'Net Bill',
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
    );
  }

  Widget _buildDescription4() {
    return TextFormField(
      controller: _meterChargeController4,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          errorStyle: _errorStyle,
          labelText: 'Vat',
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
    );
  }

  var value;
  Widget _buildDescription5() {
    return TextFormField(
      controller: _otherController,
      //onChanged: (val) => value = val,

      //validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,

      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          errorStyle: _errorStyle,
          labelText: 'Late Fine',
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: _minValue, horizontal: _minValue),
          labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
    );
  }

  Widget _buildSubmitBtn(PaymentPalli) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _minValue * 3),
      child: RaisedButton(
        onPressed: () async {
          //print(dataValuePalli['phone'].runtimeType);
          //var userMobile = dataValuePalli['phone'];
          print(dataValuepalli['balance']);
          var balanceValue = dataValuepalli['balance'];
          //print('object $dataValuePalli');

          var mobile_no = _mobileNumberController.text;
          var acnumber_no = _acNumberController.text;
          var holder_no = _holderController.text;
          var smsbillno_no = _smsbillnoController.text;
          var smsaccno_no = _smsaccnoController.text;
          var netbill_no = _netbillController.text;
          var vat_no = _meterChargeController4.text;
          var lateFine_no = _otherController.text;
          var user_mobile =
              mobileValuePalli.toString(); //user mobile no taken from login
          if (mobile_no.isEmpty && acnumber_no.isEmpty && holder_no.isEmpty && smsbillno_no.isEmpty && smsaccno_no.isEmpty && netbill_no.isEmpty && vat_no.isEmpty && lateFine_no.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Fill All the Form'),
            ));
            print('check empty');
          } 
          var netbillValue = double.parse(netbill_no);
          var balanceValueDouble = double.parse(balanceValue); //new value
          var vatValue = double.parse(vat_no);
          var lateFineValue = double.parse(lateFine_no);

          var totalBalanceValue = netbillValue + vatValue + lateFineValue;

          if (balanceValueDouble > totalBalanceValue) {
            var netbill_no_update = balanceValueDouble - totalBalanceValue;
            print('netbill_no_update pappu $netbill_no_update');

            print('balance value $balanceValue');
            print('netbillValue value $netbillValue');
            final url = Uri.parse(
                ''); //paymentwzpdc
            var data = {
              'mobile': mobile_no,
              'acnumber': acnumber_no,
              'holder': holder_no,
              'smsbillno': smsbillno_no,
              'smsaccno': smsaccno_no,
              'netbill': netbill_no,
              'vat': vat_no,
              'lateFine': lateFine_no,
              'new_balance': netbill_no_update.toString(),
              'usermobile': user_mobile,
            };

            // print("khela ${PaymentPalli.mobile}");
            var response = await http.post(url, body: data);

            // print('Response status: ${res.statusCode}');
            // print('Response body: ${res.body}');
            if (response.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Successfully Done"),
              ));
              return Future.delayed(loginTime).then((_) {
                Navigator.pushReplacementNamed(context, '/dashboard');
              });
            }

            return jsonDecode(response.body);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Not enough Balance"),
            ));
          }
          print('from one info');
          print('from_one onPressed $balanceValue');

          print(_mobileNumberController.text);

          //print('Password: ${PaymentPalli.acnumber}');

          // var response = await http.post(url, body: {
          //   'mobile': '019',
          //   'acnumber': '12',
          //   'holder': 'dhaka',
          //   'smsbillno': '12',
          //   'smsaccno': '019',
          //   'netbill': '12',
          //   'metercharge': '12',
          //   'other': '12'
          // });

          // var data = {
          //   'mobile': _mobileNumberController.text,
          //   'acnumber': _acNumberController.text,
          //   'holder': _holderController.text,
          //   'smsbillno': _smsbillnoController.text,
          //   'smsaccno': _smsaccnoController..text,
          //   'netbill': _netbillController.text,
          //   'metercharge': _meterChargeController4.text,
          //   'others': _otherController.text
          // };
        },
        padding: EdgeInsets.symmetric(vertical: _minValue * 2),
        elevation: 0.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text('PAY BILL'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackTap,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("WZPDCL Payment"),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[50],
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _minValue * 1, vertical: _minValue * 1),
              child: Text(
                "💵 Paying Bill to: WZPDCL",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.all(_minValue * 2),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("*Wrong Information can closed your account"),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildFirstName(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildLastName(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildEmail(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildDescription(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildDescription2(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildDescription3(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildDescription4(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                      _buildDescription5(),
                      SizedBox(
                        height: _minValue * 3,
                      ),
                    ],
                  )),
            ),
            isLoading
                ? MyComponentsLoader(
                    color: Colors.green,
                  )
                : _buildSubmitBtn(context),
          ],
        ),
      ),
    );
  }
}
