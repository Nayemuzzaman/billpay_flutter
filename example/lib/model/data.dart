class PaymentModel {
  String mobile, acnumber, holder, smsbillno, smsaccno, netbill, vat;

  PaymentModel({
    required this.mobile,
    required this.acnumber,
    required this.holder,
    required this.smsbillno,
    required this.smsaccno,
    required this.netbill,
    required this.vat,
  });
  //constructor


  factory PaymentModel.fromJson(Map<String, dynamic> json){
      return PaymentModel(
         mobile: json['mobile'],
         acnumber: json['acnumber'],
         holder: json['holder'],
         smsbillno: json['smsbillno'],
         smsaccno: json['smsaccno'],
         netbill: json['netbill'],
         vat: json['vat'],
      );
  }

  // PaymentModel.fromJson(Map<String, dynamic> json)
  //     : mobile = json['mobile'],
  //       acnumber = json['acnumber'],
  //       holder = json['holder'],
  //       smsbillno = json['smsbillno'],
  //       smsaccno = json['smsaccno'],
  //       netbill = json['netbill'],
  //       metercharge = json['metercharge'];

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'acnumber': acnumber,
        'holder': holder,
        'smsbillno': smsbillno,
        'smsaccno': smsaccno,
        'netbill': netbill,
        'vat': vat,
      };
}
