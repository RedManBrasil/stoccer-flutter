import 'package:flutter/material.dart';
import 'package:stoccer/TeamPage.dart';
import 'ops/clubs_list.dart';
import 'welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StarterMenu extends StatelessWidget {
  static const String id = 'start';

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
      body: ListView.builder(
        //constroi a lista
        itemCount: clubs.length, //lista com o tamanho da array de clubes
        itemBuilder: (context, index) {
          return EachList(
            clubs: clubs[index][0], //para cada lista voce tem o nome do clube
            onTap: () {
              //e a funcao do que acontece onTap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamPage(
                    //onTap voce vai para a tela TeamPage() passando o index do time clicado
                    clubIndex: index,
                  ),
                ),
              );
            },
          );
        },
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
                child: Text(clubs[0]),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
              ),
              Text(clubs),
            ],
          ),
        ),
      ),
    );
  }
}
