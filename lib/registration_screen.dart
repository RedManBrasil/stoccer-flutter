import 'package:flutter/material.dart';
import 'components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'ops/constants.dart';
import 'start.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String password;
  String email;
  String errorHandling = ''; //variavel que mostra o erro caso tenha rolado algo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Register',
                  colour: Colors.greenAccent.shade700,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            StarterMenu.id,
                            (_) =>
                                false); //importante usar o .pushNamedAndRemoveUntil pq faz com que a tela de login "suma" do stack de routes, e caso o user volte a pagina, ela volte para a welcome_screen
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      _auth.signOut();
                      setState(() {
                        showSpinner = false;
                        errorHandling = e.toString();
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
