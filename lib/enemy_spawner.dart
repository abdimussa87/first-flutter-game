import 'package:first_game_flutter/game_controller.dart';

import 'components/enemy.dart';

class EnemySpawner {
  final GameController gameController;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 700;
  final int intervalChange = 200;
  final int maxEnemies = 7;
  int currentInterval;
  int nextSpawn;

  EnemySpawner(this.gameController) {
    initialize();
  }

  void initialize() {
    killAllEnemies();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAllEnemies() {
    gameController.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }

  void update(double t){
    int now = DateTime.now().millisecondsSinceEpoch;
    if(gameController.enemies.length < maxEnemies && now >= nextSpawn){
      gameController.spawnEnemy();
      if(currentInterval > minSpawnInterval){
        currentInterval -= intervalChange;
        
      }
      nextSpawn = now + currentInterval;
    }
  }
}
