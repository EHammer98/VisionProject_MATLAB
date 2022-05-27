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

        dir = 'C:\Users\busra\Documents\Documenten\Leerjaar 2\Blok 8\PROJBLOK 8\PYTHON_eindopdracht\data\';

        img = IMG_PREPROCESS.img_hand_detect(img, 15);
        IMG_PROCESS.img_create_batch(img, 1, 200, dir, batch_nr, catg_num, catg_str);
    end
end

disp('Process finished');

%% Convert single image to black-white
clc

IMG_PREPROCESS = imgPreprocess();
IMG_PROCESS = imgProcess();

%r_se = 2;
%se = strel("disk", r_se);

img = imread("images/down/U_7.jpg");

% Original method:
% img = IMG_PREPROCESS.img_hand_detect(img, 12);

% --- Testing different methods ---
img = imresize(img, IMG_PREPROCESS.imgsize);
%img = rgb2gray(img);
%                               img = medfilt2(img);
% 
% % ag = fspecial("disk", 15);
% % img = imfilter(img, ag);
% 
%                               img = edge(img, 'sobel');
% % img = imclose(img, se);
% % img = imfill(img, 'holes');
%imshow(img)

% r_crop = round(r_se / 4);
% 
% img = imclose(img, se);
% img = IMG_PROCESS.img_crop_center(img, IMG_PREPROCESS.imgsize(1, 1) - 2 * r_crop, IMG_PREPROCESS.imgsize(1, 2) - 2 * r_crop); 


%BW = imbinarize(img)


x = rgb2gray(img);
x= im2double(x);

subplot(3, 1, 1);
imshow(x)

se = strel('disk', 100);
bg=imdilate(x, se);

z = bg-x;

ag = fspecial("disk", 3);
k = imfilter(z, ag);

i = imbinarize(k);

se = strel('disk', 3);
i = imclose(i, se);    %erote dan dilate
imshow(i)




%q = imfill(i, 'holes');
%p = imclearborder(i, 4)

edges = edge(i,'prewitt');
bw_out = bwareaopen(i, 150); %re_se ipv 20

se = strel('disk', 2);
bw_out = imopen(bw_out, se);    %erote dan dilate

%imshow(bw_out)

%Determine the connected components
CC = bwconncomp(edges, 26); 
%Compute the area of each component
S = regionprops(CC,'Area');
%Remove small objects
L = labelmatrix(CC);
BW2 = ismember(L,find([S.Area] >= 0));

%m = bwmorph(BW2, 'skeleton', inf); % Use this to connect the pixels
subplot(3, 1, 2);
imshow(BW2); %bw_out



[rows, columns] = size(bw_out);
for col = 1 : columns
	% Find the top most pixel.
	topRow = find(bw_out(:, col), 1, 'first');
	if ~isempty(topRow)
		% If there is a pixel in this column, then find the lowest/bottom one.
		bottomRow = find(bw_out(:, col), 1, 'last');
		% Fill from top to bottom.
		bw_out(topRow : bottomRow, col) = true;
	end
end
interior_filled = bw_out;

se = strel('disk', 35);
interior_filled = imclose(interior_filled, se); %dilate dan erote

BW1 = imfill(interior_filled, 'holes');


subplot(3, 1, 3);
imshow(BW1);

% subplot(2, 1, 2);
% imshow(bw_out);

%imshow(bw_out);






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