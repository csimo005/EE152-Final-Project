clear all;
close all;
left_root = 'test images/left/im_';
right_root = 'test images/right/im_';
result_root = 'fft_mask_size_results/';

img_temp = imread('test images/left/im_00.jpg');

for blk=1:60
   sum = 0;
   
   % Make the storage result folder
   result_folder_root = strcat(result_root, sprintf('blksize_%02d/', blk));
   result_folder_left_root = strcat(result_folder_root, 'left/');
   result_folder_right_root = strcat(result_folder_root, 'right/');
   
   mkdir(result_folder_root);
   mkdir(result_folder_left_root);
   mkdir(result_folder_right_root);
   
   % Create the mask
   fftmask = ones(size(img_temp));

   xlow = size(img_temp,2)/2 - blk;
   xhigh = size(img_temp,2)/2 + blk;

   ylow = size(img_temp,1)/2 - blk;
   yhigh = size(img_temp,1)/2 + blk;

   % Removal of low frq
   for x=xlow:xhigh
       for y = ylow:yhigh
           fftmask(y,x) = 0;
       end
   end
   
    
   % Store the mask
   MaskFileName = strcat(result_folder_root , sprintf('fft_mask_%02d.jpg', blk))
   imwrite(fftmask, MaskFileName);
   
   for imgC=0:20
       left_fileName = strcat(left_root, sprintf('%02d.jpg',imgC));
   
       right_fileName = strcat(right_root, sprintf('%02d.jpg',imgC));
       
       left = rgb2gray(imread(left_fileName));
       right = rgb2gray(imread(right_fileName));

       left = im2double(left);
       right = im2double(right);
       
       left_fft = log(abs(fftshift(fft2(left))));
       right_fft = log(abs(fftshift(fft2(right))));
     
       left_compressed = fftCompress(left, blk);
       right_compressed = fftCompress(right, blk);
       
       left_compressed_fft = log(abs(fftshift(fft2(left_compressed))));
       right_compressed_fft = log(abs(fftshift(fft2(right_compressed))));
       
       % Store all the images
       left_img_fft_filename = strcat(result_folder_left_root, sprintf('img_%02d_fft_before', imgC));
       left_img_compress_filename = strcat(result_folder_left_root, sprintf('img_%02d_compressed.jpg', imgC));
       left_img_fft_after_filename = strcat(result_folder_left_root, sprintf('img_%02d_fft_after', imgC));
       
       right_img_fft_filename = strcat(result_folder_right_root, sprintf('img_%02d_fft_before', imgC));
       right_img_compress_filename = strcat(result_folder_right_root, sprintf('img_%02d_compressed.jpg', imgC));
       right_img_fft_after_filename = strcat(result_folder_right_root, sprintf('img_%02d_fft_after', imgC));
       
       % Save a specific block size.
       if blk == 30
           %imwrite(imagesc(left_fft), left_img_fft_filename);
           imagesc(left_fft);
           saveas(gcf, left_img_fft_filename, 'jpg');
           imwrite(left_compressed, left_img_compress_filename);
           %imwrite(imagesc(left_compressed_fft), left_img_fft_after_filename);
           imagesc(left_compressed_fft);
           saveas(gcf, left_img_fft_after_filename, 'jpg');

           %imwrite(imagesc(right_fft), right_img_fft_filename);
           imagesc(right_fft);
           saveas(gcf, right_img_fft_filename, 'jpg');
           imwrite(right_compressed, right_img_compress_filename);
           %imwrite(imagesc(right_compressed_fft), right_img_fft_after_filename);
           imagesc(right_compressed);
           saveas(gcf, right_img_fft_after_filename, 'jpg');
       end
       
       sum = sum + compare(left, right, left_compressed, right_compressed);
   end
    
   avg_rmse(blk) = sum / 21
end

plot(blk, avg_rmse);
