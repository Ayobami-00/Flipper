part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class LoadGamePage implements GameEvent{
 
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool get stringify => throw UnimplementedError();

}

class VerifyGamePage implements GameEvent{
 
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool get stringify => throw UnimplementedError();

}
