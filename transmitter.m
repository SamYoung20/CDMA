%% Code Division Multiple Access Transmitter
% CDMAt - Function
% 1. (s) Input the data 
% Input data must be (+/- 1's) (this is a PSK modulation (BPSK))
% 2. (hl) Hadamard matrix length 
% 3. (cn) code number to be used for this user (row - number of H - matrix)
% 4. Spread the data by multiplying s by cn.
% 6. Outpot of the function is spread symbol of user cn.
%%

    data = [1, -1];
    codes = hadamard(4)
    codes(codes==-1)=0
    data_ex1 = data(1)*ones(1,length(codes(1,:)));
    data_ex2 = data(2)*ones(1,length(codes(1,:)));
    transignal1 = xor(data_ex1,codes(2,:));
    transignal2 = xor(data_ex2,codes(2,:));
    tran11 = double(transignal1);
    tran21 = double(transignal2);
    tran21(tran21==0)= -1;
    tran11(tran11==0)= -1;
    tran1 = horzcat(tran11, tran21)
    
    data = [-1, -1];
    data_ex1 = data(1)*ones(1,length(codes(1,:)));
    data_ex2 = data(2)*ones(1,length(codes(1,:)));
    transignal1 = xor(data_ex1,codes(3,:));
    transignal2 = xor(data_ex2,codes(3,:));
    tran12 = double(transignal1);
    tran22 = double(transignal2);
    tran22(tran22==0)= -1;
    tran12(tran12==0)= -1;
    tran2 = horzcat(tran12, tran22)

    
   sig = tran1+tran2
   users = [2, 3]
   
   
    
    
