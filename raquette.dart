part of jeu;

class Raquette {

  Board board;

  num x;
  num y;
  num w;
  num h;

  bool horizontal;

  bool rightDown = false;
  bool leftDown = false;

  Raquette(this.board, this.x, this.y, this.w, this.h, {this.horizontal:true}) {
    draw();
    document.onKeyDown.listen(onKeyDown);
    document.onKeyUp.listen(onKeyUp);
    document.onMouseMove.listen(onMouseMove);
  }

  void draw() {
    board.context.beginPath();
    board.context.rect(x, y, w, h);
    board.context.closePath();
    board.context.fill();
  }

  // Set rightDown or leftDown if the right or left keys are down.
  void onKeyDown(event) {
    if (event.keyCode == 39) {
      rightDown = true;
    } else if (event.keyCode == 37) {
      leftDown = true;
    }
  }

  // Unset rightDown or leftDown when the right or left key is released.
  void onKeyUp(event) {
    if (event.keyCode == 39) {
      rightDown = false;
    } else if (event.keyCode == 37) {
      leftDown = false;
    }
  }

  void onMouseMove(event) {
    if (horizontal) {
      // Change a position of a racket with the mouse left or right mouvement.
      if (event.pageX > board.X && event.pageX < board.width) {
        x = event.pageX - board.X - w/2;
        if (x < board.X) x = board.X;
        if (x > board.width - w) x = board.width - w;
      }
    } else {
      // Change a position of a racket with the mouse up or down mouvement.
      if (event.pageY > board.Y && event.pageY < board.height) {
        y = event.pageY - board.Y - h/2;
        if (y < board.Y) y = board.Y;
        if (y > board.height - h) y = board.height - h;
      }
    }

  }

}


