import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class NewTaskScreen extends StatefulWidget {
  String uname;
  NewTaskScreen({required this.uname});

  @override
  State<StatefulWidget> createState() => _NewTaskScreen(uname: uname);
}

class _NewTaskScreen extends State<NewTaskScreen> {
  String uname;
  _NewTaskScreen({required this.uname});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final fs = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: Text('New Task'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    title: Text(
                      'Task',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.event,
                      color: Colors.white,
                    ),
                    tileColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    subtitle: TextField(
                      maxLines: null,
                      controller: _titleController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'Category',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    leading: Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    tileColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    subtitle: TextField(
                      maxLines: null,
                      controller: _categoryController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_titleController.text.isNotEmpty) {
                          fs.collection(uname).doc().set({
                            'title': _titleController.text.trim(),
                            'done': 'hello',
                            'time': DateTime.now(),
                            'category': _categoryController.text.trim(),
                          });
                          _titleController.clear();
                          _categoryController.clear();
                        }
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return HomePage();
                        }));
                      },
                      child: Text('ADD'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        //minimumSize: Size.fromHeight(50),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
  }
}
