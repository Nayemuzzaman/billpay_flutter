import 'package:flutter/widgets.dart';
import 'package:quiver/core.dart';

class PaymentPalli {
  final String mobile;
  final String acnumber;
  final String holder;
  final String smsbillno;
  final String smsaccno;
  final String metercharge;
  final String netbill;
  final String others;

  PaymentPalli({
    required this.mobile,
    required this.acnumber,
    required this.holder,
    required this.smsbillno,
    required this.smsaccno,
    required this.metercharge,
    required this.netbill,
    required this.others
  });

  @override
  String toString() {
    return '$runtimeType($mobile, $acnumber, $holder, $smsbillno, $smsaccno, $metercharge, $netbill, $others )';
  }

  @override
  bool operator == (Object other) {
    if (other is PaymentPalli) {
      return mobile == other.mobile && acnumber == other.acnumber &&  holder == other.holder && smsbillno == other.smsbillno &&  smsaccno == other.smsaccno && netbill == other.netbill && metercharge == other.metercharge &&  others == other.others;
    }
    return false;
  }

   @override
   int get hashCode => hash4(mobile, acnumber, holder, smsbillno);


}
