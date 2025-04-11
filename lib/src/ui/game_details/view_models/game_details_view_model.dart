import 'package:desafio_webadapte/src/data/models/game.dart';
import 'package:desafio_webadapte/src/data/services/game_service.dart';
import 'package:flutter/foundation.dart';

class GameDetailsViewModel with ChangeNotifier {
  final IGameService _gameService = GameService();
  late GameDetails game;
  bool isLoading = false;

  void getGameDetails({required int gameId}) async {
    _emitIsLoadingAndData();
    try {
      game = await _gameService.getById(id: gameId);
    } catch (e) {
      debugPrint(e.toString());
    }
    _emitIsNotLoadingAndData();
  }

  _emitIsLoadingAndData() {
    isLoading = true;
    notifyListeners();
  }

  _emitIsNotLoadingAndData() {
    isLoading = false;
    notifyListeners();
  }
}