part of jeu;

class Balle1 {

  Board board;

  num x;
  num y;
  num r;

  Balle1(this.board, this.x, this.y, this.r) {
    draw();
  }

  void draw() {
    board.context.beginPath();
    board.context.arc(x, y, r, 0, PI*2, true);
    board.context.closePath();
    board.context.fill();
  }

}

class Balle2 {

  Board board;

  num x;
  num y;
  num r;

  Balle2(this.board, this.x, this.y, this.r) {
    draw();
  }

  void draw() {
    board.context.beginPath();
    board.context.arc(x, y, r, 0, PI*2, true);
    board.context.closePath();
    board.context.fill();
  }

}


