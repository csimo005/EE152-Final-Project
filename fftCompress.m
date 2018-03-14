function [ lpf_img ] = fftCompress( img )
%FFTCOMPRESS Summary of this function goes here
%   Detailed explanation goes here

fft_img = fft(img);

fftmask = ones(size(fft_img));

xlow = size(fft_img,2)/2 - 30;
xhigh = size(fft_img,2)/2 + 30;

ylow = size(fft_img,1)/2 - 30;
yhigh = size(fft_img,1)/2 + 32;


% Removal of low frq
for x=xlow:xhigh
   for y = ylow:yhigh
       fftmask(y,x) = 0;
   end
end

fft_img = fftshift(fft_img);

lpf_fft_img = fft_img .* fftmask;

lpf_fft_img = fftshift(lpf_fft_img);

lpf_img = ifft2(lpf_fft_img);

