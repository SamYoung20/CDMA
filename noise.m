function dirty_sig = noise(clean_sig, noise_mag)  %Puts signal through a channel
    %noise mag is temporary variable for how much noise we want (can/will
    %be adjusted later)

    noise= noise_mag*rand(1, length(clean_sig));
    dirty_sig=noise+clean_sig;
end