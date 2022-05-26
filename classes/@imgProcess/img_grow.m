function img_out = img_grow(obj, img, n_pixels)

[r, c] = size(img);
img = obj.img_crop_center(img, r - n_pixels, c - n_pixels);
img_out = imresize(img, [r, c]);
    
end