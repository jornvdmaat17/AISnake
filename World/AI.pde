
private static final float lr = 0.5;

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
     //This stuff again
     Matrix input = ihWeights.singleColumnMatrixFromArray(inputs);    
     Matrix inputBias = input.addBias();
    
     Matrix hidden = ihWeights.dot(inputBias);
     Matrix hiddenActivation = hidden.activate();
     Matrix hiddenActivationBias = hiddenActivation.addBias();
     
     Matrix hiddenTranspose = hiddenActivationBias.transpose();
     Matrix inputTranspose = input.transpose();
      
     Matrix output = hoWeights.dot(hiddenActivationBias);  
     Matrix outputActivation = output.activate();
      
     //Is the output
    
     // Set the correct targets to matrix
     Matrix answers = ihWeights.singleColumnMatrixFromArray(targets);
     
     // Calculate error by substracting the output from the answers, still 1 x 1 matrix because 1 output
     Matrix outputError = answers.subtract(outputActivation);
     
     
     Matrix hoWeightsT = hoWeights.transpose();
     Matrix hiddenErrors = hoWeightsT.dot(outputError);
     
     // Calculate the gradient, still 1 by 1
     Matrix gradient = outputActivation.sigmoidDerived();
     
     
     Matrix outputErrorGradient = gradient.dot(outputError);
     outputErrorGradient.multiply(lr);
     
     
     Matrix hoWeight_deltas = outputErrorGradient.dot(hiddenTranspose);
     
     //System.out.println(hoWeight_deltas.rows);
     //System.out.println(hoWeight_deltas.cols);
     //System.out.println("Rows deltas: " + hoWeight_deltas.rows);
     //System.out.println("Cols deltas: " + hoWeight_deltas.cols);
     //System.out.println("Rows weights: " + hoWeights.rows);
     //System.out.println("Cols weight: " + hoWeights.cols);
     
     //System.out.println("Value delta 0: " + hoWeights.matrix[0][0]);
     //System.out.println("Value delta 1: " + hoWeights.matrix[0][1]);
     //System.out.println("Value delta 2: " + hoWeights.matrix[0][2]);
     //System.out.println("Value delta 3: " + hoWeights.matrix[0][3]);
     //System.out.println("Value delta 4: " + hoWeights.matrix[0][4]);
     
     //Tweak the weights 
     
     hoWeights = hoWeights.add(hoWeight_deltas);
     
     //System.out.println("Value delta 0: " + hoWeights.matrix[0][0]);
     //System.out.println("Value delta 1: " + hoWeights.matrix[0][1]);
     //System.out.println("Value delta 2: " + hoWeights.matrix[0][2]);
     //System.out.println("Value delta 3: " + hoWeights.matrix[0][3]);
     //System.out.println("Value delta 4: " + hoWeights.matrix[0][4]);
     
     
     //calculate hidden gradient
     
     Matrix gradientHidden = outputActivation.sigmoidDerived();
     Matrix hiddenErrorGradient = gradientHidden.dot(hiddenErrors);
     hiddenErrorGradient.multiply(lr);
     
     Matrix ihWeight_deltas = hiddenErrorGradient.dot(inputTranspose);
     ihWeights = ihWeights.add(ihWeight_deltas);
     
  }
}
