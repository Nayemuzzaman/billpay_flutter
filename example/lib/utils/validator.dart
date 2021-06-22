import 'package:flutter/material.dart';

class Validator {
//   static bool isEmail(String email) => EmailValidator.validate(email);

// // Making Form Email Validation
//   String validateEmail(String value) {
//     bool isEmail(String email) => EmailValidator.validate(email);
//     String msg = '';
//     if (!isEmail(value.trim())) {
//       msg = 'Please enter a valid email';
//     } else {
//       msg = null;
//     }
//     return msg;
//   }

  String? usernameValidator(String? value) {
    //String msg = '';
    if (value!.isNotEmpty) {
      return 'Please enter a name';
    } else if (value.length < 4) {
      return 'Name must be 4';
    }
  }
    String? usernamevalidator(String value) {
      if (value.isEmpty) {
        return "* Required";
      } else if (value.length < 6) {
        return "Password should be atleast 6 characters";
      } else if (value.length > 15) {
        return "Password should not be greater than 15 characters";
      } else {
        return null;
      }
    }

    //   return msg;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else {
      return null;
    }
  }

  // String? usernameValidator(String? value) {
  //   return 'value check';
  // }

  // String mobileValidator(String value) {
  //   String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  //   RegExp regExp = new RegExp(patttern);
  //   if (value.length == 0) {
  //     return 'Please enter mobile number';
  //   } else if (!regExp.hasMatch(value)) {
  //     return 'Please enter valid mobile number';
  //   }
  // }

