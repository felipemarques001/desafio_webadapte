import 'package:desafio_webadapte/src/data/models/player_ad.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class IGamesDatabase {
  Future<List<Map<String, dynamic>>> getAllGames();
  Future<Map<String, dynamic>> getGameById({required int gameId});
  Future<int> createPlayerAd({required int gameId, required PlayerAd ad});
}

class GamesDatabase extends IGamesDatabase {
  final String _dbName = 'games.db';
  final String _gamesTableName = 'TB_GAME';
  final String _gamesAdsTableName = 'TB_GAME_AD';

  Database? _database;

  Future<Database> createDataBase() async {
    final path = join(await getDatabasesPath(), _dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_gamesTableName (
            id INTEGER PRIMARY KEY,
            name TEXT,
            imageSrc TEXT,
            adsQuantity INTEGER
          )
        ''');

        for (final game in DatabaseInitialData.games) {
          await db.insert(_gamesTableName, game);
        }

        await db.execute('''
          CREATE TABLE $_gamesAdsTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            gameId INTEGER,
            playerName TEXT,
            yearsGameTime INTEGER,
            daysAvailability INTEGER,
            startHoursAvailability INTEGER,
            endHoursAvailability INTEGER,
            audioCall INTEGER,
            discordUsername TEXT,
            FOREIGN KEY (gameId) REFERENCES games(id)
          )
        ''');

        for (final ad in DatabaseInitialData.gamesAds) {
          await db.insert(_gamesAdsTableName, ad);
        }
      },
    );

    return _database!;
  }

  Future<Database> getDataBase() async {
    if (_database != null) {
      return _database!;
    }
    return await createDataBase();
  }

  @override
  Future<List<Map<String, dynamic>>> getAllGames() async {
    final db = await getDataBase();
    return await db.query(_gamesTableName);
  }

  @override
  Future<Map<String, dynamic>> getGameById({required int gameId}) async {
     final db = await getDataBase();

    final List<Map<String, dynamic>> game = await db.query(
      _gamesTableName,
      where: 'id = ?',
      whereArgs: [gameId],
    );

    final List<Map<String, dynamic>> playerAds = await db.query(
      _gamesAdsTableName,
      where: 'gameId = ?',
      whereArgs: [gameId],
    );

    return {...game.first, 'ads': playerAds};
  }

  @override
  Future<int> createPlayerAd({required int gameId, required PlayerAd ad}) async {
    final db = await getDataBase();

    final Map<String, dynamic> adAsMap = {
      'gameId': gameId,
      'playerName': ad.playerName,
      'yearsGameTime': ad.yearsGameTime,
      'daysAvailability': ad.daysAvailability,
      'startHoursAvailability': ad.startHoursAvailability,
      'endHoursAvailability': ad.endHoursAvailability,
      'audioCall': ad.audioCall ? 1 : 0,
      'discordUsername': ad.discordUsername,
    };

    try {
      await db.insert(
        'TB_GAME_AD',
        adAsMap,
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );

      await db.rawUpdate(
        'UPDATE TB_GAME SET adsQuantity = adsQuantity + 1 WHERE id = ?',
        [gameId],
      );

      return 201;
    } catch (e) {
      return 400;
    }
  }
}

abstract final class DatabaseInitialData {
  static final List<Map<String, dynamic>> games = [
    {
      "id": 1,
      "name": "League of Legends",
      "imageSrc": "assets/images/games/lol.png",
      "adsQuantity": 4,
    },
    {
      "id": 2,
      "name": "Apex Legends",
      "imageSrc": "assets/images/games/apex.png",
      "adsQuantity": 3,
    },
    {
      "id": 3,
      "name": "Counter Strike",
      "imageSrc": "assets/images/games/cs.png",
      "adsQuantity": 2,
    },
    {
      "id": 4,
      "name": "World of Warcraft",
      "imageSrc": "assets/images/games/wow.png",
      "adsQuantity": 5,
    },
    {
      "id": 5,
      "name": "Dota 2",
      "imageSrc": "assets/images/games/dota2.png",
      "adsQuantity": 2,
    },
    {
      "id": 6,
      "name": "Fortnite",
      "imageSrc": "assets/images/games/fortnite.png",
      "adsQuantity": 6,
    },
  ];

  static final List<Map<String, dynamic>> gamesAds = [
    {
      "gameId": 1,
      "playerName": "Diego Fernandes",
      "yearsGameTime": 2,
      "daysAvailability": 3,
      "startHoursAvailability": 18,
      "endHoursAvailability": 20,
      "audioCall": 1,
      "discordUsername": "Diegao#6445",
    },
    {
      "gameId": 1,
      "playerName": "Antônio Felipe",
      "yearsGameTime": 5,
      "daysAvailability": 1,
      "startHoursAvailability": 20,
      "endHoursAvailability": 22,
      "audioCall": 0,
      "discordUsername": "AFxx#6463",
    },
    {
      "gameId": 1,
      "playerName": "Mateus Mendes",
      "yearsGameTime": 3,
      "daysAvailability": 5,
      "startHoursAvailability": 13,
      "endHoursAvailability": 16,
      "audioCall": 1,
      "discordUsername": "Mendesss#7732",
    },
    {
      "gameId": 1,
      "playerName": "Lucas Ferreira",
      "yearsGameTime": 1,
      "daysAvailability": 1,
      "startHoursAvailability": 19,
      "endHoursAvailability": 23,
      "audioCall": 0,
      "discordUsername": "Lucaoo#7575",
    },
    {
      "gameId": 2,
      "playerName": "Lucas Almeida",
      "yearsGameTime": 5,
      "daysAvailability": 4,
      "startHoursAvailability": 16,
      "endHoursAvailability": 22,
      "audioCall": 1,
      "discordUsername": "Lucasx#2344",
    },
    {
      "gameId": 2,
      "playerName": "Mariana Souza",
      "yearsGameTime": 3,
      "daysAvailability": 2,
      "startHoursAvailability": 19,
      "endHoursAvailability": 23,
      "audioCall": 0,
      "discordUsername": "Mari@n@#0023",
    },
    {
      "gameId": 2,
      "playerName": "Fernando Ribeiro",
      "yearsGameTime": 1,
      "daysAvailability": 5,
      "startHoursAvailability": 14,
      "endHoursAvailability": 18,
      "audioCall": 1,
      "discordUsername": "Fern@ndo-12#4439",
    },
    {
      "gameId": 3,
      "playerName": "Ana Oliveira",
      "yearsGameTime": 4,
      "daysAvailability": 3,
      "startHoursAvailability": 17,
      "endHoursAvailability": 21,
      "audioCall": 0,
      "discordUsername": "An@Oli#8456",
    },
    {
      "gameId": 3,
      "playerName": "Ricardo Mendes",
      "yearsGameTime": 6,
      "daysAvailability": 5,
      "startHoursAvailability": 15,
      "endHoursAvailability": 20,
      "audioCall": 0,
      "discordUsername": "Ricardoxx#2345",
    },
    {
      "gameId": 4,
      "playerName": "Beatriz Lima",
      "yearsGameTime": 2,
      "daysAvailability": 4,
      "startHoursAvailability": 18,
      "endHoursAvailability": 22,
      "audioCall": 1,
      "discordUsername": "Bebeu#7891",
    },
    {
      "gameId": 4,
      "playerName": "Gustavo Rocha",
      "yearsGameTime": 3,
      "daysAvailability": 2,
      "startHoursAvailability": 19,
      "endHoursAvailability": 23,
      "audioCall": 0,
      "discordUsername": "Guga@#9674",
    },
    {
      "gameId": 4,
      "playerName": "Carla Nunes",
      "yearsGameTime": 1,
      "daysAvailability": 5,
      "startHoursAvailability": 14,
      "endHoursAvailability": 18,
      "audioCall": 1,
      "discordUsername": "Carl@ww#0123",
    },
    {
      "gameId": 4,
      "playerName": "Renato Silva",
      "yearsGameTime": 7,
      "daysAvailability": 3,
      "startHoursAvailability": 16,
      "endHoursAvailability": 21,
      "audioCall": 0,
      "discordUsername": "SilvaRenato#1257",
    },
    {
      "gameId": 4,
      "playerName": "Juliana Ferreira",
      "yearsGameTime": 4,
      "daysAvailability": 6,
      "startHoursAvailability": 17,
      "endHoursAvailability": 22,
      "audioCall": 1,
      "discordUsername": "Juuuw#8039",
    },
    {
      "gameId": 5,
      "playerName": "Felipe Cardoso",
      "yearsGameTime": 5,
      "daysAvailability": 4,
      "startHoursAvailability": 15,
      "endHoursAvailability": 20,
      "audioCall": 1,
      "discordUsername": "Felipeew#4511",
    },
    {
      "gameId": 5,
      "playerName": "Larissa Monteiro",
      "yearsGameTime": 3,
      "daysAvailability": 2,
      "startHoursAvailability": 18,
      "endHoursAvailability": 22,
      "audioCall": 0,
      "discordUsername": "L@riss@aa#7453",
    },
    {
      "gameId": 6,
      "playerName": "Thiago Santos",
      "yearsGameTime": 2,
      "daysAvailability": 3,
      "startHoursAvailability": 17,
      "endHoursAvailability": 21,
      "audioCall": 1,
      "discordUsername": "THww#3357",
    },
    {
      "gameId": 6,
      "playerName": "Camila Ribeiro",
      "yearsGameTime": 6,
      "daysAvailability": 5,
      "startHoursAvailability": 14,
      "endHoursAvailability": 19,
      "audioCall": 0,
      "discordUsername": "Cami#7534",
    },
    {
      "gameId": 6,
      "playerName": "Roberto Nogueira",
      "yearsGameTime": 4,
      "daysAvailability": 4,
      "startHoursAvailability": 16,
      "endHoursAvailability": 22,
      "audioCall": 1,
      "discordUsername": "Nogueiraa#9756",
    },
    {
      "gameId": 6,
      "playerName": "Patrícia Alves",
      "yearsGameTime": 1,
      "daysAvailability": 2,
      "startHoursAvailability": 19,
      "endHoursAvailability": 23,
      "audioCall": 0,
      "discordUsername": "Patw#9906",
    },
    {
      "gameId": 6,
      "playerName": "Eduardo Martins",
      "yearsGameTime": 5,
      "daysAvailability": 6,
      "startHoursAvailability": 15,
      "endHoursAvailability": 20,
      "audioCall": 1,
      "discordUsername": "Eduww#5709",
    },
    {
      "gameId": 6,
      "playerName": "Vanessa Costa",
      "yearsGameTime": 3,
      "daysAvailability": 3,
      "startHoursAvailability": 18,
      "endHoursAvailability": 21,
      "audioCall": 0,
      "discordUsername": "Ness@#4232",
    },
  ];
}
