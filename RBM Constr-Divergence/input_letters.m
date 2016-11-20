%This script generates images of letters as input and associates to each of
%them a label in the following way

%letters are represented by matrices of 35 pixels so the size of the
%first layer is N=35 
%since there are 26 different letters to be recognized, the last layer has
%26 neurons. 

%Neural network with only 1 hidden layer, whose size is 30,
%if trained with the Num_samples=26 letters, finds a good 
%solution after O(4000) time steps with SGD with alpha=0. and eta=0.1

%If Num_samples=r*26, comparable results should be
%obtained after ~ 4000 / r time steps but this would be much better in
%terms of recognition of noising input patterns.

%Num_samples           : # of patterns to be learned
%N                     : # of input neurons. In this case this number is 26
%                        since there are 26 different letters
%data                  : this contains the patterns to learn
%target                : this is the target associated to each pattern

function [ data,target ] = input_letters (Num_samples, N)

    data = zeros(N,Num_samples);

    %here we load a predefinite set of letters, each one contanined in X(:,k).
    %T is a vector of targets. 
    [X,T] = prprob;

    %the letter represented by X(:,k) can be plotted as
    %imagesc(reshape(bi2de(X(:,k)),5,7)')

    %this the small noise we add to the real input patterns
    noise_input=0.0;

    for m=0:Num_samples
        t=mod(m,26)+1;
        a(:,m+1) = X(:,t);
        a(:,m+1)=a(:,m+1) + normrnd(0,noise_input,N,1);
        target(:,m+1)=T(:,t);
    end

    %normalize the input vectors
    for m=1:Num_samples
%        data(:,m)=a(:,m)/norm(a(:,m));
        data(:,m)=a(:,m);
    end 

end