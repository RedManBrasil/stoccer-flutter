import 'package:flutter/material.dart';
import 'package:stoccer/TeamPage.dart';
import 'welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class StarterMenu extends StatelessWidget {
  static const String id = 'start';
  final CollectionReference ref = null;

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Stoccer'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);
              }),
        ],
        backgroundColor: Colors.green.shade400,
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('teams').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final teams = snapshot.data.documents;
                List<String> teamList = [];
                for (var team in teams) {
                  final teamName = team.data['name'];
                  teamList.add(teamName);
                }
                return Expanded(
                  child: ListView.builder(
                    //constroi a lista
                    itemCount: teamList
                        .length, //lista com o tamanho da array de clubes
                    itemBuilder: (context, index) {
                      return EachList(
                        clubs: teamList[
                            index], //para cada lista voce tem o nome do clube
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamPage(
                                //onTap voce vai para a tela TeamPage() passando o index do time clicado
                                clubCode: teamList[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                //caso os dados ainda não chegaram, mostra uma barra de progressão para o user
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class EachList extends StatelessWidget {
  EachList({@required this.clubs, @required this.onTap});

  final String clubs; //recebe a info do clube a qual pertence o card
  final Function onTap; //necessario para criar a funcao do que acontece onTap

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                child:
                    Text(clubs[0]), //inicial do nome do time em forma de avatar
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
              ),
              Text(clubs), //nome do time
            ],
          ),
        ),
      ),
    );
  }
}
