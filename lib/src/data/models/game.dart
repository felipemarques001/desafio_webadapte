import 'package:desafio_webadapte/src/data/models/player_ad.dart';

class GameSummary {
  final int id;
  final String name;
  final String imageSrc;
  final int adsQuantity;

  GameSummary({
    required this.id,
    required this.name,
    required this.imageSrc,
    required this.adsQuantity,
  });

  factory GameSummary.fromJson(Map<String, dynamic> json) {
    return GameSummary(
      id: json['id'],
      name: json['name'],
      imageSrc: json['imageSrc'],
      adsQuantity: json['adsQuantity'],
    );
  }

  GameSummary copyWith({
    int? id,
    String? name,
    String? imageSrc,
    int? adsQuantity,
  }) {
    return GameSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      imageSrc: imageSrc ?? this.imageSrc,
      adsQuantity: adsQuantity ?? this.adsQuantity,
    );
  }
}

class GameDetails {
  final int id;
  final String name;
  final String imageSrc;
  final List<PlayerAd> ads;

  GameDetails({
    required this.id,
    required this.name,
    required this.imageSrc,
    required this.ads,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
      id: json['id'],
      name: json['name'],
      imageSrc: json['imageSrc'],
      ads: (json['ads'] as List)
        .map((adsJson) => PlayerAd.fromJson(adsJson))
        .toList(),
    );
  }
}
