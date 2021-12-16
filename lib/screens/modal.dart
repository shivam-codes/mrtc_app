import 'dart:ffi';

import 'package:flutter/material.dart';

class Modelfeed {
  String? name;
  String? feedback;
  String? phone;
  String? firm;
  DateTime? date;
  int? type;
  Modelfeed({this.feedback, this.name, this.firm, this.date, this.phone, this.type,});
}
class complaintdata {
  String? name;
  String? firm;
  String? city;
  String? phone;
  String? email;
  String? consno;
  int? type;
  String? complaint;
  DateTime? date;
  complaintdata({this.name, this.firm, this.city, this.complaint, this.phone, this.email, this.consno, this.type, this.date});
}
class claimdata {
  String? cnmt;
  String? cnge;
  String? name;
  int? type;
  String? amnt;
  double? invoice;
  double? claimamnt;
  String? phone;
  String? remark;
  String? invoiceno;
  claimdata({this.invoiceno, this.phone, this.cnmt, this.cnge, this.name, this.type, this.amnt, this.invoice, this.claimamnt, this.remark});
}