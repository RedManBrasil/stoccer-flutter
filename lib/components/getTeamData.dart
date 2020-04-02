import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveTeam {
  final _firestore = Firestore.instance;
  Future<List> getTeamData(name) async {
    //puxa o banco de dados para um time especifico e retorna um objeto com todos os dados dele
    List temp = [];
    QuerySnapshot docs = await _firestore
        .collection('teams')
        .where('name', isEqualTo: name)
        .getDocuments();
    if (docs.documents.isNotEmpty) {
      for (int i = 0; i < docs.documents.length; i++) {
        var obj = docs.documents[i].data;
        temp.add(obj);
      }
      return temp;
    } else {
      print('%%% Nada retornado %%%');
      return null;
    }
  }
}
