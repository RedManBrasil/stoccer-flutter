import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PlaceOrder {
  final _firestore = Firestore.instance;
  String placeOrder(
      {@required buy,
      @required amount,
      @required price,
      @required user,
      @required pair}) {
    if (buy.runtimeType == bool) {
      // TODO: Connect the statement with the code returned by firebase to confirm if the adding was successful with the database
      String type = buy ? 'BUY' : 'SELL';
      _firestore
          .collection('pairs')
          .document(pair)
          .collection(type)
          .add({'amount': amount, "price": price, "user": user});
      return 'Order Placed Successfully';
    } else {
      return 'We had a problem placing your order';
    }
  }
}
