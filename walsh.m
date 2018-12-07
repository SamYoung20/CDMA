function H = walsh(N);
% H = walsh(N)
%  generate a sequency (Walsh) ordered Hadamard matrix of size N,
%  N must be an integer power of 2.
i = log2(N);
if i-floor(i)>eps
  error('N must be an integer power of 2.');
end
% Generate the Hadamard matrix
H = hadamard(N);
% generate Gray code of size N.
graycode = [0;1];
while size(graycode,1) < N
  graycode = [kron([0;1], ones(size(graycode,1),1)), ...
              [graycode; flipud(graycode)]];
end
% Generate indices from bit-reversed Gray code which correspond to the
% indices that will form a sequency ordered walsh matrix (i.e. each row
% different from previous by 1 sign change)
seqord = bin2dec(fliplr(char(graycode+'0')))+1;

H = H(seqord,:);