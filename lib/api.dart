// API Key: 74317366-B335-4CF4-B8B2-7C4E8F9C2F40
// uri: https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=74317366-B335-4CF4-B8B2-7C4E8F9C2F40
import 'dart:convert';

import 'package:http/http.dart' as http;

class DataGetModel {
  static const String mainDomainLink =
      "https://rest.coinapi.io/v1/exchangerate";
  // https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=74317366-B335-4CF4-B8B2-7C4E8F9C2F40
  static const String apiKey = "74317366-B335-4CF4-B8B2-7C4E8F9C2F40";
  static const String apiBTCtoUSD = "$mainDomainLink/BTC/USD?apikey=$apiKey";

  static dynamic fetchData(String link) async {
    Uri url = Uri.parse(link);
    var response = await http.get(url);
    return json.decode(response.body);
  }
}
