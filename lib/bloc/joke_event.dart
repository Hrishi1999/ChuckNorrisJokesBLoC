import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JokeEvent extends Equatable{
  JokeEvent([List props = const []]) : super();
}

class GetJoke extends JokeEvent {

  final String joke = '';
  GetJoke() : super([]);

  @override
  List<Object> get props => [joke];
  

}
