%% Code Division Multiple Access Receiver
% CDMA - Function
% 1. Input data from transmitter and hadamard matrix used from transmitter
% 2. Sum data for the size of each bit. Multiply by each bit in the
% spreading code
% 3. Divide each bit sum by the number of chips in each bit
% 4. Repeat for each user

%%

function decoded_signal= receiver_clean(sent_sig, spread_codes)
    decoded_signal=[]; %decoded_signal to be returned
    spread_codes(spread_codes==0)=-1; %replace 0's with -1's
    currbit=1; %the current bit
    sum=0; %sum over course of bit
    bitsize=size(spread_codes,2);

    for j=1:size(spread_codes,1) %runs once for each spread code
        for i=1:length(sent_sig) %goes through each chip in sent_sig
            if(mod(i,bitsize)~=0) %if this is not the last chip in the bit
                sum=sum+spread_codes(j,mod(i,bitsize))*sent_sig(i); 
            else %if it's the last chip in the bit...
                sum=sum+(spread_codes(j, bitsize)*sent_sig(i)); %add to sum
                decoded_signal(j,currbit)=1.0*sum/bitsize; %divide sum by number of chips in a bit
                sum=0; %reset sum for next bit
                currbit=currbit+1; %increase currbit
            end
        end
        currbit=1; %reset currbit for next signal
    end  
    for i=1:size(decoded_signal,1)
        j=1:size(decoded_signal,2)
           if(decoded_signal(i,j)<0)
               decoded_signal(i,j)=-1;
           elseif(decoded_signal(i,j)>0)
               decoded_signal(i,j)=1;
           end
    end
    
    decoded_signal(decoded_signal==1)=0;
    decoded_signal(decoded_signal==-1)=1;
end