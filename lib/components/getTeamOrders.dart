import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveOrders {
  final _firestore = Firestore.instance;
  Future<List> getPairOrders(
    clubCode,
  ) async {
    //puxa o banco de dados para um time especifico e retorna um objeto com todos as ordens dele
    List tempBUY = [];
    QuerySnapshot docs = await _firestore
        .collection('pairs')
        .document(clubCode)
        .collection('BUY')
        .getDocuments();
    if (docs.documents.isNotEmpty) {
      for (int i = 0; i < docs.documents.length; i++) {
        var obj = docs.documents[i].data;
        tempBUY.add(obj);
      }
      return tempBUY;
    } else {
      print('%%% Nada retornado %%%');
      return null;
    }
  }
}
