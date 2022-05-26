function img_create_batch(obj, img, allow_flip, batch_size, folder, batch_nr, category, name)

% This function creates a batch of randomised images from a given image

    curr_folder = folder;

    curr_folder = append(curr_folder, '/0', string(batch_nr), '/0', string(category), '_', name);
    delete( append(curr_folder, "*.png"));

    for i = 1 : 1 : batch_size
        curr_img = img;
        imflip = 0;

        if (i > batch_size / 2)
            imflip = allow_flip * 1;
        end

        curr_img = obj.img_randomise(curr_img, imflip);
        curr_img = obj.img_crop_center(curr_img);

        filename = append('0', string(batch_nr), '_', '0', string(category), '_', name, '_', string(i), '.png');
        path = fullfile(curr_folder, filename);
        imwrite(curr_img, path);
    end

    disp( append('Batch created', " (", string(batch_nr), ")") );
end