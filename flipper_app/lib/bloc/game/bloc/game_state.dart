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

  GamePageLoaded({@required this.shuffled_image_list, @required this.cards_data});

  @override
  List<Object> get props => [];
}
