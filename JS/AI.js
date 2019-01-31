const PLAYERSIZE = 30;
const OBSSIZE = 50;
const TOTAL = 1000;


var gameoverFrame = 0;
var jumpers = [];
var deadjumpers = [];
var obs = [];

var newPipeFrames = 100;

function setup() {
    createCanvas(400, 400);
    obs.push(new obstructor());
    for(i = 0; i< TOTAL; i++){
        jumpers[i] = new jumper();
    }
}

function draw() {
    background(0);
    
    newPipeFrames--;
    if(newPipeFrames == 0){
        obs.push(new obstructor());
        newPipeFrames = Math.round(random(50, 90));
    }
    

    for(o of obs){
        if(!o.update()){
            obs.splice(0,1);
        }else{
            o.draw();
        }
    }

    currentPipe = obs[0];

    for(i = 0; i < jumpers.length; i++){
        if(currentPipe.hit(jumpers[i])){
            deadjumpers.push(jumpers.splice(i, 1)[0]);            
        }
    }

    if(jumpers.length == 0){
        nextGeneration();
        newPipeFrames = 100;
    }

    for(i = 0; i < jumpers.length; i++){
        jumpers[i].update();
        jumpers[i].draw();
    }

}

function nextGeneration(){
    obs = [];
    jumpers = [];
    gameoverFrame = frameCount - 1;
    obs.push(new obstructor());

    calcFitniss();
    
    for(i = 0; i< TOTAL; i++){
        jumpers[i] = pickOne();
    }
    console.log("new gen");
    deadjumpers = [];
}

function calcFitniss(){
    scoresum = 0;
    for(i = 0; i < deadjumpers.length; i++){
        scoresum += deadjumpers[i].score;
    }

    for(i = 0; i < deadjumpers.length; i++){
        deadjumpers[i].fitniss = deadjumpers[i].score / scoresum;
    }
}

function pickOne(){
    let index = 0;
    let r = random(1);
    while (r > 0) {
        r = r - deadjumpers[index].fitness;
        index++;
    }
    index--;
    var newJumper = new jumper(deadjumpers[index].brain);
    newJumper.brain.mutate(0.1);
    return newJumper;
}


function closestPipe(){
    if(obs[0].x > 50 + PLAYERSIZE || obs.length == 1){
        return obs[0];
    }else{
        return obs[1];
    }
}

class jumper{

    constructor(brain){
        this.x = 50;
        this.y = height - PLAYERSIZE;

        this.gravity = 0.6;
        this.lift = -15;
        this.velocity = 0;

        this.score = 0;
        this.fitniss = 0;

        if (brain) {
            this.brain = brain.copy();
          } else {
            this.brain = new NeuralNetwork(1, 4, 1);
        }
    }

    draw(){
        rect(this.x, this.y, PLAYERSIZE, PLAYERSIZE);
    }

    jump(pipe){
        if(this.y == height - PLAYERSIZE){
            var inputs = [];
            inputs.push(this.x + PLAYERSIZE - pipe.x);
            var guess = this.brain.predict(inputs);
            if(guess > 0.5){
                this.velocity = this.lift;
            }            
        }        
    }

    update(){
        this.jump(closestPipe());
        this.score += 1;
        this.velocity += this.gravity;
        this.y += this.velocity;
        if (this.y >= height - PLAYERSIZE) {
            this.y = height - PLAYERSIZE;
            this.velocity = 0;
        } 
    }

    mutate(){
        this.brain.mutate(0.1);
    }
}

class obstructor{

    constructor(){
        this.x = width ;
        this.y = height - OBSSIZE;
    }

    draw(){
        rect(this.x, this.y, OBSSIZE, OBSSIZE);
    }

    update(){
        if(this.x < 0 - OBSSIZE){
            return false;
        }else{
            this.x -= 4;
            return true;
        }        
    }

    hit(jumper){
        if(this.y < jumper.y){
            if(jumper.x + PLAYERSIZE / 2 > this.x && jumper.x + PLAYERSIZE / 2< this.x + OBSSIZE){
                return true;
            }
        }
        return false;
    }

}