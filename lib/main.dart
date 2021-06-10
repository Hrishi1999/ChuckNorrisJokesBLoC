import 'package:chucknorrisbloc/bloc/joke_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/joke_bloc.dart';
import 'bloc/joke_state.dart';
import 'bloc/joke_event.dart';
import 'models/joke.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CN Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'CN Jokes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) => JokeBloc(JokeInitial()),
        child: JokePage(),
      ),
    );
  }

}

class JokePage extends StatefulWidget {
  const JokePage({ key }) : super(key: key);

  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocListener(
              bloc: BlocProvider.of<JokeBloc>(context),
              listener: (BuildContext context, JokeState state) {
                if (state is JokeLoaded) {
                  print("Loaded: ${state.joke}");
                }
              },
              child: BlocBuilder(
                bloc: BlocProvider.of<JokeBloc>(context),
                builder: (BuildContext context, JokeState state) {
                  if (state is JokeInitial) {
                    return buildInitialInput();
                  } else if (state is JokeLoading) {
                    return buildLoading();
                  } else if (state is JokeLoaded) {
                    return buildColumnWithData(state.joke);
                  }
                },
              ),
            ),
          ],
        ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: ElevatedButton(
        child: Text('Get A Chuck Norris Joke'),
        onPressed: () {
          final jokeBloc = BlocProvider.of<JokeBloc>(context);
          jokeBloc.add(GetJoke());
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Joke joke) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              joke.joke,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        buildInitialInput(),
      ],
    );
  }
}