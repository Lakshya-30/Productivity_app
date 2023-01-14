import 'dart:convert';

import 'package:capstone_app/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../pages/login.dart';
import '../pages/stats.dart';
import '../helper/quote.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  var uname='hello';
  Future<Quote>? quote;
  void initState() {
    // TODO: implement initState
    super.initState();
    //uname = UserSimplePreferences.getUname() ?? 'ok';
    loadCounter();
    quote = fetchQuote();
  }
  void loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uname = prefs.getString('userName') ?? 'ok';
    });
  }

  Future<Quote> fetchQuote() async{
    var url = Uri.parse("https://favqs.com/api/qotd");
    final http.Response response = await http.get(url);

    if(response.statusCode == 200){
      return Quote.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Quote');
    }
  }


  @override
  final fs = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[850],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: FutureBuilder<Quote>(
                future: quote,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Text(snapshot.data!.quoteText, style: TextStyle(
                              fontSize: 20
                            ),),
                            Text('-'+snapshot.data!.quoteAuthor),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  //return CircularProgressIndicator();
                  return Text('Loading...');
                },
              )


            ),
            decoration: BoxDecoration(
              color: Colors.purple[300],
            ),
          ),
          ListTile(
              leading: Icon(Icons.home,color: Colors.white,),
              title: Text('Home',style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                      return HomePage();
                    }));
              }),
          ListTile(
              leading: Icon(Icons.bar_chart,color: Colors.white,),
              title: Text('Statistics',style: TextStyle(color: Colors.white),),
              onTap: () {
                 Navigator.of(context).pop();
                 Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (_) {
                       return Stats();
                     }));
               }),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.white,),
            title: Text('Logout',style: TextStyle(color: Colors.white),),
            onTap: () async{
              SharedPreferences pref =await SharedPreferences.getInstance();
              fs.collection(uname).doc('tasknum').set({
                'monday': pref.getInt('mon'),
                'tuesday': pref.getInt('tues'),
                'wednesday': pref.getInt('wed'),
                'thursday': pref.getInt('thurs'),
                'friday': pref.getInt('fri'),
                'saturday': pref.getInt('sat'),
                'sunday': pref.getInt('sun'),
              });
              pref.remove('userName');
              pref.remove('mon');
              pref.remove('tues');
              pref.remove('wed');
              pref.remove('thurs');
              pref.remove('fri');
              pref.remove('sat');
              pref.remove('sun');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return LoginPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
