import 'package:chucknorrisbloc/models/joke.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JokeState extends Equatable {
  JokeState([List props = const []]) : super();
}

class JokeInitial extends JokeState {
  @override
  List<Object> get props => ['null'];
}

class JokeLoading extends JokeState {
  @override
  List<Object> get props => ['loading'];
}

class JokeLoaded extends JokeState {
  final Joke joke;

  JokeLoaded(this.joke) : super([joke]);

  @override
  List<Object> get props => [joke];
}
