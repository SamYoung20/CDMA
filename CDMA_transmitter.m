function signal = transmit(num_users, user_data, code)
 % if ~exist('type','var')
     % third parameter does not exist, so default it to something
  %    type = 'rcos';
  end
  samplesPerSymbol = round(samplerate/symbolrate);
  
  m = repmat(symbols,[samplesPerSymbol,1]);
  signalLen = samplesPerSymbol*length(symbols);
  symbolsResampled = reshape(m,[1, signalLen]);
  
  %raised cosine filter 
  h = rcosdesign(0.25, length(symbols) ,samplesPerSymbol, 'normal');
  shapedPulses = conv(symbolsResampled, h, 'same');  
  
  time = length(symbols)/symbolrate;
  t = linspace(0,time,signalLen);
  
  carrier = exp(i*carrierFreq*2*pi*t);
  
  %change shapedPulses to symbolResampled to not use the RCF
  if(strncmp(type,'rcos',4))
    signal = carrier.*shapedPulses;
  else
    signal = carrier.*symbolsResampled;
  end
end