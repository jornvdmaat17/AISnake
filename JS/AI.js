var brain;

datas = [

    {
        inputs : [0, 0],
        answer : [0]
    },
    {
        inputs : [0, 1],
        answer : [1]
    },
    {
        inputs : [1, 0],
        answer : [1]
    },
    {
        inputs : [1, 1],
        answer : [0]
    }
]

function setup() {
  brain = new NeuralNetwork(2, 2, 1);
}

function draw() {
  data = random(datas);
  for(i = 0; i < 1000; i++){
    brain.train(data.inputs, data.answer);
  }
}