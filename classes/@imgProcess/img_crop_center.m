function img_out = img_crop_center(obj, img, n_row, n_column)

% This function takes an image (any format) and crops it towards the center.
% 
% Arguments:
%  * obj: -
%  * img: image (any format)
%  * n_row: target number of rows
%  * n_column: target number of columns

if (nargin < 4) n_row = obj.rand_imgsize(1, 1); end
if (nargin < 3) n_column = obj.rand_imgsize(1, 2); end

img_new = [n_row, n_column];
crop_window = centerCropWindow2d(size(img), img_new);
img_out = imcrop(img, crop_window);

end