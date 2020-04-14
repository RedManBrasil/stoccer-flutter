import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stoccer/buy_screen.dart';
import 'package:stoccer/sell_screen.dart';
import 'dart:math';
import 'components/chart.dart';
import 'components/getTeamData.dart';
import 'components/getTeamOrders.dart';

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: Colors.white70,
);

var rng = new Random();

class TeamPage extends StatefulWidget {
  static const String id = 'TeamPage';

  TeamPage({this.clubCode});

  final String clubCode;

  @override
  _TeamPageState createState() => _TeamPageState(clubCode: this.clubCode);
}

class _TeamPageState extends State<TeamPage> {
  _TeamPageState({@required this.clubCode});

  final String clubCode;
  String clubNameT = '';
  String cityClub = '';
  String countryClub = '';
  String codeClub = ''; //código da imagem
  String pairClub = ''; //código do pair
  List<Color> colorsClub = [];
  List<Text> buyOrders = [];

  List<dynamic> tempObject = [];

  /// Construct a color from a hex code string, of the format #RRGGBB.
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    super.initState();

    /// retrieve as ordens do pair em questão
    List<Text> bOrders = [];

    RetrieveOrders().getPairOrders('FLA').then((data) {
      int i = 0;
      while (i < data.length) {
        bOrders.add(Text("₡${data[i]['price']}"));
        i++;
      }
      setState(() {
        buyOrders = bOrders;
      });
    });

    ///retrieve dos dados do time para construir a pagina do time
    RetrieveTeam().getTeamData(clubCode).then((data) {
      tempObject = data;
      setState(() {
        pairClub = tempObject[0]['pair'];
        clubNameT = tempObject[0]['name'];
        cityClub = tempObject[0]['city'];
        countryClub = tempObject[0]['country'];
        codeClub = tempObject[0]['code'];
        colorsClub = [
          hexToColor(tempObject[0]['colors'][0]),
          hexToColor(tempObject[0]['colors'][1])
        ];
      });
    }); //puxa os dados do time e os armazena em uma Lista
  }

  @override
  Widget build(BuildContext context) {
    return tempObject
            .isEmpty //só carrega tudo depois que o firebase puxar os dados
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: Text(clubNameT),
              backgroundColor: colorsClub[0],
            ),
            body: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
                          child: Image.asset('images/club_logos/' +
                              codeClub + //logo do clube
                              '.png'),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              clubNameT,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              cityClub + //cidade
                                  ', ' +
                                  countryClub, //país do time
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.arrowUp,
                                  color: Colors.green.shade700,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  child: Text(
                                    rng.nextInt(99).toString() +
                                        ',00%', //variaçao da stock
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '₡230.00', //valor da acao no momento
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    child: LineChartSample2(
                      primaryClubColor: colorsClub,
                    ),
                    flex: 14,
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18.0),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BuyScreen(
                                                clubName: clubNameT,
                                                colorsClub: colorsClub,
                                                pairClub: pairClub,
                                              )));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'BUY',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18.0),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SellScreen(
                                                clubName: clubNameT,
                                                colorsClub: colorsClub,
                                                pairClub: pairClub,
                                              )));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'SELL',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Orders Book',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
