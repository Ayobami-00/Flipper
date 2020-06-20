part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class GameInitial extends GameState {
  @override
  List<Object> get props => [];
}

class GamePageLoaded extends GameState {

  final int score;
  final bool status;
  final bool init;
  

  GamePageLoaded({@required this.score,@required this.status,@required this.init,});

  @override
  List<Object> get props => [];
}
