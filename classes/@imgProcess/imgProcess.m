classdef imgProcess
    properties
        % Default image randomiser parameters
        rand_amin = 2; % Min rotation angle
        rand_amax = 10; % Max rotation angle 
        rand_edmin = 3; % Min erode/dilate radius
        rand_edmax = 20; % Max erode/dilate radius
        rand_trxmin = 4; % Min translation across x-axis
        rand_trxmax = 75; % Max translation across x-axis
        rand_trymin = 2; % Min translation across y-axis
        rand_trymax = 8; % Max translation across y-axis
        rand_imgsize = [310, 470]; % Target image size (470 x 310 pixels)

        catg_map = containers.Map( {'thumbsup', 'thumbsdown', 'highfive', 'down'}, ...
                                   {1, 2, 3, 4} );
    end

    properties (Constant)
        THUMBSUP = 1;
        THUMBSDOWN = 2;
        HIGHFIVE = 3;
    end

    methods
        img_create_batch(obj, img, allow_flip, batch_size, folder, batch_nr, category, name);
        img_out = img_crop_center(obj, img, n_row, n_column);
        img_out = img_randomise(obj, img, allow_flip, amin, amax, edmin, edmax, trxmin, trxmax, trymin, trymax);
        img_out = img_shrink(obj, img, n_pixels);
        img_out = img_grow(obj, img, n_pixels);
    end
end
