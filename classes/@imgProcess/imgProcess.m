classdef imgProcess
    properties
        % Default image randomiser parameters
        rand_amin = 2; % Min rotation angle
        rand_amax = 6; % Max rotation angle 
        rand_edmin = 2; % Min erode/dilate radius
        rand_edmax = 7; % Max erode/dilate radius
        rand_trxmin = 4; % Min translation across x-axis
        rand_trxmax = 35; % Max translation across x-axis
        rand_trymin = 1; % Min translation across y-axis
        rand_trymax = 4; % Max translation across y-axis
        rand_imgsize = [310, 470]; % Target image size (470 x 310 pixels)
    end

    methods
        img_create_batch(obj, img, batch_size, folder, batch_nr, category, name);
        img_out = img_crop_center(obj, img, n_row, n_column);
        img_out = img_randomise(obj, img, amin, amax, edmin, edmax, trxmin, trxmax, trymin, trymax);
    end
end
