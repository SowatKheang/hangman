//github.com/sowatkheang


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hangman/engine/hangman.dart';
import 'package:hangman/ui/hangman_page.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

var words = {
  "CPU":"the electronic circuitry within a computer that carries out the instructions of a computer program ",
  "RAM":"a form of computer data storage that stores data and machine code currently being used",
  "ROUTER":"a networking device that forwards data packets between computer networks",
  "COMPUTER":" a machine that can be instructed to carry out sequences of arithmetic or logical operations automatically via computer programming",
  "SWITCH":"computer networking device that connects devices on a computer network by using packet switching to receive, process, and forward data to the destination device."

};

var listKeys = words.keys.toList();

void main() => runApp(MaterialApp(
      home: HangmanApp(),
      debugShowCheckedModeBanner: false,
    ));

class HangmanApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HangmanAppState();
}

class _HangmanAppState extends State<HangmanApp> {
  HangmanGame _engine;

  @override
  void initState() {
    super.initState();

   // _engine = HangmanGame(wordList);
   _engine = HangmanGame(listKeys);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          'HANGMAN',
          style: TextStyle(fontFamily: 'Merienda', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColorStart: Colors.deepPurpleAccent,
        backgroundColorEnd: Colors.deepPurple[800],
      ),
      body: ListView(
              children: [Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('data_repo/img/welCome2_.gif')),
              SizedBox(
                  width: 250,
                  height: 300,
                  child: Image.asset('data_repo/img/logo1.png')),
              Text('IT Vocabularies', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Merienda'),),
              SizedBox(height: 27),
              RaisedButton(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                color: Colors.deepPurple,
                splashColor: Colors.purpleAccent,
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text('Play Now', style: TextStyle(fontSize: 20, fontFamily: 'Merienda', color: Colors.deepPurple[50])),
                onPressed:() => Navigator.push(context, MaterialPageRoute(builder:(context)=>HangmanPage(_engine))),
              ),
            ],
          ),
        ),]
      ),
      backgroundColor: Colors.deepPurple[50],
    );
  }
}
