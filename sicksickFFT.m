data_length = 100;
num_users = 64;
sampling = 2;
users = 1:10;

[spread_sig, user_code, data_mat] = transmitter_submodule(data_length,num_users,users);
data_sig = repelem(data_mat(1,:),1,64*sampling);
spread_sig = sum(spread_sig);
spreaded_sig = repelem(spread_sig,sampling);
figure(1)
subplot(2,1,1)
stairs(data_sig)
subplot(2,1,2)
fs = data_length*num_users*sampling;
f = fs/2*linspace(-1,1,fs);
plot(f,abs(fftshift(fft(data_sig))));

figure(2)
subplot(2,1,1)
stairs(spreaded_sig);
subplot(2,1,2)
plot(f,abs(fftshift(fft(spreaded_sig))));