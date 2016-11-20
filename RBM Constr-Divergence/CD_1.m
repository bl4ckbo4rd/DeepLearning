%This function run the Contrastive Divergence (CD) algorithm to train a
%Restricted Boltzmann Machine.
%We assume binary \in [0,1] variables for visible and hidden spins. 
%units are transformed \in [-1,1] in the script
%<>_data is computed exactly by avaraging over P(h|v).


%N              : # of visible units
%M              : # of hidden units
%data           : set of patterns to memorize
%beta           : inverse temperature
%eta            : learning parameter
%Num_samples    : # of samples to learn
%Num_iterations : # of iterations of the CD algorithm
%L              : L1 regularizer
%F              : Momentum to speed up gradient descent

function [J, Delta ] = CD_1(N,M,data,beta,eta,Num_samples,Num_iterations,L,F)

    v_spin=zeros(N,Num_samples,2);
    h_spin=zeros(M,Num_samples,2);
    v_spin(:,:,1)=2*data-1;
    
    Delta = zeros(1,Num_iterations);

    J=normrnd(0,0.1,M,N);
    DeltaJ_prev = zeros(M,N);
    
    for it = 1:Num_iterations

        for samp = 1:Num_samples
            h_field            = beta * J * v_spin(:,samp,1); % + beta*h_external' ;          
            h_spin(:,samp,1)   = 2 * (1./(1 + exp(-2*h_field)) > rand(M,1)) - 1;  
                
            v_field            = beta * J' * h_spin(:,samp,1); % + beta*h_external' ;          
            v_spin(:,samp,2)   = 2 * (1./(1 + exp(-2*v_field)) > rand(N,1)) - 1;  
         
            h_field            = beta * J * v_spin(:,samp,2); % + beta*h_external' ;          
            h_spin(:,samp,2)   = 2 * (1./(1 + exp(-2*h_field)) > rand(M,1)) - 1;  
        end

        C1 = zeros(M,N);
        C2 = zeros(M,N);

        for samp = 1:Num_samples
            C1 = C1 + ( v_spin(:,samp,1) * tanh(J*v_spin(:,samp,1))' )'; 
            C2 = C2 + h_spin(:,samp,2) * v_spin(:,samp,2)';
        end

        C1 = C1./Num_samples;
        C2 = C2./Num_samples;
    
        Delta(it) = mean(mean(abs(eta * (C1 - C2))));
        
        DeltaJ = eta * ((C1 - C2)-L * sign(J));  
        
        J = J + DeltaJ + F * DeltaJ_prev;
        
        DeltaJ_prev = DeltaJ;
    end

end

