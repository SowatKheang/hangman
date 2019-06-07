import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:hangman/engine/hangman.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

const List<String> progressImages = const [
  'data_repo/img/progress_0.png',
  'data_repo/img/progress_1.png',
  'data_repo/img/progress_2.png',
  'data_repo/img/progress_3.png',
  'data_repo/img/progress_4.png',
  'data_repo/img/progress_5.png',
  'data_repo/img/progress_6.png',
  'data_repo/img/progress_7.png',
];

const String victoryImage = 'data_repo/img/victory.png';

const List<String> alphabet = const [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

const TextStyle activeWordStyle = TextStyle(
  fontSize: 30.0,
  letterSpacing: 5.0,
);

class HangmanPage extends StatefulWidget {
  final HangmanGame _engine;

  HangmanPage(this._engine);

  @override
  State<StatefulWidget> createState() => _HangmanPageState();
}

class _HangmanPageState extends State<HangmanPage> {
  bool _showNewGame;
  String _activeImage;
  String _activeWord;

  @override
  void initState() {
    super.initState();

    widget._engine.onChange.listen(this._updateWordDisplay);
    widget._engine.onWrong.listen(this._updateGallowsImage);
    widget._engine.onWin.listen(this._win);
    widget._engine.onLose.listen(this._gameOver);

    this._newGame();
  }

  void _updateWordDisplay(String word) {
    this.setState(() {
      _activeWord = word;
    });
  }

  void _updateGallowsImage(int wrongGuessCount) {
    this.setState(() {
      _activeImage = progressImages[wrongGuessCount];
    });
  }

  void _win([_]) {
    this.setState(() {
      _activeImage = victoryImage;
      this._gameOver();
    });
  }

  void _gameOver([_]) {
    this.setState(() {
      _showNewGame = true;
    });
  }

  void _newGame() {
    widget._engine.newGame();

    this.setState(() {
      _activeWord = '';
      _activeImage = progressImages[0];
      _showNewGame = false;
    });
  }

  Widget _renderBottomContent() {
    if (_showNewGame) {
      return Center(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 105,
                child: RaisedButton(
                  child: Text(
                    'New Game',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Merienda'),
                  ),
                  color: Colors.deepPurple,
                  splashColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  onPressed: this._newGame,
                ),
              ),
              SizedBox(
                width: 105,
                child: RaisedButton(
                  child: Text(
                    'Exit',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Merienda'),
                  ),
                  color: Colors.deepPurple,
                  splashColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final Set<String> lettersGuessed = widget._engine.lettersGuessed;

      return Wrap(
        spacing: 2.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.center,
        children: alphabet
            .map((letter) => MaterialButton(
                  color: Colors.deepPurple,
                  shape: CircleBorder(),
                  child: Text(
                    letter,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Merienda'),
                  ),
                  padding: EdgeInsets.all(5.0),
                  onPressed: lettersGuessed.contains(letter)
                      ? null
                      : () {
                          widget._engine.guessLetter(letter);
                        },
                ))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        appBar: GradientAppBar(
          title: Text(
            'HANGMAN',
            style:
                TextStyle(fontFamily: 'Merienda', fontWeight: FontWeight.bold),
          ),
          backgroundColorStart: Colors.deepPurple[800],
          backgroundColorEnd: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                ),
                // Image
                Expanded(
                  child: Image.asset(_activeImage),
                ),
                // Word
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    //child: Text(_activeWord, style: activeWordStyle,),
                    child: Text(_activeWord,
                        style: TextStyle(
                            fontFamily: 'Merienda',
                            letterSpacing: 5.0,
                            fontSize: 30)),
                  ),
                ),
                // Controls
                Expanded(
                  child: ListView(children: <Widget>[
                    this._renderBottomContent(),
                  ]),
                ),
              ]),
        ));
  }
}
