import 'package:bit_coin_ticker_new/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  dynamic getDropdownItems({required List<String>? itemList}) {
    var list = itemList?.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    });
    return list?.toList();
  }

  List<Widget>? getCupertinoItems({required List<String>? itemList}) {
    var list = itemList?.map((String value) {
      return Text(value);
    });
    return list?.toList();
  }

  Widget dropdownSelector() {
    if (1 == 2) {
      //if(Platform.isIOS)
      //chrome emulator platform support kore na.error mare
      // print(Platform.isIOS);
      return CupertinoPicker(
        children: getCupertinoItems(itemList: currenciesList)!,
        itemExtent: 50,
        onSelectedItemChanged: (value) async {
          setState(() {
            selectedCurrency = currenciesList[value];
            getData2(selectedCurrency);
          });
        },
      );
    } else {
      return DropdownButton<String>(
        items: getDropdownItems(itemList: currenciesList),
        onChanged: (value) async {
          setState(
            () {
              selectedCurrency = value!;
              getData2(selectedCurrency);
            },
          );
        },
        value: selectedCurrency,
      );
    }
  }

  String selectedCurrency = "AUD";
  var data;
  Map<String, String> cryptoRespectValue = {};
  void getData2(String currencyName) async {
    DataGetModel dgm = DataGetModel();
    data = await dgm.fetchData2(currencyName: currencyName);
    setState(() {
      cryptoRespectValue = DataGetModel.cryptoRespectValue;
    });
  }

  @override
  void initState() {
    super.initState();
    // getData("BTC", "AUD");
    getData2(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    // print(data['rate']);
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataCard(
                selectedCurrencyValue: cryptoRespectValue[cryptoList[0]] ?? "?",
                selectedCurrency: selectedCurrency,
                crypto: cryptoList[0],
              ),
              DataCard(
                selectedCurrencyValue: cryptoRespectValue[cryptoList[1]] ?? "?",
                selectedCurrency: selectedCurrency,
                crypto: cryptoList[1],
              ),
              DataCard(
                selectedCurrencyValue: cryptoRespectValue[cryptoList[2]] ?? "?",
                selectedCurrency: selectedCurrency,
                crypto: cryptoList[2],
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: dropdownSelector(),
          ),
        ],
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.selectedCurrencyValue,
    required this.selectedCurrency,
    this.crypto = "BTC",
  }) : super(key: key);

  final String selectedCurrencyValue;
  final String selectedCurrency;
  final String crypto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $selectedCurrencyValue $selectedCurrency',
            // '1 $crypto = ${usd.toStringAsFixed(2)} $selectedItemValue'
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
