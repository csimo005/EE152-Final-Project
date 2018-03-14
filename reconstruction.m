function [ points, points_l, points_r ] = reconstruction( im_left, im_right )
%3D_RECONSTRUCTION Summary of this function goes here
%   Detailed explanation goes here
    l_cx = 643.6470;
    l_cy = 493.3790;
    l_fx = 983.0440;
    
    r_cx = 643.6470;
    r_cy = 493.3790;
    
    focal_length = l_fx*(0.0036/960);
    baseline = 0.2400;
    
    sz = size(im_left);

    l_features = detectSURFFeatures(im_left);
    r_features =  detectSURFFeatures(im_right);
        
    % Extract features vectors for each point
    [fl,vptsl] = extractFeatures(im_left,l_features);
    [fr,vptsr] = extractFeatures(im_right,r_features);
       
    % match the points by extracted features vector
    pair_lr = matchFeatures(fl,fr);
            
    % convert from image position, to position on image plane
    points_l = bsxfun(@minus,vptsl.Location(pair_lr(:,1),:),[l_cx l_cy]);
    points_l(:,1) = points_l(:,1).*(0.0036/sz(1));
    points_l(:,2) = points_l(:,2).*(0.0048/sz(2));
     
    points_r = bsxfun(@minus, vptsr.Location(pair_lr(:,2),:), [r_cx r_cy]);
    points_r(:,1) = points_r(:,1).*(0.0036/sz(1));
    points_r(:,2) = points_r(:,2).*(0.0048/sz(2));
        
    points = ones([3,size(pair_lr,1)]);
    points(3,:) = (focal_length*baseline)./(points_l(:,1)-points_r(:,1));
    points(1,:) = (points(3,:)./(focal_length)).*points_l(:,1)';
    points(2,:) = (points(3,:)./(focal_length)).*points_l(:,2)';
    
    points_l = vptsl.Location(pair_lr(:,1));
    points_r = vptsr.Location(pair_lr(:,2));
end

