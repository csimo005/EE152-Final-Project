function [ rmse ] = compare( left_1, right_1, left_2, right_2 )
%COMPARE Summary of this function goes here
%   Detailed explanation goes here
    [p1, xy_l_1, xy_r_1] = reconstruction(left_1, right_1);
    [p2, xy_l_2, xy_r_2] = reconstruction(left_2, right_2);
    
    if ~isempty(xy_l_1) && ~isempty(xy_r_1) &&~isempty(xy_l_2) && ~isempty(xy_r_2)
        [IDX_l, D_l] = knnsearch(xy_l_1, xy_l_2);
        [IDX_r, D_r] = knnsearch(xy_r_1, xy_r_2);

        rmse = 0;
        matches = 0;
        for i=1:size(IDX_l)
            if IDX_l(i) == IDX_r(i) && D_l(i) < 1 && D_r(i) < 1
                rmse = rmse + sum((p1(:,IDX_l(i)) - p2(:,i)).^2);
                matches = matches + 1;
            end
        end
        if matches
            rmse = sqrt(rmse./(3*matches));
        else
            rmse = -1;
        end
    else
        rmse = -1;
    end
end

