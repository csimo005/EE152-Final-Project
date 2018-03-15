clc;
clear all;
close all;

block = 3:2:21;
sigma = 0.5:0.1:12;
    
rmse = zeros(size(block,2),size(sigma,2));
img = rmse;
for it=0:20
    sprintf('%02d',it)
    
    left = im2double(rgb2gray(imread(strcat('test images/left/im_',sprintf('%02d',it),'.jpg'))));
    right = im2double(rgb2gray(imread(strcat('test images/right/im_',sprintf('%02d',it),'.jpg'))));

    
    for jt=1:size(block,2)
        jt
        for kt=1:size(sigma,2)
            kt
            left_comp = hpf_img(left,block(jt),sigma(kt));
            right_comp = hpf_img(right,block(jt),sigma(kt));

            if rmse(jt,kt) ~= inf
            err = compare(left,right,left_comp,right_comp);
            if err == -1
                rmse(jt,kt) = inf;
            else
                rmse(jt,kt) = rmse(jt,kt) + err;
            end
            end
        end
    end
end

rmse = rmse ./ 21;