import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuyScreen extends StatefulWidget {
  static const String id = 'BuyScreen';

  BuyScreen({this.clubName, this.colorsClub});
  final String clubName;
  final List<Color> colorsClub;

  @override
  _BuyScreenState createState() =>
      _BuyScreenState(clubName: this.clubName, colorsClub: colorsClub);
}

class _BuyScreenState extends State<BuyScreen> {
  _BuyScreenState({@required this.clubName, @required this.colorsClub});
  final String clubName;
  final List<Color> colorsClub;
  double totalPrice = 0.0;
  String errorHandling = ''; //variavel que mostra o erro caso tenha rolado algo
  double amountHandling = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clubName),
        backgroundColor: colorsClub[0],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Container(
            color: errorHandling.isEmpty ? Colors.white : Colors.redAccent,
            height: 80,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(errorHandling),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 0, 10),
                    child: Text('$clubName stocks'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          val.isEmpty
                              ? amountHandling = 0
                              : amountHandling = double.parse(val);
                          totalPrice = amountHandling * 270;
                          errorHandling = '';
                        });
                      },
                      textAlign: TextAlign.right,
                      initialValue: '0.0',
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 0, 10),
                    child: Text('Market price'),
                  ),
                  TextCard(text: '₡ 270.00'),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 0, 10),
                    child: Text('Estimated Cost'),
                  ),
                  TextCard(text: '₡ $totalPrice'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 60),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
                child: FlatButton(
                  onPressed: () {
                    if (totalPrice <= 0 || amountHandling == 0.0) {
                      setState(() {
                        errorHandling = 'Cannot be empty or negative';
                      });
                    }
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
          ),
        ],
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  TextCard({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 40, 10),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
