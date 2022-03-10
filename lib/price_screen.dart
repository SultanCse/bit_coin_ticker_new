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
    if (1 == 1) {
      //Platform.isIOS
      //chrome emulator platform support kore na.error mare
      // print(Platform.isIOS);
      return CupertinoPicker(
        children: getCupertinoItems(itemList: currenciesList)!,
        itemExtent: 50,
        onSelectedItemChanged: (value) {
          print(value);
        },
      );
    } else {
      return DropdownButton<String>(
        items: getDropdownItems(itemList: currenciesList),
        onChanged: (value) {
          setState(() {
            selectedItemValue = value!;
          });
        },
        value: selectedItemValue,
      );
    }
  }

  // Widget dropDownOrCupertino(){
  //   Platform.isIOS?
  // }

  String selectedItemValue = "USD";
  var data;
  double usd = 0;
  void getData() async {
    data = await DataGetModel.fetchData(DataGetModel.apiBTCtoUSD);
    setState(() {
      usd = data["rate"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${usd.toStringAsFixed(2)} USD',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
