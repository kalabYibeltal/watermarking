% hiding image data in audio signal AKA watermarking
%importing audio data from file
[msg, f] = audioread ('ImperialMarch60.wav');   %message variable msg
msg      = uint8(255*(msg + 0.5));  % double to 'uint8' 
wm        = imread('Capture2.png');  %  Image data to be hidden aka watermark 
[r, c]    = size(wm);                 % watermark size
wm_ln      = length(wm(:))*8;          % watermark length
% watermark size checking
if length(msg) < (length(wm(:))*8)
    disp('The audio file and the image file and disproportinate please select larger audio file or smaller image file')
else
%watermarking    
% prepare host
msg_bin  = dec2bin(msg, 8);         
% prepare watermark   
wm_bin    = dec2bin(wm(:), 8);        
wm_str    = zeros(wm_ln, 1);           

for j = 1:8                           
    for i = 1:length(wm(:))
        ind   = (j-1)*length(wm(:)) + i;
        wm_str(ind, 1) = str2double(wm_bin(i, j));
    end
end
% insert watermark into the host

for i     = 1:wm_ln                   % insert water mark into the first plane of host               
msg_bin(i, 8) = dec2bin(wm_str(i)); % Least Significant Bit (LSB)
end 
% watermarked host
msg_new  = bin2dec(msg_bin);       
msg_new  = (double(msg_new)/255 - 0.5);   % 'uint8' to double
% save the watermarked message to "newmsg.wav" file
audiowrite('NEWMSG.wav', msg_new, f)     
end