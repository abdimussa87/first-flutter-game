import 'dart:math';

import 'package:first_game_flutter/components/enemy.dart';
import 'package:first_game_flutter/components/health_bar.dart';
import 'package:first_game_flutter/components/highscore_text.dart';
import 'package:first_game_flutter/components/player.dart';
import 'package:first_game_flutter/components/score_text.dart';
import 'package:first_game_flutter/components/start_text.dart';
import 'package:first_game_flutter/enemy_spawner.dart';
import 'package:first_game_flutter/state.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends Game {
  SharedPreferences storage;
  Random rand;
  Size screenSize;
  double tileSize;
  Player player;
  List<Enemy> enemies;
  HealthBar healthBar;
  EnemySpawner enemySpawner;
  int score;
  ScoreText scoreText;
  State state;
  HighScoreText highScoreText;
  StartText startText;

  GameController(this.storage,this.screenSize) {
    initialize();
  }

  void initialize() async {
    resize(screenSize);
    state = State.menu;
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    healthBar = HealthBar(this);
    enemySpawner = EnemySpawner(this);
    score = 0;
    scoreText = ScoreText(this);
    highScoreText = HighScoreText(this);
    startText = StartText(this);
      }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);

    c.drawRect(background, backgroundPaint);

    player.render(c);

    if(state == State.menu){
      highScoreText.render(c);
      startText.render(c);
    }else{

    enemies.forEach((Enemy enemy) => enemy.render(c));
    scoreText.render(c);
    healthBar.render(c);
  }
  }

  void update(double t) {
    if(state == State.menu){
      highScoreText.update(t);
      startText.update(t);
    }else{
    enemySpawner.update(t);
    enemies.forEach((Enemy enemy) => enemy.update(t));
    enemies.removeWhere((Enemy enemy) => enemy.isDead);
    player.update(t);
    healthBar.update(t);
    scoreText.update(t);
  }
  }

  void resize(Size size) {
    //screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
   
    if(state == State.menu){
     
            state = State.playing;
    
    }
    
    enemies.forEach((Enemy enemy) {
      if (enemy.enemyRect.contains(d.globalPosition)) {
        enemy.onTapDown();
      }
    });
  }

  void spawnEnemy() {
    double x, y;

    switch (rand.nextInt(4)) {
      case 0:
        //top enemy spawn
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize;
        break;
      case 1:
        // right enemy spawn
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
        // bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize;
        break;
      case 3:
        //left
        x = -tileSize * 1.2;
        y = rand.nextDouble() * screenSize.height;
    }

    enemies.add(Enemy(this, x, y));
  }
}
