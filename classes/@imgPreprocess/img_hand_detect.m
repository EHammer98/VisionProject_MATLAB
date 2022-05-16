function img_out = img_hand_detect(obj, img, r_se)

if (nargin < 3) r_se = obj.r_se; end

IMG_PROCESS = imgProcess();

img = imresize(img, obj.imgsize);
img = rgb2gray(img);
img = edge(img, 'canny');

r_crop = round(r_se / 4);

se = strel("disk", r_se);
img = imclose(img, se);
img = IMG_PROCESS.img_crop_center(img, obj.imgsize(1, 1) - 2 * r_crop, obj.imgsize(1, 2) - 2 * r_crop); 

img_out = img;

end