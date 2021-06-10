import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Joke extends Equatable {
  final String joke;

  Joke({
    @required this.joke,
  });

  @override
  List<Object> get props => [joke];

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
        joke: json['value']
    );
  }
}
