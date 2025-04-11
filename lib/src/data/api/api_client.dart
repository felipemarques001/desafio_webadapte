import 'package:desafio_webadapte/src/data/api/database_mock.dart';
import 'package:desafio_webadapte/src/data/models/api_response.dart';
import 'package:desafio_webadapte/src/data/models/player_ad.dart';

abstract class IApiClient {
  Future<ApiResponse> getAll();
  Future<ApiResponse> getById({required int gameId});
  Future<ApiResponse> createPlayerAd({
    required int gameId,
    required PlayerAd ad,
  });
}

class ApiClient extends IApiClient {
  final IGamesDatabase _gamesDatabase = GamesDatabase();

  @override
  Future<ApiResponse> getAll() async {
    // Aqui simulamos o tempo de processamento da requisição
    await Future.delayed(const Duration(seconds: 3));

    final List<Map<String, dynamic>> games = await _gamesDatabase.getAllGames();
    return ApiResponse(body: games, statusCode: 200);
  }

  @override
  Future<ApiResponse> getById({required int gameId}) async {
    // Aqui simulamos o tempo de processamento da requisição
    await Future.delayed(const Duration(seconds: 2));

    final Map<String, dynamic> game = await _gamesDatabase.getGameById(
      gameId: gameId,
    );
    // final db = await DatabaseMock.getDataBase();

    // final List<Map<String, dynamic>> game = await db.query(
    //   'TB_GAME',
    //   where: 'id = ?',
    //   whereArgs: [gameId],
    // );

    // final List<Map<String, dynamic>> playerAds = await db.query(
    //   'TB_GAME_AD',
    //   where: 'gameId = ?',
    //   whereArgs: [gameId],
    // );

    // final responseBody = {...game.first, 'ads': playerAds};

    return ApiResponse(body: game, statusCode: 200);
  }

  @override
  Future<ApiResponse> createPlayerAd({
    required int gameId,
    required PlayerAd ad,
  }) async {
    // Aqui simulamos o tempo de processamento da requisição
    await Future.delayed(const Duration(seconds: 2));
    
    final int responseStatus = await _gamesDatabase.createPlayerAd(gameId: gameId, ad: ad);
    return ApiResponse(body: {}, statusCode: responseStatus);
  }
}
