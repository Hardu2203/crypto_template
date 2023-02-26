
import 'package:crypto_template/sell/sell_order_model.dart';
import 'package:flutter/cupertino.dart';

import '../crypto/crypto_types.dart';
import '../fiat/fiat_type.dart';


class SellProvider extends ChangeNotifier {
  SellProvider? _previousSellProvider;


  final List<SellOrderModel> _sellOrders = [];
  List<SellOrderModel> get sellOrders => _sellOrders;

  SellProvider([this._previousSellProvider]);
  
  void loadSellOrders() {
    // _sellOrders = [
    //   SellOrderModel(0.1, CryptoType.bitcoin, 5000, FiatType.zar, SellOrderStatus.open, "0x339F31Df86D58BdbA677784da1c9a970Ec42B1b8")
    // ];
    // notifyListeners();
  }


  void createSellOrder(double amount, CryptoType selectedCryptoType, double price, FiatType selectedFiatType) {

    _sellOrders.add(SellOrderModel(amount, selectedCryptoType, price, selectedFiatType, SellOrderStatus.open, "Hardu"));
    notifyListeners();
  }

  void deleteSellOrder(int index) {
    _sellOrders.removeAt(index);
    notifyListeners();
  }

}