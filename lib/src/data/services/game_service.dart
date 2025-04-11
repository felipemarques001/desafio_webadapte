import 'package:desafio_webadapte/src/data/models/api_response.dart';
import 'package:desafio_webadapte/src/data/models/game.dart';
import 'package:desafio_webadapte/src/data/models/player_ad.dart';
import 'package:desafio_webadapte/src/data/repositories/game_repository.dart';

abstract class IGameService {
  Future<List<GameSummary>> getAll();
  Future<GameDetails> getById({required int id});
  Future<int> createPlayerAd({required String gameName, required PlayerAd ad});
}

class GameService extends IGameService {
  final IGameRepository _gameRepository = GameRepository();

  @override
  Future<List<GameSummary>> getAll() async {
    final ApiResponse response = await _gameRepository.getAll();

    List<GameSummary> gameSummaryList =
        (response.body as List)
            .map((gameJson) => GameSummary.fromJson(gameJson))
            .toList();

    return gameSummaryList;
  }

  @override
  Future<GameDetails> getById({required int id}) async {
    final ApiResponse response = await _gameRepository.getById(id: id);
    return GameDetails.fromJson(response.body);
  }

  @override
  Future<int> createPlayerAd({
    required String gameName,
    required PlayerAd ad,
  }) async {
    late final int gameId;

    switch (gameName) {
      case 'League of Legends':
        gameId = 1;
        break;
      case 'Apex Legends':
        gameId = 2;
        break;
      case 'Counter Strike':
        gameId = 3;
        break;
      case 'World of Warcraft':
        gameId = 4;
        break;
      case 'Dota 2':
        gameId = 5;
        break;
      case 'Fortnite':
        gameId = 6;
        break;
      default:
        throw Exception('Invalid game name!');  
    }

    final ApiResponse response = await _gameRepository.createPlayerAd(
      gameId: gameId,
      ad: ad,
    );
    return response.statusCode;
  }
}
