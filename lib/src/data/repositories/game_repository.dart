import 'package:desafio_webadapte/src/data/api/api_client.dart';
import 'package:desafio_webadapte/src/data/models/api_response.dart';
import 'package:desafio_webadapte/src/data/models/player_ad.dart';

abstract class IGameRepository {
  Future<ApiResponse> getAll();
  Future<ApiResponse> getById({required int id});
  Future<ApiResponse> createPlayerAd({
    required int gameId,
    required PlayerAd ad,
  });
}

class GameRepository extends IGameRepository {
  final IApiClient _apiClient = ApiClient();

  @override
  Future<ApiResponse> getAll() async {
    return _apiClient.getAll();
  }

  @override
  Future<ApiResponse> getById({required int id}) {
    return _apiClient.getById(gameId: id);
  }
  
  @override
  Future<ApiResponse> createPlayerAd({required int gameId, required PlayerAd ad}) {
    return _apiClient.createPlayerAd(gameId: gameId, ad: ad);
  }
}
