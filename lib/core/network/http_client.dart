import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';


class HttpClient {
  final http.Client _client = http.Client();


  Map<String, String> get headers => {
    'Content-Type': 'application/json',
  };


  Map<String, String> headersWithToken(String token) => {
    'Content-Type': 'application/json',
    'authorization': token,
  };


  Uri buildUrl(String endpoint) =>
      Uri.parse('${ApiConstants.baseUrl}$endpoint');
}