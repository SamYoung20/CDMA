%% Code Division Multiple Access Transmitter
% CDMAt - Function
% 1. (s) Input the data 
% Input data must be (+/- 1's) (this is a PSK modulation (BPSK))
% 2. (hl) Hadamard matrix length 
% 3. (cn) code number to be used for this user (row - number of H - matrix)
% 4. Spread the data by multiplying s by cn.
% 6. Outpot of the function is spread symbol of user cn.
%%
function [spread_sig, user_code, data] = transmitter_submodule(data_length, num_users, user)
    %INPUTS:
    %data: a matrix of the data you want to transmit where each row is a different user
    %num_users: integar of number of users the number of users that 
    
    %OUTPUTS: 
    %sum_sig: transmitted signal
    %user_codes : hadamard matrix
    
    
    %data_mat = [1, -1; -1, -1; -1 , 1];
    %users = 2;
    %data_mat = randi([0 1],num_users,data_length);
    
    %or to have all users xmit same data:
    data_mat=randi([0 1],1,data_length);
    data_mat = repmat(data_mat,num_users,1);
    data_mat = 2.*(data_mat-0.5);
    users=num_users;
    % Step 1: Generate Hadamard Matrix for Encoding
    n = pow2(ceil(log2(users)));% finds next closest power of two larger than # of users
    %Uncomment this line for natural ordering
    %codes = hadamard(n);
    
    %Uncomment this line for sequency ordering
    codes = walsh(n); 
    
    %Step 2: Process Hadamard Matrix, converting -1s to 0 for MATLAB
    %logicals processing
    codes(codes==-1)=0;
    codes_log = logical(codes);
    
    %initalizing arrays
    spread_sig = [];
    word = [];
    for i = 1: users
        for j = 1: length(data_mat(1,:))
            %For spread each bit of data using the respective user code
            data_ex = (data_mat(i,j)*ones(1,length(codes(1,:))));
            data_ex(data_ex==-1) = 0; % MATLAB processing to make it a logical array
            data_log = logical(data_ex);
            %XOR the data with the user code
            transignal = xor(data_log,codes_log(i,:));
            %convert back to doubles
            chip= double(transignal);
            chip(chip==0)= -1;
            %add newly spread encided bit to data stream
            word = [word chip];
        end
         spread_sig(i,:) = word;
         %add datastream of new user
         word=[];
    end
   %sum all of the users 
   sig_sum = sum(spread_sig);
   user_codes = codes(1:users,:);
   user_code = user_codes(user,:);
   data = data_mat(user,:);
   spread_sig=spread_sig(user,:);
end  
   