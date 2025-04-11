class PlayerAd {
  final String playerName;
  final int yearsGameTime;
  final int daysAvailability;
  final int startHoursAvailability;
  final int endHoursAvailability;
  final bool audioCall;
  final String discordUsername;

  PlayerAd({
    required this.playerName,
    required this.yearsGameTime,
    required this.daysAvailability,
    required this.startHoursAvailability,
    required this.endHoursAvailability,
    required this.audioCall,
    required this.discordUsername,
  });

  factory PlayerAd.fromJson(Map<String, dynamic> json) {
    return PlayerAd(
      playerName: json['playerName'],
      yearsGameTime: json['yearsGameTime'],
      daysAvailability: json['daysAvailability'],
      startHoursAvailability: json['startHoursAvailability'],
      endHoursAvailability: json['endHoursAvailability'],
      audioCall: json['audioCall'] == 1,
      discordUsername: json['discordUsername'],
    );
  }
}