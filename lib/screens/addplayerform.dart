

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;

class UpiForm extends StatefulWidget {
  UpiForm({Key key, this.title}) : super(key: key);
  static String id = 'upi_screen';
  

  final String title;

  @override
  _UpiFormState createState() => _UpiFormState();
}

class _UpiFormState extends State<UpiForm> {
  TextEditingController controllerPlayerName;
  TextEditingController controllerPlayerAge;
  TextEditingController controllerPlayerPassword;
  TextEditingController controllerPlayerEmail;
  TextEditingController controllerTotalRuns;
  TextEditingController controllerTotalWickets;
  TextEditingController controllerStrikeRate;
  TextEditingController controllerEconomy;


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _initiateTransaction;
  GlobalKey<ScaffoldState> _key;

  String player_name;
  String player_age;
  String player_email;
  String player_password;
    String player_tot_runs;
      String player_tot_wickets;
        String player_strike;
          String player_economy;



  final _auth = FirebaseAuth.instance;

     bool showSpinner = false;

  String _currentSelectedItem = 'Batsman';

  String dropdownValue1 = 'Awesome';

  void _onDropDownSelectedItem(String newValueSelected) {
    setState(() {
      this._currentSelectedItem = newValueSelected;
    });
  }

  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Add Player'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
              child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //SHOP NAME
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the Player Name';
                      } else if (value.length > 100) {
                        return 'Player name cant have more than 100 letters';
                      }
                    },
                    onChanged: (value) {
                      player_name = value;
                    },
                    controller: controllerPlayerName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_box),
                      labelText: 'Player Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //SAVE LOCATTION BUTTON

                //UPI ID
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter player age';
                      } else if (value.length > 20) {
                        return 'Player age cant be greater than 50 ';
                      }
                    },
                    onChanged: (value) {
                      player_age = value;
                    },
                    controller: controllerPlayerAge,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.transit_enterexit),
                      labelText: 'Player Age',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                  Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter player age';
                      } else if (value.length > 20) {
                        return 'Player age cant be greater than 50 ';
                      }
                    },
                    onChanged: (value) {
                      player_tot_runs = value;
                    },
                    controller: controllerTotalRuns,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.transit_enterexit),
                      labelText: 'Total Runs',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                  Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter player age';
                      } else if (value.length > 20) {
                        return 'Player age cant be greater than 50 ';
                      }
                    },
                    onChanged: (value) {
                      player_tot_wickets = value;
                    },
                    controller: controllerTotalWickets,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.transit_enterexit),
                      labelText: 'Total Wickets',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                  Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter player age';
                      } else if (value.length > 20) {
                        return 'Player age cant be greater than 50 ';
                      }
                    },
                    onChanged: (value) {
                      player_strike = value;
                    },
                    controller: controllerStrikeRate,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.transit_enterexit),
                      labelText: 'Player Strike',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                  Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter player age';
                      } else if (value.length > 20) {
                        return 'Player age cant be greater than 50 ';
                      }
                    },
                    onChanged: (value) {
                      player_economy = value;
                    },
                    controller: controllerEconomy,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.transit_enterexit),
                      labelText: 'Player Economy',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

//ENTER AMMOUNT
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the Ammount';
                      } else if (value.length > 80) {
                        return 'Product name cant have more than 50 letters';
                      }
                    },
                    onChanged: (value) {
                      player_email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: controllerPlayerEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      labelText: 'Player email id',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the password';
                      } else if (value.length < 8) {
                        return 'You must enter atleast 8 characters';
                      }
                    },
                    onChanged: (value) {
                      player_password = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: controllerPlayerPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      labelText: 'Player password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

            

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                  child: Text('* Required To Save All',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      )),
                ),

                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Player Type :'),
                          SizedBox(
                            height: 35,
                            width: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.lightBlueAccent[200],
                                        offset: Offset(2, 1),
                                        blurRadius: 5)
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: DropdownButton<String>(
                                  value: _currentSelectedItem,
                                  icon: Icon(Icons.expand_more),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black87),
                                  isExpanded: true,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _currentSelectedItem = newValue;
                                      print(_currentSelectedItem);
                                    });
                                  },
                                  items: <String>[
                                    'Batsman',
                                    'Bowler',
                                    'WK',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  ],
                ),

                Text('it a new module altogether'),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {

             setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: player_email, password: player_password);

                            _firestore.collection('players').add({
                            'playername': player_name,
                             'playerage': player_age,                           
                           'playeremail': player_email,                          
                            'playerpass':player_password,
                            'playerTotRun':player_tot_runs,
                            'playerTotWickets':player_tot_wickets,
                            'playerStrikeRate':player_strike,
                            'playerEconomy':player_economy,
                            'playertype':_currentSelectedItem,
                          
                          });

                    setState(() {
                      showSpinner = false;
                    });
                    if (newUser != null) {
                       FlutterToast.showToast(
                              msg: "details saved successfully");
                    }
                  } catch (e) {
                    
                    setState(() {
                      showSpinner = false;
                      
                    dynamic msg = '     User already exists ';
                    });
                    print(e);
                  }


                      
//'Purpose':purpose,'ItemName':itemname,'Review': review,
                        } else {
                          FlutterToast.showToast(
                              msg: "Fill all fields to save your FavPayment");
                        }
                      },
                      minWidth: 150.0,
                      height: 42.0,
                      child: Text(
                        'Save All',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //response
              ],
            ),
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
