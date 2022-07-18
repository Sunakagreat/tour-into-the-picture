function out=rendering(layers,origin,pixel,vanishing_point)
% input: layers:            5 cell images after segmentation,
%        estimatedVertex:   12 reference point before perspective
%        transformation
%        ReferenceVertex:   12 reference point after perspective
%        transformation
% output: one RGB image, the image after perspective transformation
%functionality: 1. Apply perspective to each cell, according to the
%                  reference point
%               2. Aggregate 5 layers into one image(image size should be 
%                  determined by min-max value along x-y axis of ReferenceVertex)
%return 1 image after synthesis 
size_before=1+max(origin')-min(origin');
size_after=1+max(pixel')-min(pixel');
shift_origin=min(origin');
shift_after=min(pixel');

estimatedVertex=ceil(1+origin'-shift_origin);estimatedVertex=estimatedVertex';
ReferenceVertex=ceil(1+pixel'-shift_after);ReferenceVertex=ReferenceVertex';
[trans,selected_region]=get_trans_and_region(estimatedVertex,ReferenceVertex);
out=uint8(zeros(ceil(size_after(2)),ceil(size_after(1)),3));
p0=imref2d(size(img(:,1:1229,:)));

for i=[1:5]
    [outputImage,p1] = imwarp(layers{i},p0, trans{i} );
    shift_x=-p1.XWorldLimits(1)+0.5;
    shift_y=-p1.YWorldLimits(1)+0.5;
    ix=selected_region{i}(1);iy=selected_region{i}(2);ax=selected_region{i}(3);ay=selected_region{i}(4);
    shift_x=-p1.XWorldLimits(1)-0.5;
    shift_y=-p1.YWorldLimits(1)-0.5;
    out(iy:ay,ix:ax,:)=out(iy:ay,ix:ax,:)+outputImage(ceil(iy+shift_y)+1:ceil(ay+shift_y)+1,1+ceil(ix+shift_x):1+ceil(ax+shift_x),:);
end





end