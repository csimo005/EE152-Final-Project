function [ coeff ] = dctCoeff( im, block_sz )
%DCTCOEFF Summary of this function goes here
%   Detailed explanation goes here
    if mod(480,block_sz) == 0 && mod(640,block_sz) == 0
        coeff = zeros(480/block_sz,640/block_sz);
        im_dct = dct2(im);
        for it=0:(480/block_sz)-1
           for jt=0:(640/block_sz)-1
               coeff(it+1,jt+1) = mean(mean(im_dct((it*block_sz)+1:(it+1)*block_sz,(jt*block_sz)+1:(jt+1)*block_sz)));
           end
        end
    else
        coeff = -1;
    end
end

