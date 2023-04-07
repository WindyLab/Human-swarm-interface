%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: build formation shape
function image_mtr=LoadBinaryImage(img_src,grid_num)
    [image_mtr,rn,cn]=PreprocImage(img_src);
    image_mtr=DiscreteImage(image_mtr,rn,cn,grid_num);
    %image_dis=mat2gray(image_mtr);    
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% FUNCTION:discrete the image
function dis_mtr=DiscreteImage(image_mtr,rn,cn,grid_num) 
    % square the image
    dis_num=ceil(max(rn,cn)/grid_num);
    side_num=dis_num*grid_num;
    delta=side_num-cn;
    half=floor(delta/2);
    image_mtr=[ones(rn,half),image_mtr,ones(rn,delta-half)]; 
    delta=side_num-rn;
    half=floor(delta/2);
    image_mtr=[ones(half,side_num);image_mtr;ones(delta-half,side_num)];    
    % discrete the image
    image_cell=mat2cell(image_mtr,ones(1,grid_num).*dis_num,ones(1,grid_num).*dis_num);
    dis_mtr=GetDiscMatrix(image_cell,grid_num);    
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% FUNCTION: get discrete mtrix from image cells
function dis_mtr=GetDiscMatrix(image_cell,grid_num)
    threshold=0.4;
    dis_mtr=ones(grid_num,grid_num);
    for i=1:1:grid_num
        for j=1:1:grid_num
            block=cell2mat(image_cell(i,j));
            black_num=length(find(block==0));
            block_size=numel(block);
            ratio=black_num/block_size;
            if ratio>threshold
                dis_mtr(i,j)=0;
            end
        end
    end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% FUNCTION: get image information
function [image_mtr,rn,cn]=PreprocImage(img_src)
    pic_bin=double(imbinarize(img_src,0.5));% image binarization processing 
    image_mtr=sum(pic_bin,3)./3;            % convert binary image to matrix
    [rn,cn]=size(image_mtr);                % get the image matrix scale
end