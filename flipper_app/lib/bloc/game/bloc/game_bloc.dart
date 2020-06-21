import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flipper_app/models/card_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => GameInitial();

  // @override
  // void dispose() {

  //   super.dispose();
  // }

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    // final Box<HiveInterface> numberofTapsDataBox = Hive.box('numberofTapsData');

    if (event is LoadGamePage) {
      List<String> shuffled_image_list = [
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg",
        "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg",
        "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
        "https://cdn.pixabay.com/photo/2015/09/09/16/05/forest-931706__340.jpg",
        "https://cdn.pixabay.com/photo/2016/01/08/11/57/butterfly-1127666__340.jpg",
        "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228__340.jpg",
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg",
        "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg",
        "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
        "https://cdn.pixabay.com/photo/2015/09/09/16/05/forest-931706__340.jpg",
        "https://cdn.pixabay.com/photo/2016/01/08/11/57/butterfly-1127666__340.jpg",
        "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228__340.jpg",
      ];

      // Map<String, dynamic> cards_data = {
      //   "0": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[0]
      //   },
      //   "1": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[1]
      //   },
      //   "2": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[2]
      //   },
      //   "3": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[3]
      //   },
      //   "4": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[4]
      //   },
      //   "5": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[5]
      //   },
      //   "6": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[6]
      //   },
      //   "7": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[7]
      //   },
      //   "8": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[8]
      //   },
      //   "9": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[9]
      //   },
      //   "10": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[10]
      //   },
      //   "11": {
      //     "stay_flipped_open": true,
      //     "do_animation": true,
      //     "image": shuffled_image_list[11]
      //   },
      // };

      final cardDataBox = await Hive.openBox('cardsData');
      List<CardData> cardDataList = [];
      for (int index = 0; index < 12; index++) {
        CardData cardData = CardData(
            index: index,
            stay_flipped_open: false,
            do_animation: true,
            image: shuffled_image_list[index]);
        cardDataList.add(cardData);
      }

      await cardDataBox.put("cardsData", cardDataList);

      final gameRoomData = await Hive.openBox('gameRoomData');
      await gameRoomData.put("gameScore", 0);
      int score = gameRoomData.get("gameScore") as int;
      print("Initial Score: $score");
      // Hive.close();

      yield (GamePageLoaded(
          status: false, init: true, cardDataList: cardDataList));
    } else if (event is VerifyGamePage) {
      yield  GameInitial();
      if (event.cardData1.image == event.cardData2.image) {
        final cardDataBox = Hive.box('cardsData');
        List<CardData> cardDataList =
            await cardDataBox.get("cardsData") as List<CardData>;
        cardDataList[event.cardData1.index] = CardData(
            index: event.cardData1.index,
            stay_flipped_open: true,
            do_animation: false,
            image: event.cardData1.image);

        cardDataList[event.cardData2.index] = CardData(
            index: event.cardData2.index,
            stay_flipped_open: true,
            do_animation: false,
            image: event.cardData2.image);
        print(cardDataList);
        await cardDataBox.put("cardsData", cardDataList);

        final gameRoomData = await Hive.openBox('gameRoomData');
        int score = await gameRoomData.get("gameScore") as int;
        await gameRoomData.put("gameScore", score+5);
        print("Updated Score: ${score+5}");

        await Future.delayed(const Duration(milliseconds: 400));
        yield (GamePageLoaded(
            status: true,
            init: false,
            cardDataList: cardDataList));
      } else {
        yield  GameInitial();
        final cardDataBox = Hive.box('cardsData');
        List<CardData> cardDataList =
            await cardDataBox.get("cardsData") as List<CardData>;
            print("No match $cardDataList");

        final gameRoomData = await Hive.openBox('gameRoomData');
        int score = await gameRoomData.get("gameScore") as int;
        print("Updated Score: ${score}");
        await Future.delayed(const Duration(milliseconds: 500));
        yield (GamePageLoaded(
          status: false,
          init: false,
          cardDataList: cardDataList,
        ));
      }
    }
  }
}
