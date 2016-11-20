N=35;                   %# of input neurons
M=[30,26];              %row vector containing the numbers of neurons in all the subsequent layers.
                        %M(end) is the number of neurons in the output layer
                        
alpha=0.0;              %this is a parameter of the prior on the weights P(W_ij) = e^{-1/2 alpha * W_ij^2}
                        %and acts as a regularizer in the gradient descent

r              = 10;    %multiple of the patterns that we need to learn
Num_samples    = r*26;  %# of samples of the training set. 
                        %it has to be a multiple of the patterns that we would like
                        %to learn

eta            = 0.1;   %this is the learning rate
Num_iterations = 600;   %# of iterations of the SGD algorithm



%chose the type of input to learn:

%simple_input;       %see the description in the script.

[data, target] = input_letters (Num_samples, N);

error = SGD(N,M,Num_iterations,Num_samples,data,target,eta,alpha);







