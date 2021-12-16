import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mrtc/screens/modal.dart';

Future<dynamic> fetchdata(String url) async {
  var client = new http.Client();
  var uri = Uri.parse(url);
  print(uri.host);
  print(uri.port);
  try {
    var response = await client.get(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
  //http.Response response = await http.get(Uri.parse(url));
}

Future<dynamic> fetchstates() async {
  var client = new http.Client();
  String url = "http://103.91.90.200:8085/locations";
  var uri = Uri.parse(url);
  //print(uri.host);
  //print(uri.port);
  try {
    var response = await client.get(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
  //http.Response response = await http.get(Uri.parse(url));
}
Future<dynamic> fetchcentres(String id) async {
  var client = new http.Client();
  String url = "http://103.91.90.200:8085/centres/" + id.toString();
  var uri = Uri.parse(url);
  //print(uri.host);
  //print(uri.port);
  try {
    var response = await client.get(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
  //http.Response response = await http.get(Uri.parse(url));
}
Future savefeedback(Modelfeed modal) async {
  var client = new http.Client();
  String query = """Exec USP_SavePublicComments '${modal.name}', '${modal.firm}', '1', '0000000', '0000001', 'noreply', '${modal.feedback}', 2, 'f'""";
  String url = "http://103.91.90.200:8085/feedback/" + query.toString();
  var uri = Uri.parse(url);
  //print(uri.host);
  //print(uri.port);
  try {
    var response = await client.post(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
}
Future savecomplain(complaintdata modal) async {
  var client = new http.Client();
  String query = """Exec USP_SavePublicComments '${modal.name}', '${modal.firm}', '${modal.city}', '${modal.consno}', '${modal.phone}', '${modal.email}', '${modal.complaint}', 1, 'f'""";
  String url = "http://103.91.90.200:8085/complaint/" + query.toString();
  var uri = Uri.parse(url);
  //print(uri.host);
  //print(uri.port);
  try {
    var response = await client.post(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
}
Future verify(String id) async {
  var client = new http.Client();
  String url = "http://103.91.90.200:8085/verify/" + id.toString();
  var uri = Uri.parse(url);
  try {
    var response = await client.get(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
}
Future saveclaim(claimdata modal) async {
  var client = new http.Client();
  String query = """Exec USP_SaveClaimDetails '${modal.cnmt}', ${modal.type}, '${modal.cnge}', '${modal.name}', '${modal.invoiceno}', ${modal.invoice}, ${modal.claimamnt}, '${modal.phone}', '${modal.remark}'""";
  String url = "http://103.91.90.200:8085/claim/" + query.toString();
  var uri = Uri.parse(url);
  try {
    var response = await client.post(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
}
Future gettoken(String cns) async {
  var client = new http.Client();
  String url = "http://103.91.90.200:8085/gettoken/" + cns.toString();
  var uri = Uri.parse(url);
  try {
    var response = await client.get(uri);
    print(response.statusCode);
    if(response.statusCode != 200)
      return "Try again";
    else
      return response;
  } on SocketException {
    return "Try again";
  }
}