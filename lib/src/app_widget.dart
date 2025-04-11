import 'package:desafio_webadapte/src/ui/game_details/widgets/game_details_screen.dart';
import 'package:desafio_webadapte/src/ui/home/widgets/home_screen.dart';
import 'package:desafio_webadapte/src/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/game-details':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => GameDetailsScreen(gameId: args['gameId'])
            );
          case '/home':
              return MaterialPageRoute(builder: (_) => const HomeScreen());
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        } 
      },
      debugShowCheckedModeBanner: false,
    );
  }
}