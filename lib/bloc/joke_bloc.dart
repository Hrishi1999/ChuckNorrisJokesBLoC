import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:chucknorrisbloc/models/joke.dart';

import './joke_event.dart';
import './joke_state.dart';
import 'package:http/http.dart' as http;

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc(JokeState initialState) : super(initialState);


  @override
  JokeState get initialState => JokeInitial();
  
  @override
  Stream<JokeState> mapEventToState(
    JokeEvent event,
  ) async* {
    if (event is GetJoke) {
      yield JokeLoading();
      final joke = await _fetchJoke(event.joke);
      yield JokeLoaded(joke);
    }
  }

  Future<Joke> _fetchJoke(String cityName) async {

    final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    Map<String, dynamic> data = jsonDecode(response.body);
    String _joke = data['value'];
    print(jsonDecode(response.body));
    return Joke(joke: _joke);
  }
}