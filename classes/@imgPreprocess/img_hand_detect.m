function img_out = img_hand_detect(obj, img, r_se)

if (nargin < 3) r_se = obj.r_se; end

IMG_PROCESS = imgProcess();

img = imresize(img, obj.imgsize);
img = rgb2gray(img);
img= im2double(img);

se = strel('disk', 100);
bg=imdilate(img, se);
img = bg-img;

ag = fspecial("disk", 3);
img = imfilter(img, ag);
img = imbinarize(img);

se = strel('disk', 3);
img = imclose(img, se);    %erote dan dilate

r_crop = 2;
img = IMG_PROCESS.img_crop_center(img, obj.imgsize(1, 1) - 2 * r_crop, obj.imgsize(1, 2) - 2 * r_crop); 

img_out = img;

end