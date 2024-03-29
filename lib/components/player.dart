import 'dart:ui';

import 'package:first_game_flutter/game_controller.dart';

class Player {
  Rect playerRect;
  int maxHealth;
  int currentHealth;
  GameController gameController;
  bool isDead = false;
  Player(this.gameController) {
    maxHealth = 300;
    currentHealth = 300;
    final size = gameController.tileSize * 1.5;

    playerRect = Rect.fromLTWH(gameController.screenSize.width / 2 - size / 2,
        gameController.screenSize.height / 2 - size / 2, size, size);
  }

  void render(Canvas c) {
    Paint color = Paint()..color = Color(0xFF0000FF);
    c.drawRect(playerRect, color);
  }

  void update(double t) {
    //print(currentHealth);
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController.initialize();
    }
  }
}
