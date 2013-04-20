part of jeu;

/** Table board or squash court. */
class Board {

  const num X = 0;
  const num Y = 0;
  const num BALLE1_R = 12;
  const num BALLE2_R = 8;
  const num RAQUETTE_W = 75;
  const num RAQUETTE_H = 8;

  Timer timer;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  num width;
  num height;
  num startBalle1X;
  num startBalle1Y;
  num startBalle2X;
  num startBalle2Y;
  num d1x;
  num d1y;
  num d2x;
  num d2y;

  Balle1 balle1;
  Balle2 balle2;
  Raquette raquetteNorth;
  Raquette raquetteSouth;
  Raquette raquetteWest;
  Raquette raquetteEast;

  Board(this.canvas) {
    context = canvas.getContext("2d");
    width = canvas.width;
    height = canvas.height;
    border();

    startBalle1X = width / 2;
    startBalle1Y = height / 2;
    startBalle2X = width / 4;
    startBalle2Y = height / 4;
    context.fillStyle = '#0000ff'; // blue
    context.moveTo(200, 250);//épaisseur de la ligne
    context.lineWidth = 8;//
    context.strokeStyle = '#ff0000'; // red
    context.stroke();//
    document.query('#jouer').onClick.listen((e) {
      init();
    });
  }

  void init() {
    d1x = 2;
    d1y = 4;
    d2x = 3;
    d2y = 1;

    balle1 = new Balle1(this, startBalle1X, startBalle1Y, BALLE1_R);
    raquetteNorth =
        new Raquette(this, width/2, Y, RAQUETTE_W, RAQUETTE_H);
    raquetteSouth =
        new Raquette(this, width/2, height-RAQUETTE_H, RAQUETTE_W, RAQUETTE_H);
    balle2 = new Balle2(this, startBalle2X, startBalle2Y, BALLE2_R);
    raquetteWest =
        new Raquette(this, X, height/2, RAQUETTE_H, RAQUETTE_W, horizontal:false);
    raquetteEast =
        new Raquette(this, width-RAQUETTE_H, height/2, RAQUETTE_H, RAQUETTE_W, horizontal:false);
    // redraw every 20 ms
    timer = new Timer.periodic(const Duration(milliseconds: 20),
        (t) => redraw());
  }

  void border() {
    context.beginPath();
    context.rect(X, Y, width, height);
    context.closePath();
    context.stroke();
  }


  void clear() {
    context.clearRect(X, Y, width, height);
    border();
  }

  void redraw() {
    clear();

    balle1.draw();
    balle2.draw();
    
    // Move the east side racket if the up or the down key is currently pressed.
    if (raquetteEast.upUp) {
      raquetteEast.y += 5;
    } else if (raquetteEast.downUp) {
      raquetteEast.y -= 5;
    }    
    raquetteEast.draw();
    
    // Move the west side racket if the up or the down key is currently pressed.
    if (raquetteWest.upUp) {
      raquetteWest.y += 5;
    } else if (raquetteWest.downUp) {
      raquetteWest.y -= 5;
    }    
    raquetteWest.draw();

    // Move the north side racket if the left or the right key is currently pressed.
    if (raquetteNorth.rightDown) {
      raquetteNorth.x += 5;
    } else if (raquetteNorth.leftDown) {
      raquetteNorth.x -= 5;
    }
    raquetteNorth.draw();

    // Move the south side racket if the left or the right key is currently pressed.
    if (raquetteSouth.rightDown) {
      raquetteSouth.x += 5;
    } else if (raquetteSouth.leftDown) {
      raquetteSouth.x -= 5;
    }
    raquetteSouth.draw();


    // The ball must stay within the west and east sides.
   //if (balle1.x + d1x > width || balle1.x + d1x < 0) d1x = -d1x;
   // if (balle2.x + d2x > width || balle2.x + d2x < 0) d2x = -d2x;

    // The north side.
    if (balle1.y + d1y < 0) {
      if (balle1.x > raquetteNorth.x && balle1.x < raquetteNorth.x + raquetteNorth.w) {
        d1y = -d1y;
      } else {
        // The ball hit the north side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }
    if (balle2.y + d2y < 0) {
      if (balle2.x > raquetteNorth.x && balle2.x < raquetteNorth.x + raquetteNorth.w) {
        d2y = -d2y;
      } else {
        // The ball hit the north side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }
    // The West side.
    if (balle1.x + d1x < 0) {
      if (balle1.y > raquetteWest.y && balle1.y < raquetteWest.y + raquetteWest.h) {
        d1x = -d1x;
      } else {
        // The ball hit the west side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }
    if (balle2.x + d2x < 0) {
      if (balle2.y > raquetteWest.x && balle2.y < raquetteWest.y + raquetteWest.h) {
        d2x = -d2x;
      } else {
        // The ball hit the west side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }

    // The East side.
    if (balle1.x + d1x > width) {
      if (balle1.y > raquetteEast.y && balle1.y < raquetteEast.y + raquetteEast.h) {
        d1x = -d1x;
      } else {
        // The ball hit the east side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }
   if (balle2.x + d2x > width) {
      if (balle2.y > raquetteEast.y && balle2.y < raquetteEast.y + raquetteEast.h) {
        d2x = -d2x;
      } else {
        // The ball hit the east side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }
    // The south side.
    if (balle1.y + d1y > height) {
      if (balle1.x > raquetteSouth.x && balle1.x < raquetteSouth.x + raquetteSouth.w) {
        d1y = -d1y;
      } else {
        // The ball hit the south side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }
   if (balle2.y + d2y > height) {
      if (balle2.x > raquetteSouth.x && balle2.x < raquetteSouth.x + raquetteSouth.w) {
        d2y = -d2y;
      } else {
        // The ball hit the south side but outside the racket - game over, so stop the animation.
        //timer.cancel();
      }
    }

    balle1.x += d1x;
    balle1.y += d1y;
    balle2.x += d2x;
    balle2.y += d2y;
  }

}


