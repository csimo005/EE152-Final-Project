function [ hpf_img ] = hpf_img( img, block, std )
%HPF_IMG Summary of this function goes here
%   Detailed explanation goes here

lpf = fspecial('gaussian',block,std);
hpf = fspecial('gaussian',block,0.0001) - lpf;

hpf_img = imfilter(img,hpf);

end

