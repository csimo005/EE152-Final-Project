left = rgb2gray(imread('test images/left/im_00.jpg'));
right = rgb2gray(imread('test images/right/im_00.jpg'));

left = im2double(left);
right = im2double(right);

lpf = fspecial('gaussian',5,1.7);
left_lpf = imfilter(left,lpf);
right_lpf = imfilter(right,lpf);
left_hpf = fftCompress(left);
right_hpf = fftCompress(right);

compare(left, right, left, right)
compare(left, right, left_lpf, right_lpf)
compare(left, right, left_hpf, right_hpf)

left_hpf = hpf_img(left);
right_hpf = hpf_img(right);
compare(left, right, left_hpf, right_hpf)