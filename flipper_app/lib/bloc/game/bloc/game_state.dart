part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class GameInitial extends GameState {
  @override
  List<Object> get props => [];
}

class GamePageLoaded extends GameState {

  final List<String> shuffled_image_list;
  final Map<String,dynamic> cards_data;
  final int score;

  GamePageLoaded({@required this.shuffled_image_list, @required this.cards_data, @required this.score});

  @override
  List<Object> get props => [];
}
