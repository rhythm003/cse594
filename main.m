clear;
im1 = imread('p2.JPG');
imtool(im1);
gf = fspecial('gaussian', [11 11], 1.5);
se = ones(11, 11);
imm1 = rgb2ycbcr(im1);
im2 = imm1(:, :, 1);
hist = imhist(im2);
[idx, c] = kmeans(double(reshape(im2, size(im2, 1)*size(im2, 2), 1)), 3);
[center ind] = sort(c);
shadow_max = 0;
shadow_min = 255;
mask = zeros(size(idx));
for i = 1:size(idx, 1)
    if idx(i) == ind(1)
        if im2(i) > shadow_max
            shadow_max = im2(i);
        end
        if im2(i) < shadow_min
            shadow_min = im2(i);
        end
        mask(i) = 1;
    end

end
mask = reshape(mask, size(im2));
mask2 = imerode(imdilate(mask, se), se);
mask2 = imdilate(imerode(mask2, se), se);
smask = imfilter(mask2, gf);
im3 = curve_im(im2, shadow_min, shadow_max, 0.5);
im4 = correct_cbcr(im1, im3);
im5 = zeros(size(im4));
im5(:,:,1) = double(im4(:,:,1)).*smask + double(im1(:,:,1)).*(1-smask);
im5(:,:,2) = double(im4(:,:,2)).*smask + double(im1(:,:,2)).*(1-smask);
im5(:,:,3) = double(im4(:,:,3)).*smask + double(im1(:,:,3)).*(1-smask);
im5 = uint8(im5);
imtool(im5);

% X = []; count = 1;
% for i = 1:750000
%     if idx(i) == ind(1)
%         X(count) = im2(i); count = count+1;
%     end
% end
% mean(X)
% std(X)
% imm3 = double(im3).*smask + double(im2).*(1-smask);
% imm3 = uint8(imm3);
% [nidx, nc] = kmeans(double(reshape(imm3, size(im2, 1)*size(im2, 2), 1)), 3);
% [ncenter nind] = sort(nc);
% nX = []; count = 1;
% for i = 1:750000
%     if nidx(i) == nind(1)
%         nX(count) = imm3(i); count = count+1;
%     end
% end
% mean(nX)
% std(nX)
