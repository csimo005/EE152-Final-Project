left = rgb2gray(imread('test images/left/im_00.jpg'));
right = rgb2gray(imread('test images/right/im_00.jpg'));

lpf = fspecial('gaussian',5,1.7);
left_lpf = imfilter(left,lpf);
right_lpf = imfilter(right,lpf);
left_hpf = left - left_lpf;
right_hpf = right - right_lpf;

compare(left, right, left, right)
compare(left, right, left_lpf, right_lpf)
compare(left, right, left_hpf, right_hpf)