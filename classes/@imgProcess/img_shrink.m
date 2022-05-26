function img_out = img_shrink(obj, img, n_pixels)

[r, c] = size(img);
img = imresize(img, [r - n_pixels, c - n_pixels]);
padsize = [n_pixels, n_pixels];
padval = 255; % White in gray-scale
img_out = padarray(img, padsize, padval);

end

