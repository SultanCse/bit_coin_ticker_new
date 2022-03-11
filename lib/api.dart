// API Key: 74317366-B335-4CF4-B8B2-7C4E8F9C2F40
// uri: https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=74317366-B335-4CF4-B8B2-7C4E8F9C2F40
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'coin_data.dart';

class DataGetModel {
  static const String mainDomainLink =
      "https://rest.coinapi.io/v1/exchangerate";
  static const String apiKey = "74317366-B335-4CF4-B8B2-7C4E8F9C2F40";
  static const String apiBTCtoUSD = "$mainDomainLink/BTC/USD?apikey=$apiKey";
  static Map<String, String> cryptoRespectValue = {};

  static dynamic fetchData(
      {required String crypto, required String currency}) async {
    Uri url = Uri.parse("$mainDomainLink/$crypto/$currency?apikey=$apiKey");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  dynamic fetchData2({required String currencyName}) async {
    for (String crypto in cryptoList) {
      Uri url =
          Uri.parse("$mainDomainLink/$crypto/$currencyName?apikey=$apiKey");
      var response = await http.get(url);
      var data = json.decode(response.body);
      cryptoRespectValue[crypto] = data['rate'].toStringAsFixed(2);
    }
    return cryptoRespectValue;
  }
}

// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=4A8A79CA-DE78-4A02-BFC8-5C049ADA13F9
// https://rest.coinapi.io/v1/exchangerate/BTC?invert=false&apikey=74317366-B335-4CF4-B8B2-7C4E8F9C2F40
