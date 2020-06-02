import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => GameInitial();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
