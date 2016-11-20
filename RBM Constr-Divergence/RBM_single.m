%this script trains a RMB.
%we use the 26 letters of the alphabets as data. each letter is a N=35 pixel image.

%Notes:
%at a given N, the choice of M and F can play important roles as can be seen by plotting Error.
%The final error decreses as M is increased from small values up to ~20, 
%then it does not decreases anymore. so in order to avoid overfitting we take M~20.

%parameters of the RBM ----------------------------------------------------------------------------


Num_samples=26;             % # of samples to memorize
Num_iterations=500;         % # of iterations for the CD alghorithm

beta=1;                     % inverse temperature
N=35;                       % # of visible units
M=20;                       % # of hidden units
eta=0.1;                    % learning rate
L = 10^-4;                  % L1 regularizer
F = 5;                      % Momentum

%here we use input data made of letters ------------------------------------------------------------
%N has to be 35 for this kind of data
[data,~] = input_letters(Num_samples,N);

%data contains all the letters to be learned, 
%e.g. the first two letters, A and B, are given by
%A : imagesc(reshape(data(:,1),5,7)')
%B : imagesc(reshape(data(:,2),5,7)')

Num_samples=26;
data = data(:,1:Num_samples);

%here we run the CD algorithm to learn the weights of the RBM --------------------------------------
[J, Error] = CD(N,M,data,beta,eta,Num_samples,Num_iterations,L,F);

plot(Error,'b')