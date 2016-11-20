%this is a simple set of inputs made by two kinds of patterns:
%one where the first N/2 bits are equal to 1 and the rest are 0;
%another one where the second N/2 bits are 1 and the rest are 0.
%the input patterns are then normalized.

%instead of presenting only 2 input patters, we present MU input patters
%where MU is a multiple of 2, and input patterns are perturbed with
%a small noise. in this way we have a larger number pattern to learn.
%these patterns are synthetic, since the real patterns are the only
%two mentioned before. by the way this strategy works better because we
%train the net not to be fooled by a noise version of the input pattern,
%and to assign it to the correct target. 

%the target is a 2-dimensional representation of the input patterns:
%[1,0] for the first kind and [0,1] for the second kind.
%so if N=2, the target is just noiseless  version of the input pattern.

%with N=2 and M=[5,2] it finds a good solution in a O(300) time steps when
%MU=2 and b=0.1, alpha=0, sd=0.01 with SGD.
%if MU=r*2 it should give comparable results in ~ 300 / r time steps but
%in fact, in terms of recognizing noising input patterns, it does much
%better.

%this is the small noise we add to the real input patterns
noise_input=0.01;

for m=0:MU-1
    t=mod(m,2);
    a(:,m+1)=zeros(N,1);
    a(t*N/2+1:(t+1)*N/2,m+1)=ones(N/2,1);
   
    a(:,m+1)=a(:,m+1) + normrnd(0,noise_input,N,1);
    
    tar(:,m+1)=([1-t; t]);    
end
 
%normalize the input vectors
for m=1:MU
    a1(:,m)=a(:,m)/norm(a(:,m));
end