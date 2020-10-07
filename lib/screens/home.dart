import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//my own imports
import 'dart:io';

import 'package:teacher_panel/screens/addplayerform.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DocumentSnapshot> prodData1;

  Future<List<DocumentSnapshot>> getProducts() {
    return Firestore.instance
        .collection("products")
        .getDocuments()
        .then((snaps) {
      return snaps.documents;
    });
  }

  void initState() {
    // _getfeatProdList();

    super.initState();

    // Stream<QuerySnapshot> q =
    //     Firestore.instance.collection("products").snapshots();
    // print(q.length);
    // print("llllllllllllllllllllllllllll");
    // Firestore.instance.collection("brands").getDocuments().then((data) {
    //   var list = data.documents;
    //   setState(() {
    //     documents = list;
    //   });
    // });

    //print(documents.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.1,
        toolbarHeight: 66,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.indigo[400],
        title: Text('Cricket Team'),
     
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpiForm()),
            );
          },
          tooltip: 'Add Players',
          child: IconButton(icon: Icon(Icons.add), onPressed: null)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.indigo[400],
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7),
            topRight: Radius.circular(7),
          )),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Add ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                "Players",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      body: new Column(
        children: <Widget>[
          //image carousel begins here

          //padding widget
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Team Players'),
          ),

          //Horizontal list view begins here

          //padding widget
       

          //grid view
          Flexible(
            child: MessageStream(),
          )
        ],
      ),
    );
  }
}

class MessageStream extends StatefulWidget {
  @override
  _MessageStreamState createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  // Stream<QuerySnapshot> check() {
  //   if (selectedChoice == "Awesome") {
  //     Stream s = Firestore.instance
  //         .collection("messages")
  //         .where('Review', isEqualTo: "Awesome")
  //         .snapshots();
  //   }
  //   if (selectedChoice == "PhonePay") {
  //     return Firestore.instance
  //         .collection("messages")
  //         .where('Review', isEqualTo: "Awesome")
  //         .snapshots();
  //   }
  //   return Firestore.instance
  //       .collection("messages")
  //       .where('UpiMode', isEqualTo: "PhonePay")
  //       .snapshots();
  //   setState(() {
  //     // selectedChoice = item;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("players").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data.documents.reversed;
        List<Single_prod> messageWidgets = [];
        for (var message in messages) {
          final playerName = message.data['playername'];

          final playerType = message.data['playertype'];
          final playerRuns = message.data['playerTotRun'];
          final playerWickets = message.data['playerTotWickets'];
          final playerStrike = message.data['playerStrikeRate'];
          final playerEconomy = message.data['playerEconomy'];
          //final  = List.from(message.data['sizes']);
          final playerEmail = message.data['playeremail'];
          final playerPassword = message.data['playerpass'];
          final playerAge = message.data['playerage'];
          // final prodId = message.data['id'];

          final messageWidget = Single_prod(
            player_name: playerName,
            player_age: playerAge,
            player_economy: playerEconomy,
            player_strike: playerStrike,
            player_tot_run: playerRuns,
            player_tot_wickets: playerWickets,
            player_type: playerType,
            player_email: playerEmail,
            player_pw: playerPassword,
          );

          messageWidgets.add(messageWidget);
        }
        return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (200 / 300),
            crossAxisCount: 2,
            children: messageWidgets);
      },
    );
  }
}

class Single_prod extends StatelessWidget {
  final player_name;
  final player_type;
  final player_age;
  final player_tot_run;
  final player_tot_wickets;
  final player_strike;
  final player_economy;
  final player_email;
  final player_pw;

  // final prod_sizes;

  Single_prod({
    this.player_name,
    this.player_age,
    this.player_economy,
    this.player_strike,
    this.player_tot_run,
    this.player_tot_wickets,
    this.player_type,
    this.player_email,
    this.player_pw,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
        elevation: 3,
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //   context, //here we are passing the values of  product to proddta
            //   MaterialPageRoute(
            //       builder: (context) => ProductDetails(
            //           product_details_name: prod_name,
            //           product_details_new_price: prod_price,
            //           product_details_old_price: prod_old_price,
            //           product_details_picture1: prod_pricture1,
            //           product_details_picture2: prod_pricture2,
            //           product_details_picture3: prod_pricture3,
            //           // product_details_sizes: prod_sizes,
            //           prod_details_brand: prod_brand,
            //           prod_details_category: prod_category,
            //           prod_details_video: prod_video,
            //           prod_details_id: prod_id,)),
            // );
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                  ),
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://media.zenfs.com/en/mykhel_233/a422a84e7ab2a5e9a6bc505ab2958a50"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.supervised_user_circle,
                      size: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "${player_name}",
                      style:
                          TextStyle(fontSize: 14.8, color: Colors.blueAccent),
                    ),
                  ],
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Text(
                                    'PlayerType : ',
                                    style: TextStyle(
                                        color: Colors.green[400], fontSize: 10),
                                  ),
                                  Text(
                                    "$player_type",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            //sdf
                            Flexible(
                              child: Row(
                                children: [
                                  starIcon(Colors.yellow[700]),
                                  starIcon(Colors.yellow[700]),
                                  starIcon(Colors.yellow[700]),
                                  starIcon(Colors.yellow[700]),
                                  starIcon(Colors.grey[200]),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context, //here we are passing the values of  product to proddta
                                //   MaterialPageRoute(
                                //       builder: (context) => ProductVideo(
                                //             product_details_video: prod_video,
                                //           )),
                                // );
                              },
                              child: Flexible(
                                child: Container(
                                  height: 26.0,
                                  width: 26.0,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Material(
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        player_age,
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                                child: Text(
                              "Age",
                              style: TextStyle(fontSize: 7),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: 120.0,
                  height: 27.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo[400],
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo[400],
                        offset: Offset(0.0, 10.0),
                        spreadRadius: -5.0,
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context, //here we are passing the values of  product to proddta
                        //   MaterialPageRoute(
                        //       builder: (context) => ProductDetails(
                        //           product_details_name: prod_name,
                        //           product_details_new_price: prod_price,
                        //           product_details_old_price: prod_old_price,
                        //           product_details_picture1: prod_pricture1,
                        //           product_details_picture2: prod_pricture2,
                        //           product_details_picture3: prod_pricture3,
                        //           // product_details_sizes: prod_sizes,
                        //           prod_details_brand: prod_brand,
                        //           prod_details_category: prod_category,
                        //           prod_details_video: prod_video)),
                        // );
                      },
                      child: Center(
                        child: Text(
                          'Details',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Icon starIcon(Color color) {
    return Icon(
      Icons.star,
      size: 10.0,
      color: color,
    );
  }
}

//message stream like classs for stream of categories
//as listview and list item
