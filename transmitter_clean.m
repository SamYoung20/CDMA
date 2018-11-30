%% Code Division Multiple Access Transmitter
% CDMAt - Function
% 1. (s) Input the data 
% Input data must be (+/- 1's) (this is a PSK modulation (BPSK))
% 2. (hl) Hadamard matrix length 
% 3. (cn) code number to be used for this user (row - number of H - matrix)
% 4. Spread the data by multiplying s by cn.
% 6. Outpot of the function is spread symbol of user cn.
%%
    data_mat = [1, -1; -1, -1; -1 , 1];
    users = 2;
    codes = hadamard(4)
    codes(codes==-1)=0
    spread_sig = []
    for i = 1: users
        for j = 1: length(data_mat(1,:))
            data_ex = data_mat(i,j)*ones(1,length(codes(1,:)));
            transignal = xor(data_ex2,codes(2,:));
            chip= double(transignal);
            chip(chip==0)= -1;
            spread_sig(i,:) = horzcat(spread_sig(i,:), chip)
        end
    end
    
   sig = sum(spread_sig)
   users = [2, 3]
   
   