%#ok<*AGROW> 

%% Create dataset for all handgestures
clc

IMG_PREPROCESS = imgPreprocess();
IMG_PROCESS = imgProcess();

% Gather image folders
listdir = dir("images/");
numdir = numel(listdir);
imgdir = [];

for i = 1:1:numdir
    if (listdir(i).name(1) ~= ".")
        str = convertCharsToStrings(listdir(i).name);
        imgdir = [imgdir str];
    end
end

numdir = numel(imgdir);

for i = 1 : 1 : numdir
    catg_num = i;

    catgs = keys(IMG_PROCESS.catg_map);
    catgs_len = numel(catgs);

    for k = 1 : 1 : catgs_len
        if (IMG_PROCESS.catg_map(char(catgs(k))) == catg_num)
            catg_str = catgs(k);
            break;
        end
    end

    disp( append("--- Creating batches for ", catg_str, " ---") );
    for j = 1 : 1 : 10

        imgname = append("images/", catg_str, "/", catg_str, string(j), ".jpg");
        img = imread(imgname);
        batch_nr = j - 1;

        dir = 'C:\Users\timvd\Documents\Programming\Python\Tensorflow\handgestures\data\leapGestRecog_2';

        img = IMG_PREPROCESS.img_hand_detect(img, 15);
        IMG_PROCESS.img_create_batch(img, 1, 200, dir, batch_nr, catg_num, catg_str);
    end
end

disp('Process finished');

%% Convert single image to black-white
clc

IMG_PREPROCESS = imgPreprocess();
IMG_PROCESS = imgProcess();

r_se = 2;
se = strel("disk", r_se);

img = imread("images/down/down1.jpg");

% Original method:
% img = IMG_PREPROCESS.img_hand_detect(img, 12);

% --- Testing different methods ---
img = imresize(img, IMG_PREPROCESS.imgsize);
img = rgb2gray(img);
img = medfilt2(img);
% 
% % ag = fspecial("disk", 15);
% % img = imfilter(img, ag);
% 
img = edge(img, 'sobel');
% % img = imclose(img, se);
% % img = imfill(img, 'holes');
imshow(img)

% r_crop = round(r_se / 4);
% 
% img = imclose(img, se);
% img = IMG_PROCESS.img_crop_center(img, IMG_PREPROCESS.imgsize(1, 1) - 2 * r_crop, IMG_PREPROCESS.imgsize(1, 2) - 2 * r_crop); 


%% Create test batch
clc

disp("test");

IMG_PREPROCESS = imgPreprocess();
IMG_PROCESS = imgProcess();

listdir = dir("images_testbatch/");
numdir = numel(listdir);
imgdir = [];

for i = 1:1:numdir
    if (listdir(i).name(1) ~= ".")
        str = convertCharsToStrings(listdir(i).name);
        imgdir = [imgdir str];
    end
end

numdir = numel(imgdir);

for i = 1:1:numdir
    img = imread( append("images_testbatch/", imgdir(i)) );
    img = IMG_PREPROCESS.img_hand_detect(img, 12);

    name = convertStringsToChars(imgdir(i));
    basename = '';
    n = 1;

    while (name(n) ~= '.')
        basename = [basename name(n)];
        n = n + 1;
    end

    newdir = append("C:\Users\timvd\Documents\Programming\Python\Tensorflow\handgestures\testdata\", basename, ".png");
    imwrite(img, newdir);
end

%% Char test

name = convertStringsToChars("test1.jpg");
basename = '';
n = 1;

while (name(n) ~= '.')
    basename = [basename name(n)];
    n = n + 1;
end

basename

% 
% while (name)