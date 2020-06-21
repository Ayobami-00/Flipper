part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class GameInitial extends GameState {
  @override
  List<Object> get props => [];
}

class GamePageLoaded extends GameState {

  final bool status;
  final bool init;
  final List<CardData> cardDataList;
  

  GamePageLoaded({@required this.status,@required this.init,this.cardDataList});

  @override
  List<Object> get props => [];
}
