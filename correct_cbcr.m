function out = correct_cbcr(im, y)
out = double(rgb2ycbcr(im));
out(:, :, 2) = (out(:, :, 2) - 128)./out(:, :, 1).*double(y) + 128;
out(:, :, 3) = (out(:, :, 3) - 128)./out(:, :, 1).*double(y) + 128;
out(:, :, 1) = y;
out = ycbcr2rgb(uint8(out));