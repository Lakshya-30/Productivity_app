import 'package:capstone_app/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final fs = FirebaseFirestore.instance;
  var uname = 'hello';
  late int _mon ;
  late int _tues;
  late int _wed;
  late int _thurs;
  late int _fri;
  late int _sat;
  late int _sun;

  @override
  void initState() {
    super.initState();
    loadUname();
    loadCounter();
  }

  void loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _mon = prefs.getInt('mon') ?? 0;
      _tues = prefs.getInt('tues') ?? 0;
      _wed = prefs.getInt('wed') ?? 0;
      _thurs = prefs.getInt('thurs') ?? 0;
      _fri = prefs.getInt('fri') ?? 0;
      _sat = prefs.getInt('sat') ?? 0;
      _sun = prefs.getInt('sun') ?? 0;
    });
    // fs
    //     .collection(uname)
    //     .doc('tasknum')
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     var data = documentSnapshot.data() as Map<String, int?>;
    //     setState(() {
    //       _mon = data['monday'] ?? 0;
    //       _tues = data['tuesday'] ?? 0;
    //       _wed = data['wednesday'] ?? 0;
    //       _thurs = data['thursday'] ?? 0;
    //       _fri = data['friday'] ?? 0;
    //       _sat = data['saturday'] ?? 0;
    //       _sun = data['sunday'] ?? 0;
    //     });
    //   }
      print(_mon);
      print(_tues);
      print(_wed);
      print(_thurs);
      print(_fri);
      print(_sat);
      print(_sun);
    }

  void loadUname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uname = prefs.getString('userName') ?? 'ok';
    });
  }

  List findMin() {
    String min = 'ok';
    List list = [_mon, _tues, _wed, _thurs, _fri, _sat, _sun];
    int m = list[0];
    list.forEach((element) {
      if (element < m) {
        m = element;
      }
    });
    if (m == list[0]) {
      min = 'Monday';
    }
    if (m == list[1]) {
      min = 'Tuesday';
    }
    if (m == list[2]) {
      min = 'Wednesday';
    }
    if (m == list[3]) {
      min = 'Thursday';
    }
    if (m == list[4]) {
      min = 'Friday';
    }
    if (m == list[5]) {
      min = 'Saturday';
    }
    if (m == list[6]) {
      min = 'Sunday';
    }
      return [min, m];
  }

  List findMax() {
    String max = 'ok';
    List list = [_mon, _tues, _wed, _thurs, _fri, _sat, _sun];
    int n = list[0];
    list.forEach((element) {
      if (element >n) {
        n = element;
      }
    });
    if (n == list[0]) {
      max = 'Monday';
    }
    if (n == list[1]) {
      max = 'Tuesday';
    }
    if (n == list[2]) {
      max = 'Wednesday';
    }
    if (n == list[3]) {
      max = 'Thursday';
    }
    if (n == list[4]) {
      max = 'Friday';
    }
    if (n == list[5]) {
      max = 'Saturday';
    }
    if (n == list[6]) {
      max = 'Sunday';
    }
      return [max, n];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Text(
                      'You do most work on ${findMax()[0]}',
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Maximum tasks done in one day is ${findMax()[1]}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'You are least productive on ${findMin()[0]}',
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Minimum tasks done in one day is ${findMin()[1]}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              //color: Colors.purple[100],
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Tasks completed',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'On a Monday        : $_mon',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'On a Tuesday       : $_tues',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'On a Wednesday : $_wed',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'On a Thursday     : $_thurs',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'On a Friday           : $_fri',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'On a Saturday       : $_sat',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'On a Sunday         : $_sun',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: const NavDrawer(),
    );
  }
}
