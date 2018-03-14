i = imread('test images/left/im_01.jpg');
i = im2double(i);
i = rgb2gray(i);

block_sz = 8;
I = i;
T = dctmtx(block_sz);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[block_sz block_sz],dct);

mask = zeros(block_sz, block_sz);
for r = 1:block_sz/2
    mask(r,1:(block_sz/2)-r+1) = 1;
end

B2 = blockproc(B,[block_sz block_sz],@(block_struct) mask .* block_struct.data);
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B2,[block_sz block_sz],invdct);

figure;
imshow(I);
figure;
imshow(I2);

imwrite(I2, 'image_01.jpg');