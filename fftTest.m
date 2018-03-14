clear all;
close all;

left = rgb2gray(imread('test images/left/im_00.jpg'));
right = rgb2gray(imread('test images/right/im_00.jpg'));

left = im2double(left);
right = im2double(right);

figure;
imshow(left);
figure;
imshow(right);

l_fft_img = fft2(left);

figure;
imagesc(log(abs(fftshift(l_fft_img))));

fftmask = ones(size(l_fft_img));


xlow = size(l_fft_img,2)/2 - 1;
xhigh = size(l_fft_img,2)/2 + 1;

ylow = size(l_fft_img,1)/2 - 1;
yhigh = size(l_fft_img,1)/2 + 1;


% Removal of low frq
for x=xlow:xhigh
   for y = ylow:yhigh
       fftmask(y,x) = 0;
   end
end

l_fft_img = fftshift(l_fft_img);

l_lpf_fft_img = l_fft_img .* fftmask;

l_lpf_fft_img = fftshift(l_lpf_fft_img);

figure;
imagesc(log(abs(fftshift(l_lpf_fft_img))));

figure;
imshow(real(ifft2(l_lpf_fft_img)));