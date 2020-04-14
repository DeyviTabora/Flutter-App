import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Intructioins debugger
// Add permissions
// sudo chown deyvi -R /dev/kvm
// 1 Run Emulator
// 2 Run App

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Application',
      home: RandomWords(),
      theme: ThemeData(
        primaryColor: Colors.black,
        // brightness: Brightness.dark
      ),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords>{
  final _auggeations = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.list
              ),
              onPressed: _pushSaved,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('New'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
          ],
          selectedItemColor: Colors.black,
        ),
        body: _buildSuggeations(),
      );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Favorite'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  title: Text('New'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
              ],
              selectedItemColor: Colors.black,
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggeations(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd){
          return Divider();
        }
        if(i >= _auggeations.length){
          _auggeations.addAll(generateWordPairs().take(10));
        }
        final index = i ~/ 2;

        return _buildRow(_auggeations[index]);
      },
      );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite: Icons.favorite_border,
          color: alreadySaved ? Colors.red: null,
        ),
        onTap: () {
          setState(() {
            if(alreadySaved){
              _saved.remove(pair);
            }else{
              _saved.add(pair);
            }
          });
        },
    );
  }
  
}