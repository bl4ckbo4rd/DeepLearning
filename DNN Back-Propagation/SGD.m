%This function implements the Stochastic Gradient Descent (SGD) to learn the
%weights W which describe all the samples.
%SGD works minimizing the errors on these samples in a parallel way.

%It differs from a simple sample by sample GD, where we would learn each
%sample and forget it when we learning the next one.
%Moreover, it differes from a GD aiming at learning all the samples because
%it would evaluates the step in the wights Delta_W at each iteration
%taking into account all the samples. In other words, while evaluating
%different samples in a single iteration we are not changing the W's. 

%What stochastic gradient descent does is slightly different. In fact, 
%it makes a small change in W's after looking at each sample.
%Learning all the samples together may be done making small steps at each iteration.

%In the following we give two versions of SGD 
%In the first one the order in which we look at the samples is the same 
%at every iteration.
%In the second (commented) one the order in which we consider different 
%samples changes randomly at each iteration. 
%The first one seems to work better

%N                  : # of input neurons
%M                  : row vector containing the number of neurons in all
%                     the subsequent layers. M(end) is the number of 
%                     neurons in the last layer and correspond to the 
%                     number of different categories in which we want to 
%                     catalogate the patterns.
%Num_iterations     : # of iterations of the SGD
%Num_samples        : # of samples to learn
%data               : matrix N * Num_samples containing the data to learn 
%target             : matrix M(end) * Num_samples containing the labels for each
%                     patterns in the form of versors of an M(end)-dim space

%error              : matrix Num_iterations * Num_patters containing
%                     for each pattern, the difference between the current
%                     output and the desidered one at each time step

function [ error ] = SGD(N,M,Num_iterations,Num_samples,data,target,eta,alpha)

    L = size(M,2)+1;     %total number of layers
    n = L-2;             %number of hidden layers

    a1=data;
    tar=target;
    
    error=zeros(Num_iterations,Num_samples);
    
    %here we initialize the weights:
    %this is the st dev with which we initalize the weights
    sd=0.01;             
    W{1}=normrnd(0,sd,M(1),N);
    for l=1:n
        W{l+1}=normrnd(0,sd,M(l+1),M(l));    
    end
    
    for t=1:Num_iterations  
       for m=1:Num_samples  
                
            z{1}=a1(:,m);
            target=tar(:,m);    
                
            feed_forward_nn;
            error(t,m)=norm(z{L}-target);
            back_propagation;
       end     
    end
    
%    for t=1:Num_iterations   
%    ind=randperm(MU);    
%        for m=1:Num_samples  
        
%           k=ind(m);
        
%           z{1}=a1(:,k);
%           target=tar(:,k);
        
        
%            feed_forward_nn;
%            error(t,m)=norm(z{L}-target);
%            back_propagation;
%         end     

%    end
    
    

end

