import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'dart:math';
import 'components/chart.dart';
import 'components/getTeamData.dart';

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
  String codeClub = '';
  List<Color> colorsClub = [];

  List<dynamic> tempObject = [];

  /// Construct a color from a hex code string, of the format #RRGGBB.
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    super.initState();

    RetrieveTeam().getTeamData(clubCode).then((data) {
      tempObject = data;
      setState(() {
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
                    flex: 5,
                  ),
                  Expanded(
                    child: LineChartSample2(
                      primaryClubColor: colorsClub,
                    ),
                    flex: 7,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                    ),
                    flex: 4,
                  )
                ],
              ),
            ),
            bottomSheet: SolidBottomSheet(
              //a partir daqui começa o rodapé ##############################################
              headerBar: Container(
                color: colorsClub[0],
                height: 50,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Buy',
                              style: kLargeButtonTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sell',
                              style: kLargeButtonTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            color: Colors.green.shade100,
                            child: GridView.count(
                              padding: EdgeInsets.all(8.0),
                              childAspectRatio: 6.0,
                              crossAxisCount: 1,
                              children: <Widget>[
                                Text('₡229.99'),
                                Text('₡229.23'),
                                Text('₡227.08'),
                                Text('₡227.07'),
                                Text('₡222.47'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.red.shade100,
                          child: GridView.count(
                            padding: EdgeInsets.all(8.0),
                            childAspectRatio: 6.0,
                            crossAxisCount: 1,
                            children: <Widget>[
                              Text('₡232.11'),
                              Text('₡232.69'),
                              Text('₡234.20'),
                              Text('₡298.99'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
