%% Create dataset for handgesture x
clc

IMG_PREPROCESS = imgPreprocess();
IMG_PROCESS = imgProcess();

for i = 1 : 1 : 10
    imgname = append("images/highfive/highfive", string(i), ".jpg");
    img = imread(imgname);
    batch_nr = i - 1;
    category = 3;

    img = IMG_PREPROCESS.img_hand_detect(img, 15);
    IMG_PROCESS.img_create_batch(img, 200, 'C:\Users\timvd\Documents\Programming\Matlab\ProjectVision\images\handgestures', batch_nr, category, 'highfive');
end

%% Convert single image to black-white
clc

IMG_PREPROCESS = imgPreprocess();
IMG_PROCESS = imgProcess();

img = imread("images/testbatch/test2.jpg");
img = IMG_PREPROCESS.img_hand_detect(img, 15);

imwrite(img, "C:\Users\timvd\Documents\Programming\Python\Tensorflow\handgestures\testdata\test2.png");