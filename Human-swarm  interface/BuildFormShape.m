%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: build formation shape
function gray_mtr=BuildFormShape(image_mtr,gray_level)
    % initial gray grid image
    gray_mtr=image_mtr;
    grid_num=length(image_mtr(1,:));    
    gray_mtr=[ones(grid_num,gray_level),gray_mtr,ones(grid_num,gray_level)];     
    gray_mtr=[ones(gray_level,2*gray_level+grid_num);gray_mtr;ones(gray_level,2*gray_level+grid_num)]; 
    % gray transformation
    init_value=gray_level+1;
    gray_mtr(gray_mtr==1)=init_value;  
    for i=1:1:gray_level
        [index_r,index_c]=find(gray_mtr==i-1);
        num=length(index_r);
        for j=1:1:num
            % determine the pixel directly above the current pixel
            if gray_mtr(index_r(j)-1,index_c(j))==init_value
                gray_mtr(index_r(j)-1,index_c(j))=i;
            end
            % determine the pixel directly below the current pixel
            if gray_mtr(index_r(j)+1,index_c(j))==init_value
                gray_mtr(index_r(j)+1,index_c(j))=i;
            end
            % determine the left pixel of the current pixel
            if gray_mtr(index_r(j),index_c(j)-1)==init_value
                gray_mtr(index_r(j),index_c(j)-1)=i;
            end
            % determine the right pixel of the current pixel
            if gray_mtr(index_r(j),index_c(j)+1)==init_value
                gray_mtr(index_r(j),index_c(j)+1)=i;
            end
            % determine the upper left pixel of the current pixel
            if gray_mtr(index_r(j)-1,index_c(j)-1)==init_value
                gray_mtr(index_r(j)-1,index_c(j)-1)=i;
            end
            % determine the lower left pixel of the current pixel
            if gray_mtr(index_r(j)+1,index_c(j)-1)==init_value
                gray_mtr(index_r(j)+1,index_c(j)-1)=i;
            end
            % determine the upper right pixel of the current pixel
            if gray_mtr(index_r(j)-1,index_c(j)+1)==init_value
                gray_mtr(index_r(j)-1,index_c(j)+1)=i;
            end
            % determine the lower right pixel of the current pixel
            if gray_mtr(index_r(j)+1,index_c(j)+1)==init_value
                gray_mtr(index_r(j)+1,index_c(j)+1)=i;
            end
        end       
    end
    % Extract the effective area of the gray image
    [pos_y,pos_x]=find(flipud(gray_mtr)<init_value);
    lth=length(gray_mtr(:,1));
    min_x=min(pos_x);
    max_x=max(pos_x);
    min_y=min(pos_y);
    max_y=max(pos_y);
    gray_mtr=gray_mtr(:,min_x:max_x);
    gray_mtr=gray_mtr((lth-max_y+1):(lth-min_y+1),:);
    gray_mtr(gray_mtr==init_value)=gray_level;
    % normalize the gray image
    gray_mtr=gray_mtr.*(1/gray_level);
    % save image matrix
    save('formation_shape.mat','gray_mtr');
end

