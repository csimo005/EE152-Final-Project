function [im, rev] = dctRevCoeff(coeff, block)
    m = 480;
    n = 640;
    r = m/block;
    c = n/block;
    
    im = zeros(m,n);
    for i = 1:r
        for j = 1:c
            val = coeff(i,j);
            row = (i-1)*block + 1;
            col = (j-1)*block + 1;
            im(row:row+block-1, col:col+block-1) = val;
        end
    end
%     figure;imshow(im);
    rev = im;
    im = idct2(im);
end