import 'dart:ui';

import 'package:first_game_flutter/game_controller.dart';

class HealthBar {
  GameController gameController;
  Rect redBarRect;
  Rect remainingGreenBarrect;

  HealthBar(this.gameController) {
    double barWidth = gameController.screenSize.width / 2;
    redBarRect = Rect.fromLTWH(
        gameController.screenSize.width / 2 - barWidth/2,
        gameController.screenSize.height * 0.8,
        barWidth,
        gameController.tileSize * 0.8);
    remainingGreenBarrect = Rect.fromLTWH(
        gameController.screenSize.width / 2 - barWidth/2,
        gameController.screenSize.height * 0.8,
        barWidth,
        gameController.tileSize * 0.8);
  }

  void render(Canvas c) {
    Paint redBarColor = Paint()..color = Color(0xFFFF0000);
    Paint remainingGreenBarColor = Paint()..color = Color(0xFF00FF00);
    c.drawRect(redBarRect, redBarColor);
    c.drawRect(remainingGreenBarrect, remainingGreenBarColor);
  }

  void update(double t) {
    double barWidth = gameController.screenSize.width / 2;
    double healthPercent =
        gameController.player.currentHealth / gameController.player.maxHealth;
    remainingGreenBarrect = Rect.fromLTWH(
        gameController.screenSize.width / 2 - barWidth/2,
        gameController.screenSize.height * 0.8,
        barWidth * healthPercent,
        gameController.tileSize * 0.8);
  }
}
