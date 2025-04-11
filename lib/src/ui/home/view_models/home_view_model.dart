import 'package:desafio_webadapte/src/data/models/game.dart';
import 'package:desafio_webadapte/src/data/models/player_ad.dart';
import 'package:desafio_webadapte/src/data/services/game_service.dart';
import 'package:desafio_webadapte/src/data/services/validator_service.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel with ValidatorService, ChangeNotifier {
  final IGameService _gameService = GameService();

  List<GameSummary> gameSummaryList = List.empty();
  bool isGameSummaryListLoading = false;

  bool isNewPlayerAdLoading = false;
  bool isPlayerAdCreated = false;
  String playerAdCreationErrorMessage = '';

  void getGameSummaryList() async {
    isGameSummaryListLoading = true;
    notifyListeners();

    try {
      gameSummaryList = await _gameService.getAll();
    } catch (e) {
      debugPrint(e.toString());
    }

    isGameSummaryListLoading = false;
    notifyListeners();
  }

  void createGameAd({
    required String gameName,
    required String playerName,
    required String yearsGameTime,
    required String discordUsername,
    required int daysAvailability,
    required String startHoursAvailability,
    required String endHoursAvailability,
    required bool canAudioCall,
  }) async {
    isNewPlayerAdLoading = true;
    notifyListeners();

    final playerAd = PlayerAd(
      playerName: playerName,
      yearsGameTime: int.parse(yearsGameTime),
      daysAvailability: daysAvailability,
      startHoursAvailability: int.parse(startHoursAvailability),
      endHoursAvailability: int.parse(endHoursAvailability),
      audioCall: canAudioCall,
      discordUsername: discordUsername,
    );

    final int response = await _gameService.createPlayerAd(
      gameName: gameName,
      ad: playerAd,
    );
    if (response == 201) {
      isPlayerAdCreated = true;

      final index = gameSummaryList.indexWhere((game) => game.name == gameName);
      final gameSummaryUpdated = gameSummaryList[index].copyWith(
        adsQuantity: gameSummaryList[index].adsQuantity + 1,
      );
      gameSummaryList[index] = gameSummaryUpdated;

    } else {
      playerAdCreationErrorMessage = 'Falha no salvamento do anúncio, tente novamente';
    }

    isNewPlayerAdLoading = false;
    notifyListeners();
    
    isPlayerAdCreated = false;
    playerAdCreationErrorMessage = '';
  }
}
