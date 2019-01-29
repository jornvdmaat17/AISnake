

public class AI{
  
  int inputNodes, hiddenNodes, outputNodes;
  
  
  Matrix ihWeights;
  Matrix hoWeights;  
  
  Snake s;
  
  public AI(int inputNodes, int hiddenNodes, int outputNodes, Snake s){
    this.inputNodes = inputNodes;
    this.hiddenNodes = hiddenNodes;
    this.outputNodes = outputNodes;
    
    //+1 for bias
    ihWeights = new Matrix(hiddenNodes, inputNodes + 1);
    hoWeights = new Matrix(outputNodes, hiddenNodes + 1);
    
    //randomize those matrices
    ihWeights.randomize();
    hoWeights.randomize();
    
    this.s = s;
  }
  
  public float[] feedforward(float inputs[]){
    Matrix input = ihWeights.singleColumnMatrixFromArray(inputs);    
    Matrix inputBias = input.addBias();
    
    Matrix hidden = ihWeights.dot(inputBias);
    Matrix hiddenActivation = hidden.activate();
    Matrix hiddenActivationBias = hiddenActivation.addBias();
    
    Matrix output = hoWeights.dot(hiddenActivationBias);  
    Matrix outputActivation = output.activate();
    
    return outputActivation.toArray();
  }
  
  public void train(float inputs[], float targets[]){
     float output[] = feedforward(inputs);
     Matrix out = ihWeights.singleColumnMatrixFromArray(output); 
     Matrix answers = ihWeights.singleColumnMatrixFromArray(targets);
     Matrix error = answers.subtract(out);
     
     Matrix hoWeightsT = hoWeights.transpose();
     Matrix hiddenErrors = hoWeightsT.dot(error);
     
     //Tweak the weights 
     
  }
}
