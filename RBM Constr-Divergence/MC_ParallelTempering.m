%input variables:
%T       : # of time steps for which we would like to run the dynamics
%beta    : vector containing inverse temperatures of different replicas
%rep     : initial condition of different replicas.
%          e.g. rep = [3,8] means that the first replica starts from the
%          3rd letter and the second replica starts from the 8th
%P       : interval between proposed swaps 

%observation:
%if P=T there the replicas are completely independent, and 
%we are just running in parallel M different MCMC at different 
%temperatures


rep  = [5,1,2];
beta = [1 0.9 0.8];

K = numel(beta);

for a=1:K
    v(:,a)            = 2*data(:,rep(a))-1;

    h_field(:,a)      = beta(a) * J * v(:,a); % + beta*h_external' ;          
    h(:,a)            = 2 * (1./(1 + exp(-h_field(:,a))) > rand(M,1) ) - 1;

    data_RBM        = zeros(N, T+1, K);
    data_RBM(:,1,a) = v(:,a);
end

for t=1:T
    
    if (mod(t,P)==0)
        swap = randperm(K);
        v = v(:,swap);
        h = h(:,swap);
        %qua ci manca la prob di accettare la mossa proposta
        
        
        
    else
        for a=1:K
            r = randi([1 N+M]);
            if r <= M
                Jv = J*v(:,a);
                DeltaE = 2 * h(r,a) * Jv(r);
                p = min(1,exp(-beta(a)*DeltaE));
                if rand < p
                    h(r,a) = -h(r,a);
                end
            else
                Jh = J'*h(:,a);
                DeltaE = 2 * v(r-M,a) * Jh(r-M);
                p = min(1,exp(-beta(a)*DeltaE));
                if rand < p
                    v(r-M,a) = -v(r-M,a);
                end
            end
            data_RBM(:,t,a) = v(:,a);
        end
    end
end
       
for t=1:T
    imagesc(reshape(data_RBM(:,t,1),5,7)')
    pause(0.5)
end

Q = zeros(T,Num_samples);

for t=1:T
    for n=1:Num_samples
        Q(t,n)=data_RBM(:,t,1)'*(2*data(:,n)-1);
    end
end
