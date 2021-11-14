import 'package:http/http.dart' as http;

Future<dynamic> fetchdata(String url) async {
  var client = new http.Client();
  var uri = Uri.parse(url);
  print(uri.host);
  print(uri.port);
  var response = await client.get(uri);
  //http.Response response = await http.get(Uri.parse(url));
  print(response.statusCode);
  if(response.statusCode != 200)
    return "Try again";
  else
    return response;
}