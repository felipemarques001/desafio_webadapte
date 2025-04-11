import 'package:desafio_webadapte/src/ui/core/widgets/responsive_widget.dart';
import 'package:desafio_webadapte/src/ui/game_details/widgets/phone_game_details_screen.dart';
import 'package:desafio_webadapte/src/ui/game_details/widgets/tablet_game_details_screen.dart';
import 'package:flutter/material.dart';

class GameDetailsScreen extends StatelessWidget {
  final int gameId;

  const GameDetailsScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: PhoneGameDetailsScreen(gameId: gameId),
      tablet: TabletGameDetailsScreen(gameId: gameId),
    );
  }
}