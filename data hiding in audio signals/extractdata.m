%Extracting hidden image from water marked audio signal
clc
clear
close all 
wm_sz     = 20000;                        % watermark size
px_sz     = wm_sz/8;                      % number of pixels
im_sz     = sqrt(px_sz);                  % image size
msg_new  = audioread ('NEWMSG.wav');   % new (watermarked) host signal
msg_new  = uint8(255*(msg_new + 0.5));  % double [-0.5 +0.5] to 'uint8' [0 255]

% prepare host
msg_bin  = dec2bin(msg_new, 8);         % binary host [n 8]

% extract watermark
wm_bin_str = msg_bin(1:wm_sz, 8);
wm_bin    = reshape(wm_bin_str, px_sz , 8);
wm_str    = zeros(px_sz, 1, 'uint8');

for i     = 1:px_sz                        % extract water mark from the first plane of host               
    wm_str(i, :) = bin2dec(wm_bin(i, :));      % Least Significant Bit (LSB)
end

wm  = reshape(wm_str, im_sz , im_sz);

% show image
imshow(wm);
imwrite(wm,'kal.png');