function [ hpf_img ] = hpf_img( img )
%HPF_IMG Summary of this function goes here
%   Detailed explanation goes here

lpf = fspecial('gaussian',15,10.7);
hpf = fspecial('gaussian',15,0.0001) - lpf;

hpf_img = imfilter(img,hpf);

end

