library jeu;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'board.dart';
part 'balle.dart';
part 'raquette.dart';

void main() {
  CanvasElement canvas = document.query('#canvas');
  Board board = new Board(canvas);
}


