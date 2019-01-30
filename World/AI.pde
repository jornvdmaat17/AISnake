
private static final float lr = 0.1;

public class AI{
  
  int inputNodes, hiddenNodes, outputNodes;
  
  
  Matrix ihWeights;
  Matrix hoWeights;  
  
  Matrix bias_h;
  Matrix bias_o;  
  
  public AI(int inputNodes, int hiddenNodes, int outputNodes){
    this.inputNodes = inputNodes;
    this.hiddenNodes = hiddenNodes;
    this.outputNodes = outputNodes;
    
    //+1 for bias
    ihWeights = new Matrix(hiddenNodes, inputNodes);
    hoWeights = new Matrix(outputNodes, hiddenNodes);
    
    //randomize those matrices
    ihWeights.randomize();
    hoWeights.randomize();
    
    this.bias_h = new Matrix(this.hiddenNodes, 1);
    this.bias_o = new Matrix(this.outputNodes, 1);
    this.bias_h.randomize();
    this.bias_o.randomize();
    
  }
  
  public float[] feedforward(float inputs[]){
    //convert input to matrix and add bias
    Matrix input = ihWeights.singleColumnMatrixFromArray(inputs);
    Matrix inputBias = input.addBias();
    
    //Caclulate the hidden nodes by multiplying the weights by the input with bias
    Matrix hidden = ihWeights.dot(inputBias);
    Matrix hiddenBias = hidden.add(bias_h);
    
    //Activation function
    Matrix hiddenActivation = hiddenBias.activate();
    
    //Caculate the output nodes by multiplying the weights by the hidden nodes with bias
    Matrix output = hoWeights.dot(hiddenActivation);  
    Matrix outputBias = output.add(bias_o);
    
    //Activation function
    Matrix outputActivation = outputBias.activate();
       
    //Convert output to array and return that
    return outputActivation.toArray();
  }
  
  public void train(float inputs[], float targets[]){
     //Calculate the ouput
     //-----------------------------------------------------------
     //convert input to matrix and add bias
     Matrix input = ihWeights.singleColumnMatrixFromArray(inputs);
     Matrix inputBias = input.addBias();
    
     //Caclulate the hidden nodes by multiplying the weights by the input with bias
     Matrix hidden = ihWeights.dot(inputBias);
     Matrix hiddenBias = hidden.add(bias_h);
    
     //Activation function
     Matrix hiddenActivation = hiddenBias.activate();
    
     //Caculate the output nodes by multiplying the weights by the hidden nodes with bias
     Matrix output = hoWeights.dot(hiddenActivation);  
     Matrix outputBias = output.add(bias_o);
    
     //Activation function
     Matrix outputActivation = outputBias.activate();   
     //----------------------------------------------------------
     
    
     // Set the correct targets to matrix
     Matrix answers = ihWeights.singleColumnMatrixFromArray(targets);
     
     // Calculate error by substracting the output from the answers
     Matrix outputError = answers.subtract(outputActivation);
     
     //Calculate the gradient
     Matrix gradient = outputActivation.sigmoidDerived();
     
     //Multiply the gradient with the outputError and learning rate
     Matrix outputErrorGradient = gradient.dot(outputError);
     outputErrorGradient.multiply(lr);     
              
     //Calculate the deltas by multiplying the gradient by the hiddentranspose
     Matrix hiddenTranspose = hiddenActivation.transpose();
     Matrix hoWeight_deltas = outputErrorGradient.dot(hiddenTranspose);
     
     //Adjust the weights by the deltas
     hoWeights = hoWeights.add(hoWeight_deltas);
     //Adjust the bias by gradient
     bias_o = bias_o.add(outputErrorGradient);
     
     
     
     
     //calculate hidden error  
     Matrix hoWeightsT = hoWeights.transpose();
     Matrix hiddenErrors = hoWeightsT.dot(outputError);
     
     //Calculate hidden gradient
     Matrix gradientHidden = hiddenActivation.sigmoidDerived();
     Matrix hiddenErrorGradient = gradientHidden.dot(hiddenErrors);
     hiddenErrorGradient.multiply(lr);
     
     // Calculate hidden deltas
     Matrix inputTranspose = answers.transpose();
     Matrix ihWeight_deltas = hiddenErrorGradient.dot(inputTranspose);
     
     //Adjust the weights by the hidden deltas
     ihWeights = ihWeights.add(ihWeight_deltas);
     //Adjust the bias by the gradient
     bias_h = bias_h.add(hiddenErrorGradient);
     
  }
}
