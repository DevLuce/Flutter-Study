import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:korean_words/korean_words.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSC HUFS homework#1 by Hyeok',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: RandomWords(),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class RandomWordsState extends State<RandomWords> {
  final _suggestionsK = <KoreanWords>[];
  final Set<KoreanWords> _savedK = Set<KoreanWords>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  // #enddocregion RWS-var

  // #docregion _buildSuggestions
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestionsK.length) {
            _suggestionsK.addAll(generateKoreanWords().take(10)); /*4*/
          }
          var suggestionsK = _suggestionsK;
          return _buildRow(suggestionsK[index]);
        });
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(KoreanWords kw) {
    final bool alreadySaved = _savedK.contains(kw);
    return ListTile(
      title: Text(
        kw.asString,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.amber : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedK.remove(kw);
          } else {
            _savedK.add(kw);
          }
        });
      },
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DSC HUFS homework#1 by Hyeok'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  // #enddocregion RWS-build

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _savedK.map(
                (KoreanWords kw) {
              return ListTile(
                title: Text(
                  kw.asString,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'I \u2665 한글',
                style: TextStyle(color: Colors.red) ),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
// #docregion RWS-var
}
// #enddocregion RWS-var

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}