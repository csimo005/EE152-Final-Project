clear all;
close all;

left = rgb2gray(imread('test images/left/im_00.jpg'));
left = im2double(left);

lpf = fspecial('gaussian',5,1.7);
hpf = fspecial('gaussian',5,0.0001) - lpf;


left_hpf = imfilter(left,hpf);

figure;
imshow(left);
figure;
imshow(left_hpf);