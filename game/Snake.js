var canvas = document.getElementById("canvas");           
var context = canvas.getContext("2d");    
var pX = pY = 4;
var cX = cY = 0;
var mul = 20;
var aX = aY = 12;
var length = 5;
var snake = [];
var direction = 4;
var tail = 5;

setInterval(game, 1000/15);

function game(){
    pX += cX;
    pY += cY;

    context.fillStyle = "#000";
    context.fillRect(-1, -1, canvas.width + 1, canvas.height + 1);

    context.fillStyle = "blue";
    for(i = 0; i < canvas.width; i++){
        context.fillRect(i * mul, 0, (i + 1)* mul, mul);
        context.fillRect(i * mul, canvas.height - mul, (i + 1)* mul, canvas.height - mul);
    }

    for(j = 0; j < canvas.height; j++){
        context.fillRect(0,j * mul, mul, (j + 1) * mul);
        context.fillRect(canvas.width - 20, j * mul, canvas.height - mul, (j + 1) * mul);
    }

    if(pX < 1 || pX > 15 || pY < 1 || pY > 15){
        dood();
    }

    

    context.fillStyle = "red";
    context.fillRect(aX * mul, aY * mul, mul, mul);

    context.fillStyle = "lime";
    for(var i=0;i<snake.length;i++) {
        context.fillRect(snake[i].x*mul,snake[i].y*mul,mul,mul);
        if(snake[i].x==pX && snake[i].y==pY) {
            dood();
        }
    }

    snake.push({x:pX,y:pY});
    while(snake.length > tail) {
        snake.shift();
    }

    if(pX == aX && pY == aY){
        tail++;
        aX = generateRandomNumber(1, 15);
        aY = generateRandomNumber(1, 15);
    }
}

function dood(){
    pX = pY = 4;
    cX = cY = 0;
    aX = aY = 12;
    direction = 4;
    tail = 5;
}

function generateRandomNumber(min , max) 
{
    return Math.floor(Math.random() * (max-min) + min);
} 


document.onkeydown = function(e) {
    start = true;
    switch (e.keyCode) {
        case 37:
            if(direction != 1){
              cX = -1;
              cY = 0;
              direction = 3;
            }
            break;
        case 38:
            if(direction != 0){
                cX = 0;
                cY = -1;
                direction = 2;
            }
            break;
        case 39:
            if(direction != 3){
                cX = 1;
                cY = 0;
                direction = 1;
            }
            break;
        case 40:
            if(direction != 2){
                cX = 0;
                cY = 1;
                direction = 0;
            }
            break;
    }
};

